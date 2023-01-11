--- punto 1
select t1.* , t2.aporte_diario_total_m3 from (SELECT x.fechaoperacion , sum(aportes_m3) aporte_diario_antioquia_m3 FROM public.aportes_ido x
WHERE regionhidrologica IN ('ANTIOQUIA') and DATE_TRUNC('year', fechaoperacion) = DATE_TRUNC('year', CURRENT_DATE - INTERVAL '1 year')
group by fechaoperacion) t1
left join 

(select fechaoperacion , sum(aportes_m3) aporte_diario_total_m3 from public.aportes_ido
where regionhidrologica IN ('ANTIOQUIA','CARIBE','CENTRO','ORIENTE','VALLE') 
group by fechaoperacion) t2

on t1.fechaoperacion = t2.fechaoperacion
ORDER BY fechaoperacion DESC;
---- punto 2
select nombreembalse,(sum(volutildiarioenergia)/ sum(volenergia) )*100 as porcentaje_reserva_energia,date_part('year', fechaoperacion) as año  from reservasproduccion
where  DATE_TRUNC('year', fechaoperacion) = DATE_TRUNC('year', CURRENT_DATE - interval'1 year')
group by fechaoperacion,nombreembalse


--Máximo diario del precio de bolsa de los últimos tres meses.
SELECT x.fechaoperacion , 
		greatest(hora1 , hora2 , hora3 , hora4 , hora5 , hora6, hora7 , hora8, hora9 , hora10, hora11 , hora12 , hora13, hora14, hora15, hora16, hora17, hora18, hora19, hora20, hora21 , hora22 , hora23 , hora24 )
		as max_pb
FROM public.trsd x
WHERE codigo IN ('PBNA') and fechaoperacion >= date_trunc('month', current_date ) - interval '3 month'  and version in ('txr') ;

--Minimo diario del precio de bolsa de los últimos tres meses.
SELECT x.fechaoperacion , 
		least(hora1 , hora2 , hora3 , hora4 , hora5 , hora6, hora7 , hora8, hora9 , hora10, hora11 , hora12 , hora13, hora14, hora15, hora16, hora17, hora18, hora19, hora20, hora21 , hora22 , hora23 , hora24 )
		as min_pb
FROM public.trsd x
WHERE codigo IN ('PBNA') and fechaoperacion >= date_trunc('month', current_date ) - interval '3 month'  and version in ('txr') ;

--Promedio diario del precio de bolsa de los últimos tres meses.
SELECT x.fechaoperacion , 
		(hora1+ hora2+ hora3 + hora4 + hora5 + hora6+ hora7 + hora8+ hora9 + hora10+ hora11 + hora12 + hora13+ hora14+ hora15+ hora16+ hora17+ hora18+ hora19+ hora20+ hora21 + hora22 + hora23 + hora24 )/24 as avg_pb
FROM public.trsd x
WHERE codigo IN ('PBNA') and fechaoperacion >= date_trunc('month', current_date ) - interval '3 month'  and version in ('txr') ;

--Demanda mensual del SIN durante los últimos tres años.

with demanda_diaria as (select fechaoperacion ,
		(hora1+ hora2+ hora3 + hora4 + hora5 + hora6+ hora7 + hora8+ hora9 + hora10+ hora11 + hora12 + hora13+ hora14+ hora15+ hora16+ hora17+ hora18+ hora19+ hora20+ hora21 + hora22 + hora23 + hora24) as demanda_dia
from public.trsd
where codigo ilike '%dmnd%' and fechaoperacion >= current_date - interval '3 years' and version = 'txr'
order by fechaoperacion )

select EXTRACT(YEAR FROM fechaoperacion) AS year,
       EXTRACT(MONTH FROM fechaoperacion) AS mes , sum(demanda_dia)
from demanda_diaria 
group by mes, year
order by year, mes


--punto 7 Precios de oferta promedio horaria por tecnología de generación durante el último año
with preofe1 as (select * from (select submercado, fechaoperacion,hora1 , hora2 , hora3 , hora4 , hora5 , hora6, hora7 , hora8, hora9 , hora10, hora11 , hora12 , hora13, hora14, hora15, hora16, hora17, hora18, hora19, hora20, hora21 , hora22 , hora23 , hora24   from preofe

where  DATE_TRUNC('year', fechaoperacion) = DATE_TRUNC('year', CURRENT_DATE - INTERVAL '1 year') and version in ('txr') 
) t1

left join

(select planta, tecnologia from capains
where  DATE_TRUNC('year', fechaoperacion) = DATE_TRUNC('year', CURRENT_DATE - INTERVAL '1 year') and version in ('txr')
) t2
on t1.submercado = t2.planta
)
select tecnologia, fechaoperacion,avg(hora1 ) as hora1 , avg(hora2 ) as hora2, avg(hora3 ) as hora3, avg(hora4 ) as hora4, avg(hora5 ) as hora5, avg(hora6) as hora6, avg(hora7 ) as hora7, avg(hora8) as hora8, avg(hora9 ) as hora9, avg(hora10) as hora10, avg(hora11) as hora11 , avg(hora12) as hora12 , avg(hora13) as hora13, avg(hora14) as hora14, avg(hora15) as hora15, avg(hora16) as hora16, avg(hora17) as hora17, avg(hora18) as hora18, avg(hora19) as hora19, avg(hora20) as hora20, avg(hora21) as hora21 , avg(hora22) as hora22 , avg(hora23) as hora23 , avg(hora24) as hora24 from preofe1
group by tecnologia,fechaoperacion

