-- AVISOS:
-- Consideramos que strings pequenas possuem no maximo 30 caracteres, medias 50 e grandes 180 (um tweet) 

-- SOMENTE DESCOMENTE SE quiser o codigo SQL para dropar todas as tabelas. Basta executar numa query dentro do banco correto
-- select 'drop table if exists "' || tablename || '" cascade;' from pg_tables where schemaname = 'public';

-- ! PERGUNTA PARA PROF SE VALE A PENA FAZER OS ENDERECOS NUMA TABELA E USAR FK NOS TODOS QUE ESTAO POR AE

CREATE TABLE IF NOT EXISTS Destino (
	
	/*    ATRIBUTOS    */
	Pais VARCHAR(30),
	Cidade VARCHAR(30),
	Descricao VARCHAR(180),
	Idioma VARCHAR(30) NOT NULL,
	Clima VARCHAR(30),
	
	/*    KEYS    */
	CONSTRAINT PK_Destino PRIMARY KEY(Pais, Cidade)
	
	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS DestinoTags (
	
	/*    ATRIBUTOS    */
	Pais VARCHAR(30),
	Cidade VARCHAR(30),
	Tag VARCHAR(30),
	
	/*    KEYS    */
	CONSTRAINT PK_DestinoTag PRIMARY KEY(Pais, Cidade, Tag),
	CONSTRAINT FK_DestinoTag FOREIGN KEY (Pais, Cidade) REFERENCES Destino(Pais, Cidade) ON DELETE CASCADE ON UPDATE CASCADE
	-- Se o destino for deletado, nao faz sentido manter as associações das tags dele

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS Aeroporto (
	
	/*    ATRIBUTOS    */
	CodIATA INT,
	Pais VARCHAR(30) NOT NULL,
	Cidade VARCHAR(30) NOT NULL,
	Bairro VARCHAR(30) NOT NULL,
	Rua VARCHAR(30) NOT NULL,
	Numero INT NOT NULL,
	CEP CHAR(9) NOT NULL,-- Um CEP tem no maximo nove caracteres (00000-000)
	Nome VARCHAR(30) NOT NULL,
	
	/*    KEYS    */
	CONSTRAINT PK_Aeroporto PRIMARY KEY(CodIATA),
	CONSTRAINT FK_AeroportoDestino FOREIGN KEY (Pais, Cidade) REFERENCES Destino(Pais, Cidade) ON DELETE CASCADE ON UPDATE CASCADE,
	-- Um aeroporto nao pode existir independente de um destino, ele precisa estar fixado em um local geografico
	CONSTRAINT UC_Aeroporto UNIQUE(Pais, Cidade, Bairro, Rua, Numero)
	-- A chave secundária vale para diferenciarmos os Aeroportos, uma vez que não existem dois Aeroportos no mesmo exato local

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS Voo (
	
	/*    ATRIBUTOS    */
	Nro INT,-- TODO Deveria ser SERIAL?
	Aeroporto_Origem INT NOT NULL,
	Aeroporto_Destino INT NOT NULL,
	Data_Partida TIMESTAMP NOT NULL,
	Data_Chegada TIMESTAMP NOT NULL,-- Ambos sao TIMESTAMPS, para ja tratar o horario de um voo
	Portao_Embarque VARCHAR(30) NOT NULL,
	Portao_Desembarque VARCHAR(30) NOT NULL,-- Ambos são VARCHARs pois alguns aeroportos usam caracteres alfanumericos nos seus portoes
	
	/*    KEYS    */
	CONSTRAINT PK_Voo PRIMARY KEY(Nro),
	CONSTRAINT FK_VooOrigem FOREIGN KEY (Aeroporto_Origem) REFERENCES Aeroporto(CodIATA) ON DELETE CASCADE ON UPDATE CASCADE,
	-- A FK de origem deve ser deletada se o aeroporto for deletado, ja que um voo depende necessariamente do aeroporto que o planejou
	CONSTRAINT FK_VooDestino FOREIGN KEY (Aeroporto_Destino) REFERENCES Aeroporto(CodIATA) ON DELETE CASCADE ON UPDATE CASCADE,
    -- A FK de destino deve ser deletada se o aeroporto for deletado, ja que um voo depende necessariamente do aeroporto que o recebera

	/*    CHECKS    */
	CONSTRAINT CK_Data CHECK (Data_Partida < Data_Chegada)
	-- E impossivel a data de chegada ser antes da de partida
	-- TODO Na verdade e possivel sim, se ele pegar um voo e for contra os fuso horarios. Discutir isso 
	
);

CREATE TABLE IF NOT EXISTS VooAssentos (

	/*    ATRIBUTOS    */
	Voo INT,-- TODO Deveria ser SERIAL?
	Assentos VARCHAR(4),-- Nao achamos viavel um Aviao com mais de 9999 assentos

	/*    KEYS    */
	CONSTRAINT PK_VooAssentos PRIMARY KEY(Voo, Assentos),
	CONSTRAINT FK_VooAssentos FOREIGN KEY(Voo) REFERENCES Voo(Nro) ON DELETE CASCADE ON UPDATE CASCADE
	-- E impossivel existirem assentos nao associados a um voo
	
	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS Cliente (
	/*    ATRIBUTOS    */
	CPF CHAR(14),-- Um CPF tem no maximo 14 caracteres (123.456.789-09)
	Tipo VARCHAR(30) NOT NULL,-- TODO Tem muitas entradas que repetem essas informacoes pessoais, Tipo, Nome, Email, etc
	Nome VARCHAR(30) NOT NULL,
	Email VARCHAR(30) NOT NULL,
	Telefone VARCHAR(30) NOT NULL,
	Pais VARCHAR(30) NOT NULL,-- TODO Tem muitas entradas que repetem essas informacoes geograficas, Pais, Bairro, Cidade, etc
	Cidade VARCHAR(30) NOT NULL,
	Bairro VARCHAR(30) NOT NULL,
	Rua VARCHAR(30) NOT NULL,
	Numero VARCHAR(30) NOT NULL,
	CEP CHAR(9) NOT NULL,-- Um CEP tem no maximo nove caracteres (00000-000)
	Genero VARCHAR(30) NOT NULL,
	Religiao VARCHAR(30),
	MBTI CHAR(4),-- O indice MBTI so precisa de quatro caracteres para ser identificado (AAAA)

	/*    KEYS    */
	CONSTRAINT PK_Cliente PRIMARY KEY(CPF)

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS ClienteCondicoesMedicas (
	/*    ATRIBUTOS    */
	Cliente CHAR(14),-- Um CPF tem no maximo 14 caracteres (123.456.789-09)
	CondicoesMedicas VARCHAR(180),
	/*    KEYS    */
	CONSTRAINT PK_ClienteCondicoesMedicas PRIMARY KEY(Cliente, CondicoesMedicas)

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS Embarque (
	/*    ATRIBUTOS    */
	Voo INT,
	Assentos VARCHAR(4),
	Cliente CHAR(14),
	
	/*    KEYS    */
	CONSTRAINT PK_Embarque PRIMARY KEY(Voo, Assentos, Cliente),
	CONSTRAINT FK_EmbarqueVooAssentos FOREIGN KEY(Voo, Assentos) REFERENCES VooAssentos(Voo, Assentos) ON DELETE CASCADE ON UPDATE CASCADE,-- TODO Falar com a monitora se e valido ter foreign key de foreign key
	CONSTRAINT FK_EmbarqueCliente FOREIGN KEY(Cliente) REFERENCES Cliente(CPF) ON DELETE CASCADE ON UPDATE CASCADE
	-- Para que ocorra um embarque, tanto um Voo quanto um Cliente precisam necessariamente existir

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS Estadia (
	/*    ATRIBUTOS    */
	ID SERIAL,
	Pais VARCHAR(30) NOT NULL,-- TODO Tem muitas entradas que repetem essas informacoes geograficas, Pais, Bairro, Cidade, etc
	Cidade VARCHAR(30) NOT NULL,
	Bairro VARCHAR(30) NOT NULL,
	Rua VARCHAR(30) NOT NULL,
	Numero VARCHAR(30) NOT NULL,
	CEP CHAR(9) NOT NULL,-- Um CEP tem no maximo nove caracteres (00000-000)
	Nome VARCHAR(30) NOT NULL,
	Nro_Quartos INT,-- TODO O que e exatamente isso? Quantos quartos tem no total? Quantos quartos tem disponivel?
	
	/*    KEYS    */
	CONSTRAINT PK_Estadia PRIMARY KEY(ID),
	CONSTRAINT FK_EstadiaDestino FOREIGN KEY (Pais, Cidade) REFERENCES Destino(Pais, Cidade) ON DELETE CASCADE ON UPDATE CASCADE,
	-- Uma Estadia nao pode existir independente de um destino, ela precisa estar fixada em um local geografico
	CONSTRAINT UC_Estadia UNIQUE(Pais, Cidade, Bairro, Rua, Numero)
	-- A chave secundária vale para diferenciarmos os locais das Estadias, uma vez que não existem duas Estadias diferentes no mesmo exato local
	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS Hospedagem (
	/*    ATRIBUTOS    */
	Estadia INT,-- Foreign Keys em SERIAL sao na verdade INTs
	Cliente CHAR(14),
	Quarto VARCHAR(4) NOT NULL,-- Apesar do total de quartos estar marcado em INT, o quarto em si pode ter letras na sua designacao ('B12','B13')
	Valor NUMERIC(11,2) NOT NULL,-- Aceitamos numeros com duas casas decimais de precisao, num maximo de preço igual a 999 999 999,99
	Data_Inicio TIMESTAMP NOT NULL,
	Data_Fim TIMESTAMP NOT NULL,
	
	/*    KEYS    */
	CONSTRAINT PK_Hospedagem PRIMARY KEY(Estadia, Cliente, Quarto),
	CONSTRAINT FK_HospedagemEstadia FOREIGN KEY (Estadia) REFERENCES Estadia(ID) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT FK_HospedagemCliente FOREIGN KEY (Cliente) REFERENCES Cliente(CPF) ON DELETE CASCADE ON UPDATE CASCADE
	-- Uma Hospedagem nao pode existir sem termos tanto Estadia quanto Cliente, logo CASCADE ao perder ou autalizar qualquer um
	
	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS LocalT (
	/*    ATRIBUTOS    */
	ID SERIAL,
	Pais VARCHAR(30) NOT NULL,-- TODO Tem muitas entradas que repetem essas informacoes geograficas, Pais, Bairro, Cidade, etc
	Cidade VARCHAR(30) NOT NULL,
	Bairro VARCHAR(30) NOT NULL,
	Rua VARCHAR(30) NOT NULL,
	Numero VARCHAR(30) NOT NULL,
	Complemento VARCHAR(30),-- Nao e obrigatorio um complemento
	CEP CHAR(9) NOT NULL,-- Um CEP tem no maximo nove caracteres (00000-000)
	Nome VARCHAR(30) NOT NULL,
	
	/*    KEYS    */
	CONSTRAINT PK_Local PRIMARY KEY(ID),
	CONSTRAINT FK_LocalDestino FOREIGN KEY (Pais, Cidade) REFERENCES Destino(Pais, Cidade) ON DELETE CASCADE ON UPDATE CASCADE,
	-- Um Local nao pode existir independente de um destino, ele precisa estar fixado em um local geografico
	CONSTRAINT UC_Local UNIQUE(Pais, Cidade, Bairro, Rua, Numero, Complemento)
	-- A chave secundária vale para diferenciarmos os Locais, uma vez que não existem dois Locais exatamente iguais

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS LocalTipo (
	/*    ATRIBUTOS    */
	LocalT INT,-- Foreign Keys em SERIAL sao na verdade INTs
	Tipo VARCHAR(30),
	
	/*    KEYS    */
	CONSTRAINT PK_LocalTipo PRIMARY KEY(LocalT, Tipo),
	CONSTRAINT FK_LocalTipoLocal FOREIGN KEY (LocalT) REFERENCES LocalT(ID) ON DELETE CASCADE ON UPDATE CASCADE
	-- Um Tipo de um Local nao pode existir independente de um Local
	

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS Transporte (
	/*    ATRIBUTOS    */
	Cod_Linha VARCHAR(30),
	Tipo VARCHAR(30) NOT NULL,
	Local_Origem INT NOT NULL,-- Foreign Keys em SERIAL sao na verdade INTs
	Local_Destino INT NOT NULL,
	Horario_Ida TIMESTAMP NOT NULL,
	Horario_Chegada TIMESTAMP NOT NULL,
	
	/*    KEYS    */
	CONSTRAINT PK_Transporte PRIMARY KEY(Cod_Linha),
	CONSTRAINT FK_TransporteOrigem FOREIGN KEY (Local_Origem) REFERENCES LocalT(ID) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT FK_TransporteDestino FOREIGN KEY (Local_Destino) REFERENCES LocalT(ID) ON DELETE SET NULL ON UPDATE CASCADE,
	-- Um transporte sempre demanda uma origem (ele nao existe num void), mas o destino pode ficar marcado sem um local exato
	CONSTRAINT UC_Transporte UNIQUE(Local_Origem, Local_Destino, Horario_Ida, Horario_Chegada),

	/*    CHECKS    */
	CONSTRAINT CK_DataTransporte CHECK (Horario_Ida < Horario_Chegada)
	-- E impossivel a data de chegada ser antes da de ida
	
);

CREATE TABLE IF NOT EXISTS PontoTransporte (
	/*    ATRIBUTOS    */
	Transporte VARCHAR(30),
	LocalT INT,-- Foreign Keys em SERIAL sao na verdade INTs
	Horario TIMESTAMP NOT NULL,
	
	/*    KEYS    */
	CONSTRAINT PK_PontoTransporte PRIMARY KEY(Transporte, LocalT),
	CONSTRAINT FK_PontoTransporteTransporte FOREIGN KEY (Transporte) REFERENCES Transporte(Cod_linha) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT FK_PontoTransporteLocal FOREIGN KEY (LocalT) REFERENCES LocalT(ID) ON DELETE CASCADE ON UPDATE CASCADE

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS Organizador (
	/*    ATRIBUTOS    */
	CPF CHAR(14),-- Um CPF tem no maximo 14 caracteres (123.456.789-09)
	CNPJ CHAR(18),-- Um CNPJ tem no maximo 14 caracteres (XX.XXX.XXX/0001-XX)
	Tipo VARCHAR(30) NOT NULL,-- TODO Tem muitas entradas que repetem essas informacoes pessoais, Tipo, Nome, Email, etc
	Nome VARCHAR(30) NOT NULL,
	Email VARCHAR(30) NOT NULL,
	Telefone VARCHAR(30) NOT NULL,
	Pais VARCHAR(30) NOT NULL,-- TODO Tem muitas entradas que repetem essas informacoes geograficas, Pais, Bairro, Cidade, etc
	Cidade VARCHAR(30) NOT NULL,
	Bairro VARCHAR(30) NOT NULL,
	Rua VARCHAR(30) NOT NULL,
	Numero VARCHAR(30) NOT NULL,
	CEP CHAR(9) NOT NULL,-- Um CEP tem no maximo nove caracteres (00000-000)
	Nome_Social VARCHAR(30),
	Telefone_Empresa VARCHAR(30),-- Existe muita variacao de telefone no mundo para especificarmos um numero menor
	Email_Empresa VARCHAR(30),
	
	/*    KEYS    */
	CONSTRAINT PK_Organizador PRIMARY KEY(CPF),
	CONSTRAINT UC_Organizador UNIQUE(CNPJ)

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS OrganizadorTiposAtuacao (
	/*    ATRIBUTOS    */
	Organizador CHAR(14),-- Um CPF tem no maximo 14 caracteres (123.456.789-09)
	TiposAtuacao VARCHAR(30),
	
	/*    KEYS    */
	CONSTRAINT PK_OrganizadorTiposAtuacao PRIMARY KEY(Organizador, TiposAtuacao),
	CONSTRAINT FK_OrganizadorTiposAtuacao FOREIGN KEY (Organizador) REFERENCES Organizador(CPF) ON DELETE CASCADE ON UPDATE CASCADE
	

	/*    CHECKS    */

);

CREATE TABLE IF NOT EXISTS OrganizadorRecomendacao (
	/*    ATRIBUTOS    */
	Organizador CHAR(14),-- Um CPF tem no maximo 14 caracteres (123.456.789-09)
	Recomendacao VARCHAR(30),
	
	/*    KEYS    */
	CONSTRAINT PK_OrganizadorRecomendacao PRIMARY KEY(Organizador, Recomendacao),
	CONSTRAINT FK_OrganizadorRecomendacao FOREIGN KEY (Organizador) REFERENCES Organizador(CPF) ON DELETE CASCADE ON UPDATE CASCADE
	

	/*    CHECKS    */

);

-- ! FAZER EVENTO AQUI

-- CREATE TABLE IF NOT EXISTS tabela (
-- 	/*    ATRIBUTOS    */

	
-- 	/*    KEYS    */


-- 	/*    CHECKS    */

-- );