-- TODO deixar explicito apos a tabela os campos que estao sendo inseridos public.Destino(Pais, Cidade, etc)
-- Inserts de Destino
-- Pais VARCHAR(30), Cidade VARCHAR(30), Descricao VARCHAR(180), Idioma VARCHAR(30) NOT NULL, Clima VARCHAR(30)
INSERT INTO public.Destino(Pais, Cidade, Descricao, Idioma, Clima) VALUES ('Brasil','Bauru', 'Desc teste 1', 'Português','Temperado');
INSERT INTO public.Destino(Pais, Cidade, Descricao, Idioma, Clima) VALUES ('Brasil','São Paulo', '', 'Português','Temperado');
INSERT INTO public.Destino(Pais, Cidade, Descricao, Idioma, Clima) VALUES ('Brasil','Rio De Janeiro', '', 'Português','Tropical');
INSERT INTO public.Destino(Pais, Cidade, Descricao, Idioma, Clima) VALUES ('Inglaterra','Londres', 'Desc teste 2', 'Inglês Britânico','Frio');
INSERT INTO public.Destino(Pais, Cidade, Descricao, Idioma, Clima) VALUES ('México','Cidade Do México', 'Desc teste 3', 'Espanhol Mexicano','Tropical');
INSERT INTO public.Destino(Pais, Cidade, Descricao, Idioma, Clima) VALUES ('França','Paris', '', 'Francês','Frio');
INSERT INTO public.Destino(Pais, Cidade, Descricao, Idioma, Clima) VALUES ('Alemanha','Frankfurt', 'Desc teste 4', 'Alemão','Frio');

-- Inserts de DestinoTags
-- PK FK Pais VARCHAR(30), PK FK Cidade VARCHAR(30), PK Tag VARCHAR(30)
INSERT INTO public.DestinoTags(Pais, Cidade, Tag) VALUES ('Brasil','Bauru','Lanche');
INSERT INTO public.DestinoTags(Pais, Cidade, Tag) VALUES ('Brasil','São Paulo','Urbano');
INSERT INTO public.DestinoTags(Pais, Cidade, Tag) VALUES ('Brasil','São Paulo','Metrópole');
INSERT INTO public.DestinoTags(Pais, Cidade, Tag) VALUES ('Brasil','São Paulo','Turismo');
INSERT INTO public.DestinoTags(Pais, Cidade, Tag) VALUES ('França','Paris','Metrópole');

-- Inserts de Aeroporto
-- PK CodIATA INT, FK Pais VARCHAR(30) NOT NULL, FK Cidade VARCHAR(30) NOT NULL, Bairro VARCHAR(30) NOT NULL, Rua VARCHAR(30) NOT NULL, Numero VARCHAR(30) NOT NULL, CEP CHAR(9) NOT NULL, Nome VARCHAR(30) NOT NULL
INSERT INTO public.Aeroporto(CodIATA, Pais, Cidade, Bairro, Rua, Numero, CEP, Nome) VALUES (111, 'Brasil','Bauru','Geisel','Rua 1','123','17033690','Aeroporto do Geisel');
INSERT INTO public.Aeroporto(CodIATA, Pais, Cidade, Bairro, Rua, Numero, CEP, Nome) VALUES (222, 'Brasil','São Paulo','Centro ','Rua 2','321','17033691','Aeroporto do Centro');
INSERT INTO public.Aeroporto(CodIATA, Pais, Cidade, Bairro, Rua, Numero, CEP, Nome) VALUES (333, 'Inglaterra','Londres','Greenwich','Rua 3','456','17033-692','Aeroporto de Greenwich');
INSERT INTO public.Aeroporto(CodIATA, Pais, Cidade, Bairro, Rua, Numero, CEP, Nome) VALUES (444, 'Inglaterra','Londres','Holland Park','Rua 4','654','17033-693','Aeroporto de Holland Park');
INSERT INTO public.Aeroporto(CodIATA, Pais, Cidade, Bairro, Rua, Numero, CEP, Nome) VALUES (555, 'Inglaterra','Londres','Westminster','Rua 5','789','17033694','Aeroporto de Westminster');
INSERT INTO public.Aeroporto(CodIATA, Pais, Cidade, Bairro, Rua, Numero, CEP, Nome) VALUES (666, 'Alemanha','Frankfurt','Hauptbahnhof','Rua 6','987','17033695','Aeroporto de Hauptbahnhof');

