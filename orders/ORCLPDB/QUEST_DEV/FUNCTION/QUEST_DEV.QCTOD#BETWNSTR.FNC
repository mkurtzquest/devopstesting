CREATE OR REPLACE FUNCTION QUEST_DEV.qctod#betwnstr (string_in      IN VARCHAR2
                                         , start_in       IN PLS_INTEGER
                                         , end_in         IN PLS_INTEGER
                                         , inclusive_in   IN BOOLEAN := TRUE)
   RETURN VARCHAR2
IS
   v_start      PLS_INTEGER;
   v_numchars   PLS_INTEGER;
BEGIN
   IF    string_in IS NULL
      OR (start_in < 0 AND end_in > 0)
      OR (start_in > 0 AND end_in < 0)
      OR (start_in < 0 AND end_in > start_in)
      OR (start_in > 0 AND end_in < start_in)
   THEN
      RETURN NULL;
   ELSE
      IF start_in < 0
      THEN
         v_numchars := ABS (end_in) - ABS (start_in) + 1;
         v_start := GREATEST (end_in, -1 * LENGTH (string_in));
      ELSIF start_in = 0
      THEN
         v_start := 1;
         v_numchars := ABS (end_in) - ABS (v_start) + 1;
      ELSE
         v_start := start_in;
         v_numchars := ABS (end_in) - ABS (v_start) + 1;
      END IF;

      IF NOT NVL (inclusive_in, FALSE)
      THEN
         v_start := v_start + 1;
         v_numchars := v_numchars - 2;
      END IF;

      RETURN (SUBSTR (string_in, v_start, v_numchars));
   END IF;
END qctod#betwnstr;
/
