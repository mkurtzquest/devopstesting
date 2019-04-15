CREATE OR REPLACE PACKAGE QUEST_DEV.qctod#string_tracker
/*
Overview: qctod#string_tracker allows you to keep track of whether a
certain name has already been used within a particular list.
Author: Steven Feuerstein
You are permitted to use this code in your own applications.
Requirements:
   * Oracle9i Database Release 2 and above
*/
IS
   SUBTYPE maxvarchar2_t IS VARCHAR2 (32767);

   TYPE used_aat IS TABLE OF BOOLEAN
                       INDEX BY maxvarchar2_t;

   TYPE list_of_lists_aat IS TABLE OF used_aat
                                INDEX BY maxvarchar2_t;

   PROCEDURE clear_all_lists;

   PROCEDURE CLEAR_LIST (list_in IN maxvarchar2_t);

   -- Is the string already in use?
   FUNCTION string_in_use (list_in             IN maxvarchar2_t
                         , value_in            IN maxvarchar2_t
                         , case_sensitive_in   IN BOOLEAN DEFAULT FALSE)
      RETURN BOOLEAN;

   -- Mark this string as being used.
   PROCEDURE mark_as_used (list_in             IN maxvarchar2_t
                         , value_in            IN maxvarchar2_t
                         , case_sensitive_in   IN BOOLEAN DEFAULT FALSE);

   FUNCTION used_list (list_in IN maxvarchar2_t)
      RETURN used_aat;
END qctod#string_tracker;
/
