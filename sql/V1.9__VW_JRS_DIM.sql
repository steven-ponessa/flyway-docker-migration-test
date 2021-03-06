CREATE OR REPLACE VIEW EDS.VW_JRS_DIM
AS
SELECT  RTRIM(J.JOB_ROLE_CD) || '-' || RTRIM(S.SPECIALTY_CD) AS JRS_CD
     ,  B.BRAND_CD
     ,  B.BRAND_NM
     ,  GP.GROWTH_PLATFORM_CD
     ,  GP.GROWTH_PLATFORM_NM
     ,  SL.SERVICE_LINE_CD
     ,  SL.SERVICE_LINE_NM
     ,  P.PRACTICE_CD
     ,  P.PRACTICE_NM
     ,  SA.SERVICE_AREA_CD
     ,  SA.SERVICE_AREA_NM
     ,  J.JOB_ROLE_CD
     ,  J.JOB_ROLE_NM
     ,  S.SPECIALTY_CD
     ,  S.SPECIALTY_NM
FROM    EDS.REFT_BRAND_DIM           B
   ,    EDS.REFT_GROWTH_PLATFORM_DIM GP
   ,    EDS.REFT_SERVICE_LINE_DIM    SL
   ,    EDS.REFT_PRACTICE_DIM        P
   ,    EDS.REFT_SERVICE_AREA_DIM    SA
   ,    EDS.REFT_SERVICE_AREA_JOB_ROLE_SPECIALTY_ASSOC A
   ,    EDS.REFT_JOB_ROLE_DIM        J
   ,    EDS.REFT_SPECIALTY_DIM       S
WHERE   B.BRAND_CD            = GP.BRAND_CD
  AND   GP.GROWTH_PLATFORM_CD = SL.GROWTH_PLATFORM_CD
  AND   SL.SERVICE_LINE_CD    = P.SERVICE_LINE_CD
  AND   P.PRACTICE_CD         = SA.PRACTICE_CD
  AND   SA.SERVICE_AREA_CD    = A.SERVICE_AREA_CD
  AND   A.JOB_ROLE_CD         = J.JOB_ROLE_CD
  AND   A.SPECIALTY_CD        = S.SPECIALTY_CD
--ORDER BY B.BRAND_CD
--       , GP.GROWTH_PLATFORM_CD
--       , SL.SERVICE_LINE_CD
--       , S.SPECIALTY_CD
--       , P.PRACTICE_CD
--       , SA.SERVICE_AREA_CD
--       , J.JOB_ROLE_CD
--       , S.SPECIALTY_CD
;

