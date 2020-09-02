-- Create EDS table
CREATE TABLE EDS.REFT_LABOR_MODEL_DIM (
      LABOR_MODEL_KEY          INTEGER  NOT NULL GENERATED ALWAYS AS IDENTITY ( START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE CACHE 20 NO ORDER )
  ,   LABOR_MODEL_CD           CHAR    (8) NOT NULL
  ,   LEAF_CD                  CHAR    (8) NOT NULL
  ,   LEAF_NM                  VARCHAR (255) NOT NULL
  ,   L10_CD                   CHAR    (8) NOT NULL
  ,   L10_NM                   VARCHAR (255) NOT NULL
  ,   L20_CD                   CHAR    (8) NOT NULL
  ,   L20_NM                   VARCHAR (255) NOT NULL
  ,   L30_CD                   CHAR    (8) NOT NULL
  ,   L30_NM                   VARCHAR (255) NOT NULL
  ,   L40_CD                   CHAR    (8)
  ,   L40_NM                   VARCHAR (255)
  ,   L50_CD                   CHAR    (8)
  ,   L50_NM                   VARCHAR (255)
  )
  DATA CAPTURE NONE 
  COMPRESS NO;

--Alter table to add primary key for Surrogate Id
ALTER TABLE EDS.REFT_LABOR_MODEL_DIM ADD CONSTRAINT REFT_LABOR_MODEL_DIM_PK PRIMARY KEY (LABOR_MODEL_KEY);

--Create UNIQUE INDEX based on the natural key
CREATE UNIQUE INDEX EDS.REFT_LABOR_MODEL_DIM_UX1 
    ON EDS.REFT_LABOR_MODEL_DIM (
      LABOR_MODEL_CD  ASC
    , LEAF_CD  ASC
    )
    MINPCTUSED 0
    DISALLOW REVERSE SCANS
    PAGE SPLIT SYMMETRIC
    COLLECT SAMPLED DETAILED STATISTICS
    COMPRESS NO;

--Add comments to the table
COMMENT ON TABLE EDS.REFT_LABOR_MODEL_DIM IS 'The Services Labor Model is a structure to capture the organizational structure of IBM’s services business from a resource perspective. It is intended to support global capacity management, financial planning, and resource deploy…';

--Add comments to the columns
COMMENT ON COLUMN EDS.REFT_LABOR_MODEL_DIM.LABOR_MODEL_KEY IS 'Surrogate key for EDS.REFT_LABOR_MODEL_DIM.';
COMMENT ON COLUMN EDS.REFT_LABOR_MODEL_DIM.LABOR_MODEL_CD IS 'Labor Model code';
COMMENT ON COLUMN EDS.REFT_LABOR_MODEL_DIM.LEAF_CD IS 'Level code for leaf node';
COMMENT ON COLUMN EDS.REFT_LABOR_MODEL_DIM.LEAF_NM IS 'Level name (short description) for leaf node';
COMMENT ON COLUMN EDS.REFT_LABOR_MODEL_DIM.L10_CD IS 'Level 10 code';
COMMENT ON COLUMN EDS.REFT_LABOR_MODEL_DIM.L10_NM IS 'Level 10 name (short description)';
COMMENT ON COLUMN EDS.REFT_LABOR_MODEL_DIM.L20_CD IS 'Level 20 code';
COMMENT ON COLUMN EDS.REFT_LABOR_MODEL_DIM.L20_NM IS 'Level 20 name (short description)';
COMMENT ON COLUMN EDS.REFT_LABOR_MODEL_DIM.L30_CD IS 'Level 30 code';
COMMENT ON COLUMN EDS.REFT_LABOR_MODEL_DIM.L30_NM IS 'Level 30 name (short description)';
COMMENT ON COLUMN EDS.REFT_LABOR_MODEL_DIM.L40_CD IS 'Level 40 code';
COMMENT ON COLUMN EDS.REFT_LABOR_MODEL_DIM.L40_NM IS 'Level 40 name (short description)';
COMMENT ON COLUMN EDS.REFT_LABOR_MODEL_DIM.L50_CD IS 'Level 50 code';
COMMENT ON COLUMN EDS.REFT_LABOR_MODEL_DIM.L50_NM IS 'Level 50 name (short description)';