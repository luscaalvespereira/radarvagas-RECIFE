-- =============================================================================
-- PROJETO RADARVAGAS (RADAREMPREGO RECIFE)
-- ESQUEMA DE BANCO DE DADOS GEOESPACIAL: POSTGRESQL + EXTENSÃO POSTGIS
-- AUTOR: Lucas Alves Pereira (Bacharel em Direito - FDR/UFPE)
-- =============================================================================

-- 1. Habilitação da extensão PostGIS para cálculos espaciais geodésicos
CREATE EXTENSION IF NOT EXISTS postgis;

-- 2. Tabela de Edifícios Comerciais Mapeados (Micro-Densidade Vertical)
CREATE TABLE IF NOT EXISTS edificios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    numero VARCHAR(50),
    bairro VARCHAR(100) DEFAULT 'Boa Vista',
    cidade VARCHAR(100) DEFAULT 'Recife',
    estado CHAR(2) DEFAULT 'PE',
    cep CHAR(8) NOT NULL,
    total_salas INT DEFAULT 0,
    geom GEOGRAPHY(Point, 4326) NOT NULL,
    criado_em TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 3. Tabela de Corredores Viários Estruturantes (Densidade Linear)
CREATE TABLE IF NOT EXISTS corredores (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    ponto_inicial VARCHAR(255),
    ponto_final VARCHAR(255),
    extensao_metros NUMERIC(10,2),
    linha_viaria GEOGRAPHY(LineString, 4326) NOT NULL,
    criado_em TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 4. Tabela Central de Empresas e Estabelecimentos Ativos
CREATE TABLE IF NOT EXISTS empresas (
    id SERIAL PRIMARY KEY,
    cnpj CHAR(14) UNIQUE NOT NULL,
    razao_social VARCHAR(255) NOT NULL,
    nome_fantasia VARCHAR(255),
    cnae_principal VARCHAR(10),
    descricao_cnae TEXT,
    edificio_id INT REFERENCES edificios(id) ON DELETE SET NULL,
    sala_andar VARCHAR(100),
    logradouro VARCHAR(255) NOT NULL,
    numero VARCHAR(50),
    complemento VARCHAR(100),
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) DEFAULT 'Recife',
    estado CHAR(2) DEFAULT 'PE',
    cep CHAR(8) NOT NULL,
    email_contato VARCHAR(255),
    telefone VARCHAR(50),
    whatsapp VARCHAR(50),
    responsavel_rh VARCHAR(255),
    geom GEOGRAPHY(Point, 4326) NOT NULL,
    ativo BOOLEAN DEFAULT TRUE,
    opt_out BOOLEAN DEFAULT FALSE,
    criado_em TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 5. Tabela de Telemetria de Disparos e Conformidade Anti-Spam / LGPD
CREATE TABLE IF NOT EXISTS envios_outreach (
    id SERIAL PRIMARY KEY,
    empresa_id INT NOT NULL REFERENCES empresas(id) ON DELETE CASCADE,
    email_destinatario VARCHAR(255) NOT NULL,
    conta_remetente VARCHAR(255) NOT NULL,
    assunto_spintax TEXT NOT NULL,
    corpo_mensagem TEXT NOT NULL,
    status_envio VARCHAR(50) DEFAULT 'ENVIADO', -- 'ENVIADO', 'FALHA', 'BOUNCE', 'OPT_OUT'
    mensagem_erro TEXT,
    tempo_resposta_segundos INT,
    enviado_em TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 6. Criação de Índices Espaciais GiST de Alta Performance (Buscas em < 5ms)
CREATE INDEX IF NOT EXISTS idx_empresas_geom ON empresas USING GIST(geom);
CREATE INDEX IF NOT EXISTS idx_edificios_geom ON edificios USING GIST(geom);
CREATE INDEX IF NOT EXISTS idx_corredores_linha ON corredores USING GIST(linha_viaria);
CREATE INDEX IF NOT EXISTS idx_empresas_cnpj ON empresas(cnpj);
CREATE INDEX IF NOT EXISTS idx_empresas_cep ON empresas(cep);
CREATE INDEX IF NOT EXISTS idx_empresas_edificio ON empresas(edificio_id);

-- =============================================================================
-- INSERTS DE EXEMPLO COM O CASO PILOTO REAL
-- =============================================================================

-- Inserindo o Edifício Círculo Católico
INSERT INTO edificios (nome, endereco, numero, bairro, cep, geom)
VALUES (
    'Edifício Círculo Católico', 
    'Rua do Riachuelo', 
    '105', 
    'Boa Vista', 
    '50050400', 
    ST_SetSRID(ST_MakePoint(-34.882200, -8.060100), 4326)::geography
) ON CONFLICT DO NOTHING;

-- Inserindo o Corredor da Avenida Conde da Boa Vista (Trecho Cinema São Luiz -> Shopping Boa Vista)
INSERT INTO corredores (nome, ponto_inicial, ponto_final, linha_viaria)
VALUES (
    'Avenida Conde da Boa Vista',
    'Cinema São Luiz (Ponte Duarte Coelho)',
    'Shopping Boa Vista',
    ST_SetSRID(ST_MakeLine(
        ST_MakePoint(-34.880500, -8.060900),
        ST_MakePoint(-34.891200, -8.058300)
    ), 4326)::geography
) ON CONFLICT DO NOTHING;

-- =============================================================================
-- QUERIES FUNDAMENTAIS DE GEOINTELIGÊNCIA HIPERLOCAL
-- =============================================================================

-- QUERY A: Listar todas as empresas dentro de um edifício comercial específico
SELECT 
    e.nome_fantasia, 
    e.razao_social, 
    e.sala_andar, 
    e.email_contato, 
    e.telefone,
    e.descricao_cnae
FROM empresas e
JOIN edificios ed ON e.edificio_id = ed.id
WHERE ed.nome = 'Edifício Círculo Católico'
  AND e.opt_out = FALSE
ORDER BY e.sala_andar ASC;

-- QUERY B: Consulta Radial por Raio Concêntrico (Ex: 1 km a partir do Círculo Católico)
SELECT 
    e.nome_fantasia, 
    e.logradouro, 
    e.numero, 
    e.bairro, 
    e.email_contato,
    ROUND(ST_Distance(e.geom, ST_SetSRID(ST_MakePoint(-34.882200, -8.060100), 4326)::geography)::numeric, 1) AS distancia_metros
FROM empresas e
WHERE ST_DWithin(e.geom, ST_SetSRID(ST_MakePoint(-34.882200, -8.060100), 4326)::geography, 1000)
  AND e.opt_out = FALSE
ORDER BY distancia_metros ASC;

-- QUERY C: Consulta Linear por Corredor Viário com Buffer de 50 metros (Ambos os Lados)
SELECT 
    e.nome_fantasia, 
    e.numero, 
    e.logradouro, 
    e.sala_andar, 
    e.email_contato
FROM empresas e, corredores c
WHERE c.nome = 'Avenida Conde da Boa Vista'
  AND ST_DWithin(e.geom, c.linha_viaria, 50)
  AND e.opt_out = FALSE
ORDER BY e.numero ASC;