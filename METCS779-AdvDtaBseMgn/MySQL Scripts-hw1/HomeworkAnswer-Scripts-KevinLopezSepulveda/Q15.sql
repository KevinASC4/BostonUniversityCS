SELECT
  sup.name AS supplier_name,
  COUNT(DISTINCT CASE WHEN manu.name = 'Manufacturer A' THEN pr.medicine_id END) AS `Manufacturer A`,
  COUNT(DISTINCT CASE WHEN manu.name = 'Manufacturer B' THEN pr.medicine_id END) AS `Manufacturer B`,
  COUNT(DISTINCT CASE WHEN manu.name = 'Manufacturer C' THEN pr.medicine_id END) AS `Manufacturer C`
FROM prescription pr
JOIN medicine med ON pr.medicine_id = med.medicine_id
JOIN supplier sup ON med.supplier_id = sup.supplier_id
JOIN manufacturer manu ON med.manufacturer_id = manu.manufacturer_id
GROUP BY sup.name
ORDER BY sup.name;
