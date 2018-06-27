CREATE OR REPLACE function QUEST_PROD.ow_create_order(c_id number)
return number
AS
o_id   number;
result number;
begin
    result := ow_check_cust(c_id);
    if (result <= 0) then
        return (-1);
    end if;
    /*
     * Create a new order record...
     */
    SELECT max(a.order_id)
      INTO o_id
      FROM ow_orders a;
    UPDATE ow_orders
       SET order_id = o_id+1;
    INSERT INTO ow_orders
      (order_id,
       cust_id,
       order_date)
    VALUES
      (o_id,
       c_id,
       SYSDATE);
    return (o_id);
exception
    when others then return (-1);
end;
/
