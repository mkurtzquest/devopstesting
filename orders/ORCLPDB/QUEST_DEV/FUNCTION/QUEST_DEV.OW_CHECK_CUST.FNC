CREATE OR REPLACE function QUEST_DEV.ow_check_cust(c_id number)
return number
AS
I   number;
begin
    /*
     * Check that customer exists...
     */
    SELECT 1
      INTO I
      FROM ow_customers a
     WHERE a.cust_id = c_id;
    return (1);
exception
    when others then return (0);
end;
/
