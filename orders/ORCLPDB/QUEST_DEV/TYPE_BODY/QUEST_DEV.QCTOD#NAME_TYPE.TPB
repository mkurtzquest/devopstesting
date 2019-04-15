CREATE OR REPLACE TYPE BODY QUEST_DEV.qctod#name_type
AS
   MEMBER FUNCTION full_name (self IN OUT qctod#name_type)
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN self.firstname || ' ' || self.lastname;
   END;
END;
/
