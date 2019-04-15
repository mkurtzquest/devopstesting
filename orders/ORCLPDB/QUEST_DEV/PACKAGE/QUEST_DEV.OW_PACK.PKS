CREATE OR REPLACE PACKAGE QUEST_DEV.ow_pack
IS
   FUNCTION ow_calc_order_cost (p_id NUMBER, qty_wanted NUMBER)
      RETURN NUMBER;

   PROCEDURE ow_add_line_item (
      c_id         NUMBER,
      p_id         NUMBER,
      o_id         NUMBER,
      qty_wanted   NUMBER
   );

   PROCEDURE ow_new_order (c_id NUMBER, p_id NUMBER, qty_wanted NUMBER);

   PROCEDURE ow_parse_order (info IN VARCHAR2);
END ow_pack;
/
