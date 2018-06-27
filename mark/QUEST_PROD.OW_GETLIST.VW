CREATE OR REPLACE FORCE VIEW QUEST_PROD.OW_GETLIST
(BIN, PART_ID, NUM)
BEQUEATH DEFINER
AS 
select b.bin, b.part_id, sum(a.qty) num
from ow_order_lines a, ow_parts b
where a.filled = 0 and a.part_id = b.part_id
group by b.bin, b.part_id;
