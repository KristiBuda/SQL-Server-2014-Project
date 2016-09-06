create database ARGILI_SHPK

--KRIJIMI I TABELES PUNONJES--

create table PUNONJES(
ID_P      varchar (20) not null primary key, --ID e punonjesi eshte e perbere nga 6 shifra ku 3 te parat identifikojne ambientin ku punon dhe pozicionin ndersa pjesa tjeter eshte identiteti i punonjesit.
SSN_P     varchar (10) not null, 
EMER_P    varchar (20) not null,
ATESIA_P  varchar (20),
MBIEMER_P varchar (20) not null,
DTL_P     varchar (10) not null,
NRLLOG_P  int          not null unique,
PAGA_P    int          not null,
constraint CHK_LLOOGARIA check(NRLLOG_P between 10000 and 99999)
)

create table FILIAL(
KOD_FI  int           not null primary key, --Kodi i filialit eshte i perbere nga 3 shifra te cilat fillojne me 1 qe identifikojne objekti eshte filial ndersa pjesa tjeter identifikon filialin specifik.
ADR_FI  varchar (50)  not null,  
NRP_FI  int ,
constraint CHK_KOD_FI check(KOD_FI between 101 and 199) 
)

create table FURNITOR(
NIPT_FU   varchar (10)  not null primary key,
EMRI_FU   varchar (20),
ADR_FU    varchar (50),
NRLLOG_FU int           not null unique,
constraint CH_NRLLOG check(NRLLOG_FU between 10000 and 99999)
)

create table MAGAZINE(
ID_M     int identity(0000000000000000,1) not null primary key,
KODID_M  int,                                                    --Ndryshe nga filiali kodi identifikues qe objekti ne fjale eshte magazine eshte 200
ADR_M    varchar (50) ,
KODP_M   varchar (20)                     not null unique,       --Ka 2 lloje kodesh ne magazine. Kodi per furnizimin perbehet nga 9 karaktere dhe i pari eshte 1 dhe pjesa tjeter 200 qe tregon i destinuar per ne magazine, ndersa kodi per produktet e ardhura nga filialet per t'iu shitur furnitoreve perbehet nga 8 karaktere dhe fillon me 100 qe tregon prejardhjen.
CMIMP_M  int                              not null,
LLOJIP_M varchar (15), 
NIPT_FU  varchar (10)							   default '-',
KOD_FI   varchar (3)                               default '-'
)

create table PUNISHTE(
ID_PU    int identity(0000000000000000,1) not null primary key,
KODID_PU int,                                                    -- Kodi identifikues qe objekti eshte punishte eshte 300
ADR_PU   varchar (50),
KODP_PO  int                              not null foreign key references POROSI(KODP_PO),
KODFI_PO int                              not null foreign key references FILIAL(KOD_FI)
)


create table KLIENT(
ID_K      varchar (10) not null primary key,
EMER_K    varchar (20) not null,
MBIEMER_K varchar (20) not null,
LLOJVEP_K varchar (10) not null
)

create table DERGUAR(
ID_D    int identity(0000000000000000,1) not null primary key,
DERGUAR varchar (8)                      not null default '0', --3 shifrat e para tregojne origjinen e mallit ndersa -> tregon qe i destinohet objektit me kodin perkates
KODP_D  varchar (11)	     			 not null,
LLOJI_D varchar (15),
CMIMI_D int                                       default 0,  
PESHE_D decimal (5,3)					 not null
)

create table SHITJE(
ID_S       int identity(0000000000000000,1) not null primary key,
IDK_S      varchar (10)                     not null foreign key references KLIENT(ID_K),
KODFI_S    int                              not null foreign key references FILIAL(KOD_FI),
KODP_S     int							    not null unique,
LLOJP_S    varchar (15)                     not null default 'Material i cmuar',
CMIMI_S    decimal (7,2)                    not null,
PESHE_S    decimal (5,3)                    not null,
LLOJIVEP_S varchar (15)                     not null,
)


create table POROSI(
KODP_PO  int           not null primary key,
KODI_FI  int           not null foreign key references FILIAL(KOD_FI),
ID_K     varchar (10)  not null foreign key references KLIENT(ID_K),
LLOJ_PO  varchar (15),
CMIM_PO  int           not null,
PESHE_PO decimal (5,3) not null
)

