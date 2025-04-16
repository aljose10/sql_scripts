SELECT 
    d.*, 
    a.vytalize_practice_name
FROM 
    main.healthjump.demographics d
JOIN 
    main.emr_stg.dim_patient_stg p 
    ON d.patient_id = p.patient_id  -- or use appropriate join key
JOIN 
    main.core.standard.attribution a 
    ON p.mbi = a.mbi
WHERE 
    d.client_id = 'NOMS01'
    AND p.client_id = 'NOMS01'
