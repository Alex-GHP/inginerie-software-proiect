-- =====================================================
-- Schema Bază de Date - Sistem Clasificare Ideologie Politică
-- PostgreSQL 16+
-- =====================================================

-- Activare extensii necesare
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- =====================================================
-- TIPURI ENUM
-- =====================================================

CREATE TYPE user_role AS ENUM ('user', 'analyst', 'admin');
CREATE TYPE analysis_status AS ENUM ('pending', 'queued', 'processing', 'completed', 'failed', 'archived');
CREATE TYPE export_format AS ENUM ('pdf', 'csv', 'json', 'xlsx');

-- =====================================================
-- TABELA: users
-- Stochează informațiile utilizatorilor
-- =====================================================

CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    name VARCHAR(100) NOT NULL,
    role user_role NOT NULL DEFAULT 'user',
    is_active BOOLEAN NOT NULL DEFAULT true,
    is_email_verified BOOLEAN NOT NULL DEFAULT false,
    profile_picture_url VARCHAR(500),
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE,
    last_login TIMESTAMP WITH TIME ZONE,
    deleted_at TIMESTAMP WITH TIME ZONE,
    
    CONSTRAINT chk_email_format CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
);

-- Indexuri pentru users
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role ON users(role);
CREATE INDEX idx_users_is_active ON users(is_active) WHERE is_active = true;
CREATE INDEX idx_users_deleted_at ON users(deleted_at) WHERE deleted_at IS NOT NULL;

-- =====================================================
-- TABELA: text_analyses
-- Stochează analizele de text
-- =====================================================

CREATE TABLE text_analyses (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    text_content TEXT NOT NULL,
    text_hash VARCHAR(64) NOT NULL, -- SHA-256 hash pentru deduplicare
    language VARCHAR(10) NOT NULL DEFAULT 'ro',
    word_count INTEGER NOT NULL,
    status analysis_status NOT NULL DEFAULT 'pending',
    source_filename VARCHAR(255),
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE,
    completed_at TIMESTAMP WITH TIME ZONE,
    
    CONSTRAINT chk_word_count CHECK (word_count > 0),
    CONSTRAINT chk_language CHECK (language IN ('ro', 'en'))
);

-- Indexuri pentru text_analyses
CREATE INDEX idx_analyses_user_id ON text_analyses(user_id);
CREATE INDEX idx_analyses_status ON text_analyses(status);
CREATE INDEX idx_analyses_created_at ON text_analyses(created_at DESC);
CREATE INDEX idx_analyses_text_hash ON text_analyses(text_hash);
CREATE INDEX idx_analyses_user_status ON text_analyses(user_id, status);

-- =====================================================
-- TABELA: classification_results
-- Stochează rezultatele clasificării
-- =====================================================

CREATE TABLE classification_results (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    analysis_id UUID NOT NULL UNIQUE REFERENCES text_analyses(id) ON DELETE CASCADE,
    left_right_score DECIMAL(5, 4) NOT NULL,
    auth_lib_score DECIMAL(5, 4) NOT NULL,
    economic_score DECIMAL(5, 4) NOT NULL,
    social_score DECIMAL(5, 4) NOT NULL,
    confidence DECIMAL(5, 4) NOT NULL,
    quadrant VARCHAR(50) NOT NULL,
    keywords JSONB NOT NULL DEFAULT '[]',
    model_version VARCHAR(50) NOT NULL,
    processing_time_ms INTEGER NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    
    CONSTRAINT chk_scores_range CHECK (
        left_right_score BETWEEN 0 AND 1 AND
        auth_lib_score BETWEEN 0 AND 1 AND
        economic_score BETWEEN 0 AND 1 AND
        social_score BETWEEN 0 AND 1 AND
        confidence BETWEEN 0 AND 1
    ),
    CONSTRAINT chk_quadrant CHECK (quadrant IN (
        'Libertarian Left', 'Libertarian Right',
        'Authoritarian Left', 'Authoritarian Right',
        'Center'
    ))
);

-- Indexuri pentru classification_results
CREATE INDEX idx_results_analysis_id ON classification_results(analysis_id);
CREATE INDEX idx_results_quadrant ON classification_results(quadrant);
CREATE INDEX idx_results_confidence ON classification_results(confidence DESC);
CREATE INDEX idx_results_keywords ON classification_results USING GIN(keywords);

-- =====================================================
-- TABELA: batch_jobs
-- Stochează job-urile de procesare batch
-- =====================================================

CREATE TABLE batch_jobs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    total_documents INTEGER NOT NULL,
    processed_documents INTEGER NOT NULL DEFAULT 0,
    failed_documents INTEGER NOT NULL DEFAULT 0,
    status analysis_status NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    started_at TIMESTAMP WITH TIME ZONE,
    completed_at TIMESTAMP WITH TIME ZONE,
    
    CONSTRAINT chk_document_counts CHECK (
        total_documents > 0 AND
        processed_documents >= 0 AND
        failed_documents >= 0 AND
        processed_documents + failed_documents <= total_documents
    )
);