create table MENAXHERE(
ID_M     int identity(000000,1) not null primary key,
ID_P     varchar     (20)       not null foreign key references PUNONJES(ID_P),  --identiteti i menaxherit eshte ndryshe nga ai i punetoreve te thjeshte ai perbehet nga dy shifrat e para 11 qe tregojne qe personi ne fjale eshte menaxher dhe pjesa tjeter kodi unik identifikues.
MENAXHON varchar     (10)       not null 
)



insert  into    PUNONJES    values  (  '11-001',	'J32201574F', 'Bashkim' ,  'Bexhet'	 , 'Sulaj'	  , '17-05-82'  ,   98456   ,   75000   );
insert  into    PUNONJES    values  (  '11-002',	'A65465465A', 'Skender' ,  'Thanas'	 , 'Paqo'	  , '16-02-70'  ,   88454   ,   75000   );
insert  into    PUNONJES    values  (  '11-003',	'P65465655C', 'Genti'   ,  'Edmond'	 , 'Topi'	  , '08-01-90'  ,   65465   ,   75000   );
insert  into    PUNONJES    values  (  '11-004',	'P65465655C', 'Skerdi'   , 'Fatos'	 , 'Mucaj'	  , '04-05-80'  ,   98752   ,   75000   );
insert  into    PUNONJES    values  (  '11-005',	'P65465655C', 'Astrit'   , 'Rexhep'	 , 'Nelaj'	  , '18-12-84'  ,   67721   ,   75000   );

insert  into    PUNONJES    values  (  '101-001',   'F26154321L', 'Lumir'   , 'Bektash'  , 'Nurellari' , '26-04-77' ,   32165	,   22000   );
insert	into	PUNONJES	values	(  '104-001',	'J63568223K', 'Luljeta' , 'Liridon'  , 'Shehu'	  ,	'15-10-56'	,	75578	,	22000	);
insert	into	PUNONJES	values	(  '105-001',	'K75939942J', 'Genta'   , 'Gjovalin' , 'Hoxha'	  ,	'13-01-75'	,	88965	,	25000	);
insert	into	PUNONJES	values	(  '102-001',	'L98237463L', 'Bledar'  , 'Arber'    , 'Goxhaj'	  ,	'31-12-88'	,	38322	,	32500	);
insert	into	PUNONJES	values	(  '102-002',	'A20384892P', 'Bardhyl' , 'Hasan'    , 'Rrapaj'	  ,	'28-09-64'	,	64843	,	35000	);
insert	into	PUNONJES	values	(  '103-001',	'V57383920K', 'Albina'  , 'Enver'    , 'Lame'	  ,	'29-04-83'	,	60377	,	45000	);
insert	into	PUNONJES	values	(  '103-002',	'K32597237L', 'Genci'   , 'Vangjel'  , 'Cibaku'	  ,	'23-02-61'	,	73575	,	45500	);
insert	into	PUNONJES	values	(  '103-003',	'J23845723J', 'Enkeleda', 'Novruz'   , 'Xhaka'	  ,	'17-12-80'	,	83184	,	47500	);

insert	into	PUNONJES	values	(  '200-001',	'M82395738L', 'Genci'   , 'Reshat'   , 'Cana'	  ,	'10-04-83'	,	77951	,	30000	);
insert	into	PUNONJES	values	(  '200-002',	'L32975230C', 'Artan'   , 'Hyqmet'   , 'Berisha'  ,	'31-03-68'	,	92879	,	30000	);
insert	into	PUNONJES	values	(  '200-003',	'A23974032N', 'Arben'   , 'Shkelzen' , 'Goxhaj'	  ,	'14-02-85'	,	64902	,	50000	);
insert	into	PUNONJES	values	(  '200-004',	'K04024343G', 'Bledi'   , 'Qatip'    , 'Kodra'	  ,	'11-12-81'	,	45229	,	50000	);
insert	into	PUNONJES	values	(  '300-001',	'M32534255F', 'Fatbadh' , 'Aranit'   , 'Lila'	  ,	'13-07-79'	,	68932	,	40000	);
insert	into	PUNONJES	values	(  '300-002',	'B32431243F', 'Dhimitër', 'Ferdinand', 'Bakaj'	  ,	'12-05-77'	,	26057	,	40000	);
insert	into	PUNONJES	values	(  '300-003',	'H36427463Q', 'Andon'   , 'Xhaferr'  , 'Beqaj'	  ,	'08-08-54'	,	83542	,	50000   );


