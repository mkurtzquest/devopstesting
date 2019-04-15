CREATE OR REPLACE FUNCTION QUEST_DEV.qctod#employee_salary (
   employee_id_in IN qctod#employees.employee_id%TYPE)
   RETURN qctod#employees.salary%TYPE
IS
   retval   qctod#employees.salary%TYPE;
BEGIN
   SELECT salary
     INTO retval
     FROM qctod#employees
    WHERE employee_id = employee_id_in;

   RETURN retval;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      RETURN NULL;
END qctod#employee_salary;
/