-- Inserts de Voo
-- PK Nro INT, FK Aeroporto_Origem INT NOT NULL, FK Aeroporto_Destino INT NOT NULL, Data_Partida TIMESTAMP NOT NULL, Data_Chegada TIMESTAMP NOT NULL, Portao_Embarque VARCHAR(30) NOT NULL, Portao_Desembarque VARCHAR(30) NOT NULL
INSERT INTO public.Voo(Nro, Aeroporto_Origem, Aeroporto_Destino, Data_Partida, Data_Chegada, Portao_Embarque, Portao_Desembarque) VALUES (101, 111, 222, TO_DATE('2017-03-14','yyy/mm/dd'), TO_DATE('2017-03-15','yyy/mm/dd'), 'E126', 'S213');-- Voos do aeroporto de Bauru
INSERT INTO public.Voo(Nro, Aeroporto_Origem, Aeroporto_Destino, Data_Partida, Data_Chegada, Portao_Embarque, Portao_Desembarque) VALUES (102, 111, 222, TO_DATE('2017-03-14','yyy/mm/dd'), TO_DATE('2017-03-15','yyy/mm/dd'), 'E526', 'S432');
INSERT INTO public.Voo(Nro, Aeroporto_Origem, Aeroporto_Destino, Data_Partida, Data_Chegada, Portao_Embarque, Portao_Desembarque) VALUES (103, 111, 555, TO_DATE('2017-03-14','yyy/mm/dd'), TO_DATE('2017-03-16','yyy/mm/dd'), 'E625', 'S251');
--
INSERT INTO public.Voo(Nro, Aeroporto_Origem, Aeroporto_Destino, Data_Partida, Data_Chegada, Portao_Embarque, Portao_Desembarque) VALUES (201, 222, 111, '2017-03-15', '2017-03-17', 'E413', 'S281');-- Voos do aeroporto de Sao Paulo, nao e necessario o uso constante to TO_DATE
INSERT INTO public.Voo(Nro, Aeroporto_Origem, Aeroporto_Destino, Data_Partida, Data_Chegada, Portao_Embarque, Portao_Desembarque) VALUES (202, 222, 666, '2017-03-15', '2017-04-10', 'E272', 'S453');
--
INSERT INTO public.Voo(Nro, Aeroporto_Origem, Aeroporto_Destino, Data_Partida, Data_Chegada, Portao_Embarque, Portao_Desembarque) VALUES (601, 666, 444, '2021-01-04', '2021-01-15', 'E192', 'S261');-- Voos do aeroporto de Frankfurt
INSERT INTO public.Voo(Nro, Aeroporto_Origem, Aeroporto_Destino, Data_Partida, Data_Chegada, Portao_Embarque, Portao_Desembarque) VALUES (602, 666, 444, '2021-01-04', '2021-01-15', 'E272', 'S675');
INSERT INTO public.Voo(Nro, Aeroporto_Origem, Aeroporto_Destino, Data_Partida, Data_Chegada, Portao_Embarque, Portao_Desembarque) VALUES (603, 666, 444, '2021-01-21', '2021-01-22', 'E635', 'S291');

-- Inserts de VooAssentos
-- PK FK Voo INT, PK Assentos VARCHAR(30)
INSERT INTO public.VooAssentos(Voo, Assentos) VALUES (101, 1);-- Os varios assentos do voo 101, de Bauru
INSERT INTO public.VooAssentos(Voo, Assentos) VALUES (101, 2);
INSERT INTO public.VooAssentos(Voo, Assentos) VALUES (101, 3);
--
INSERT INTO public.VooAssentos(Voo, Assentos) VALUES (102, 1);-- Os varios assentos do voo 102, de Bauru
INSERT INTO public.VooAssentos(Voo, Assentos) VALUES (102, 2);
INSERT INTO public.VooAssentos(Voo, Assentos) VALUES (102, 3);
--
INSERT INTO public.VooAssentos(Voo, Assentos) VALUES (103, 1);-- Os varios assentos do voo 103, de Bauru
INSERT INTO public.VooAssentos(Voo, Assentos) VALUES (103, 2);
INSERT INTO public.VooAssentos(Voo, Assentos) VALUES (103, 3);
--
INSERT INTO public.VooAssentos(Voo, Assentos) VALUES (201, 1);-- Os varios assentos do voo 201, de Sao Paulo
INSERT INTO public.VooAssentos(Voo, Assentos) VALUES (201, 2);
INSERT INTO public.VooAssentos(Voo, Assentos) VALUES (201, 3);
--
INSERT INTO public.VooAssentos(Voo, Assentos) VALUES (202, 1);-- Os varios assentos do voo 202, de Sao Paulo
INSERT INTO public.VooAssentos(Voo, Assentos) VALUES (202, 2);
INSERT INTO public.VooAssentos(Voo, Assentos) VALUES (202, 3);
--
INSERT INTO public.VooAssentos(Voo, Assentos) VALUES (601, '1A');-- Os varios assentos do voo 601, de Frankfurt
INSERT INTO public.VooAssentos(Voo, Assentos) VALUES (601, '1B');
INSERT INTO public.VooAssentos(Voo, Assentos) VALUES (601, '2B');
--
INSERT INTO public.VooAssentos(Voo, Assentos) VALUES (602, 99);-- Os varios assentos do voo 602, de Frankfurt
INSERT INTO public.VooAssentos(Voo, Assentos) VALUES (602, 100);
--
INSERT INTO public.VooAssentos(Voo, Assentos) VALUES (603, 'A');-- Os varios assentos do voo 603, de Frankfurt
INSERT INTO public.VooAssentos(Voo, Assentos) VALUES (603, 'B');

