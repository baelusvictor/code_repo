/****** Object:  StoredProcedure [dbo].[usp_create_dm_d_date]    Script Date: 29/09/2023 10:12:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_create_dm_d_date] @StartDate DATE = '19400101'
	,@CutoffYears INT = 100
AS
BEGIN
	DECLARE @LogStoredProcedureName NVARCHAR(150) = OBJECT_NAME(@@PROCID);
	DECLARE @LogStartTime DATETIME2 = CURRENT_TIMESTAMP;
	DECLARE @ErrorMessage VARCHAR(2000)
		,@ErrorSeverity TINYINT
		,@ErrorState TINYINT
	--DECLARE @StartDate date = '20100101';
	DECLARE @CutoffDate DATE = DATEADD(DAY, - 1, DATEADD(YEAR, @CutoffYears, @StartDate))

	SET NOCOUNT ON;

	BEGIN TRY
		IF OBJECT_ID('[dm].[d_date]') IS NULL
		BEGIN
			-- Logging: create
			EXEC log.usp_log_stored_procedures_create 'create'
				,@LogStoredProcedureName
				,@LogStartTime
				,'create_dm_d';

			-- Drop datamart if exists
			DROP TABLE

			IF EXISTS [dm].[d_date]
				CREATE TABLE [dm].[d_date] (
					[dwh_id] [char](8) NOT NULL PRIMARY KEY
					,
					--[date_key] [date] NULL,
					[day] [int] NULL
					,[day_suffix] [char](2) NULL
					,[day_name] [nvarchar](30) NULL
					,[day_of_week] [int] NULL
					,[day_of_week_in_month] [tinyint] NULL
					,[day_of_year] [int] NULL
					,[is_weekend] [int] NOT NULL
					,[week] [int] NULL
					,[ISO_week] [int] NULL
					,[first_of_week] [date] NULL
					,[last_of_week] [date] NULL
					,[week_of_month] [tinyint] NULL
					,[month] [int] NULL
					,[month_name] [nvarchar](30) NULL
					,[first_of_month] [date] NULL
					,[last_of_month] [date] NULL
					,[first_of_next_month] [date] NULL
					,[last_of_next_month] [date] NULL
					,[quarter] [int] NULL
					,[first_of_quarter] [date] NULL
					,[last_of_quarter] [date] NULL
					,[year] [int] NULL
					,[yearmonth] [nvarchar](6) NULL
					,[ISO_year] [int] NULL
					,[first_of_year] [date] NULL
					,[last_of_year] [date] NULL
					,[is_leap_year] [bit] NULL
					,[has_53_weeks] [int] NOT NULL
					,[has_53_iso_weeks] [int] NOT NULL
					,[mmyyyy] [char](6) NULL
					,[style_101] [char](10) NULL
					,[style_103] [char](10) NULL
					,[style_112] [char](8) NULL
					,[style_120] [char](10) NULL
					)
		END

		-- Truncate staging table if exists
		TRUNCATE TABLE [dm].[d_date]

		-- Logging: truncate
		EXEC log.usp_log_stored_procedures_create 'truncate'
			,@LogStoredProcedureName
			,@LogStartTime
			,'truncate_dm_d';;

		WITH seq (n)
		AS (
			SELECT 0
			
			UNION ALL
			
			SELECT n + 1
			FROM seq
			WHERE n < DATEDIFF(DAY, @StartDate, @CutoffDate)
			)
			,d (d)
		AS (
			SELECT DATEADD(DAY, n, @StartDate)
			FROM seq
			)
			,src
		AS (
			SELECT date_key = CONVERT(DATE, d)
				,day = DATEPART(DAY, d)
				,day_name = DATENAME(WEEKDAY, d)
				,week = DATEPART(WEEK, d)
				,iso_week = DATEPART(ISO_WEEK, d)
				,day_of_week = DATEPART(WEEKDAY, d)
				,month = DATEPART(MONTH, d)
				,month_name = DATENAME(MONTH, d)
				,quarter = DATEPART(Quarter, d)
				,year = DATEPART(YEAR, d)
				,first_of_month = DATEFROMPARTS(YEAR(d), MONTH(d), 1)
				,last_of_year = DATEFROMPARTS(YEAR(d), 12, 31)
				,day_of_year = DATEPART(DAYOFYEAR, d)
			FROM d
			)
			,dim
		AS (
			SELECT date_key
				,day
				,day_suffix = CONVERT(CHAR(2), CASE 
						WHEN day / 10 = 1
							THEN 'th'
						ELSE CASE RIGHT(day, 1)
								WHEN '1'
									THEN 'st'
								WHEN '2'
									THEN 'nd'
								WHEN '3'
									THEN 'rd'
								ELSE 'th'
								END
						END)
				,day_name
				,day_of_week
				,day_of_week_in_month = CONVERT(TINYINT, ROW_NUMBER() OVER (
						PARTITION BY first_of_month
						,day_of_week ORDER BY date_key
						))
				,day_of_year
				,is_weekend = CASE 
					WHEN day_of_week IN (
							CASE @@DATEFIRST
								WHEN 1
									THEN 6
								WHEN 7
									THEN 1
								END
							,7
							)
						THEN 1
					ELSE 0
					END
				,week
				,ISO_week
				,first_of_week = DATEADD(DAY, 1 - day_of_week, date_key)
				,last_of_week = DATEADD(DAY, 6, DATEADD(DAY, 1 - day_of_week, date_key))
				,week_of_month = CONVERT(TINYINT, DENSE_RANK() OVER (
						PARTITION BY year
						,month ORDER BY week
						))
				,month
				,month_name
				,first_of_month
				,last_of_month = MAX(date_key) OVER (
					PARTITION BY year
					,month
					)
				,first_of_next_month = DATEADD(MONTH, 1, first_of_month)
				,last_of_next_month = DATEADD(DAY, - 1, DATEADD(MONTH, 2, first_of_month))
				,quarter
				,first_of_quarter = MIN(date_key) OVER (
					PARTITION BY year
					,quarter
					)
				,last_of_quarter = MAX(date_key) OVER (
					PARTITION BY year
					,quarter
					)
				,year
				,yearmonth = CAST(CONCAT (
						[year]
						,format([month], '00')
						) AS INT)
				,ISO_year = year - CASE 
					WHEN month = 1
						AND iso_week > 51
						THEN 1
					WHEN month = 12
						AND iso_week = 1
						THEN - 1
					ELSE 0
					END
				,first_of_year = DATEFROMPARTS(year, 1, 1)
				,last_of_year
				,is_leap_year = CONVERT(BIT, CASE 
						WHEN (year % 400 = 0)
							OR (
								year % 4 = 0
								AND year % 100 <> 0
								)
							THEN 1
						ELSE 0
						END)
				,has_53_weeks = CASE 
					WHEN DATEPART(WEEK, last_of_year) = 53
						THEN 1
					ELSE 0
					END
				,has_53_iso_weeks = CASE 
					WHEN DATEPART(ISO_WEEK, last_of_year) = 53
						THEN 1
					ELSE 0
					END
				,mmyyyy = CONVERT(CHAR(2), CONVERT(CHAR(8), date_key, 101)) + CONVERT(CHAR(4), year)
				,style_101 = CONVERT(CHAR(10), date_key, 101)
				,style_103 = CONVERT(CHAR(10), date_key, 103)
				,style_112 = CONVERT(CHAR(8), date_key, 112)
				,style_120 = CONVERT(CHAR(10), date_key, 120)
			FROM src
			)
		--SET IDENTITY_INSERT [dm].[d_date] OFF;
		INSERT INTO dm.[d_date] (
			[dwh_id]
			,[day]
			,[day_suffix]
			,[day_name]
			,[day_of_week]
			,[day_of_week_in_month]
			,[day_of_year]
			,[is_weekend]
			,[week]
			,[ISO_week]
			,[first_of_week]
			,[last_of_week]
			,[week_of_month]
			,[month]
			,[month_name]
			,[first_of_month]
			,[last_of_month]
			,[first_of_next_month]
			,[last_of_next_month]
			,[quarter]
			,[first_of_quarter]
			,[last_of_quarter]
			,[year]
			,[yearmonth]
			,[ISO_year]
			,[first_of_year]
			,[last_of_year]
			,[is_leap_year]
			,[has_53_weeks]
			,[has_53_iso_weeks]
			,[mmyyyy]
			,[style_101]
			,[style_103]
			,[style_112]
			,[style_120]
			)
		SELECT [style_112] AS [dwh_id]
			,[day]
			,[day_suffix]
			,[day_name]
			,[day_of_week]
			,[day_of_week_in_month]
			,[day_of_year]
			,[is_weekend]
			,[week]
			,[ISO_week]
			,[first_of_week]
			,[last_of_week]
			,[week_of_month]
			,[month]
			,[month_name]
			,[first_of_month]
			,[last_of_month]
			,[first_of_next_month]
			,[last_of_next_month]
			,[quarter]
			,[first_of_quarter]
			,[last_of_quarter]
			,[year]
			,[yearmonth]
			,[ISO_year]
			,[first_of_year]
			,[last_of_year]
			,[is_leap_year]
			,[has_53_weeks]
			,[has_53_iso_weeks]
			,[mmyyyy]
			,[style_101]
			,[style_103]
			,[style_112]
			,[style_120]
		FROM dim
		ORDER BY date_key
		OPTION (MAXRECURSION 0);

		--SET IDENTITY_INSERT [dm].[d_date] OFF;
		-- End logging
		EXEC log.usp_log_stored_procedures_create 'success'
			,@LogStoredProcedureName
			,@LogStartTime;
	END TRY

	BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorState = ERROR_STATE()

		RAISERROR (
				@ErrorMessage
				,@ErrorSeverity
				,@ErrorState
				)
	END CATCH
END
GO


