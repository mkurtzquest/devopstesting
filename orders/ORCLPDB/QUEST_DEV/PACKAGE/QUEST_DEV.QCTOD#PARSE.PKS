CREATE OR REPLACE PACKAGE QUEST_DEV.qctod#parse
IS
   TYPE item_tt IS TABLE OF VARCHAR2 (2000)
                      INDEX BY PLS_INTEGER;

   PROCEDURE string_to_list (string_in   IN     VARCHAR2
                           , items_out   IN OUT item_tt
                           , delim_in    IN     VARCHAR2 := ',');

   FUNCTION string_to_list (string_in   IN VARCHAR2
                          , delim_in    IN VARCHAR2 := ',')
      RETURN item_tt;
END qctod#parse;
/
