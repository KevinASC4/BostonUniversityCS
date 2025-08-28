WITH RankedDrugs AS (
  SELECT
    sup.name AS supplier_name,
    med.name AS drug_name,
    manu.name AS manufacturer_name,
    med.price,
    ROW_NUMBER() OVER (PARTITION BY sup.supplier_id ORDER BY med.price DESC) AS price_rank
  FROM medicine med
  JOIN supplier sup ON med.supplier_id = sup.supplier_id
  JOIN manufacturer manu ON med.manufacturer_id = manu.manufacturer_id
)
SELECT
  supplier_name,
  drug_name,
  manufacturer_name,
  price
FROM RankedDrugs
WHERE price_rank <= 2
ORDER BY supplier_name, price_rank;
