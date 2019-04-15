CREATE OR REPLACE PACKAGE QUEST_DEV.qctod#file_io
IS
   PROCEDURE copy_file (dir_in         IN VARCHAR2
                      , orig_file_in   IN VARCHAR2
                      , new_file_in    IN VARCHAR2);

   FUNCTION file_exists (dir_in IN VARCHAR2, file_in IN VARCHAR2)
      RETURN BOOLEAN;
END qctod#file_io;
/
