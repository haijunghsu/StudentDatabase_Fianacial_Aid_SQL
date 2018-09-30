SELECT DISTINCT A.AID_YEAR, A.EMPLID, B.Y_AWD_OFFR_FALL, B.Y_AWD_OFFR_WINT, B.Y_AWD_OFFR_FW_TTL, B.Y_AWD_OFFR_SPSU, A.PRIMARY_EFC, C.Y_FULL_TIME_ADJ, C.Y_THR_QTR_TIME_ADJ, C.Y_HALF_TIME_ADJ, C.Y_LSS_HLF_TIME_ADJ, D.STRM, D.TERM_SRC, D.FA_LOAD, D.UNT_TAKEN_FA, D.UNT_TAKEN_FA_CL, E.STRM, E.TERM_SRC, E.FA_LOAD, E.UNT_TAKEN_FA, E.UNT_TAKEN_FA_CL, F.STRM, F.TERM_SRC, F.FA_LOAD, F.UNT_TAKEN_FA, F.UNT_TAKEN_FA_CL, TO_CHAR(G.EFFDT,'YYYY-MM-DD'),  G.SFA_LIFETIME_ELIG * 100, A.PELL_ELIGIBILITY, SYSDATE, TO_CHAR(D.START_DATE,'YYYY-MM-DD'), TO_CHAR(E.START_DATE,'YYYY-MM-DD'), TO_CHAR(F.START_DATE,'YYYY-MM-DD'), I.FA_DFLT_RULE_SET, J.PELL_CALC_START, H.PELL_CALC_START 
  FROM (((((PS_Y_DASH_ISIR_VW A LEFT OUTER JOIN  PS_Y_DASH_AWRD_VW B ON  A.AID_YEAR = B.AID_YEAR AND A.EMPLID = B.EMPLID AND B.FEDERAL_ID = 'PELL' ) LEFT OUTER JOIN  PS_STDNT_FA_TERM D ON  A.AID_YEAR = D.AID_YEAR AND A.EMPLID = D.EMPLID AND ( D.EFFDT = 
        (SELECT MAX(D_ED.EFFDT) FROM PS_STDNT_FA_TERM D_ED 
        WHERE D.EMPLID = D_ED.EMPLID 
          AND D.INSTITUTION = D_ED.INSTITUTION 
          AND D.STRM = D_ED.STRM 
          AND D_ED.EFFDT <= SYSDATE) 
    AND D.EFFSEQ = 
        (SELECT MAX(D_ES.EFFSEQ) FROM PS_STDNT_FA_TERM D_ES 
        WHERE D.EMPLID = D_ES.EMPLID 
          AND D.INSTITUTION = D_ES.INSTITUTION 
          AND D.STRM = D_ES.STRM 
          AND D.EFFDT = D_ES.EFFDT) OR D.EFFDT IS NULL) AND D.STRM = 2 || substr(( A.AID_YEAR - 1), 3, 2) || 5 ) LEFT OUTER JOIN  PS_STDNT_FA_TERM E ON  A.AID_YEAR = E.AID_YEAR AND A.EMPLID = E.EMPLID AND E.STRM = 2 || substr(  A.AID_YEAR, 3, 2) || 1 AND ( E.EFFDT = 
        (SELECT MAX(E_ED.EFFDT) FROM PS_STDNT_FA_TERM E_ED 
        WHERE E.EMPLID = E_ED.EMPLID 
          AND E.INSTITUTION = E_ED.INSTITUTION 
          AND E.STRM = E_ED.STRM 
          AND E_ED.EFFDT <= SYSDATE) 
    AND E.EFFSEQ = 
        (SELECT MAX(E_ES.EFFSEQ) FROM PS_STDNT_FA_TERM E_ES 
        WHERE E.EMPLID = E_ES.EMPLID 
          AND E.INSTITUTION = E_ES.INSTITUTION 
          AND E.STRM = E_ES.STRM 
          AND E.EFFDT = E_ES.EFFDT) OR E.EFFDT IS NULL) ) LEFT OUTER JOIN  PS_STDNT_FA_TERM F ON  A.AID_YEAR = F.AID_YEAR AND A.EMPLID = F.EMPLID AND ( F.EFFDT = 
        (SELECT MAX(F_ED.EFFDT) FROM PS_STDNT_FA_TERM F_ED 
        WHERE F.EMPLID = F_ED.EMPLID 
          AND F.INSTITUTION = F_ED.INSTITUTION 
          AND F.STRM = F_ED.STRM 
          AND F_ED.EFFDT <= SYSDATE) 
    AND F.EFFSEQ = 
        (SELECT MAX(F_ES.EFFSEQ) FROM PS_STDNT_FA_TERM F_ES 
        WHERE F.EMPLID = F_ES.EMPLID 
          AND F.INSTITUTION = F_ES.INSTITUTION 
          AND F.STRM = F_ES.STRM 
          AND F.EFFDT = F_ES.EFFDT) OR F.EFFDT IS NULL) AND F.STRM = 2 || substr( A.AID_YEAR, 3 ,2) || 3 ) LEFT OUTER JOIN  PS_NSLDS_FAT_AGGR G ON  A.EMPLID = G.EMPLID AND ( G.EFFDT = 
        (SELECT MAX(G_ED.EFFDT) FROM PS_NSLDS_FAT_AGGR G_ED 
        WHERE G.EMPLID = G_ED.EMPLID 
          AND G_ED.EFFDT <= SYSDATE) 
    AND G.EFFSEQ = 
        (SELECT MAX(G_ES.EFFSEQ) FROM PS_NSLDS_FAT_AGGR G_ES 
        WHERE G.EMPLID = G_ES.EMPLID 
          AND G.EFFDT = G_ES.EFFDT) OR G.EFFDT IS NULL) ), PS_Y_PELL_ELIG_CHT C, PS_INSTALLATION_FA H, PS_AID_YEAR_CAREER I, PS_FA_DFLT_RUL_SET J 
  WHERE ( A.AID_YEAR = C.AID_YEAR 
     AND A.AID_YEAR = :1 
     AND A.EMPLID = :2 
     AND A.PRIMARY_EFC BETWEEN C.Y_MIN_EFC AND C.Y_MAX_EFC 
     AND A.AID_YEAR = I.AID_YEAR 
     AND J.FA_DFLT_RULE_SET = 'PPY' 
     AND I.ACAD_CAREER = 'UGRD')
