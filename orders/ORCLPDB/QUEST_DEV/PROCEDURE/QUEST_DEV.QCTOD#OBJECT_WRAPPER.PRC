CREATE OR REPLACE PROCEDURE QUEST_DEV.qctod#object_wrapper (
   firstname_in   IN     VARCHAR2
 , lastname_in    IN     VARCHAR2
 , fullname_out      OUT VARCHAR2)
IS
   l_object   qctod#name_type := qctod#name_type (firstname_in, lastname_in);
BEGIN
   fullname_out := l_object.full_name;
END qctod#object_wrapper;
/
