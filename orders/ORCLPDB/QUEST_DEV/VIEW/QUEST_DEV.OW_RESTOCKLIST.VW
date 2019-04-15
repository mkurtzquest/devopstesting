CREATE OR REPLACE FORCE VIEW QUEST_DEV.OW_RESTOCKLIST
(BIN, PART_ID, QTY_ON_HAND, RESTOCK_QTY)
BEQUEATH DEFINER
AS 
select bin, part_id, qty_on_hand, restock_qty from ow_parts
where qty_on_hand < restock_qty;
