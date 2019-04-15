CREATE OR REPLACE FUNCTION QUEST_DEV.qctod#names_eq (p_names1_i   IN qctod#name_type
                                         , p_names2_i   IN qctod#name_type)
   RETURN BOOLEAN
IS
   result   BOOLEAN;
   fn       VARCHAR2 (500);
   LN       VARCHAR2 (500);
BEGIN
   RETURN ( (p_names1_i.firstname = p_names2_i.firstname
             OR (p_names1_i.firstname IS NULL
                 AND p_names2_i.firstname IS NULL))
           AND (p_names1_i.lastname = p_names2_i.lastname
                OR (p_names1_i.lastname IS NULL
                    AND p_names2_i.lastname IS NULL)));
END qctod#names_eq;
/