insert	into	FILIAL	values	(	101	,	'Rr.Antipatrea, BERAT'			      ,  1  );
insert	into	FILIAL	values	(	102	,	'Blv.Zogu I, TIRANE'			      ,  2  );
insert	into	FILIAL	values	(	103	,	'Rr.Sami Frasheri, TIRANE'		      ,  3  );
insert	into	FILIAL	values	(	104	,	'Rr. Kostandin Kristoforidhi, ELBASAN',  1  );
insert	into	FILIAL	values	(	105	,	'Rr. Sadik Zotaj, VLORE'              ,  1  );


Insert	into	FURNITOR	values	(  'J38492839L' , 'ENI Sh.P.K'   , 'Rr.Myslym Shyri'      ,  89498  );
Insert	into	FURNITOR	values	(  'D45983267N' , 'Orbico Group' , 'Rr.Siri Kodra'        ,  85878  );
Insert	into	FURNITOR	values	(  'A35974216U' , 'Vega Company' , 'Rr.Komuna e Parisit'  ,  17572  );
Insert	into	FURNITOR	values	(  'T58974231F' , 'LTD Group'    , 'Zogu I zi'            ,  51714  );
Insert	into	FURNITOR	values	(  'B78532194S' , 'R&B SH.P.K'   , 'Bulevardi Zogu I pare',  14631  );



insert	into	MAGAZINE	values	(	200	 ,	' Aut. Tirane-Durres, KM.7'	,	'1-200-70085' ,		302000	,	'Unaze'	    , 'J38492839L' ,	'	'   );
insert	into	MAGAZINE	values	(	200	 ,	' Aut. Tirane-Durres, KM.7'	,	'1-200-70086' ,		504000	,	'Varese'	, 'J38492839L' ,	'	'   );
insert	into	MAGAZINE	values	(	200  ,	' Aut. Tirane-Durres, KM.7'	,	'1-200-70087' ,		60000	,	'Sterline'	, 'A35974216U' ,	'	'   );
insert	into	MAGAZINE	values	(	200  ,	' Aut. Tirane-Durres, KM.7'	,	'100-032242'  ,		30000	,	'Tretje_AU'	, '          ' ,    '103'	);
insert	into	MAGAZINE	values	(	200  ,	' Aut. Tirane-Durres, KM.7'	,	'100-054133'  ,		22000	,	'Tretje_AG'	, '		     ' ,	'105'	);


																																		
Insert	into	KLIENT		values ( 'L38495837J' , 'Marsida', 'Balla'      , 'Blen'    );
Insert	into	KLIENT		values ( 'N39485382D' , 'Lorena' , 'Kulla'      , 'Shet'    );
Insert	into	KLIENT		values ( 'U58683937A' , 'Edmond' , 'Takaj'      , 'Blen'    );
Insert	into	KLIENT		values ( 'F85947576K' , 'Dritan' , 'Shakohoxha' , 'Porosit' );
Insert	into	KLIENT		values ( 'S39485765T' , 'Bekim'  , 'Dinaj'      , 'Porosit' );
Insert  into	KLIENT		values ( 'A64556545K' , 'Jona'  , 'Rroshi'		, 'Porosit' );
Insert  into	KLIENT		values ( 'J89755455K' , 'Astrit' , 'Veliaj'     , 'Porosit' );
Insert  into	KLIENT		values ( 'F87985425B' , 'Eliot'  , 'Ajazi'		, 'Porosit' ); 
Insert	into	KLIENT	    values ( 'D54659873G' ,	'Jurgen' , 'Dakaj'	    , 'Blen'	);
Insert	into	KLIENT	    values ( 'S12356498E' ,	'Jolda'	 , 'Ruli'	    , 'Shet'	);

																																																						


