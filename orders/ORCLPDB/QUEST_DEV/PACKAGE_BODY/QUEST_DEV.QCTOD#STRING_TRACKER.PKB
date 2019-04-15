CREATE OR REPLACE PACKAGE BODY QUEST_DEV.qctod#string_tracker
/*
Overview: qctod#string_tracker allows you to keep track of whether a
certain name has already been used within a particular list.
Author: Steven Feuerstein
You are permitted to use this code in your own applications.
Requirements:
   * Oracle9i Database Release 2 and above
*/
IS
   g_list_of_lists   list_of_lists_aat;

   PROCEDURE assert (expr_in IN BOOLEAN, text_in IN VARCHAR2)
   IS
   BEGIN
      IF NOT expr_in OR expr_in IS NULL
      THEN
         raise_application_error (-20000, text_in);
      END IF;
   END assert;

   PROCEDURE clear_all_lists
   IS
   BEGIN
      g_list_of_lists.delete;
   END clear_all_lists;

   PROCEDURE CLEAR_LIST (list_in IN maxvarchar2_t)
   IS
   BEGIN
      g_list_of_lists.delete (list_in);
   END CLEAR_LIST;

   FUNCTION string_in_use (list_in             IN maxvarchar2_t
                         , value_in            IN maxvarchar2_t
                         , case_sensitive_in   IN BOOLEAN DEFAULT FALSE)
      RETURN BOOLEAN
   IS
      l_flag   BOOLEAN;
   BEGIN
      assert (list_in IS NOT NULL
            , 'You must provide a non-NULL name for your list!');
      assert (value_in IS NOT NULL
            , 'You must provide a non-NULL string for tracking!');
      l_flag :=
         g_list_of_lists (
            list_in) (
            CASE case_sensitive_in
               WHEN TRUE THEN value_in
               ELSE UPPER (value_in)
            END);
      RETURN TRUE;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN FALSE;
   END string_in_use;

   PROCEDURE mark_as_used (list_in             IN maxvarchar2_t
                         , value_in            IN maxvarchar2_t
                         , case_sensitive_in   IN BOOLEAN DEFAULT FALSE)
   IS
   BEGIN
      assert (value_in IS NOT NULL
            , 'You must provide a non-NULL name for your list!');
      assert (value_in IS NOT NULL
            , 'You must provide a non-NULL string for tracking!');
      g_list_of_lists (
         list_in) (
         CASE case_sensitive_in
            WHEN TRUE THEN value_in
            ELSE UPPER (value_in)
         END) :=
         TRUE;
   END mark_as_used;

   FUNCTION used_list (list_in IN maxvarchar2_t)
      RETURN used_aat
   IS
      l_empty   used_aat;
   BEGIN
      RETURN g_list_of_lists (list_in);
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN l_empty;
   END used_list;
END qctod#string_tracker;
/
