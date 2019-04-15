CREATE OR REPLACE PACKAGE BODY QUEST_DEV.ow_pack
IS
   TYPE owol_table_type IS TABLE OF ow_order_lines%ROWTYPE
      INDEX BY BINARY_INTEGER;

   owol_table   owol_table_type;

   FUNCTION ow_calc_order_cost (p_id NUMBER, qty_wanted NUMBER)
      RETURN NUMBER
   IS
      p_price         NUMBER;
      p_qty_on_hand   NUMBER;
      COST            NUMBER;
   BEGIN
      SELECT price, qty_on_hand
        INTO p_price, p_qty_on_hand
        FROM ow_parts
       WHERE part_id = p_id;

      IF (qty_wanted > p_qty_on_hand)
      THEN
         RETURN (-1);
      END IF;

      COST := p_price * qty_wanted;
      RETURN (COST);
   END ow_calc_order_cost;

   FUNCTION ow_check_cust (c_id NUMBER)
      RETURN NUMBER
   IS
      i   NUMBER;
   BEGIN
      SELECT 1
        INTO i
        FROM ow_customers
       WHERE cust_id = c_id;

      RETURN (1);
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN (-2);
   END ow_check_cust;

   FUNCTION ow_check_order (c_id NUMBER, o_id NUMBER)
      RETURN NUMBER
   IS
      i   NUMBER;
   BEGIN
      SELECT 1
        INTO i
        FROM ow_orders
       WHERE cust_id = c_id AND order_id = o_id;

      RETURN (1);
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN (-3);
   END ow_check_order;

   PROCEDURE ow_create_order (c_id NUMBER, o_id OUT NUMBER)
   IS
      local_o_id   NUMBER; --Order ID Variable, local to this procedure
   BEGIN
      SELECT   MAX (order_id)
             + 1
        INTO local_o_id
        FROM ow_orders;
/*
Identifies the highest order number and increments by one to calculate the
new order number
*/

      o_id := local_o_id;
/*
Assigns the local scope order id value to the order id variable that it will
return to the calling procedure
*/


      INSERT INTO ow_orders
                  (order_id, cust_id, order_date)
           VALUES (o_id, c_id, SYSDATE);
/*
Inserts order into order table
*/

   END ow_create_order;

   PROCEDURE ow_add_line_item (
      c_id         NUMBER,
      p_id         NUMBER,
      o_id         NUMBER,
      qty_wanted   NUMBER
   )
   IS
      val    NUMBER;
      l_id   NUMBER;
   BEGIN
      IF ow_check_order (c_id, o_id) < 0
      THEN
         raise_application_error (-20000, 'Order does not exist');
      END IF;

      val := ow_calc_order_cost (p_id, qty_wanted);

      SELECT   NVL (MAX (i_line), 0)
             + 1
        INTO l_id
        FROM ow_order_lines
       WHERE order_id = o_id;

      INSERT INTO ow_order_lines
                  (order_id, i_line, part_id, qty, VALUE, filled, paid)
           VALUES (o_id, l_id, p_id, qty_wanted, val, 0, 0);
   END ow_add_line_item;

   PROCEDURE ow_new_order (c_id NUMBER, p_id NUMBER, qty_wanted NUMBER)
   IS
      o_id   NUMBER;
   BEGIN
      IF ow_check_cust (c_id) < 0
      THEN
         raise_application_error (-20001, 'No such customer exists.');
      END IF;

      ow_create_order (c_id, o_id);
      ow_add_line_item (c_id, p_id, o_id, qty_wanted);
   END ow_new_order;

   PROCEDURE ow_parse_order (info IN VARCHAR2)
   IS
      v_info        VARCHAR2 (255)   := info;  --Input string to be parsed
      v_colon       NUMBER;                    --Variable to find location of colon delimiter
      v_comma       NUMBER;                    --Variable to find location of comma delimiter
      v_space       NUMBER;                    --Variable to find location of space delimiter
      v_exit        BOOLEAN;                   --Variable to set loop exit condition
      c_id          NUMBER;                    --Customer ID variable
      o_id          NUMBER;                    --Order ID Variable

      TYPE owol_record_type IS RECORD (
         part_id                       ow_order_lines.part_id%TYPE,
         qty                           ow_order_lines.qty%TYPE);

      owol_record   owol_record_type;  --Record variable to hold part/quanitity pair

/*
Procedure ow_parse_order parses an input string from our text based order entry system.
Customer numbers are passed in, delimited by a colon.  The product id, followed by
product quantity, is passed in, with a space separating the two.  Additional products
and quantity pairs may follow and are seperated by commas.  The parsed string is used
to create a new order and order lines as necessary.
*/

   BEGIN
      v_colon := INSTR (v_info, ':');
/* Find numeric location of colon (INSTR) in parse string */

      c_id := TRIM (SUBSTR (v_info, 1,   v_colon - 1));
/*
Initialize customer id by parsing from character 1
to colon delimiter - 1 (SUBSTR (v_info, 1,   v_colon - 1), and
stripping leading and trailing blank characters (TRIM)
*/


      IF ow_check_cust (c_id) < 0
      THEN
         raise_application_error (-20001, 'No such customer exists.');
      END IF;
/*
Use check customer function (ow_check_cust(c_id)) function
to check for existing customer record.  Raise error if customer does not exist.
*/


      ow_create_order (c_id, o_id);
/*
Call create order procedure (ow_create_order), passing customer ID and returning
the new order id.
*/

      v_info := TRIM (SUBSTR (v_info, v_colon /* +1 */)); -- Adding 1 removes the ":"
/*
Remove the customer id from the input string TRIM(SUBSTR) so that the
product and quantity pairs can be parsed and inserted using the following loop.
*/


      LOOP
         v_comma := INSTR (v_info, ',');
/*
Finds the comma delimiter seperating product/quantity pairs
*/

         IF v_comma = 0
         THEN
            v_comma :=   LENGTH (v_info)
                       + 1;
            v_exit := TRUE;
         END IF;
/*
If there are no comma's, set the exit variable to true
*/


         v_space := INSTR (v_info, ' '); --Find the location of the space delimiter
         owol_record.part_id := TRIM (SUBSTR (v_info, 1, v_space));
/*
Parse and assign the part id to the record variable
*/
         owol_record.qty :=
                          TRIM (SUBSTR (v_info, v_space,   v_comma
                                                         - v_space));
/*
Parse and assign the quantity variable to the record variable
*/

         ow_add_line_item (c_id, owol_record.part_id, o_id, owol_record.qty);
/*
Pass the customer identifier, part identifier, order identifier and quanity
to the add line item procedure
*/


         v_info := TRIM (SUBSTR (v_info,   v_comma
                                         + 1));
/*
Trim the part/quantity pair that was just entered
*/

         EXIT WHEN v_exit;
      END LOOP;
   END ow_parse_order;



END ow_pack;
/