Insert  into    MENAXHERE values ( '11-001' , 'Filial'   );
Insert  into    MENAXHERE values ( '11-002' , 'Filial'   );
Insert  into    MENAXHERE values ( '11-003' , 'Filial'   );
Insert  into    MENAXHERE values ( '11-004' , 'Punishte' );
Insert  into    MENAXHERE values ( '11-005' , 'Magazine' );

											
insert	into	POROSI	values	( 54554	, 101 ,	'F85947576K' ,	'Varese'    ,	200		,	6.90	);	
insert	into	POROSI	values	( 65454	, 102 ,	'A64556545K' ,	'Unaze'	    ,	500		,	6.60	);	
insert	into	POROSI	values	( 34465	, 102 ,	'S39485765T' ,	'Varese'	,	300		,	11.72	);	
insert	into	POROSI	values	( 45799	, 103 ,	'J89755455K' ,	'Byzylyk'	,	250		,	5.30	);	
insert	into	POROSI	values	( 98965	, 105 ,	'F87985425B' ,	'Unaze' 	,	400		,	2.33	);	


insert	into	PUNISHTE	values	(	300	,	'Aut. Tirane-Durres, KM.7'	,	54554	,	101	);
insert	into	PUNISHTE	values	(	300	,	'Aut. Tirane-Durres, KM.7'	,	65454	,	102	);
insert	into	PUNISHTE	values	(	300	,	'Aut. Tirane-Durres, KM.7'	,	34465	,	102	);
insert	into	PUNISHTE	values	(	300	,	'Aut. Tirane-Durres, KM.7'	,	45799	,	103	);
insert	into	PUNISHTE	values	(	300	,	'Aut. Tirane-Durres, KM.7'	,	98965	,	105	);


insert	into	DERGUAR	    values	( '101->300'	,	     '54554'	, 'Porosi'	   ,   200	    ,	6.9 	);
insert	into	DERGUAR     values	( '300->101'	,	     '54554'    , 'Porosi'	   ,   200	    ,	6.9	    );
insert	into	DERGUAR  	values	( '105->200'	,	'100-054133'	, 'Shitje'	   ,   22000	,	13.34	);
insert	into	DERGUAR 	values	( '103->200'	,	'100-032242'	, 'Shitje'	   ,   30000	,	14.5	);
insert	into	DERGUAR 	values	( '200->102'	,  '1-200-70085'	, 'Furnizim'   ,   320000	,	85.7	);


Insert	into	SHITJE	values	( 'L38495837J' , 101 , 32145 , 'Byzylyke' , 37200	 , 9.3	 , 'Blerje');
Insert	into	SHITJE	values	( 'N39485382D' , 103 , 36541 , 'Varese'	  ,	16000	 , 6.74	 , 'Shitje');
Insert	into	SHITJE	values	( 'U58683937A' , 105 , 89657 , 'Unaze'	  ,	13400	 , 3.35  , 'Blerje');
Insert	into	SHITJE	values	( 'D54659873G' , 102 , 15247 , 'Unaze'	  ,	35100    , 7.8	 , 'Blerje');
Insert	into	SHITJE	values	( 'S12356498E' , 102 , 98674 , 'Varese'	  ,	30000      , 9	 , 'Shitje');




WHILE ( 0 = 0 ) BEGIN UPDATE TOP ( 10000 ) PUNONJES SET PAGA_P = 32000 WHERE   PAGA_P = 30000 IF @@ROWCOUNT = 0 BREAK END

update SHITJE    set LLOJP_S = 'Monedhe' , CMIMI_S = 60000 , PESHE_S = 9 where IDK_S = 'U58683937A'; 

update MENAXHERE set MENAXHON = 'Magazine' where ID_P = '11-002';




delete from  MAGAZINE where KODP_M in (select KODP_D = '1-200-70085' from DERGUAR);

delete from  PUNONJES where ID_P = '104-001'
update FILIAL set NRP_FI = NRP_FI-1 where KOD_FI = 104;

delete from MAGAZINE where NIPT_FU in (select P.NIPT_FU from FURNITOR P inner join FURNITOR  E on  P.NIPT_FU = E.NIPT_FU);