--avg(hora1 ) as hora1 , avg(hora2 ) as hora2, avg(hora3 ) as hora3, avg(hora4 ) as hora4, avg(hora5 ) as hora5, avg(hora6) as hora6, avg(hora7 ) as hora7, avg(hora8) as hora8, avg(hora9 ) as hora9, avg(hora10) as hora10, avg(hora11) as hora11 , avg(hora12) as hora12 , avg(hora13) as hora13, avg(hora14) as hora14, avg(hora15) as hora15, avg(hora16) as hora16, avg(hora17) as hora17, avg(hora18) as hora18, avg(hora19) as hora19, avg(hora20) as hora20, avg(hora21) as hora21 , avg(hora22) as hora22 , avg(hora23) as hora23 , avg(hora24) as hora24

-- punto 8 Compras y ventas en bolsa por agente durante el último mes.
select agente, fechaoperacion,mctb as COMPRA_ENERGIA_B_KWH, vctb as COMPRA_ENERGIA_B_$ ,mvtb as venta_ENERGIA_B_KWH, vvtb as venta_ENERGIA_B_$, version  from afac
where  DATE_TRUNC('year', fechaoperacion) = DATE_TRUNC('year', CURRENT_DATE - INTERVAL '1 month') and version in ('txr')
ORDER BY fechaoperacion ASC;

--- punto 9 falta 

with demanda_diaria as (
	select fechaoperacion ,(hora1+ hora2+ hora3 + hora4 + hora5 + hora6+ hora7 + hora8+ hora9 + hora10+ hora11 + hora12 + hora13+ hora14+ hora15+ hora16+ hora17+ hora18+ hora19+ hora20+ hora21 + hora22 + hora23 + hora24) as demanda_dia
	from public.trsd
	where codigo ilike '%dmnd%' and DATE_TRUNC('year', fechaoperacion) = DATE_TRUNC('year', CURRENT_DATE - INTERVAL '1 month') and date_part('week', fechaoperacion)=1
	)

		select EXTRACT(YEAR FROM fechaoperacion) AS year, date_part('week', fechaoperacion)as num_semana, sum(demanda_dia) as demanda,fechaoperacion,to_char(fechaoperacion, 'Day') as dia_of_semana from demanda_diaria
		group by year,fechaoperacion 




with demanda_diaria as (
	select fechaoperacion ,(hora1+ hora2+ hora3 + hora4 + hora5 + hora6+ hora7 + hora8+ hora9 + hora10+ hora11 + hora12 + hora13+ hora14+ hora15+ hora16+ hora17+ hora18+ hora19+ hora20+ hora21 + hora22 + hora23 + hora24) as demanda_dia
	from public.trsd
	where codigo ilike '%dmnd%'and DATE_TRUNC('year', fechaoperacion) = DATE_TRUNC('year', CURRENT_DATE ))

	select EXTRACT(YEAR FROM fechaoperacion) AS year, date_part('week', fechaoperacion) as num_semana, sum(demanda_dia) as demanda,fechaoperacion, to_char(fechaoperacion, 'Day') as dia_of_semana
	from demanda_diaria 
	group by year,fechaoperacion 

---------- punto 9 final 
with fechas_semanas as (select s1.semana_year, s1.dia_semana, s1.date_column semana1 , s2.date_column semana2

from (select date_column , date_part('dow' , date_column) num_dia_semana , to_char(date_column::date, 'Day') dia_semana , date_part('week' , date_column) semana_year
		from    (SELECT generate_series(date_trunc( 'week' ,  current_date - interval '3 week') 
    			, date_trunc( 'week' ,  current_date)  - interval '2 week' - interval '1 day'
    			, '1 day'::interval) 
    				as date_column) t1) s1 
left join 

	(select date_column , date_part('dow' , date_column) , to_char(date_column::date, 'Day') dia_semana , date_part('week' , date_column) semana_year
		from    (SELECT generate_series(date_trunc( 'month' ,  current_date) - interval '1 month' - interval '1 year'
    			, date_trunc( 'month' ,  current_date)  + interval '1 month' - interval '1 year'
    			, '1 day'::interval) 
    				as date_column) t1)  s2
    				
on s1.dia_semana = s2.dia_semana and s1.semana_year = s2.semana_year

order by semana1) ,


tabla_demanda as (select fechaoperacion
		, to_char(fechaoperacion::date, 'Day') dia_semana  
		, date_part('week' , fechaoperacion) semana_year
		, date_part('year' , fechaoperacion) ano
		, (hora1 + hora2  + hora3 + hora4 + hora5 + hora6+ hora7 + hora8+ hora9 + hora10+ hora11 + hora12 + hora13+ hora14+ hora15+ hora16+ hora17+ hora18+ hora19+ hora20+ hora21 + hora22 + hora23 + hora24 ) demanda
from public.trsd 
where codigo ilike '%dmnd%' 
	and (fechaoperacion in (select semana1 from fechas_semanas) or fechaoperacion in (select semana2 from fechas_semanas))
	and version ilike 'txr') ,
	
	max_year as (select max(ano) ano  from tabla_demanda) , min_year as (select min(ano) ano from tabla_demanda)
	
	
select dia_semana,
				max(tabla_demanda.demanda) filter (where ano = (select ano from max_year )) as "semana_actual", 
				max(tabla_demanda.demanda) filter (where ano = (select ano from min_year )) as "semana_ano_atras"
	from tabla_demanda 
	group by dia_semana
	