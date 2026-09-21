BEGIN;
ALTER TABLE learners ADD COLUMN IF NOT EXISTS parent_phone text;
ALTER TABLE report_templates ADD COLUMN IF NOT EXISTS config jsonb DEFAULT '{}'::jsonb;
CREATE TABLE IF NOT EXISTS school_resource_documents(
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(), school_id uuid NOT NULL REFERENCES schools(id) ON DELETE CASCADE,
 title text NOT NULL, resource_type text NOT NULL CHECK(resource_type IN ('PDF','SCHEME_OF_WORK','REVISION_PAPER','TEACHER_GUIDE','OTHER')),
 file_url text NOT NULL, original_name text, description text DEFAULT '', uploaded_by uuid REFERENCES users(id), is_active boolean NOT NULL DEFAULT true, created_at timestamptz DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_school_resources ON school_resource_documents(school_id,is_active,resource_type,created_at DESC);
COMMIT;