select EMER_K, MBIEMER_K, P.ID_K from KLIENT P inner join POROSI  E on  P.ID_K = E.ID_K;

select IDK_S , CMIMI_S from SHITJE order by CMIMI_S desc;

select sum(PAGA_P)    as PAGA_TOTALE , avg(PAGA_P) as PAGA_MESATARE  , max(PAGA_P) as PAGA_MAX from PUNONJES;

select count(LLOJP_S) as UNAZA from SHITJE where LLOJP_S = 'Unaze';

select Emer_P, Mbiemer_P, PAGA_P from PUNONJES where ID_P in(select P.ID_P from MENAXHERE P join PUNONJES O on P.ID_P = O.ID_P);

select * from FURNITOR where NIPT_FU in(select NIPT_FU from magazine where LLOJIP_M = 'Sterline');

select * from FURNITOR where NIPT_FU not in(select P.NIPT_FU from MAGAZINE P left outer join FURNITOR O on O.NIPT_FU = P.NIPT_FU);

select * from KLIENT as K where exists (select * from POROSI as P where K.ID_K = P.ID_K and P.LLOJ_PO = 'Varese');

select distinct * from FURNITOR where ADR_FU = 'Zogu i Zi';


create view PUNONJES_PAGA_600 as select PAGA_P, EMER_P, MBIEMER_P from PUNONJES where PAGA_P >= 40000



select * from PUNONJES
select * from FILIAL
select * from FURNITOR
select * from MAGAZINE
select * from PUNISHTE
select * from DERGUAR
select * from SHITJE
select * from POROSI
select * from MENAXHERE
select * from KLIENT


----------------------------------------------------------------------------------
-----------------------------DETYRE KURSI FAZA 3 ---------------------------------
--///////////////////////////--------------------\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\--


----------------------------------------------------------------------------------
---KRIJIMI I USERAVE DHE DHENIA E TE DREJTAVE MBI TA------------------------------
--|============================================================================|--
--| a) User: KristiBuda te drejta te plota mbi DB                              |--
--| b) User: IgliGrykshi te drejta vetem insert, select,					   |--
--| c) User:FatjonBidinaj  te drejte insert, select, update                    |--
--|============================================================================|--
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------


-------------------------------------------------------------------------------------
-- USER KristiBuda 
create login KristiBuda with password = '*JewelARGkrb6227828*' use ARGILI_SHPK
create user  KristiBuda for login KristiBuda
drop login   KristiBuda
drop user    KristiBuda

-------------------------------------------------------------------------------------

--USER IgliGrykshi
create login IgliGrykshi with password = '*JewelARGigg6183897*' use ARGILI_SHPK
create user  IgliGrykshi for login IgliGrykshi
drop login IgliGrykshi
drop user IgliGrykshi

-------------------------------------------------------------------------------------

--USER FatjonBidinaj
create login FatjonBidinaj with password = '*JewelARGfab3322017*' use ARGILI_SHPK
create user  FatjonBidinaj for login FatjonBidinaj
drop login FatjonBidinaj
drop user FatjonBidinaj
-------------------------------------------------------------------------------------

--GRANTING PRIVILEGES TO KristiBuda
use ARGILI_SHPK
go
exec sp_addrolemember 'db_owner', 'KristiBuda'
go

--GRANTING RIGHTS TO IgliGrykshi
use ARGILI_SHPK grant select, insert to IgliGrykshi

--GRANTING RIGHTS TO FatjonBidinaj
use ARGILI_SHPK grant select, insert, update to FatjonBidinaj


-----------------------------------------------------------------------------------------------------------
----------------------------------------KRISTI BUDA PIKA 2-------------------------------------------------
--/////////////////////////////////////                    \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-----------------------------------------------------------------------------------------------------------

------------------------------------------TRIGGER DDL------------------------------------------------------
-------------------------------MAT NUMRIN E DATABAZAVE NE SERVER-------------------------------------------
-----------------------------------------------------------------------------------------------------------

if exists (select* from sys.server_triggers where name = 'ddl_trig_databaza') 
	drop trigger ddl_trig_databaza on all server 
