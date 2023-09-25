with

_datetable as --creer tijdstabel vanaf 2019-01-01 tot ....

(

select date(x) as datum

from unnest(sequence(date '2019-01-01', date_add('year',1,current_date), interval '1' day)) t(x)

),

 

_werknemertabel as  --haal de rules van de medewerkers op waarbij statuut van rule intern is

(

select

    *

   

FROM {{ ref('prep_opdata_fin_planning_schedwin_werknemerwerkstelsel') }}

where statuut = 'intern'

),

 

_join as --geef per werknemer een tijdstabel op dag niveau binnen de van en tot van zijn interne rules

(

select

    t.*,

    w.*

   

from _werknemertabel as w  

inner join _datetable as t on w.geldigvanaf <= t.datum and w.geldigtot >= t.datum

)

 

select * from _join