-- Inserts de Cliente
-- CPF CHAR(14), Tipo VARCHAR(30) NOT NULL, Nome VARCHAR(30) NOT NULL, Email VARCHAR(30) NOT NULL, Telefone VARCHAR(30) NOT NULL, Pais VARCHAR(30) NOT NULL, Cidade VARCHAR(30) NOT NULL, Bairro VARCHAR(30) NOT NULL, Rua VARCHAR(30) NOT NULL, Numero VARCHAR(30) NOT NULL, CEP CHAR(9) NOT NULL, Genero VARCHAR(30) NOT NULL, Religiao VARCHAR(30) NOT NULL, MBTI CHAR(4) NOT NULL,
INSERT INTO public.Cliente(CPF, Tipo, Nome, Email, Telefone, Pais, Cidade, Bairro, Rua, Numero, CEP, Genero, Religiao, MBTI) VALUES ('111.222.333-45', 'Normal', 'Fulano de Tal', 'email@email.com', '55 14 991234561', 'Brasil', 'Bauru', 'Geisel', 'Rua 1', '123-10', '123456-22', 'Masc', 'Judeu', 'ENTJ');
INSERT INTO public.Cliente(CPF, Tipo, Nome, Email, Telefone, Pais, Cidade, Bairro, Rua, Numero, CEP, Genero, Religiao, MBTI) VALUES ('111.222.333-46', 'Normal', 'Ciclano de Tal', 'email2@email.com', '55 12 991234562', 'Brasil', 'Bauru', 'Geisel', 'Rua 1', '123-20', '123456-11', 'Masc', 'Judeu', 'INTJ');
INSERT INTO public.Cliente(CPF, Tipo, Nome, Email, Telefone, Pais, Cidade, Bairro, Rua, Numero, CEP, Genero, Religiao, MBTI) VALUES ('111.222.333-47', 'Normal', 'Fulano de Acolá', 'email3@email.com', '55 12 99123-4563', 'Inglaterra','Londres','Westminster','Rua 5', '999-0', '123456-72', 'Fem', 'Agnostico', 'ENTP');
INSERT INTO public.Cliente(CPF, Tipo, Nome, Email, Telefone, Pais, Cidade, Bairro, Rua, Numero, CEP, Genero, Religiao, MBTI) VALUES ('111.222.333-48', 'Premium', 'Ciclano de Acolá', 'email4@email.com', '55 13 99123-4564', 'Inglaterra','Londres','Westminster','Rua 5', '999-0', '123456-71', 'Fem', 'Ateu', 'ENTJ');
INSERT INTO public.Cliente(CPF, Tipo, Nome, Email, Telefone, Pais, Cidade, Bairro, Rua, Numero, CEP, Genero, Religiao, MBTI) VALUES ('111.222.333-49', 'Premium', 'José Silva', 'email5@email.com', '55 13 99123-4565', 'Brasil', 'São Paulo', 'Centro', 'Rua 2', '321','17033691', 'Masc', 'Ateu', 'INTJ');
INSERT INTO public.Cliente(CPF, Tipo, Nome, Email, Telefone, Pais, Cidade, Bairro, Rua, Numero, CEP, Genero, Religiao, MBTI) VALUES ('111.222.333-50', 'Premium', 'Maria Silva', 'email5@email.com', '55 15 99123-4566', 'Brasil', 'São Paulo', 'Centro', 'Rua 2', '321','17033691', 'Fem', 'Crista', 'ENTP');

-- Inserts de ClienteCondicoesMedicas
INSERT INTO public.ClienteCondicoesMedicas(Cliente, CondicoesMedicas) VALUES ('111.222.333-45', 'Artroscopia, histeroscopia e lamparoscopia');-- Cliente Fulano
INSERT INTO public.ClienteCondicoesMedicas(Cliente, CondicoesMedicas) VALUES ('111.222.333-46', 'Deverão viajar acompanhados pelo equipe de saúde ou de uma pessoa conhecedora da doença, previamente avaliada por médico de saúde.');-- Cliente Ciclano

-- Inserts de Embarque
-- Voo INT,	Cliente CHAR(14), Assento INT,
INSERT INTO public.Embarque(Voo, Assento, Cliente) VALUES (101, 1, '111.222.333-45');
INSERT INTO public.Embarque(Voo, Assento, Cliente) VALUES (101, 2, '111.222.333-45');-- Mesmo cliente comprando dois assentos em seu nome
INSERT INTO public.Embarque(Voo, Assento, Cliente) VALUES (101, 3, '111.222.333-47');
--
INSERT INTO public.Embarque(Voo, Assento, Cliente) VALUES (201, 1, '111.222.333-48');
--
INSERT INTO public.Embarque(Voo, Assento, Cliente) VALUES (601, '1A', '111.222.333-49');
INSERT INTO public.Embarque(Voo, Assento, Cliente) VALUES (601, '1B', '111.222.333-50');

-- Inserts de Estadia
-- ! AVISO: Eu estou parando de comentar igual acima, com cada atributo, seu tipo, e se eh PK ou FK. Pega muito tempo e nao oferece muita informação util
ALTER SEQUENCE Estadia_id_seq RESTART WITH 1;-- Garantindo que a sequencia nao continue apos resetar a base e reinserir esses dados
INSERT INTO public.Estadia(ID, Pais, Cidade, Bairro, Rua, Numero, CEP, Nome, Nro_Quartos) VALUES (DEFAULT, 'Brasil','São Paulo','Centro ','Rua 2','321','17033691','Pousada do Canário', 20);
INSERT INTO public.Estadia(ID, Pais, Cidade, Bairro, Rua, Numero, CEP, Nome, Nro_Quartos) VALUES (DEFAULT, 'Brasil','Bauru','Geisel','Rua 1','123','17033690','Casa do José', 2);
INSERT INTO public.Estadia(ID, Pais, Cidade, Bairro, Rua, Numero, CEP, Nome, Nro_Quartos) VALUES (DEFAULT, 'Inglaterra','Londres','Holland Park','Rua 4','654','17033-693','Holland Stay', 120);
INSERT INTO public.Estadia(ID, Pais, Cidade, Bairro, Rua, Numero, CEP, Nome, Nro_Quartos) VALUES (DEFAULT, 'Inglaterra','Londres','Holland Park','Rua 4','655','17033-693','Holland Beach Hotel', 120);

