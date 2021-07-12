/*
    Algumas informacoes sobre a clausula SELECT:
        1. Select distinct rows using DISTINCT operator.
        2. Sort rows usingORDER BY clause.
        3. Filter rows using WHERE clause.
        4. Select a subset of rows from a table using LIMIT or FETCH clause.
        5. Group rows into groups using GROUP BY clause.
        6. Filter groups using HAVING clause.
        7. Join with other tables using joins such as INNER JOIN, LEFT JOIN, FULL OUTER JOIN, CROSS JOIN clauses.
        8. Perform set operations using UNION, INTERSECT, and EXCEPT.
*/

-- Exemplo 1: Considerando que temos Destino <- DestinoTags...
-- Seleciona somente os destinos que possuem tags
SELECT * FROM destino INNER JOIN destinotags ON (destino.pais = destinotags.pais) AND (destino.cidade=destinotags.cidade);
-- Seleciona todos os destinos, adicionando tags se existirem e null caso nao
SELECT * FROM destino LEFT JOIN destinotags ON (destino.pais = destinotags.pais) AND (destino.cidade=destinotags.cidade);
-- Seleciona somente os destinos que NAO possuem tags
SELECT * FROM destino LEFT JOIN destinotags ON (destino.pais = destinotags.pais) AND (destino.cidade = destinotags.cidade) WHERE destinotags.pais IS NULL AND destinotags.cidade IS NULL;
-- Por destinotags ser uma tabela representando um atributo composto, nao vai ter nenhuma tag sem destino, logo nao faremos RIGHT JOIN
-- A mesma logica se aplica ao FULL JOIN

-- Exemplo 2: Considerando que temos Aeroporto <- Voo...
-- Seleciona todos os aeroportos e mostre a soma de todos os voos de cada aeroporto
SELECT aeroporto.CodIATA, aeroporto.nome, aeroporto.pais, COUNT(voo.nro) AS totalvoos
FROM aeroporto 
	LEFT JOIN voo ON (aeroporto.CodIATA = voo.Aeroporto_Origem)
GROUP BY aeroporto.codiata



-- Selects mais complexos...