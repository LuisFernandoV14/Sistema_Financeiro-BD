-- Vou separar os arquivos em "Schema" (criação e modificação de tabelas), "Data" (inserção, deleção e etc) e "Queries" (consultas no banco de dados)

CREATE DATABASE IF NOT EXISTS sistema_financeiro;
USE sistema_financeiro;

CREATE TABLE endereco (
	id_Endereco INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	rua VARCHAR(100),
    numero VARCHAR(10),
    cidade VARCHAR(50),
    estado VARCHAR(2),
    cep VARCHAR(10)
);

CREATE TABLE cliente (
	id_Cliente INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255),
    CPF VARCHAR(11) UNIQUE,
    data_Nascimento DATE,
    telefone VARCHAR(20),
    endereco INT UNSIGNED,
    
    -- Cliente mora em Endereço
    CONSTRAINT fk_EnderecoCliente FOREIGN KEY (endereco) REFERENCES Endereco (id_Endereco)
	ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE dependente (
    id_Dependente INT UNSIGNED NOT NULL,
    parentesco VARCHAR(255),
    data_Nascimento DATE,
    nome VARCHAR(255),
    
    -- Cliente pode ter Dependente
    CONSTRAINT fk_ClienteDependente FOREIGN KEY (id_Dependente) REFERENCES Cliente (id_Cliente)
	ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE agencia (
	id_Agencia INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome_Agencia VARCHAR(255),
    endereco_Agencia INT UNSIGNED NOT NULL,
    
    -- Agencia tem Endereço
    CONSTRAINT fk_EnderecoAgencia FOREIGN KEY (endereco_Agencia) REFERENCES Endereco (id_Endereco)
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE gerente (
	id_Gerente INT UNSIGNED PRIMARY KEY,
    nome VARCHAR (255),
    CPF VARCHAR(11),
    telefone VARCHAR(20),
    id_Agencia INT UNSIGNED,
    
    -- Gerente atua em agencia
    CONSTRAINT fk_AgenciaGerente FOREIGN KEY (id_Agencia) REFERENCES Agencia (id_Agencia)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE conta (
	id_Conta INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    numero_Conta VARCHAR(15),
    saldo DECIMAL(15,2),
    data_Abertura DATE,
    id_Cliente INT UNSIGNED,
    
    -- Cliente possui Conta
    CONSTRAINT fk_ClienteConta FOREIGN KEY (id_Cliente) REFERENCES Cliente (id_Cliente)
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE cartao (
	id_Cartao INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    numero_Cartao VARCHAR(20),
    validade DATE,
    CVV VARCHAR(3),
    tipo_Cartao VARCHAR(20),
    id_Conta INT UNSIGNED,
    
    -- Conta emite Cartao
    CONSTRAINT fk_ContaCartao FOREIGN KEY (id_Conta) REFERENCES Conta (id_Conta)
	ON UPDATE CASCADE ON DELETE RESTRICT
);

-- Tipos de conta (associação) :

CREATE TABLE corrente (
	id_Tipo INT UNSIGNED PRIMARY KEY,
	tarifa_mensal DECIMAL(15,2),
    
    -- Define o tipo de Conta como Corrente
    CONSTRAINT fk_idTipoConta_1 FOREIGN KEY (id_Tipo) REFERENCES Conta (id_Conta)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE investimento (
    id_Tipo INT UNSIGNED PRIMARY KEY,
	tipo_Investimento VARCHAR(255),
    valor_Aplicado DECIMAL(15,2),
    
    -- Define o tipo de Conta como Investimento
    CONSTRAINT fk_idTipoConta_2 FOREIGN KEY (id_Tipo) REFERENCES Conta (id_Conta)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE poupança (
	id_Tipo INT UNSIGNED PRIMARY KEY,
    rendimento DECIMAL(15,2),
    data_Rendimento DATE, 
    
    -- Define o tipo de Conta como Poupança
    CONSTRAINT fk_idTipoConta_3 FOREIGN KEY (id_Tipo) REFERENCES Conta (id_Conta)
    ON UPDATE CASCADE ON DELETE RESTRICT
);