-- Indexuri pentru batch_jobs
CREATE INDEX idx_batches_user_id ON batch_jobs(user_id);
CREATE INDEX idx_batches_status ON batch_jobs(status);
CREATE INDEX idx_batches_created_at ON batch_jobs(created_at DESC);

-- =====================================================
-- TABELA: batch_analyses
-- Legătură între batch-uri și analize
-- =====================================================

CREATE TABLE batch_analyses (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    batch_id UUID NOT NULL REFERENCES batch_jobs(id) ON DELETE CASCADE,
    analysis_id UUID NOT NULL REFERENCES text_analyses(id) ON DELETE CASCADE,
    order_index INTEGER NOT NULL,
    
    CONSTRAINT uq_batch_analysis UNIQUE (batch_id, analysis_id),
    CONSTRAINT uq_batch_order UNIQUE (batch_id, order_index)
);

-- Indexuri pentru batch_analyses
CREATE INDEX idx_batch_analyses_batch_id ON batch_analyses(batch_id);
CREATE INDEX idx_batch_analyses_analysis_id ON batch_analyses(analysis_id);

-- =====================================================
-- TABELA: analysis_exports
-- Stochează exporturile generate
-- =====================================================

CREATE TABLE analysis_exports (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    analysis_id UUID NOT NULL REFERENCES text_analyses(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    format export_format NOT NULL,
    file_path VARCHAR(500) NOT NULL,
    file_size_bytes BIGINT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    expires_at TIMESTAMP WITH TIME ZONE NOT NULL,
    
    CONSTRAINT chk_file_size CHECK (file_size_bytes > 0)
);

-- Indexuri pentru analysis_exports
CREATE INDEX idx_exports_analysis_id ON analysis_exports(analysis_id);
CREATE INDEX idx_exports_user_id ON analysis_exports(user_id);
CREATE INDEX idx_exports_expires_at ON analysis_exports(expires_at);

-- =====================================================
-- TABELA: user_sessions
-- Stochează sesiunile utilizatorilor
-- =====================================================

CREATE TABLE user_sessions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    refresh_token_hash VARCHAR(255) NOT NULL,
    ip_address VARCHAR(45) NOT NULL,
    user_agent VARCHAR(500),
    is_active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    expires_at TIMESTAMP WITH TIME ZONE NOT NULL,
    revoked_at TIMESTAMP WITH TIME ZONE
);

-- Indexuri pentru user_sessions
CREATE INDEX idx_sessions_user_id ON user_sessions(user_id);
CREATE INDEX idx_sessions_is_active ON user_sessions(is_active) WHERE is_active = true;
CREATE INDEX idx_sessions_expires_at ON user_sessions(expires_at);

-- =====================================================
-- TABELA: password_reset_tokens
-- Stochează token-urile de resetare parolă
-- =====================================================