go
create trigger ddl_trig_databaza on all server for create_database as
	declare @numriDB int, @emridatabazes varchar(100);
	set @numriDB = 3
		if(@numriDB = 10)
			begin
			print'NUMRI DATABAZAVE KA ARRITUR MAKSIMUMIN'
			rollback
			end
		else if(@numriDB <= 10)
			  begin
				set @emridatabazes = (select eventdata().value('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]','nvarchar(max)'))
				print'U KRIJUA NJE DATABAZE E RE ME EMER: ' + @emridatabazes
				 end
go

create database aqifi
drop database aqifi



-------------------------------------------------------------------------------------------------------------
-------------------------------------TRIGGER DML-------------------------------------------------------------
-----------CDO HERE QE BEHET INSERT NJE MENAXHER I RI PRINTON NE EKRAN INFORMACIONET E TIJ-------------------
-------------------------------------------------------------------------------------------------------------

use ARGILI_SHPK
if exists(select * from sys.triggers where name =  'ddl.trgg.newmanager' AND parent_class_desc = 'ARGILI_SHPK')
drop trigger newmenager on database

create trigger newmanager on MENAXHERE after insert as
	 begin
		declare @idm varchar(10), @idp varchar(10), @menaxhon varchar(10), @nl as char(2) =  char(13) + char(10);
			set @idm = 0 + (select max(ID_M) from MENAXHERE) 
			set @idp = (select ID_P from MENAXHERE where ID_M  in(select max(ID_M) from MENAXHERE))
			set @menaxhon = (select MENAXHON from MENAXHERE where ID_M  in(select max(ID_M) from MENAXHERE))
			print'U SHTUA NJE MENAXHER I RI ME TE DHENA:' + @nl + 'ID_M: ' + @idm + @nl + 'ID PUNETORI: ' + @idp + @nl + 'MENAXHON: ' + @menaxhon
	end

Insert  into    MENAXHERE values ( '11-001' , 'Filial'   );
select * from MENAXHERE
delete from MENAXHERE where ID_M = 9 and ID_P = '11-001'
drop trigger newmanager



------------------------------------------------------------------------------------------------------------------
-------------------------------------------------PROCEDURE--------------------------------------------------------
-----------------------------INSERON VLERA NE TABELE NE MENYRE TE SHKURTUAR---------------------------------------
------------------------------------------------------------------------------------------------------------------

create procedure iklient @idk varchar(10), @emerk varchar(20), @mbiemerk varchar (20), @llojvep varchar(10)
	as
		declare @nl as char(2) =  char(13) + char(10);
		if @idk not in (select ID_K from KLIENT)
			begin
				insert into KLIENT values(@idk,@emerk,@mbiemerk,@llojvep) 
				print 'U SHTUA NJE KLIENT I RI ME REKORDET:' 
					+ @nl + 
				'IDENTITET: ' + @idk 
					+ @nl + 
				'EMER: ' + @emerk 
					+ @nl + 
				'MBIEMER: ' + @mbiemerk 
					+ @nl +  
				'LLOJI I VEPRIMIT: ' + @llojvep;
			end
		else
			begin
				print 'REKORDER KRIJOJN PERPLASJE.' + @nl + 'JU LUTEM RISHIKONI TE DHENAT!'
				rollback;
			end

				select * from KLIENT
		
exec iklient 'L38495737J', Behgjet, Pacolli, Porosit


drop procedure iklient
revoke INSERT, DELETE, UPDATE to IgliGrykshi
grant exec on iklient to IgliGrykshi 

--------------------------------------------------------------------------------------------------------
----------------------------------------INDEX-----------------------------------------------------------
-----------------------TE GJITH KLIENTEVE QE KAN KRYER NJE POROSI---------------------------------------
--------------------------------------------------------------------------------------------------------

create unique index indKLIENT_POROSI on KLIENT(EMER_K asc, MBIEMER_K asc) where LLOJVEP_K = 'Porosit'
drop index indKLIENT_POROSI on KLIENT
---------------------------------------------------------------------------------------------------------
------------------------------------------FUNKSION-------------------------------------------------------
---------------------------KTHEN MESATAREN E POROSIVE TE NJE FILIALI-------------------------------------
---------------------------------------------------------------------------------------------------------

