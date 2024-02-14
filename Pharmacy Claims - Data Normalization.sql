-- Create Tables -- 
CREATE TABLE `dim_drug_info` (
  `drug_ndc` int NOT NULL,
  `drug_name` text,
  `drug_form_code` text,
  `drug_form_desc` text,
  `drug_brand_generic_code` int DEFAULT NULL,
  `drug_brand_generic_desc` text,
  PRIMARY KEY (`drug_ndc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `dim_member_info` (
  `member_id` int NOT NULL,
  `member_first_name` text,
  `member_last_name` text,
  `member_birth_date` text,
  `member_age` int DEFAULT NULL,
  `member_gender` text,
  PRIMARY KEY (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `fact_drug_payment_info` (
  `payment_id` int NOT NULL,
  `member_id` int DEFAULT NULL,
  `drug_ndc` int DEFAULT NULL,
  `drug_fill_date` text,
  `copay` int DEFAULT NULL,
  `insurancepaid` int DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `member_id_idx` (`member_id`),
  KEY `drug_ndc_idx` (`drug_ndc`),
  CONSTRAINT `drug_ndc` FOREIGN KEY (`drug_ndc`) REFERENCES `dim_drug_info` (`drug_ndc`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `member_id` FOREIGN KEY (`member_id`) REFERENCES `dim_member_info` (`member_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Updating the columns --
UPDATE pharmacy_claims.fact_drug_payment_info
SET drug_fill_date = DATE(STR_TO_DATE(drug_fill_date, '%d-%m-%Y'));
ALTER TABLE pharmacy_claims.fact_drug_payment_info Modify column drug_fill_date date;

UPDATE pharmacy_claims.dim_member_info
SET member_birth_date = DATE(STR_TO_DATE(member_birth_date, '%d-%m-%Y'));

ALTER TABLE pharmacy_claims.dim_member_info
Modify column member_first_name varchar(100),
Modify column member_last_name varchar(100),
Modify column member_birth_date date,
Modify column member_gender char(1);

ALTER TABLE pharmacy_claims.dim_drug_info
Modify column drug_name varchar(100),
Modify column drug_form_code char(2),
Modify column drug_form_desc varchar(100),
Modify column drug_brand_generic_desc varchar(10);

-- Task 3 --

-- Write a SQL query that identifies the number of prescriptions grouped by drug name.
SELECT 
    d.drug_name, COUNT(f.payment_id) AS `Number of Prescriptions`
FROM
    pharmacy_claims.fact_drug_payment_info AS f
        INNER JOIN
    pharmacy_claims.dim_drug_info AS d ON f.drug_ndc = d.drug_ndc
GROUP BY d.drug_name
ORDER BY d.drug_name;

-- Write a SQL query that counts total prescriptions, counts unique (i.e. distinct) members, sums copay

SELECT 
    CASE
        WHEN d2.member_age >= 65 THEN '> 65'
        ELSE '< 65'
    END AS `Age Group`,
    COUNT(f.payment_id) AS `Total Prescriptions per drug name`,
    COUNT(DISTINCT d2.member_id) AS `No of Members prescribing`,
    SUM(f.copay) AS `Sum of Copays`,
    SUM(f.insurancepaid) AS `Sum of Insurance paid`
FROM
    pharmacy_claims.fact_drug_payment_info AS f
        INNER JOIN
    pharmacy_claims.dim_drug_info AS d1 ON f.drug_ndc = d1.drug_ndc
        INNER JOIN
    pharmacy_claims.dim_member_info AS d2 ON f.member_id = d2.member_id
GROUP BY `Age Group`;

SELECT member_id,member_first_name,member_last_name,drug_name,drug_fill_date,insurancepaid
FROM(
	SELECT d2.member_id,d2.member_first_name,d2.member_last_name,d1.drug_name,f.drug_fill_date,f.insurancepaid,ROW_NUMBER() OVER (PARTITION BY d2.member_id ORDER BY f.drug_fill_date DESC) AS rw_n FROM 
    pharmacy_claims.fact_drug_payment_info AS f
        INNER JOIN
    pharmacy_claims.dim_drug_info AS d1 ON f.drug_ndc = d1.drug_ndc
        INNER JOIN
    pharmacy_claims.dim_member_info AS d2 ON f.member_id = d2.member_id
) AS sub_query
    WHERE rw_n = 1;
