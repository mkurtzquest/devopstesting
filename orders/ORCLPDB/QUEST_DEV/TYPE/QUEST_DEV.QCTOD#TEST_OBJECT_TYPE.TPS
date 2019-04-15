CREATE OR REPLACE TYPE QUEST_DEV.qctod#test_object_type IS OBJECT
                  (
                     attr1 VARCHAR2 (100)
                   , attr2 NUMBER
                   , CONSTRUCTOR FUNCTION qctod#test_object_type (
                        self         IN OUT NOCOPY qctod#test_object_type
                      , attr1_only   IN            VARCHAR2)
                        RETURN SELF AS RESULT
                   , STATIC PROCEDURE return_attr2 (
                        attr2       IN     NUMBER
                      , attr2_out      OUT NUMBER)
                   , MEMBER FUNCTION return_as_attr2 (n IN NUMBER)
                        RETURN NUMBER
                   , MEMBER FUNCTION return_as_attr2_self_inout (
                        self   IN OUT qctod#test_object_type
                      , n      IN     NUMBER)
                        RETURN NUMBER
                   , MEMBER PROCEDURE return_attr1 (
                        attr1       IN     VARCHAR2
                      , attr1_out      OUT VARCHAR2)
                   --, MAP MEMBER FUNCTION map_type
                   --     RETURN NUMBER
                   , ORDER MEMBER FUNCTION order_type (
                        compare_to_in IN qctod#test_object_type)
                        RETURN INTEGER)
/
