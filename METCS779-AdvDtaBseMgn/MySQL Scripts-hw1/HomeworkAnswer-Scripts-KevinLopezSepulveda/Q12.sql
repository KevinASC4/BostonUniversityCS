WITH HospitalAvgCharges AS (
  SELECT
    h.hospital_id,
    h.name AS hospital_name,
    st.state_name,
    AVG(b.operation_charge) AS avg_operation_charge,
    COUNT(b.bill_no) AS total_operations
  FROM bill b
  JOIN appointment a ON b.appointment_id = a.appointment_id
  JOIN hospital h ON a.hospital_id = h.hospital_id
  JOIN address addr ON h.address_id = addr.address_id
  JOIN state st ON addr.state_id = st.state_id
  GROUP BY h.hospital_id, h.name, st.state_name
  HAVING COUNT(b.bill_no) > 0
)
SELECT
  hospital_name,
  state_name,
  avg_operation_charge
FROM HospitalAvgCharges
ORDER BY avg_operation_charge DESC
LIMIT 3;
