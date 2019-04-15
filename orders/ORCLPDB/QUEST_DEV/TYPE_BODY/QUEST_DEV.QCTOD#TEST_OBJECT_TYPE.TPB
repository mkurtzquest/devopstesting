CREATE OR REPLACE TYPE BODY QUEST_DEV.qctod#test_object_type
IS
   CONSTRUCTOR FUNCTION qctod#test_object_type (
      self         IN OUT NOCOPY qctod#test_object_type
    , attr1_only   IN            VARCHAR2)
      RETURN SELF AS RESULT
   IS
   BEGIN
      self.attr1 := attr1_only;
      self.attr2 := 123;
      RETURN;
   END qctod#test_object_type;

   STATIC PROCEDURE return_attr2 (attr2 IN NUMBER, attr2_out OUT NUMBER)
   IS
   BEGIN
      attr2_out := attr2;
   END;

   MEMBER FUNCTION return_as_attr2 (n IN NUMBER)
      RETURN NUMBER
   IS
   BEGIN
      RETURN n;
   END;

   MEMBER FUNCTION return_as_attr2_self_inout (
      self   IN OUT qctod#test_object_type
    , n      IN     NUMBER)
      RETURN NUMBER
   IS
   BEGIN
      self.attr2 := n;
      RETURN n;
   END;

   MEMBER PROCEDURE return_attr1 (attr1 IN VARCHAR2, attr1_out OUT VARCHAR2)
   IS
   BEGIN
      self.attr1 := attr1;
      attr1_out := attr1;
   END;

   /*
   MAP MEMBER FUNCTION map_type
      RETURN NUMBER
   IS
   BEGIN
      RETURN attr2;
   END;
   */

   ORDER MEMBER FUNCTION order_type (compare_to_in IN qctod#test_object_type)
      RETURN INTEGER
   IS
   BEGIN
      RETURN CASE
                WHEN self.attr2 > compare_to_in.attr2 THEN 1
                WHEN self.attr2 < compare_to_in.attr2 THEN -1
                ELSE 0
             END;
   END;
END;
/