-- Inserts de Hospedagem
INSERT INTO public.Hospedagem(Estadia, Cliente, Quarto, Valor, Data_Inicio, Data_Fim) VALUES (1, '111.222.333-45', 'B12', '12399.99','2017-03-15','2017-03-17');
INSERT INTO public.Hospedagem(Estadia, Cliente, Quarto, Valor, Data_Inicio, Data_Fim) VALUES (1, '111.222.333-45', 'B13', '10199.99','2017-03-15','2017-03-17');-- Mesmo cliente comprando dois quartos diferentes, valor de cada deve ser um SUM para achar o valor total
INSERT INTO public.Hospedagem(Estadia, Cliente, Quarto, Valor, Data_Inicio, Data_Fim) VALUES (1, '111.222.333-47', 'A01', '58999.99','2017-03-15','2017-03-25');

-- Inserts de LocalT
ALTER SEQUENCE LocalT_id_seq RESTART WITH 1;-- Garantindo que a sequencia nao continue apos resetar a base e reinserir esses dados
INSERT INTO public.LocalT(ID, Pais, Cidade, Bairro, Rua, Numero, Complemento, CEP, Nome) VALUES (DEFAULT, 'Brasil','São Paulo','Centro ','Rua 2','321','1','17033691','Pousada do Canário');
INSERT INTO public.LocalT(ID, Pais, Cidade, Bairro, Rua, Numero, Complemento, CEP, Nome) VALUES (DEFAULT, 'Brasil','São Paulo','Centro ','Rua 2','325','2','17033692','Palco Livre do Centrao');
INSERT INTO public.LocalT(ID, Pais, Cidade, Bairro, Rua, Numero, Complemento, CEP, Nome) VALUES (DEFAULT, 'Brasil','São Paulo','Centro ','Rua 99','452','','17033603','Bar do Nóia');
INSERT INTO public.LocalT(ID, Pais, Cidade, Bairro, Rua, Numero, Complemento, CEP, Nome) VALUES (DEFAULT, 'Inglaterra','Londres','Greenwich','Rua 3','456','12','17033-692','Ponte de Londres');
INSERT INTO public.LocalT(ID, Pais, Cidade, Bairro, Rua, Numero, Complemento, CEP, Nome) VALUES (DEFAULT, 'Alemanha','Frankfurt','Hauptbahnhof','Rua 6','987','1','17033695','Arco de Berlim');
INSERT INTO public.LocalT(ID, Pais, Cidade, Bairro, Rua, Numero, Complemento, CEP, Nome) VALUES (DEFAULT, 'Inglaterra','Londres','Westminster','Rua 5','789','','17033694','Casa dos Representantes');
INSERT INTO public.LocalT(ID, Pais, Cidade, Bairro, Rua, Numero, Complemento, CEP, Nome) VALUES (DEFAULT, 'Inglaterra','Londres','Westminster','Rua 178','144','3','17033621','Casa do Ministro');
INSERT INTO public.LocalT(ID, Pais, Cidade, Bairro, Rua, Numero, Complemento, CEP, Nome) VALUES (DEFAULT, 'Inglaterra','Londres','Westminster','Rua 44','115','7','17022-694','Casa dos Representantes');

-- Inserts de LocalTipo
INSERT INTO public.LocalTipo(LocalT, Tipo) VALUES (1, 'Pousada');
INSERT INTO public.LocalTipo(LocalT, Tipo) VALUES (1, 'Casa Grande');
INSERT INTO public.LocalTipo(LocalT, Tipo) VALUES (1, 'Estadia');
INSERT INTO public.LocalTipo(LocalT, Tipo) VALUES (2, 'Rock');
INSERT INTO public.LocalTipo(LocalT, Tipo) VALUES (3, 'Bar');
INSERT INTO public.LocalTipo(LocalT, Tipo) VALUES (4, 'Turismo');

-- Inserts de Transporte
INSERT INTO public.Transporte(Cod_Linha, Tipo, Local_Origem, Local_Destino, Horario_Ida, Horario_Chegada) VALUES (384, 'Onibus', 1, 1, '2017-03-15 12:30:00', '2017-03-15 13:00:00');-- Caminho de local 1 para local 1
INSERT INTO public.Transporte(Cod_Linha, Tipo, Local_Origem, Local_Destino, Horario_Ida, Horario_Chegada) VALUES (799, 'Onibus Turismo', 1, 2, '2017-03-15 17:30:00', '2017-03-15 18:00:00');-- Caminho de local 1 para local 2
INSERT INTO public.Transporte(Cod_Linha, Tipo, Local_Origem, Local_Destino, Horario_Ida, Horario_Chegada) VALUES (576, 'Limousine', 3, 1, '2017-03-15 14:30:00', '2017-03-15 15:30:00');-- Caminho de local 3 para local 1

--  Inserts de PontoTransporte
INSERT INTO PontoTransporte(Transporte, LocalT, Horario) VALUES (384, 1, '2017-03-15 13:00:00');-- Onibus 394 chegando no ponto 1
INSERT INTO PontoTransporte(Transporte, LocalT, Horario) VALUES (799, 2, '2017-03-15 18:00:00');-- Onibus 799 chegando no ponto 2
INSERT INTO PontoTransporte(Transporte, LocalT, Horario) VALUES (576, 1, '2017-03-15 15:30:00');-- Onibus 576 chegando no ponto 1

