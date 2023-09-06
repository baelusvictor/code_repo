with
_source as
(
select 
    *
from(
    values
        ('A','VB', date(cast('2016-03-20 15:19:34.0' as timestamp))),
        ('A','VB', date(cast('2016-03-21 15:19:34.0' as timestamp))),
        ('B','VB', date(cast('2016-03-22 15:19:34.0' as timestamp))),
        ('A','VB', date(cast('2016-03-23 15:19:34.0' as timestamp))),
        ('A','VB', date(cast('2016-03-24 15:19:34.0' as timestamp))),
        ('A','VB', date(cast('2016-03-25 15:19:34.0' as timestamp))),
        ('C','VB', date(cast('2016-03-26 15:19:34.0' as timestamp))),
        ('C','VB', date(cast('2016-03-27 15:19:34.0' as timestamp))),
        ('A','VB', date(cast('2016-03-28 15:19:34.0' as timestamp)))
    )  as t (werk, naam, tijd)
),

_lead as
(
select 
    *,
    lag(tijd) over ( partition by werk, naam order by tijd) as lag_werknaam,
    lag(tijd) over ( partition by naam order by tijd) as lag_naam
from _source
order by tijd
),

_leadlogic as
(
select 
    *,
    case 
        when lag_werknaam is null then true
        when lag_werknaam = lag_naam then false
        else true
        end as reset
from _lead
),

_reset as 
(
select 
    werk, naam, tijd, reset, row_number() over ( partition by naam order by tijd) as rn
from _leadlogic
where reset = true
),

_yesrange as
(
select 
    c.*, 
    n.tijd as next_date,
    date_add('day', -1, n.tijd) as next_date2
from _reset c
left join _reset n on c.naam = n.naam and c.rn+1 = n.rn
),

 

_final as 
(
select 
    m.*, 
    r.rn as partitie
from _source as m
left join _yesrange r 
  on m.naam = r.naam and 
     m.tijd >= r.tijd 
     and m.tijd < coalesce(r.next_date, date_add('day', 1, m.tijd) )
)

select distinct
    werk,
    naam,
    min(tijd) over (partition by partitie) as van,
    max(tijd) over (partition by partitie) as tot
from _final
order by min(tijd) over (partition by partitie)
