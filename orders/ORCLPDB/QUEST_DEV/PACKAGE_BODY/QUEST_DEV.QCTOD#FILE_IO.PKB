CREATE OR REPLACE PACKAGE BODY QUEST_DEV.qctod#file_io
IS
   TYPE fgetattr_t IS RECORD
   (
      fexists       BOOLEAN
    , file_length   PLS_INTEGER
    , block_size    PLS_INTEGER
   );

   PROCEDURE copy_file (dir_in         IN VARCHAR2
                      , orig_file_in   IN VARCHAR2
                      , new_file_in    IN VARCHAR2)
   IS
   BEGIN
      UTL_FILE.fcopy (dir_in
                    , orig_file_in
                    , dir_in
                    , new_file_in);
   EXCEPTION
      WHEN OTHERS
      THEN
         -- Ignore the problem. Nothing copied....
         NULL;
   END copy_file;

   FUNCTION file_exists (dir_in IN VARCHAR2, file_in IN VARCHAR2)
      RETURN BOOLEAN
   IS
      fgetattr_rec   fgetattr_t;
   BEGIN
      UTL_FILE.fgetattr (location      => dir_in
                       , filename      => file_in
                       , fexists       => fgetattr_rec.fexists
                       , file_length   => fgetattr_rec.file_length
                       , block_size    => fgetattr_rec.block_size);

      -- Bug #2240685. fexists is always returned TRUE
      -- But non-existent file has ZERO file_length and block_size
      IF fgetattr_rec.file_length = 0 AND fgetattr_rec.block_size = 0
      THEN
         RETURN FALSE;
      ELSE
         RETURN TRUE;
      END IF;
   -- When the bug is fixed, comment OUT the above
   -- and uncomment this:
   -- RETURN fgetattr_rec.fexists;
   END file_exists;
END qctod#file_io;
/