-- Inserts de Organizador
INSERT INTO public.Organizador(CPF, CNPJ, Tipo, Nome, Email, Telefone, Pais, Cidade, Bairro, Rua, Numero, CEP, Nome_Social, Telefone_Empresa, Email_Empresa) VALUES ('111.222.334-11', '11.222.333/0001-01', 'Pequeno Porte', 'Alberto de Tal', 'email@emailpessoal.com', '55 16 991235432', 'Brasil', 'Bauru', 'São Paulo', 'Rua 645', '12-10', '123456-33', 'Empresa Top', '00 16 991235432', 'email@emailempresa.com');
INSERT INTO public.Organizador(CPF, CNPJ, Tipo, Nome, Email, Telefone, Pais, Cidade, Bairro, Rua, Numero, CEP, Nome_Social, Telefone_Empresa, Email_Empresa) VALUES ('111.222.334-22', '11.222.333/0001-02', 'Medio Porte', 'John Doe', 'John@emailpessoal.com', '55 16 991238654', 'Inglaterra','Londres','Greenwich','Rua 12','423','17033-333', 'Best Company', '00 16 991235486', 'Best@emailempresa.com');
INSERT INTO public.Organizador(CPF, CNPJ, Tipo, Nome, Email, Telefone, Pais, Cidade, Bairro, Rua, Numero, CEP, Nome_Social, Telefone_Empresa, Email_Empresa) VALUES ('111.222.334-33', '11.222.333/0001-03', 'Grande Porte', 'Heinz Doofenshmirtz', 'Heinz@emailpessoal.com', '55 16 991235274', 'Alemanha','Frankfurt','Hauptbahnhof','Rua 6','987','17033695', 'Sieg Heinz', '00 16 991235125', 'Sieg@emailempresa.com');

-- Inserts de OrganizadorTiposAtuacao
INSERT INTO public.OrganizadorTiposAtuacao(Organizador, Tipos_Atuacao) VALUES ('111.222.334-11', 'Turismo Brasileiro');
INSERT INTO public.OrganizadorTiposAtuacao(Organizador, Tipos_Atuacao) VALUES ('111.222.334-11', 'Radical');
INSERT INTO public.OrganizadorTiposAtuacao(Organizador, Tipos_Atuacao) VALUES ('111.222.334-11', 'Alcool');
INSERT INTO public.OrganizadorTiposAtuacao(Organizador, Tipos_Atuacao) VALUES ('111.222.334-11', 'Passesios no mar');
INSERT INTO public.OrganizadorTiposAtuacao(Organizador, Tipos_Atuacao) VALUES ('111.222.334-22', 'Turismo Britanico');
INSERT INTO public.OrganizadorTiposAtuacao(Organizador, Tipos_Atuacao) VALUES ('111.222.334-33', 'Turismo Alemão');

-- Inserts de OrganizadorRecomendacao
INSERT INTO public.OrganizadorRecomendacao(Organizador, Recomendacao) VALUES ('111.222.334-11', 'Muito bom, turismo perfeito');
INSERT INTO public.OrganizadorRecomendacao(Organizador, Recomendacao) VALUES ('111.222.334-11', 'Gostei da gentileza e cortesia');
INSERT INTO public.OrganizadorRecomendacao(Organizador, Recomendacao) VALUES ('111.222.334-22', 'Bons drinks');
INSERT INTO public.OrganizadorRecomendacao(Organizador, Recomendacao) VALUES ('111.222.334-22', 'Nao recomendo, muito ruim');
INSERT INTO public.OrganizadorRecomendacao(Organizador, Recomendacao) VALUES ('111.222.334-33', 'Ate que foi dahorinha');

-- Inserts de Evento
INSERT INTO public.Evento(LocalT, Data_Inicio, Data_Fim, Organizador, Descricao) VALUES (1, '2017-03-15 13:01:00', '2017-03-15 14:01:00', '111.222.334-11', 'Um belo evento em Brasil, organizado por Empresa Top');-- Evento no Brasil
INSERT INTO public.Evento(LocalT, Data_Inicio, Data_Fim, Organizador, Descricao) VALUES (4, '2017-03-16 13:01:00', '2017-03-17 14:01:00', '111.222.334-22', 'Um belo evento em Inglaterra, organizado por Best Company');-- Evento na Inglaterra
INSERT INTO public.Evento(LocalT, Data_Inicio, Data_Fim, Organizador, Descricao) VALUES (3, '2017-03-17 13:01:00', '2017-03-18 14:01:00', '111.222.334-33', 'Um belo evento em Alemanha, organizado por Sieg Heinz');-- Evento na Alemanha
INSERT INTO public.Evento(LocalT, Data_Inicio, Data_Fim, Organizador, Descricao) VALUES (2, '2017-03-17 13:01:00', '2017-03-18 14:01:00', '111.222.334-33', 'Um belo evento2 em Alemanha, organizado por Sieg Heinz');-- A partir de aqui criamos mais eventos para usar nas especializacoes. O mesmo organizador esta em todas elas
INSERT INTO public.Evento(LocalT, Data_Inicio, Data_Fim, Organizador, Descricao) VALUES (5, '2017-03-17 13:01:00', '2017-03-18 14:01:00', '111.222.334-33', 'Um belo evento3 em Alemanha, organizado por Sieg Heinz');
INSERT INTO public.Evento(LocalT, Data_Inicio, Data_Fim, Organizador, Descricao) VALUES (6, '2017-03-17 13:01:00', '2017-03-18 14:01:00', '111.222.334-33', 'Um belo evento4 em Alemanha, organizado por Sieg Heinz');
INSERT INTO public.Evento(LocalT, Data_Inicio, Data_Fim, Organizador, Descricao) VALUES (7, '2017-03-17 13:01:00', '2017-03-18 14:01:00', '111.222.334-33', 'Um belo evento5 em Alemanha, organizado por Sieg Heinz');
INSERT INTO public.Evento(LocalT, Data_Inicio, Data_Fim, Organizador, Descricao) VALUES (8, '2017-03-17 13:01:00', '2017-03-18 14:01:00', '111.222.334-33', 'Um belo evento6 em Alemanha, organizado por Sieg Heinz');
INSERT INTO public.Evento(LocalT, Data_Inicio, Data_Fim, Organizador, Descricao) VALUES (5, '2017-03-18 13:01:00', '2017-03-19 14:01:00', '111.222.334-33', 'Um belo evento6 em Alemanha, organizado por Sieg Heinz');-- Mesmo evento no local 5, mas no dia seguinte
INSERT INTO public.Evento(LocalT, Data_Inicio, Data_Fim, Organizador, Descricao) VALUES (6, '2017-03-18 13:01:00', '2017-03-19 14:01:00', '111.222.334-33', 'Um belo evento6 em Alemanha, organizado por Sieg Heinz');-- Mesmo evento no local 6, mas no dia seguinte
INSERT INTO public.Evento(LocalT, Data_Inicio, Data_Fim, Organizador, Descricao) VALUES (7, '2017-03-18 13:01:00', '2017-03-19 14:01:00', '111.222.334-33', 'Um belo evento6 em Alemanha, organizado por Sieg Heinz');-- Mesmo evento no local 7, mas no dia seguinte
INSERT INTO public.Evento(LocalT, Data_Inicio, Data_Fim, Organizador, Descricao) VALUES (8, '2017-03-18 13:01:00', '2017-03-19 14:01:00', '111.222.334-33', 'Um belo evento6 em Alemanha, organizado por Sieg Heinz');-- Mesmo evento no local 8, mas no dia seguinte

