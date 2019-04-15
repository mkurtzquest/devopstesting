CREATE OR REPLACE PACKAGE QUEST_DEV.qctod#parse2
IS
   TYPE item_tt IS TABLE OF VARCHAR2 (2000)
                      INDEX BY VARCHAR2 (2000);

   FUNCTION string_to_list (string_in   IN VARCHAR2
                          , delim_in    IN VARCHAR2 := ',')
      RETURN item_tt;
END qctod#parse2;
/
