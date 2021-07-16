/*
    Algumas informacoes sobre a clausula SELECT:
        1. Select distinct rows using DISTINCT operator.
        2. Sort rows using ORDER BY clause.
        3. Filter rows using WHERE clause.
        4. Select a subset of rows from a table using LIMIT or FETCH clause.
        5. Group rows into groups using GROUP BY clause.
        6. Filter groups using HAVING clause.
        7. Join with other tables using joins such as INNER JOIN, LEFT JOIN, FULL OUTER JOIN, CROSS JOIN clauses.
        8. Perform set operations using UNION, INTERSECT, and EXCEPT.
*/

-- Exemplo 1: Considerando que temos Destino <- DestinoTags...
-- Seleciona somente os destinos que possuem tags:
SELECT * FROM destino INNER JOIN destinotags ON (destino.pais = destinotags.pais) AND (destino.cidade=destinotags.cidade);
-- Seleciona todos os destinos, adicionando tags se existirem e null caso nao:
SELECT * FROM destino LEFT JOIN destinotags ON (destino.pais = destinotags.pais) AND (destino.cidade=destinotags.cidade);
-- Seleciona somente os destinos que NAO possuem tags:
SELECT * FROM destino LEFT JOIN destinotags ON (destino.pais = destinotags.pais) AND (destino.cidade = destinotags.cidade) WHERE destinotags.pais IS NULL AND destinotags.cidade IS NULL;
-- Por destinotags ser uma tabela representando um atributo composto, nao vai ter nenhuma tag sem destino, logo nao faremos RIGHT JOIN
-- A mesma logica se aplica ao FULL JOIN, nao mudaria o resultado

-- Exemplo 2: Considerando que temos Aeroporto <- Voo...
-- Seleciona todos os aeroportos e mostre a soma de todos os voos de cada aeroporto
SELECT aeroporto.CodIATA, aeroporto.nome, aeroporto.pais, COUNT(voo.nro) AS totalvoos
FROM aeroporto 
	LEFT JOIN voo ON (aeroporto.CodIATA = voo.Aeroporto_Origem)
GROUP BY aeroporto.codiata, aeroporto.nome, aeroporto.pais;
-- ? Descobrimos que o PostgreSQL detecta algumas dependencias funcionais (principalmente PK) e nao demanda que aparecam todas no GROUP BY



-- Selects mais complexos...



-- Consulta se algum cliente comprou mais de um assento num dado voo, e retorna o cliente e o voo que ele comprou varios assentos
SELECT C.CPF, C.Nome, E.Voo, V.Aeroporto_Origem, V.Aeroporto_Destino, COUNT(C.CPF) AS Quantos_Assentos_Comprou
FROM Cliente C 
    INNER JOIN Embarque E ON (E.Cliente = C.CPF)
    -- INNER JOIN VooAssentos VA ON (E.Voo = VA.Voo AND E.Assento = VA.Assentos)
    -- Esse INNER JOIN seria desnecessario, visto que ja temos o dado da PK de Voo em Embarque
    INNER JOIN Voo V ON (V.Nro = E.Voo)
GROUP BY C.CPF, C.Nome, E.Voo, V.Aeroporto_Origem, V.Aeroporto_Destino
HAVING COUNT(*) > 1-- Mais que uma aparição no resultado
ORDER BY C.CPF;


-- Consulte o nome e CPF de um cliente que comprou todos os assentos disponiveis no voo de codigo 101. Isso seria um caso "Cliente VIP Exclusive"
SELECT C.CPF, C.Nome, E.Voo AS Voo_Esvaziado_VIP, COUNT(E.Assento) AS Numero_Assentos_Totais
FROM Cliente C
    INNER JOIN Embarque E ON (E.Cliente = C.CPF)
WHERE NOT EXISTS
(
    (SELECT V.Nro FROM Voo V WHERE V.Nro = 101) -- Resultados do voo 101, para verificar se esse voo eh "VIP Exclusive"
    EXCEPT 
    (SELECT E.Voo FROM Embarque E WHERE E.Cliente = C.CPF)-- Resultados dos voos presentes em embarque com Cliente especifico
)
GROUP BY C.CPF, C.Nome, E.Voo;


-- Selecionar os locais sem eventos, para avisa-los (mandar um email) que nao temos eventos associados com eles, logo nenhum cliente vai ter interesse
-- Para fazer isso, basta fazer a juncao externa LEFT e dar um MINUS com a juncao interna INNER. Sobrou os que nao tem juncao


-- Consulta de quantos clientes estao ocupando quantos quartos
SELECT H.Estadia, E.Nome, COUNT(H.Quarto) AS Quantos_Clientes_Aqui
FROM Hospedagem H
    INNER JOIN Estadia E ON (H.Estadia = E.ID)
GROUP BY H.Estadia, E.Nome
ORDER BY H.Estadia;


-- Consulta todos os gastos de um cliente registrados no nosso sistema, ate o tempo presente
SELECT H.Cliente AS CPF, C.Nome, SUM(H.Valor) AS GastoTotal_Cliente
FROM Hospedagem H
    INNER JOIN Cliente C ON (H.Cliente = C.CPF)
GROUP BY H.Cliente, C.Nome
ORDER BY H.Cliente;


-- Consulta todos os clientes, e mostra os possiveis guias que tem compatibilidade de MBTI (personalidade)
--? Achamos interessante correlacionar duas tabelas sem relação FK com um LEFT JOIN que ainda sim faz sentido semantico
SELECT C.Nome AS Nome_Cliente, C.MBTI AS MBTI_Cliente, G.Nome AS Nome_Guia, G.MBTI AS MBTI_Guia
FROM Cliente C
    LEFT JOIN Guia G ON (C.MBTI = G.MBTI)-- Precisa ser LEFT pois alguns Clientes podem nao ter compatibilidade nenhuma
ORDER BY C.NOME;


-- Consulta assentos disponiveis em um dado voo.
-- ? Inicialmente usamos:
-- SELECT V.Voo, V.Assentos 
-- FROM VooAssentos V
-- 	LEFT JOIN Embarque E ON (V.Voo = E.Voo AND V.Assentos = E.Assento)-- Precisa ser LEFT pois existem assentos que nao foram pegos num embarque
-- EXCEPT
--     SELECT V.Voo, V.Assentos 
--     FROM VooAssentos V
--         INNER JOIN Embarque E ON (V.Voo = E.Voo AND V.Assentos = E.Assento)-- Precisa ser INNER para pegar os assentos ocupados e removelos com o EXCEPT
-- ORDER BY 1;
-- ? Mas esse código não era o mais eficiente possivel visto que tem dois JOINS, entao transformamos ele em:
SELECT V.Voo, V.Assentos FROM VooAssentos V
EXCEPT
SELECT E.Voo, E.Assento FROM Embarque E
ORDER BY 1;-- Ordena pela primeira coluna, de voo


-- Consulta dados dos clientes hospedados numa dada estadia (Estadia de ID 1 no caso)
SELECT H.Estadia AS ID_Estadia, C.Nome AS Nome_Cliente, C.Email, H.Quarto, H.Valor, H.Data_Inicio, H.Data_Fim
FROM Hospedagem H 
    INNER JOIN Cliente C ON (H.Cliente = C.CPF)
WHERE H.Estadia = 1
ORDER BY C.Nome;