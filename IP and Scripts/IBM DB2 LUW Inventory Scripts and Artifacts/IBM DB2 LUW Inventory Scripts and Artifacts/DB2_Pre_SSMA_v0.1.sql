﻿--
-- Pre SSMA Query Script
-- For DB2 LUW
-- Version 0.1
--
-- Tested on IBM DB2 version 11.1 on Red Hat Linux 7.3
--
-- Created by:
--   Jonathon Frost (jfrost@microsoft.com)
--   Lou Carbone (lcarbone@microsoft.com)
--
-- DIRECTIONS:
-- To run script, use the following command using the 'db2' command:
--
-- Where 'db2output.csv' is the name of the output file
-- 'DB2_Pre_SSMA_v0.1.sql' is the name of the input script
--
-- [db2user@host ~]$ db2 -txf DB2_Pre_SSMA_v0.1.sql -z db2output.csv
--



--
-- BLOB and CLOB
--

select

	trim(e.OS_NAME) CONCAT ',' CONCAT
	trim(e.HOST_NAME) CONCAT ',' CONCAT
	trim(i.INST_NAME) CONCAT ',' CONCAT
	trim(i.SERVICE_LEVEL) CONCAT ',' CONCAT
	trim((SELECT CURRENT SERVER FROM SYSIBM.SYSDUMMY1)) CONCAT ',' CONCAT
	trim(v.TABSCHEMA) CONCAT ',' CONCAT
	
	v.typename CONCAT ',' CONCAT
	
	COALESCE(count(v.typename), 1) CONCAT ',1,1'		

from syscat.columns as v, TABLE(SYSPROC.ENV_GET_SYS_INFO()) as e, TABLE(SYSPROC.ENV_GET_INST_INFO()) as i
where v.typename in ('BLOB', 'CLOB')
group by e.OS_NAME, i.SERVICE_LEVEL, i.INST_NAME, e.HOST_NAME, v.TABSCHEMA, v.typename;


--
-- TABLE PARTITIONS
--

select

	trim(e.OS_NAME) CONCAT ',' CONCAT
	trim(e.HOST_NAME) CONCAT ',' CONCAT
	trim(i.INST_NAME) CONCAT ',' CONCAT
	trim(i.SERVICE_LEVEL) CONCAT ',' CONCAT
	trim((SELECT CURRENT SERVER FROM SYSIBM.SYSDUMMY1)) CONCAT ',' CONCAT
	trim(v.TABSCHEMA) CONCAT ',' CONCAT	
	'TABLE PARTITION' CONCAT ',' CONCAT	
	COALESCE(count(v.TABNAME), 1) CONCAT ',1,1'		

from syscat.TABDETACHEDDEP as v, TABLE(SYSPROC.ENV_GET_SYS_INFO()) as e, TABLE(SYSPROC.ENV_GET_INST_INFO()) as i
group by e.OS_NAME, i.SERVICE_LEVEL, i.INST_NAME, e.HOST_NAME, v.TABSCHEMA;


--
-- ALIASES
--

select

	trim(e.OS_NAME) CONCAT ',' CONCAT
	trim(e.HOST_NAME) CONCAT ',' CONCAT
	trim(i.INST_NAME) CONCAT ',' CONCAT
	trim(i.SERVICE_LEVEL) CONCAT ',' CONCAT
	trim((SELECT CURRENT SERVER FROM SYSIBM.SYSDUMMY1)) CONCAT ',' CONCAT
	trim(v.TABSCHEMA) CONCAT ',' CONCAT	
	'ALIAS' CONCAT ',' CONCAT	
	COALESCE(count(v.TABNAME), 1) CONCAT ',1,1'		

from syscat.tables as v, TABLE(SYSPROC.ENV_GET_SYS_INFO()) as e, TABLE(SYSPROC.ENV_GET_INST_INFO()) as i
where v.type = 'A'
group by e.OS_NAME, i.SERVICE_LEVEL, i.INST_NAME, e.HOST_NAME, v.TABSCHEMA;


--
-- MATERIALIZED QUERY TABLES
--

