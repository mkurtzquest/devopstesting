CREATE OR REPLACE PROCEDURE QUEST_DEV.qctod#out_object (
   firstname_in      IN     VARCHAR2
 , lastname_in       IN     VARCHAR2
 , name_object_out      OUT qctod#name_type)
IS
   l_object   qctod#name_type := qctod#name_type (firstname_in, lastname_in);
BEGIN
   name_object_out := l_object;
END qctod#out_object;
/