create function porosia_mesatare(@fiid int) 
	returns table
	           as 
	           return(select avg(CMIM_PO) as MESATARJA from porosi as POROSIA_MESATARE where KODI_FI = @fiid);
go
	 

drop function porosia_mesatare()
select * from porosia_mesatare(101)


----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------VIEW----------------------------------
------------------------------------------VIEW E CILA SELEKTON TE GJITH EMRAT E TABELAVE TE ARGILI SHPK---
----------------------------------------------------------------------------------------------------------
create view TABELAT_E_DATABAZES(TABELAT_E_ARGILI_SHPK)
as select TABLE_NAME from INFORMATION_SCHEMA.TABLES
where TABLE_TYPE = 'BASE TABLE' AND TABLE_CATALOG='ARGILI_SHPK'


select * from TABELAT_E_DATABAZES







-----------------------------------------------------------------------------------------------------------
--------------------------------------IGLI GRYKSHI PIKA 2--------------------------------------------------
--/////////////////////////////////////                    \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-----------------------------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------------------------
------------------------------------------TRIGGER DDL------------------------------------------------------
----------------------------------Trigger DDL qe nuk lejon krijimin e databazave te reja-------------------
-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
create trigger ddl_trig_limited on all server for create_database as 
print 'Nuk lejohet krijimi i databazes'
rollback
go
drop trigger ddl_trig_limited on all server
create database

-----------------------------------------------------------------------------------------------------------
------------------------------------------TRIGGER DML------------------------------------------------------
---------------------------------Trigger DML qe ben te mundur ndryshimet ne tabelen------------------------
------------------------------------MENAXHERE vetem ne daten 1 te cdo muaji--------------------------------
 
create trigger dml_trigg_ifadmin on MENAXHERE 
after insert as
	begin
		declare @data int;
		set @data = (select DATEPART(dd,getdate()))
		if @data != 1
			begin 
				print 'NDRYSHIMET NE TABELEN MENAXHERE KRYHEN VETEM NE DATEN 1. PER CDO INFORMACION KONTAKTONI ADMINISTRATORIN!'
				rollback
			end
	end
go
drop trigger dml_trigg_ifadmin on MENAXHERE



-----------------------------------------------------------------------------------------------------------
-------------------------------------------------PROCEDURE-------------------------------------------------
-----------------------------Procedure qe afishon emrat e user-ave te databazes----------------------------
-----------------------------------------------------------------------------------------------------------

create procedure users_ARGILI_SHPK as 
SELECT name FROM sys.database_principals where type_desc = 'SQL_USER' and default_schema_name = 'dbo'
go
exec users_ARGILI_SHPK

-----------------------------------------------------------------------------------------------------------
----------------------------------------INDEX--------------------------------------------------------------
----------------------SSN e gjithe punetoreve me rroge me to vogel se 40000--------------------------------
-----------------------------------------------------------------------------------------------------------
create index indPUNONJES_RROGE on PUNONJES(SSN_P asc) where PAGA_P <= 40000
drop index indPUNONJES_RROGE on PUNONJES

-----------------------------------------------------------------------------------------------------------
------------------------------------------FUNKSION---------------------------------------------------------
------------------------------funksion qe tregon gjithe te dhenat e punetoreve-----------------------------
-----------------------------------------------------------------------------------------------------------
create function punetor_data(@pagap int)
	returns table
			as
			return (select * from PUNONJES where PAGA_P=@pagap) ;
go

drop function punetor_data

select * from punetor_data(22000)


-----------------------------------------------------------------------------------------------------------
------------------------------------------VIEW-------------------------------------------------------------
---------------------------shfaq adresen dhe kodin e filialeve qe kane vetem 1 punetor---------------------
-----------------------------------------------------------------------------------------------------------

create view info_filial as select  KOD_FI , ADR_FI from FILIAL where NRP_FI=1 
select * from info_filial
drop view info_filial






