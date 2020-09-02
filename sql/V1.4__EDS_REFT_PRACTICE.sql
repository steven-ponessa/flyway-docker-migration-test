-- Create EDS table
CREATE TABLE EDS.REFT_PRACTICE_DIM (
      PRACTICE_ID              INTEGER  NOT NULL GENERATED ALWAYS AS IDENTITY ( START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE CACHE 20 NO ORDER )
  ,   PRACTICE_CD              CHAR    (15)
  ,   PRACTICE_NM              VARCHAR (255)
  ,   PRACTICE_DESC            VARCHAR (255)
  ,   ACCELERATED_IND          CHAR    (1)
  ,   INNOVATION_UNIT_IND      CHAR    (1)
  ,   SERVICE_LINE_CD          CHAR    (8)
  )
  DATA CAPTURE NONE 
  COMPRESS NO;

--Alter table to add primary key for Surrogate Id
ALTER TABLE EDS.REFT_PRACTICE_DIM ADD CONSTRAINT REFT_PRACTICE_DIM_PK PRIMARY KEY (PRACTICE_ID);

--Create UNIQUE INDEX based on the natural key
CREATE UNIQUE INDEX EDS.REFT_PRACTICE_DIM_UX1 
    ON EDS.REFT_PRACTICE_DIM (
      PRACTICE_CD  ASC
    )
    MINPCTUSED 0
    DISALLOW REVERSE SCANS
    PAGE SPLIT SYMMETRIC
    COLLECT SAMPLED DETAILED STATISTICS
    COMPRESS NO;

--Add comments to the table
COMMENT ON TABLE EDS.REFT_PRACTICE_DIM IS 'A Practice represents a formally organized group of practitioners.  It is a roll-up of Service Areas within a Service.';

--Add comments to the columns
COMMENT ON COLUMN EDS.REFT_PRACTICE_DIM.PRACTICE_ID IS 'Surrogate key for EDS.REFT_PRACTICE_DIM.';
COMMENT ON COLUMN EDS.REFT_PRACTICE_DIM.PRACTICE_CD IS 'Practice code';
COMMENT ON COLUMN EDS.REFT_PRACTICE_DIM.PRACTICE_NM IS 'Practice name (short description)';
COMMENT ON COLUMN EDS.REFT_PRACTICE_DIM.PRACTICE_DESC IS 'Practice long description';
COMMENT ON COLUMN EDS.REFT_PRACTICE_DIM.ACCELERATED_IND IS 'Accelerated Practice Indicator';
COMMENT ON COLUMN EDS.REFT_PRACTICE_DIM.INNOVATION_UNIT_IND IS 'Innovation Unit (IU) Practice Indicator.  IU focus is to accelerate and scale out business in these select areas and insure that we are able to attract and onboard the talent needed.';
COMMENT ON COLUMN EDS.REFT_PRACTICE_DIM.SERVICE_LINE_CD IS 'Service Line code. Foreign Key.';
