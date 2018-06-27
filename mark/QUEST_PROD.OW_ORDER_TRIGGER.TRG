CREATE OR REPLACE TRIGGER QUEST_PROD.ow_order_trigger
    after INSERT ON QUEST_PROD.OW_ORDERS
    for each row
begin
    return;
end;
/
