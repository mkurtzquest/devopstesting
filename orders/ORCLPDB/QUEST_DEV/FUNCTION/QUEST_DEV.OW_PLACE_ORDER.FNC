CREATE OR REPLACE function QUEST_DEV.ow_place_order(c_id number, p_id number,
     o_id number, qty_wanted number, l_id number)
return number
AS
i           number;
result      number;
val         number;
local_o_id  number;
begin
    /*
     * If ORDER_ID not given, this is a new order...
     */
    local_o_id := o_id;
    if o_id < 0 then
        local_o_id := ow_create_order(c_id);
        if (o_id < 0) then
            return (-2);
        end if;
    end if;
    val := ow_calc_order_cost(p_id, qty_wanted);
    if (val <= 0) then
        return (-3);
    end if;
    /*
     * Insert one particular line for the entire order.
     */
    INSERT INTO ow_order_lines
        (order_id,
         i_line,
         part_id,
         qty,
         value,
         filled,
         paid)
    VALUES
        (local_o_id,
         l_id,
         p_id,
         qty_wanted,
         val,
         0,
         0);
    return (local_o_id);
exception
    when others then return (-4);
end ow_place_order;
/
