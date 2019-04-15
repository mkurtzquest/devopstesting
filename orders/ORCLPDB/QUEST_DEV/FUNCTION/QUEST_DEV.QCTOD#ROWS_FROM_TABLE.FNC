CREATE OR REPLACE FUNCTION QUEST_DEV.qctod#rows_from_table (
   table_in         IN VARCHAR2
 , column_list_in   IN VARCHAR2 DEFAULT NULL)
   RETURN SYS_REFCURSOR
IS
   l_curvar   SYS_REFCURSOR;
BEGIN
   OPEN l_curvar FOR
      'select ' || NVL (column_list_in, '*') || ' from ' || table_in;

   RETURN l_curvar;
END qctod#rows_from_table;
/