select

	trim(e.OS_NAME) CONCAT ',' CONCAT
	trim(e.HOST_NAME) CONCAT ',' CONCAT
	trim(i.INST_NAME) CONCAT ',' CONCAT
	trim(i.SERVICE_LEVEL) CONCAT ',' CONCAT
	trim((SELECT CURRENT SERVER FROM SYSIBM.SYSDUMMY1)) CONCAT ',' CONCAT
	trim(v.TABSCHEMA) CONCAT ',' CONCAT	
	'MATERIALIZED QUERY TABLE' CONCAT ',' CONCAT	
	COALESCE(count(v.TABNAME), 1) CONCAT ',1,1'		

from syscat.tables as v, TABLE(SYSPROC.ENV_GET_SYS_INFO()) as e, TABLE(SYSPROC.ENV_GET_INST_INFO()) as i
where v.type = 'S'
group by e.OS_NAME, i.SERVICE_LEVEL, i.INST_NAME, e.HOST_NAME, v.TABSCHEMA;


--
-- INDEXES
--

select

	trim(e.OS_NAME) CONCAT ',' CONCAT
	trim(e.HOST_NAME) CONCAT ',' CONCAT
	trim(i.INST_NAME) CONCAT ',' CONCAT
	trim(i.SERVICE_LEVEL) CONCAT ',' CONCAT
	trim((SELECT CURRENT SERVER FROM SYSIBM.SYSDUMMY1)) CONCAT ',' CONCAT
	trim(v.INDSCHEMA) CONCAT ',' CONCAT	
	'INDEX' CONCAT ',' CONCAT	
	COALESCE(count(v.INDNAME), 1) CONCAT ',1,1'		

from syscat.indexes as v, TABLE(SYSPROC.ENV_GET_SYS_INFO()) as e, TABLE(SYSPROC.ENV_GET_INST_INFO()) as i
group by e.OS_NAME, i.SERVICE_LEVEL, i.INST_NAME, e.HOST_NAME, v.INDSCHEMA;


--
-- SEQUENCES
--

select

	trim(e.OS_NAME) CONCAT ',' CONCAT
	trim(e.HOST_NAME) CONCAT ',' CONCAT
	trim(i.INST_NAME) CONCAT ',' CONCAT
	trim(i.SERVICE_LEVEL) CONCAT ',' CONCAT
	trim((SELECT CURRENT SERVER FROM SYSIBM.SYSDUMMY1)) CONCAT ',' CONCAT
	trim(v.SEQSCHEMA) CONCAT ',' CONCAT
	
	'SEQUENCE' CONCAT ',' CONCAT
	
	COALESCE(count(v.SEQNAME), 1) CONCAT ',1,1'		

from syscat.sequences as v, TABLE(SYSPROC.ENV_GET_SYS_INFO()) as e, TABLE(SYSPROC.ENV_GET_INST_INFO()) as i
group by e.OS_NAME, i.SERVICE_LEVEL, i.INST_NAME, e.HOST_NAME, v.SEQSCHEMA;


--
-- TRIGGERS
--

select

	trim(e.OS_NAME) CONCAT ',' CONCAT
	trim(e.HOST_NAME) CONCAT ',' CONCAT
	trim(i.INST_NAME) CONCAT ',' CONCAT
	trim(i.SERVICE_LEVEL) CONCAT ',' CONCAT
	trim((SELECT CURRENT SERVER FROM SYSIBM.SYSDUMMY1)) CONCAT ',' CONCAT
	trim(v.TRIGSCHEMA) CONCAT ',' CONCAT
	
	'TRIGGER' CONCAT ',' CONCAT
	
	COALESCE(count(v.TRIGNAME), 1) CONCAT ',' CONCAT
	COALESCE(sum(length(v.TEXT)), 1) CONCAT ',' CONCAT
	COALESCE((sum(length(v.TEXT)) / count(v.TRIGNAME)), 1)	

from syscat.triggers as v, TABLE(SYSPROC.ENV_GET_SYS_INFO()) as e, TABLE(SYSPROC.ENV_GET_INST_INFO()) as i
group by e.OS_NAME, i.SERVICE_LEVEL, i.INST_NAME, e.HOST_NAME, v.TRIGSCHEMA;


--
--  VIEWS
--

