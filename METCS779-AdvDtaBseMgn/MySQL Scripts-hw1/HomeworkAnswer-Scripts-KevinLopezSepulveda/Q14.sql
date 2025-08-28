WITH RankedDrugs AS (
  SELECT
    sup.name AS supplier_name,
    med.medicine_id,
    med.name AS drug_name,
    manu.name AS manufacturer_name,
    med.price,
    ROW_NUMBER() OVER (PARTITION BY sup.supplier_id ORDER BY med.price DESC) AS price_rank
  FROM medicine med
  JOIN supplier sup ON med.supplier_id = sup.supplier_id
  JOIN manufacturer manu ON med.manufacturer_id = manu.manufacturer_id
),
LatestPrescriptions AS (
  SELECT
    p.medicine_id,
    MAX(p.prescribed_at) AS last_prescribed_at,
    ap.appointment_id,
    p.prescription_id
  FROM prescription p
  JOIN appointment_prescription ap ON p.prescription_id = ap.prescription_id
  GROUP BY p.medicine_id, ap.appointment_id, p.prescription_id
),
LatestPerMedicine AS (
  -- Get only the latest prescription per medicine
  SELECT
    lp1.medicine_id,
    lp1.last_prescribed_at,
    lp1.appointment_id,
    lp1.prescription_id
  FROM LatestPrescriptions lp1
  JOIN (
    SELECT medicine_id, MAX(last_prescribed_at) AS max_date
    FROM LatestPrescriptions
    GROUP BY medicine_id
  ) lp2 ON lp1.medicine_id = lp2.medicine_id AND lp1.last_prescribed_at = lp2.max_date
)
SELECT
  rd.supplier_name,
  rd.drug_name,
  rd.manufacturer_name,
  rd.price,
  lpm.last_prescribed_at,
  d.diagnosis AS diagnosis_name
FROM RankedDrugs rd
LEFT JOIN LatestPerMedicine lpm ON rd.medicine_id = lpm.medicine_id
LEFT JOIN appointment_diagnosis ad ON lpm.appointment_id = ad.appointment_id
LEFT JOIN diagnosis d ON ad.diagnosis_code = d.diagnosis_code
WHERE rd.price_rank <= 2
ORDER BY rd.supplier_name, rd.price_rank;
