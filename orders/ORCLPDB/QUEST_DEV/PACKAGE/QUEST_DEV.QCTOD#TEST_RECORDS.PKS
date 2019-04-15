CREATE OR REPLACE PACKAGE QUEST_DEV.qctod#test_records
IS
   -- Note that the names of the record must match
   TYPE name_salary_rt IS RECORD
   (
      lname   qctod#employees.last_name%TYPE
    , sal     qctod#employees.salary%TYPE
   );

   -- Show how to test a table-based record contents.
   -- Remember that the assertion code only fetches the first
   -- row identified by the query against the table!
   PROCEDURE fetch_into_rowtype (
      employee_id_in   IN     qctod#employees.employee_id%TYPE
    , row_out             OUT qctod#employees%ROWTYPE);

   --  Show how to test a user-defined record contents.
   --  Remember that the assertion code only fetches the first
   --  row identified by the query against the table!
   --  A SELECT FROM dual works nicely. You need to include column aliases
   --  in the select list to make sure the generated assertion code
   --  creates a valid equality check for the record.
   FUNCTION name_and_salary (
      employee_id_in IN qctod#employees.employee_id%TYPE)
      RETURN name_salary_rt;

   FUNCTION eq_name_and_salary (rec1        name_salary_rt
                              , rec2        name_salary_rt
                              , nulls_ok    BOOLEAN)
      RETURN BOOLEAN;
END qctod#test_records;
/
