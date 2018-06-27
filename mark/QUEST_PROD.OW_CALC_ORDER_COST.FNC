CREATE OR REPLACE function QUEST_PROD.ow_calc_order_cost(p_id number, qty_wanted number)
return number
is
p_price        number;
p_qty_on_hand  number;
cost           number;
begin
    /*
     * Check if order detail is ok...
     */
    SELECT a.price, a.qty_on_hand
      INTO p_price, p_qty_on_hand
      FROM ow_parts a
     WHERE a.part_id = p_id;
    if (qty_wanted > p_qty_on_hand) then
        return (-1);
    end if;
    cost := p_price * qty_wanted;
    return (cost);
end;
/