-----------------------------------------------------------------------------------------------------------
--------------------------------------FATJON BIDINAJ PIKA 2------------------------------------------------
--/////////////////////////////////////                    \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-----------------------------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------------------------
------------------------------------------TRIGGER DML------------------------------------------------------
----------------------------------DERGON EMAIL TE ADMINISTRATORI-------------------------------------------
--------------------------------SA HERE BEHET NE TABELEN PUNONJES------------------------------------------
-----------------------------------------------------------------------------------------------------------
create trigger kujto on PUNONJES 
after insert, update, delete  
as  
   exec msdb.dbo.sp_send_dbmail  
        @profile_name = 'Kristi Buda',  
        @recipients = 'budakristi@gmail.com',  
        @body = 'U KRYEN NDRYSHIME NE DATABAZE',  
        @subject = 'KUJTESE';  
go

drop trigger kujto

-----------------------------------------------------------------------------------------------------------
------------------------------------------TRIGGER DDL------------------------------------------------------
---------------------------------NUK LEJON FSHIRJEN E ASNJE TABELE-----------------------------------------
-----------------------------------------------------------------------------------------------------------
 
create trigger no_drop on database for DROP_TABLE as
print 'NUK MUND TE FSHINI ASNJE TABELE NE DATABAZE'
rollback

drop trigger no_drop on database



-----------------------------------------------------------------------------------------------------------
-------------------------------------------------PROCEDURE-------------------------------------------------
-----------------------------SELEKTON TE GJITH PUNETORET ME PAGE MAKSIMALE---------------------------------
-----------------------------------------------------------------------------------------------------------

create procedure RROGAMAX as 
	declare @pagamax int;
	set @pagamax = (select max(PAGA_P)from PUNONJES where ID_P not in(select P.ID_P from MENAXHERE P join PUNONJES O on P.ID_P = O.ID_P));
	select EMER_P, MBIEMER_P, ID_P from punonjes where PAGA_P = @pagamax

exec RROGAMAX
drop procedure RROGAMAX

-----------------------------------------------------------------------------------------------------------
----------------------------------------INDEX--------------------------------------------------------------
-----------------------TE GJITH KLIENTEVE QE KAN KRYER NJE POROSI------------------------------------------
-----------------------------------------------------------------------------------------------------------
create index indFILIAL102 on PUNISHTE(KODP_PO asc) where KODFI_PO = 102
drop index indFILIAL102 on PUNISHTE

-----------------------------------------------------------------------------------------------------------
------------------------------------------FUNKSION---------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
create function nrpout(@kodfi int) returns int as
begin
	declare @nrp int;
	set @nrp = (select NRP_FI from FILIAL where KOD_FI = @kodfi);
	return(@nrp)
end
select nrpout(101) as 'NUMER PUNETORESH'
drop function nrpout
exec nrpout(101)

-----------------------------------------------------------------------------------------------------------
------------------------------------------VIEW-------------------------------------------------------------
---------------------------shfaq llojin dhe peshen e produktit te porositur me cmim me te ulet se 400 leke-
-----------------------------------------------------------------------------------------------------------

create view cmimprod as select LLOJ_PO, PESHE_PO from POROSI where CMIM_PO < 400

select * from cmimprod




-----------------------------------------------------------------------------------------------------------
------------------------------------------BACKUP & JOB + JOB SCHEDULE--------------------------------------
-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------

BACKUP DATABASE ARGILI_SHPK 
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL12.SQL\MSSQL\Backup\ARGILI_SHPK.BAK'
WITH FORMAT ,
 MEDIANAME = 'argilimonthly' ,
 NAME = 'Full Backup ARGILI';
GO
USE msdb ;
GO

EXEC dbo.sp_add_job
    @job_name = 'arglilimonthly' ;
GO
EXEC sp_add_jobstep
    @job_name = 'arglilimonthly',
    @step_name = 'Full Backup ARGILI',
    @command = 'Full Backup ARGILI', 
    @retry_attempts = 5,
    @retry_interval = 5 ;
GO

use msdb
go
exec sp_add_schedule
@schedule_name='timetoBackup',
@freq_type=4,
@freq_interval=1,
@active_start_time=010000;
go
USE msdb ;
GO
EXEC dbo.sp_add_jobserver
    @job_name = 'arglilimonthly';
GO