-- Inserts de EventoCategoria
INSERT INTO public.EventoCategoria(LocalT, Data_Inicio, Categoria) VALUES (1, '2017-03-15 13:01:00', 'Categoria 1');-- Categoria de Evento no Brasil
INSERT INTO public.EventoCategoria(LocalT, Data_Inicio, Categoria) VALUES (4, '2017-03-16 13:01:00', 'Categoria 2');-- Categoria de Evento na Inglaterra
INSERT INTO public.EventoCategoria(LocalT, Data_Inicio, Categoria) VALUES (3, '2017-03-17 13:01:00', 'Categoria 3');-- Categoria de Evento na Alemanha
-- Como nao e obrigatorio que um evento tenha categoria, nao vamos adicionar os outros eventos do Organizador 'Sieg Heinz' aqui

-- Inserts de Participacao
INSERT INTO public.Participacao(Cliente, LocalT, Data_Inicio) VALUES ('111.222.333-45', 1, '2017-03-15 13:01:00');
INSERT INTO public.Participacao(Cliente, LocalT, Data_Inicio) VALUES ('111.222.333-46', 4, '2017-03-16 13:01:00');
INSERT INTO public.Participacao(Cliente, LocalT, Data_Inicio) VALUES ('111.222.333-47', 3, '2017-03-17 13:01:00');

-- Inserts de AvaliacaoEvento
INSERT INTO public.AvaliacaoEvento(LocalT, Data_Inicio, DataA, Cliente, Estrelas, Descricao) VALUES (1, '2017-03-15 13:01:00', '2017-03-15 13:31:21', '111.222.333-45', 4, 'Muito bom evento, gostei bastante');
INSERT INTO public.AvaliacaoEvento(LocalT, Data_Inicio, DataA, Cliente, Estrelas, Descricao) VALUES (4, '2017-03-16 13:01:00', '2017-03-15 13:31:11', '111.222.333-46', 1, 'Não foi la essas coisas. Precisava de mais musica');
INSERT INTO public.AvaliacaoEvento(LocalT, Data_Inicio, DataA, Cliente, Estrelas, Descricao) VALUES (3, '2017-03-17 13:01:00', '2017-03-15 13:31:43', '111.222.333-47', 5, 'Evento mais perfeito da minha vida');

-- Inserts de Guia
INSERT INTO public.Guia(CPF, Tipo, Nome, Email, Telefone, Pais, Cidade, Bairro, Rua, Numero, CEP, Naturalidade, Descricao, Formacao, Pagamento, MBTI) VALUES ('111.222.374-53', 'Turismo Internacional', 'Josefrina de Jesus', 'Josefrina@emailpessoal.com', '55 16 991235875', 'Brasil', 'Bauru', 'São Paulo', 'Rua 645', '12-10', '123456-33', 'Brasileiro', 'Um guia namoral e bacana', 'Formado em Turismo Internacional', 'Dinheiro ou Cartao', 'ENFJ');-- Guia 1
INSERT INTO public.Guia(CPF, Tipo, Nome, Email, Telefone, Pais, Cidade, Bairro, Rua, Numero, CEP, Naturalidade, Descricao, Formacao, Pagamento, MBTI) VALUES ('111.222.234-28', 'Turismo Local', 'Bob McKenzie', 'Bob@emailpessoal.com', '15 13 991235511', 'Inglaterra','Londres','Greenwich','Rua 56','422','17033-321', 'Ingles', 'Aqui seguimos a tour à risca', 'Formado em Eventos Turisticos', 'Cartao', 'ENTP');-- Guia 2
INSERT INTO public.Guia(CPF, Tipo, Nome, Email, Telefone, Pais, Cidade, Bairro, Rua, Numero, CEP, Naturalidade, Descricao, Formacao, Pagamento, MBTI) VALUES ('111.222.374-97', 'Qualquer Turismo', 'Finn Müller', 'Finn@emailpessoal.com', '22 16 991235523', 'Alemanha','Frankfurt','Hauptbahnhof','Rua 51','735','17033885', 'Alemão', 'Sem descricao detalhada', 'Formado em Administração', 'Dinheiro', 'ENFP');-- Guia 3