CREATE TABLE password_reset_tokens (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    token_hash VARCHAR(255) NOT NULL,
    is_used BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    expires_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Indexuri pentru password_reset_tokens
CREATE INDEX idx_reset_tokens_user_id ON password_reset_tokens(user_id);
CREATE INDEX idx_reset_tokens_expires_at ON password_reset_tokens(expires_at);

-- =====================================================
-- TABELA: api_keys
-- Stochează cheile API pentru integrări
-- =====================================================

CREATE TABLE api_keys (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    key_hash VARCHAR(255) NOT NULL,
    last_used_at TIMESTAMP WITH TIME ZONE,
    is_active BOOLEAN NOT NULL DEFAULT true,
    rate_limit INTEGER NOT NULL DEFAULT 1000,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    expires_at TIMESTAMP WITH TIME ZONE,
    
    CONSTRAINT chk_rate_limit CHECK (rate_limit > 0)
);

-- Indexuri pentru api_keys
CREATE INDEX idx_api_keys_user_id ON api_keys(user_id);
CREATE INDEX idx_api_keys_is_active ON api_keys(is_active) WHERE is_active = true;

-- =====================================================
-- TABELA: audit_logs
-- Stochează logurile de audit
-- =====================================================

CREATE TABLE audit_logs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE SET NULL,
    action VARCHAR(50) NOT NULL,
    resource_type VARCHAR(50) NOT NULL,
    resource_id UUID,
    ip_address VARCHAR(45),
    details JSONB,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

-- Indexuri pentru audit_logs
CREATE INDEX idx_audit_logs_user_id ON audit_logs(user_id);
CREATE INDEX idx_audit_logs_action ON audit_logs(action);
CREATE INDEX idx_audit_logs_resource ON audit_logs(resource_type, resource_id);
CREATE INDEX idx_audit_logs_created_at ON audit_logs(created_at DESC);

-- Partiționare pe luni pentru audit_logs (opțional, pentru volume mari)
-- CREATE TABLE audit_logs (...) PARTITION BY RANGE (created_at);

-- =====================================================
-- TABELA: system_settings
-- Stochează setările sistemului
-- =====================================================

CREATE TABLE system_settings (
    key VARCHAR(100) PRIMARY KEY,
    value JSONB NOT NULL,
    description TEXT,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_by UUID REFERENCES users(id) ON DELETE SET NULL
);

-- =====================================================
-- FUNCȚII TRIGGER
-- =====================================================

-- Funcție pentru actualizare automată updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Trigger pentru users
CREATE TRIGGER update_users_updated_at
    BEFORE UPDATE ON users
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Trigger pentru text_analyses
CREATE TRIGGER update_analyses_updated_at
    BEFORE UPDATE ON text_analyses
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Funcție pentru calculare word_count
CREATE OR REPLACE FUNCTION calculate_word_count()
RETURNS TRIGGER AS $$
BEGIN
    NEW.word_count = array_length(regexp_split_to_array(trim(NEW.text_content), '\s+'), 1);
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Trigger pentru calculare automată word_count
CREATE TRIGGER calculate_analysis_word_count
    BEFORE INSERT ON text_analyses
    FOR EACH ROW
    EXECUTE FUNCTION calculate_word_count();

-- Funcție pentru hash text
CREATE OR REPLACE FUNCTION calculate_text_hash()
RETURNS TRIGGER AS $$
BEGIN
    NEW.text_hash = encode(digest(NEW.text_content, 'sha256'), 'hex');
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Trigger pentru hash text
CREATE TRIGGER calculate_analysis_text_hash
    BEFORE INSERT ON text_analyses
    FOR EACH ROW
    EXECUTE FUNCTION calculate_text_hash();

-- =====================================================
-- VIEWS
-- =====================================================

-- View pentru analize complete cu rezultate
CREATE OR REPLACE VIEW v_complete_analyses AS
SELECT 
    a.id AS analysis_id,
    a.user_id,
    u.name AS user_name,
    u.email AS user_email,
    a.text_content,
    a.language,
    a.word_count,
    a.status,
    a.created_at AS analysis_created_at,
    a.completed_at,
    r.left_right_score,
    r.auth_lib_score,
    r.economic_score,
    r.social_score,
    r.confidence,
    r.quadrant,
    r.keywords,
    r.processing_time_ms
FROM text_analyses a
JOIN users u ON a.user_id = u.id
LEFT JOIN classification_results r ON a.id = r.analysis_id;

-- View pentru statistici utilizator
CREATE OR REPLACE VIEW v_user_statistics AS
SELECT 
    u.id AS user_id,
    u.name,
    u.email,
    COUNT(a.id) AS total_analyses,
    COUNT(CASE WHEN a.status = 'completed' THEN 1 END) AS completed_analyses,
    COUNT(CASE WHEN a.status = 'failed' THEN 1 END) AS failed_analyses,
    AVG(r.confidence) AS avg_confidence,
    MAX(a.created_at) AS last_analysis_at
FROM users u
LEFT JOIN text_analyses a ON u.id = a.user_id
LEFT JOIN classification_results r ON a.id = r.analysis_id
GROUP BY u.id, u.name, u.email;

-- =====================================================
-- DATE INIȚIALE
-- =====================================================

-- Inserare setări sistem implicite
INSERT INTO system_settings (key, value, description) VALUES
    ('max_text_length', '50000', 'Lungimea maximă a textului în caractere'),
    ('min_text_length', '100', 'Lungimea minimă a textului în caractere'),
    ('max_batch_size', '50', 'Numărul maxim de documente per batch'),
    ('result_cache_ttl', '3600', 'TTL cache rezultate în secunde'),
    ('export_retention_days', '7', 'Zile păstrare fișiere export'),
    ('analysis_retention_days', '90', 'Zile păstrare analize înainte de arhivare'),
    ('supported_languages', '["ro", "en"]', 'Limbi suportate pentru analiză')
ON CONFLICT (key) DO NOTHING;

-- =====================================================
-- COMENTARII
-- =====================================================

COMMENT ON TABLE users IS 'Tabelă principală utilizatori';
COMMENT ON TABLE text_analyses IS 'Stochează textele trimise pentru analiză';
COMMENT ON TABLE classification_results IS 'Rezultatele clasificării NLP';
COMMENT ON TABLE batch_jobs IS 'Job-uri de procesare batch';
COMMENT ON TABLE audit_logs IS 'Jurnal de audit pentru conformitate GDPR';

