/*added this comment line */

SELECT   b.order_date, d.price, a.cust_id, a.NAME, c.qty, d.part_id,
         d.qty_on_hand
    FROM quest_dev.ow_customers a, quest_dev.ow_orders b, quest_dev.ow_order_lines c, quest_dev.ow_parts d
   WHERE (d.part_id = c.part_id)
     AND (b.order_id = c.order_id)
     AND (b.cust_id = a.cust_id)
     AND (d.part_id = c.part_id)
     AND (c.order_id = b.order_id)
     AND d.price IN (SELECT price FROM quest_dev.ow_parts WHERE price IN (SELECT price FROM quest_dev.ow_parts))
     AND (price < 150)
     AND (d.qty_on_hand < 250)
ORDER BY b.order_date ASC
