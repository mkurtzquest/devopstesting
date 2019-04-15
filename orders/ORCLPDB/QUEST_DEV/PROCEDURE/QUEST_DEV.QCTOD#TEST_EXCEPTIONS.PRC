CREATE OR REPLACE PROCEDURE QUEST_DEV.qctod#test_exceptions (
   raise_ndf_in           IN BOOLEAN DEFAULT FALSE
 , raise_20000_in         IN BOOLEAN DEFAULT FALSE
 , raise_unknown_in       IN BOOLEAN DEFAULT FALSE
 , raise_nothing_in       IN BOOLEAN DEFAULT FALSE
 , cause_div_by_zero_in   IN BOOLEAN DEFAULT FALSE)
IS
BEGIN
   CASE
      WHEN raise_ndf_in
      THEN
         RAISE NO_DATA_FOUND;
      WHEN raise_20000_in
      THEN
         raise_application_error (-20000, '-20000 error');
      WHEN raise_unknown_in
      THEN
         RAISE PROGRAM_ERROR;
      WHEN raise_nothing_in
      THEN
         NULL;
      WHEN cause_div_by_zero_in
      THEN
         DBMS_OUTPUT.put_line (1 / 0);
   END CASE;
END qctod#test_exceptions;
/