-- Inserts de GuiaTiposAtuacao
INSERT INTO public.GuiaTiposAtuacao(Guia, TiposAtuacao) VALUES ('111.222.374-53', 'Tipo 1');-- Guia 1
INSERT INTO public.GuiaTiposAtuacao(Guia, TiposAtuacao) VALUES ('111.222.374-53', 'Tipo 2');-- Guia 1
INSERT INTO public.GuiaTiposAtuacao(Guia, TiposAtuacao) VALUES ('111.222.374-53', 'Tipo 3');-- Guia 1
INSERT INTO public.GuiaTiposAtuacao(Guia, TiposAtuacao) VALUES ('111.222.234-28', 'Tipo 2');-- Guia 2
INSERT INTO public.GuiaTiposAtuacao(Guia, TiposAtuacao) VALUES ('111.222.374-97', DEFAULT);-- Guia 3

-- Inserts de Orientacao
INSERT INTO public.Orientacao(Guia, Cliente) VALUES ('111.222.374-53', '111.222.333-45');-- Guia 1 com Cliente 1
INSERT INTO public.Orientacao(Guia, Cliente) VALUES ('111.222.234-28', '111.222.333-46');-- Guia 2 com Cliente 2
INSERT INTO public.Orientacao(Guia, Cliente) VALUES ('111.222.374-97', '111.222.333-47');-- Guia 3 com Cliente 3

-- Inserts de AvaliacaoGuia
INSERT INTO public.AvaliacaoGuia(Data_Avaliacao, Guia, Cliente, Estrelas, Descricao) VALUES ('2017-03-15 23:52:43', '111.222.374-53', '111.222.333-45', 3, 'Guia meio louco' );-- Guia com Cliente 1
INSERT INTO public.AvaliacaoGuia(Data_Avaliacao, Guia, Cliente, Estrelas, Descricao) VALUES ('2017-03-16 23:43:41', '111.222.234-28', '111.222.333-46', 4, 'Bom guia' );-- Guia com Cliente 2
INSERT INTO public.AvaliacaoGuia(Data_Avaliacao, Guia, Cliente, Estrelas, Descricao) VALUES ('2017-03-15 23:22:46', '111.222.374-97', '111.222.333-47', 1, 'O guia apontou e fugiu' );-- Guia com Cliente 3

-- ! INSERTS DE ESPECIALIZACAO DE EVENTO

-- Inserts de FestivalGastronomico
INSERT INTO public.FestivalGastronomico(LocalT, Data_Inicio, Tipo_Comida_Bebida) VALUES (1, '2017-03-15 13:01:00', 'Comidas salgadas');
INSERT INTO public.FestivalGastronomico(LocalT, Data_Inicio, Tipo_Comida_Bebida) VALUES (4, '2017-03-16 13:01:00', 'Comidas doces');
-- Inserts de GastroGuia
INSERT INTO public.GastroGuia(LocalT, Data_Inicio, Guia) VALUES (1, '2017-03-15 13:01:00', '111.222.374-53');-- Guia 1 no evento 1
INSERT INTO public.GastroGuia(LocalT, Data_Inicio, Guia) VALUES (4, '2017-03-16 13:01:00', '111.222.234-28');-- Guia 2 no evento 4


-- Inserts de Showt
INSERT INTO public.Showt(LocalT, Data_Inicio, Genero_Musical) VALUES (1, '2017-03-15 13:01:00', 'Rock');-- O Evento 1 vai ter tanto um festival gastronomico quanto um show nele
INSERT INTO public.Showt(LocalT, Data_Inicio, Genero_Musical) VALUES (4, '2017-03-16 13:01:00', 'Bossa nova');-- O Evento 4 vai ter tanto um festival gastronomico quanto um show nele
-- Inserts de ShowArtistas
INSERT INTO public.ShowArtistas(LocalT, Data_Inicio, Artista) VALUES (1, '2017-03-15 13:01:00', 'Um rockeiro qualquer');
INSERT INTO public.ShowArtistas(LocalT, Data_Inicio, Artista) VALUES (4, '2017-03-16 13:01:00', 'Um bossa novista qualquer');


-- Inserts de Festa
INSERT INTO public.Festa(LocalT, Data_Inicio, Tipo) VALUES (1, '2017-03-15 13:01:00', 'Pos-party de rock e salgados');-- O Evento 1 vai ter tanto um festival gastronomico e show, quanto uma festa
INSERT INTO public.Festa(LocalT, Data_Inicio, Tipo) VALUES (4, '2017-03-16 13:01:00', 'Pos-party de bossa nova e doces');-- O Evento 4 vai ter tanto um festival gastronomico e show, quanto uma festa


-- Inserts de Esporte
INSERT INTO public.Esporte(LocalT, Data_Inicio, Tipo) VALUES (2, '2017-03-17 13:01:00', 'Jogo de futebol');
INSERT INTO public.Esporte(LocalT, Data_Inicio, Tipo) VALUES (3, '2017-03-17 13:01:00', 'Jogo de basquete');
-- Inserts de EsporteParticipantes
INSERT INTO public.EsporteParticipantes(LocalT, Data_Inicio, Participantes) VALUES (2, '2017-03-17 13:01:00', 'Manchester United e Barcelona');
INSERT INTO public.EsporteParticipantes(LocalT, Data_Inicio, Participantes) VALUES (3, '2017-03-17 13:01:00', 'Time basquete1 e Time basquete2');


