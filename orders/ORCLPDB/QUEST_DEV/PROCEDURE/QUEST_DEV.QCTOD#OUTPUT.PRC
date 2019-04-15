CREATE OR REPLACE PROCEDURE QUEST_DEV.qctod#output
IS
BEGIN
   DBMS_OUTPUT.put_line ('abc');
   DBMS_OUTPUT.put_line ('def');
   DBMS_OUTPUT.put_line ('123');
END qctod#output;
/
