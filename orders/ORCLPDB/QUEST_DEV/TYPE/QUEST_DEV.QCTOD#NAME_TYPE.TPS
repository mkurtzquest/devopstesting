CREATE OR REPLACE TYPE QUEST_DEV.qctod#name_type IS OBJECT
                  (firstname VARCHAR2 (20)
                 , lastname VARCHAR2 (20)
                 , MEMBER FUNCTION full_name (self IN OUT qctod#name_type)
                      RETURN VARCHAR2)
/
