CREATE OR REPLACE PROCEDURE QUEST_DEV.qctod#insert_employee (fname_in    IN VARCHAR2
                                                 , lname_in    IN VARCHAR2
                                                 , email_in    IN VARCHAR2
                                                 , hdate_in    IN DATE
                                                 , job_id_in   IN VARCHAR2
                                                 , salary_in   IN NUMBER)
IS
   l_seq   PLS_INTEGER;
BEGIN
   IF lname_in = 'FEUERSTEIN'
   THEN
      NULL;
   ELSE
      SELECT MAX (employee_id) INTO l_seq FROM qctod#employees;

      INSERT INTO qctod#employees (employee_id
                                 , first_name
                                 , last_name
                                 , email
                                 , hire_date
                                 , job_id
                                 , salary)
           VALUES (l_seq + 1
                 , fname_in
                 , lname_in
                 , email_in
                 , hdate_in
                 , job_id_in
                 , salary_in);
   END IF;
END qctod#insert_employee;
/