-- Inserts de PasseioTuristicoTour
INSERT INTO public.PasseioTuristicoTour(LocalT, Data_Inicio, Tipo) VALUES (5, '2017-03-17 13:01:00', 'Passeio de onibus');
INSERT INTO public.PasseioTuristicoTour(LocalT, Data_Inicio, Tipo) VALUES (6, '2017-03-17 13:01:00', 'Passeio de Limousine');
-- Inserts de PasseioRota
INSERT INTO public.PasseioRota(Local_Inicio, Data_Inicio, Local_Final, Horario) VALUES (5, '2017-03-17 13:01:00', 6, '13:01:00');-- O passeio vai do local 5 para o 6
INSERT INTO public.PasseioRota(Local_Inicio, Data_Inicio, Local_Final, Horario) VALUES (6, '2017-03-17 13:01:00', 5, '13:01:00');-- O passeio vai do local 6 para o 5


-- Inserts de Filme
INSERT INTO public.Filme(LocalT, Data_Inicio, Titulo, Genero, Ano_Lancamento, Duracao) VALUES (7, '2017-03-17 13:01:00', 'Robocop', 'SciFi', '2012-01-12', '01:30:00');
INSERT INTO public.Filme(LocalT, Data_Inicio, Titulo, Genero, Ano_Lancamento, Duracao) VALUES (8, '2017-03-17 13:01:00', 'Exterminador do Futuro', 'Ação', '2014-05-21', '02:30:00');
-- Inserts de FilmeAtores
INSERT INTO public.FilmeAtores(LocalT, Data_Inicio, Ator) VALUES (7, '2017-03-17 13:01:00', 'José Padilha com Joel Kinnaman, Gary Oldman​, Michael Keaton, Abbie Cornish');
INSERT INTO public.FilmeAtores(LocalT, Data_Inicio, Ator) VALUES (8, '2017-03-17 13:01:00', ' Tim Miller com Arnold Schwarzenegger, Linda Hamilton, Mackenzie Davis, Gabriel Luna');


-- Inserts de ExposicaoArte
INSERT INTO public.ExposicaoArte(LocalT, Data_Inicio, Nome, Tema) VALUES (7, '2017-03-17 13:01:00', 'Expo do Robocop', 'Tema de Robocop');-- O Evento 7 vai ter tanto um filme quanto uma expo
INSERT INTO public.ExposicaoArte(LocalT, Data_Inicio, Nome, Tema) VALUES (8, '2017-03-17 13:01:00', 'Expo do Exterminador do Futuro', 'Tema de Exterminador');-- O Evento 8 vai ter tanto um filme quanto uma expo
-- Inserts de ExposicaoArtistas
INSERT INTO public.ExposicaoArtistas(LocalT, Data_Inicio, Artista) VALUES (7, '2017-03-17 13:01:00', 'Conglomerado de artistas');
INSERT INTO public.ExposicaoArtistas(LocalT, Data_Inicio, Artista) VALUES (8, '2017-03-17 13:01:00', 'Conglomerado de artistas 2');
-- Inserts de ExpoGuia
INSERT INTO public.ExpoGuia(LocalT, Data_Inicio, Guia) VALUES (7, '2017-03-17 13:01:00', '111.222.374-53');-- Guia 1 tambem no evento 7
INSERT INTO public.ExpoGuia(LocalT, Data_Inicio, Guia) VALUES (8, '2017-03-17 13:01:00', '111.222.234-28');-- Guia 2 tambem no evento 8

-- Inserts de Espetaculo
INSERT INTO public.Espetaculo(LocalT, Data_Inicio, Titulo, Genero, Duracao) VALUES (5, '2017-03-18 13:01:00', 'Romeu e Julieta', 'Teatro', '01:30:00');
INSERT INTO public.Espetaculo(LocalT, Data_Inicio, Titulo, Genero, Duracao) VALUES (6, '2017-03-18 13:01:00', 'Der Ring des Nibelungen', 'Opera', '05:30:00');
-- Inserts de EspetaculoArtistas
INSERT INTO public.EspetaculoArtistas(LocalT, Data_Inicio, Artista) VALUES (5, '2017-03-18 13:01:00', 'Conglomerado de artistas de teatro');
INSERT INTO public.EspetaculoArtistas(LocalT, Data_Inicio, Artista) VALUES (6, '2017-03-18 13:01:00', 'Conglomerado de artistas de teatro 2');


-- Inserts de CelebracaoReligiosa
INSERT INTO public.CelebracaoReligiosa(LocalT, Data_Inicio, Religiao) VALUES (7, '2017-03-18 13:01:00', 'Cristianismo');
INSERT INTO public.CelebracaoReligiosa(LocalT, Data_Inicio, Religiao) VALUES (8, '2017-03-18 13:01:00', 'Judaismo');
-- Inserts de ReligioGuia
INSERT INTO public.ReligioGuia(LocalT, Data_Inicio, Guia) VALUES (7, '2017-03-18 13:01:00', '111.222.374-97');-- Guia 3 no evento 7 do prox dia
INSERT INTO public.ReligioGuia(LocalT, Data_Inicio, Guia) VALUES (8, '2017-03-18 13:01:00', '111.222.234-28');-- Guia 2 tambem no evento 8 do prox dia