select

	trim(e.OS_NAME) CONCAT ',' CONCAT
	trim(e.HOST_NAME) CONCAT ',' CONCAT
	trim(i.INST_NAME) CONCAT ',' CONCAT
	trim(i.SERVICE_LEVEL) CONCAT ',' CONCAT
	trim((SELECT CURRENT SERVER FROM SYSIBM.SYSDUMMY1)) CONCAT ',' CONCAT
	trim(v.VIEWSCHEMA) CONCAT ',' CONCAT
	
	'VIEW' CONCAT ',' CONCAT
	
	COALESCE(count(v.VIEWNAME), 1) CONCAT ',' CONCAT
	COALESCE(sum(length(v.TEXT)), 1) CONCAT ',' CONCAT
	COALESCE((sum(length(v.TEXT)) / count(v.VIEWNAME)), 1)	

from syscat.views as v, TABLE(SYSPROC.ENV_GET_SYS_INFO()) as e, TABLE(SYSPROC.ENV_GET_INST_INFO()) as i
group by e.OS_NAME, i.SERVICE_LEVEL, i.INST_NAME, e.HOST_NAME, v.VIEWSCHEMA;


--
--  PROCEDURES, FUNCTIONS, METHODS
--

select

	trim(e.OS_NAME) CONCAT ',' CONCAT	
	trim(e.HOST_NAME) CONCAT ',' CONCAT
	trim(i.INST_NAME) CONCAT ',' CONCAT
	trim(i.SERVICE_LEVEL) CONCAT ',' CONCAT
	trim((SELECT CURRENT SERVER FROM SYSIBM.SYSDUMMY1)) CONCAT ',' CONCAT
	trim(v.ROUTINESCHEMA) CONCAT ',' CONCAT

	case when v.ROUTINETYPE = 'P' then 'PROCEDURE'
		 when v.ROUTINETYPE = 'F' then 'FUNCTION'
		 when v.ROUTINETYPE = 'M' then 'METHOD'
	end CONCAT ',' CONCAT

	COALESCE(count(v.ROUTINENAME), 1) CONCAT ',' CONCAT
	COALESCE(sum(length(v.TEXT)), 1) CONCAT ',' CONCAT
	COALESCE((sum(length(v.TEXT)) / count(v.ROUTINENAME)), 1)	

from syscat.routines as v, TABLE(SYSPROC.ENV_GET_SYS_INFO()) as e, TABLE(SYSPROC.ENV_GET_INST_INFO()) as i
group by e.OS_NAME, i.SERVICE_LEVEL, i.INST_NAME, e.HOST_NAME, v.ROUTINESCHEMA, v.ROUTINETYPE;












--
-- RAW DATA
--

select

	trim(e.OS_NAME) CONCAT ',' CONCAT
	trim(e.HOST_NAME) CONCAT ',' CONCAT
	trim(i.INST_NAME) CONCAT ',' CONCAT
	trim(i.SERVICE_LEVEL) CONCAT ',' CONCAT
	trim((SELECT CURRENT SERVER FROM SYSIBM.SYSDUMMY1)) CONCAT ',' CONCAT
	trim(v.TABSCHEMA) CONCAT ',,' CONCAT
	
	'RAW DATA (MB)' CONCAT ',' CONCAT
	
	round((sum(v.CARD * v.AVGROWSIZE) * 0.000001), 2)
	
from syscat.tables as v, TABLE(SYSPROC.ENV_GET_SYS_INFO()) as e, TABLE(SYSPROC.ENV_GET_INST_INFO()) as i
group by e.OS_NAME, i.SERVICE_LEVEL, i.INST_NAME, e.HOST_NAME, v.TABSCHEMA;


--
-- TABLE SIZING
--

select

	trim(e.OS_NAME) CONCAT ',' CONCAT
	trim(e.HOST_NAME) CONCAT ',' CONCAT
	trim(i.INST_NAME) CONCAT ',' CONCAT
	trim(i.SERVICE_LEVEL) CONCAT ',' CONCAT
	trim((SELECT CURRENT SERVER FROM SYSIBM.SYSDUMMY1)) CONCAT ',' CONCAT
	trim(v.TABSCHEMA) CONCAT ',' CONCAT	
	v.TABNAME CONCAT ',' CONCAT
	
	'TABLE SIZING' CONCAT ',' CONCAT
	
	v.CARD CONCAT ',' CONCAT
	v.AVGROWSIZE CONCAT ',' CONCAT
	(v.CARD * v.AVGROWSIZE)
	
	
from syscat.tables as v, TABLE(SYSPROC.ENV_GET_SYS_INFO()) as e, TABLE(SYSPROC.ENV_GET_INST_INFO()) as i
where v.type = 'T';