-- AVISOS:
-- Consideramos que strings pequenas possuem no maximo 30 caracteres, medias 50 e grandes 180 (um tweet) 

/* 	Criando tabela Destino
	PKs = 1
		(Pais, Cidade)

	FKs = 0

	UNIQUEs = 0
*/
CREATE TABLE Destino (
	
	/*    ATRIBUTOS    */
	Pais VARCHAR(30),
	Cidade VARCHAR(30),
	Descricao VARCHAR(180),
	Idioma VARCHAR(30) NOT NULL,
	Clima VARCHAR(30),
	
	/*    KEYS    */
	CONSTRAINT PK_Destino PRIMARY KEY(Pais, Cidade)
	
)

/* 	Criando tabela DestinoTags
	PKs = 1
		(Pais, Cidade, Tag)

	FKs = 1
		(Pais, Cidade)->Destino

	UNIQUEs = 0
*/
CREATE TABLE DestinoTags (
	
	/*    ATRIBUTOS    */
	Pais VARCHAR(30),
	Cidade VARCHAR(30),
	Tag VARCHAR(30),
	
	/*    KEYS    */
	CONSTRAINT PK_DestinoTag PRIMARY KEY(Pais, Cidade, Tag),
	CONSTRAINT FK_DestinoTag FOREIGN KEY (Pais, Cidade) REFERENCES Destino(Pais, Cidade) ON DELETE CASCADE ON UPDATE CASCADE
	-- Se o destino for deletado, nao faz sentido manter as associações das tags dele
)

/* 	Criando tabela Aeroporto
	PKs = 1
		ID

	FKs = 1
		(Pais, Cidade)->Destino

	UNIQUEs = 1
		(Pais, Cidade, Bairro, Rua, Numero)
*/
CREATE TABLE Aeroporto (
	
	/*    ATRIBUTOS    */
	ID SERIAL,
	Pais VARCHAR(30) NOT NULL,
	Cidade VARCHAR(30) NOT NULL,
	Bairro VARCHAR(30) NOT NULL,
	Rua VARCHAR(30) NOT NULL,
	Numero VARCHAR(30) NOT NULL,
	CEP CHAR(9) NOT NULL,-- Um CEP tem no maximo nove caracteres (00000-000)
	Nome VARCHAR(30) NOT NULL,
	
	/*    KEYS    */
	CONSTRAINT PK_Aeroporto PRIMARY KEY(ID),
	CONSTRAINT UC_Aeroporto UNIQUE(Pais, Cidade, Bairro, Rua, Numero),
	-- A chave secundária vale para diferenciarmos os locais dos aeroportos, uma vez que não existem dois aeroportos no mesmo exato local
	CONSTRAINT FK_AeroportoDestino FOREIGN KEY (Pais, Cidade) REFERENCES Destino(Pais, Cidade) ON DELETE CASCADE ON UPDATE CASCADE
	-- Se excluirmos os dados de um destino, nao faz sentido manter os dados dos aeroportos nesse destino
	
)

/* 	Criando tabela Voo
	PKs = 1
		Nro

	FKs = 2
		Aeroporto_Origem->Aeroporto
		Aeroporto_Destino->Aeroporto

	UNIQUEs = 0
*/
CREATE TABLE Voo (
	
	/*    ATRIBUTOS    */
	Nro INT,
	Aeroporto_Origem INT NOT NULL,
	Aeroporto_Destino INT NOT NULL,
	Data_Partida TIMESTAMP NOT NULL,
	Data_Chegada TIMESTAMP NOT NULL,-- Ambos sao TIMESTAMPS, para ja tratar o horario de um voo
	Portao_Embarque VARCHAR(30) NOT NULL,
	Portao_Desembarque VARCHAR(30) NOT NULL,-- Ambos são VARCHARs pois alguns aeroportos usam caracteres alfanumericos nos seus portoes
	
	/*    KEYS    */
	CONSTRAINT PK_Voo PRIMARY KEY(Nro),
	CONSTRAINT FK_VooOrigem FOREIGN KEY (Aeroporto_Origem) REFERENCES Aeroporto(ID) ON DELETE CASCADE ON UPDATE CASCADE,
	-- A FK de origem deve ser deletada se o aeroporto for deletado, ja que um voo depende necessariamente do aeroporto que o planejou
	CONSTRAINT FK_VooDestino FOREIGN KEY (Aeroporto_Destino) REFERENCES Aeroporto(ID) ON DELETE CASCADE ON UPDATE CASCADE,
    -- A FK de destino deve ser deletada se o aeroporto for deletado, ja que um voo depende necessariamente do aeroporto que o planejou
	-- TODO Discutir se nao vale a pena deixar ON DELETE SET NULL, ja que um novo destino pode ser marcado

	/*    CHECKS    */
	CONSTRAINT CK_Data CHECK (Data_Partida < Data_Chegada)
	-- E impossivel a data de chegada ser antes da de partida
	-- TODO Na verdade e possivel sim, se ele pegar um voo e for contra os fuso horarios. Discutir isso 
	
)

/* 	Criando tabela Voo
	PKs = 1
		(Voo, Assentos)

	FKs = 1
		Voo->Voo

	UNIQUEs = 0
*/
CREATE TABLE VooAssentos (

	/*    ATRIBUTOS    */
	Voo INT,
	Assentos INT,
	-- TODO O que significa Assentos? E um INT mesmo? N e composto isso aqui nao?

	/*    KEYS    */
	CONSTRAINT PK_VooAssentos PRIMARY KEY(Voo, Assentos),
	CONSTRAINT FK_VooAssentos FOREIGN KEY(Voo) REFERENCES Voo(Nro) ON DELETE CASCADE ON UPDATE CASCADE,
	-- E impossivel existirem assentos nao associados a um voo

)

/* 	Criando tabela Voo
	PKs = 0

	FKs = 0

	UNIQUEs = 0
*/
-- CREATE TABLE tabela (
-- 	/*    ATRIBUTOS    */
	
-- 	/*    KEYS    */

-- 	/*    CHECKS    */
-- )