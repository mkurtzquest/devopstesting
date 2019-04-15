CREATE OR REPLACE PACKAGE BODY QUEST_DEV.qctod#test_records
IS
   PROCEDURE fetch_into_rowtype (
      employee_id_in   IN     qctod#employees.employee_id%TYPE
    , row_out             OUT qctod#employees%ROWTYPE)
   IS
      l_row       qctod#employees%ROWTYPE;
      empty_row   qctod#employees%ROWTYPE;
   BEGIN
      SELECT *
        INTO l_row
        FROM qctod#employees
       WHERE employee_id = employee_id_in;

      row_out := l_row;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         row_out := empty_row;
   END fetch_into_rowtype;

   FUNCTION name_and_salary (
      employee_id_in IN qctod#employees.employee_id%TYPE)
      RETURN name_salary_rt
   IS
      l_row       name_salary_rt;
      empty_row   name_salary_rt;
   BEGIN
      SELECT last_name, salary
        INTO l_row
        FROM qctod#employees
       WHERE employee_id = employee_id_in;

      RETURN l_row;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN empty_row;
   END name_and_salary;

   FUNCTION eq_name_and_salary (rec1        name_salary_rt
                              , rec2        name_salary_rt
                              , nulls_ok    BOOLEAN)
      RETURN BOOLEAN
   IS
   BEGIN
      RETURN (rec1.lname = rec2.lname
              OR (rec1.lname IS NULL AND rec2.lname IS NULL))
             AND (rec1.sal = rec2.sal
                  OR (rec1.sal IS NULL AND rec2.sal IS NULL));
   END eq_name_and_salary;
END qctod#test_records;
/
