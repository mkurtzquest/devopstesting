CREATE OR REPLACE PROCEDURE QUEST_DEV.qctod#update_employee (
   employee_id_in   IN PLS_INTEGER
 , new_salary_in    IN NUMBER)
IS
BEGIN
   UPDATE qctod#employees
      SET salary = new_salary_in
    WHERE employee_id = employee_id_in;
END qctod#update_employee;
/
