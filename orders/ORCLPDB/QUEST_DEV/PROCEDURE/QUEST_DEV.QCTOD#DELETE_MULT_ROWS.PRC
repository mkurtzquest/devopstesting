CREATE OR REPLACE PROCEDURE QUEST_DEV.qctod#delete_mult_rows (
   low_in    IN PLS_INTEGER DEFAULT NULL
 , high_in   IN PLS_INTEGER DEFAULT NULL)
IS
   l_low    PLS_INTEGER := low_in;
   l_high   PLS_INTEGER := high_in;
BEGIN
   IF l_low IS NULL
   THEN
      SELECT MIN (n) INTO l_low FROM qctod#dmr_table;
   END IF;

   IF l_high IS NULL
   THEN
      SELECT MAX (n) INTO l_high FROM qctod#dmr_table;
   END IF;

   DELETE FROM qctod#dmr_table
         WHERE n BETWEEN l_low AND l_high;
END qctod#delete_mult_rows;
/
