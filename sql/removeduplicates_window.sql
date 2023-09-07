-- table contains to many rows which seem like dublicates but are really historical data
-- we use window functions to filter them out
with 
_window_aedat as
(
    select 
        *,
        -- if a kalnr contains multiple posnr's => keep the one with the latest aedate
        rank() over(partition by kalnr, posnr order by aedat_kost desc) as rank_aedat
    from {{ ref('prep_opdata_fin_sap_fctcalculatie_join') }}
),

_window_objid as
(
select
    *,
    -- if a kalnr contain multiple posnr's with the same aedate => keep the one with the highest objid
    rank() over(partition by kalnr, posnr, rank_aedat order by objid desc) as rank_objid
from _window_aedat
)

select 
    -- surrogate key that needs to be created in both the dimension and fact table in order to map both 6 and 9 in same table
    if(substr(soort_id,1,1)='9',parob_clean,mat_id_ckis) as parob_artikel_FK,
    if(substr(soort_id,1,1)='9',arbpl,mat_id_ckis) as werkplek_artikel_NK,
    if(substr(soort_id,1,1)='9','routing','stuklijst') as kostensoortgroep,
    *
from _window_objid
where 
    rank_aedat = 1 and rank_objid = 1 
    -- allready filtered out but just to be sure:
    and rank_kadky = 1
    and keko_keeprow = true
order by kalnr, posnr