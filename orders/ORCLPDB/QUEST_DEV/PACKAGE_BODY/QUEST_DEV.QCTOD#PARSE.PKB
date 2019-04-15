CREATE OR REPLACE PACKAGE BODY QUEST_DEV.qctod#parse
IS
   FUNCTION string_to_list (string_in   IN VARCHAR2
                          , delim_in    IN VARCHAR2 := ',')
      RETURN item_tt
   IS
      l_item       VARCHAR2 (32767);
      l_loc        PLS_INTEGER;
      l_startloc   PLS_INTEGER := 1;
      items_out    item_tt;

      PROCEDURE add_item (item_in IN VARCHAR2)
      IS
      BEGIN
         IF (item_in != delim_in OR item_in IS NULL)
         THEN
            items_out (items_out.COUNT + 1) := item_in;
         END IF;
      END;
   BEGIN
      IF delim_in IS NULL
      THEN
         items_out (1) := string_in;
      ELSIF string_in IS NOT NULL
      THEN
         LOOP
            -- Find next delimiter
            l_loc := INSTR (string_in, delim_in, l_startloc);

            IF l_loc = l_startloc                     -- Previous item is NULL
            THEN
               l_item := NULL;
            ELSIF l_loc = 0                     -- Rest of string is last item
            THEN
               l_item := SUBSTR (string_in, l_startloc);
            ELSE
               l_item := SUBSTR (string_in, l_startloc, l_loc - l_startloc);
            END IF;

            add_item (l_item);

            IF l_loc = 0
            THEN
               EXIT;
            ELSE
               l_startloc := l_loc + 1;
            END IF;
         END LOOP;
      END IF;

      RETURN items_out;
   END string_to_list;

   PROCEDURE string_to_list (string_in   IN     VARCHAR2
                           , items_out   IN OUT item_tt
                           , delim_in    IN     VARCHAR2 := ',')
   IS
   BEGIN
      items_out := string_to_list (string_in, delim_in);
   END string_to_list;
END qctod#parse;
/
