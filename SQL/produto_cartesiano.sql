SELECT *
  FROM (SELECT 1 id, 'N' hemisferio, 'Alberto' nome FROM dual
            UNION ALL
        SELECT 2 id, 'N' hemisferio, 'Belatrix' FROM dual
            UNION ALL
        SELECT 3 id, 'S' hemisferio, 'Carlos' FROM dual
            UNION ALL
        SELECT 4 id, 'S' hemisferio, 'Denise' FROM dual) tab_pessoas,
       (SELECT 1 id, 'N' hemisferio, 'Alaska' nome FROM dual
            UNION ALL
        SELECT 2 id, 'S' hemisferio, 'Brasil' nome FROM dual
            UNION ALL
        SELECT 3 id, 'S' hemisferio, 'Chile' nome FROM dual
            UNION ALL
        SELECT 4 id, 'N' hemisferio, 'Dinamarca' nome FROM dual) tab_lugares
  WHERE /*tab_pessoas.id = tab_lugares.id
    AND*/ tab_pessoas.hemisferio = tab_lugares.hemisferio;
