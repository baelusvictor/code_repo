with _history as 
(
select
    {{ dbt_utils.star(from=ref('prep_opdata_fin_caplan_0_cost'), except=['jaar']) }},
    jaar as jaar
from {{ ref('prep_opdata_fin_caplan_0_cost') }}
),

_maxyearplus1 as 
(
select
    {{ dbt_utils.star(from=ref('prep_opdata_fin_caplan_0_cost'), except=['jaar']) }},
    jaar + 1 as jaar
from {{ ref('prep_opdata_fin_caplan_0_cost') }}
where jaar = (select max(jaar) from {{ ref('prep_opdata_fin_caplan_0_cost') }} )
)
--test