-- # 4a. Analysis for Leadership -- 
-- #1# License beds: List of Top 10 Hospitals ordered descending by the total ICU or SICU license beds.
SELECT 
    d1.business_name AS `Hospital Name`,
    SUM(f.license_beds) AS `Total ICU & SICU License beds`
FROM
    acme_systems.bed_fact AS f
        INNER JOIN
    acme_systems.business AS d1 ON f.ims_org_id = d1.ims_org_id
WHERE
    f.bed_id IN (4 , 15)
GROUP BY d1.business_name
ORDER BY `Total ICU & SICU License beds` DESC
LIMIT 10;

-- #2# Census beds: List of Top 10 Hospitals ordered by total icu or sicu census beds. 
SELECT 
    d1.business_name AS `Hospital Name`,
    SUM(f.census_beds) AS `Total ICU & SICU Census beds`
FROM
    acme_systems.bed_fact AS f
        INNER JOIN
    acme_systems.business AS d1 ON f.ims_org_id = d1.ims_org_id
WHERE
    f.bed_id IN (4 , 15)
GROUP BY d1.business_name
ORDER BY `Total ICU & SICU Census beds` DESC
LIMIT 10;

-- #3# Staffed beds: List of Top 10 Hospitals ordered by the total icu or sicu staffed beds.
SELECT 
    d1.business_name AS `Hospital Name`,
    SUM(f.staffed_beds) AS `Total ICU & SICU Staffed beds`
FROM
    acme_systems.bed_fact AS f
        INNER JOIN
    acme_systems.business AS d1 ON f.ims_org_id = d1.ims_org_id
WHERE
    f.bed_id IN (4 , 15)
GROUP BY d1.business_name
ORDER BY `Total ICU & SICU Staffed beds` DESC
LIMIT 10;

-- # 5a. Drill down investigation  
-- #1# License beds: List of Top 10 Hospitals with atleast 1 ICU and 1 SICU.
SELECT 
    d1.business_name AS `Hospital Name`,
    SUM(f.license_beds) AS `Total ICU & SICU License Beds`
FROM
    acme_systems.bed_fact AS f
        INNER JOIN
    acme_systems.business AS d1 ON f.ims_org_id = d1.ims_org_id
WHERE
    f.bed_id IN (4 , 15)
GROUP BY d1.business_name
HAVING COUNT(DISTINCT CASE WHEN f.bed_id = 4 THEN 1 END) >= 1
AND COUNT(DISTINCT CASE WHEN f.bed_id = 15 THEN 1 END) >= 1
ORDER BY `Total ICU & SICU License Beds` DESC
LIMIT 10;

-- #2# Census beds:  List of Top 10 Hospitals with atleast 1 ICU and 1 SICU.
SELECT 
    d1.business_name AS `Hospital Name`,
    SUM(f.census_beds) AS `Total ICU & SICU Census Beds`
FROM
    acme_systems.bed_fact AS f
        INNER JOIN
    acme_systems.business AS d1 ON f.ims_org_id = d1.ims_org_id
WHERE
    f.bed_id IN (4 , 15)
GROUP BY d1.business_name
HAVING COUNT(DISTINCT CASE WHEN f.bed_id = 4 THEN 1 END) >= 1
AND COUNT(DISTINCT CASE WHEN f.bed_id = 15 THEN 1 END) >= 1
ORDER BY `Total ICU & SICU Census Beds` DESC
LIMIT 10;
-- #3# Staffed beds: List of Top 10 Hospitals with atleast 1 ICU and 1 SICU.
SELECT 
    d1.business_name AS `Hospital Name`,
    SUM(f.staffed_beds) AS `Total ICU & SICU Staffed Beds`
FROM
    acme_systems.bed_fact AS f
        INNER JOIN
    acme_systems.business AS d1 ON f.ims_org_id = d1.ims_org_id
WHERE
    f.bed_id IN (4 , 15)
GROUP BY d1.business_name
HAVING COUNT(DISTINCT CASE WHEN f.bed_id = 4 THEN 1 END) >= 1
AND COUNT(DISTINCT CASE WHEN f.bed_id = 15 THEN 1 END) >= 1
ORDER BY `Total ICU & SICU Staffed Beds` DESC
LIMIT 10;
-- # 5b. Final recommendation 
