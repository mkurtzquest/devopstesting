CREATE OR REPLACE TRIGGER QUEST_DEV.ow_order_trigger
    after INSERT ON QUEST_DEV.OW_ORDERS
    for each row
begin
    return;
end;
/
