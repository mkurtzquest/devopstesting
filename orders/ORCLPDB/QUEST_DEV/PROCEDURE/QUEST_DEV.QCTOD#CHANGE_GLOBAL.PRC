CREATE OR REPLACE PROCEDURE QUEST_DEV.qctod#change_global (
   employee_id_in   IN qctod#employees.employee_id%TYPE
 , bonus_in         IN NUMBER)
IS
BEGIN
      UPDATE qctod#employees
         SET salary = salary + bonus_in
       WHERE employee_id = employee_id_in
   RETURNING salary
        INTO qctod#my_globals.g_total_salary;

   IF SQL%ROWCOUNT = 0
   THEN
      qctod#my_globals.g_total_salary := NULL;
   END IF;
END qctod#change_global;
/
