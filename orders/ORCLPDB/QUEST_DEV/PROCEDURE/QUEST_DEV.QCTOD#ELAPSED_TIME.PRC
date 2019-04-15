CREATE OR REPLACE PROCEDURE QUEST_DEV.qctod#elapsed_time (iterations_in IN PLS_INTEGER)
/*
Run the block of code below to determine useful timings for your tests.
DECLARE
   l_start PLS_INTEGER;
   PROCEDURE show_elapsed ( NAME_IN IN VARCHAR2 )
   IS
   BEGIN
      DBMS_OUTPUT.put_line (    '"'
                             || NAME_IN
                             || '" elapsed CPU time: '
                             || TO_CHAR ( DBMS_UTILITY.get_time - l_start  )
                             || ' hundredths of seconds'
                           );
   END show_elapsed;
BEGIN
   l_start := DBMS_UTILITY.get_time;
   qctod#elapsed_time (1);
   show_elapsed ( '1 iterations' );
   l_start := DBMS_UTILITY.get_time;
   qctod#elapsed_time (5);
   show_elapsed ( '5 iterations' );
   l_start := DBMS_UTILITY.get_time;
   qctod#elapsed_time (10);
   show_elapsed ( '10 iterations' );
   l_start := DBMS_UTILITY.get_time;
END;
*/
IS
   dummy   PLS_INTEGER;
BEGIN
   FOR indx IN 1 .. iterations_in
   LOOP
      SELECT COUNT (*) INTO dummy FROM user_source;
   END LOOP;
END qctod#elapsed_time;
/
