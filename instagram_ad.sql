/* Instagram ads Performance (Data cleaning exercise) */

-- Previewing dataset
SELECT * FROM instagram_ads;

-- 1. Viewing column data types
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'instagram_ads';

-- 2. View number of rows and columns (shape)
SELECT COUNT(*) AS row_count FROM instagram_ads;

-- Columns count:
SELECT COUNT(*) AS column_count
FROM information_schema.columns
WHERE table_name = 'instagram_ads';

--- 3. View missing values per column
SELECT 
    COUNT(*) - COUNT('instagram_ads.date') AS missing_values_date,
    COUNT(*) - COUNT('instagram_ads.impression') AS missing_values_impression,
    COUNT(*) - COUNT(clicks) AS missing_values_clicks,
	COUNT(*) - COUNT(spend_usd) AS missing_values_spend,
	COUNT(*) - COUNT(campaign_name) AS missing_values_campaign
FROM instagram_ads;

-- Converting to lowercase and remove leading/trailing spaces
UPDATE instagram_ads
SET campaign_name = LOWER(TRIM(campaign_name));

-- Checking the campaign_name column
SELECT campaign_name FROM instagram_ads;


-- Creating a new table
ALTER TABLE instagram_ads
ADD COLUMN spend_usd_filled MONEY;

-- Updating the values with the filled mean values of null values in spend_usd
UPDATE instagram_ads
SET spend_usd_filled = COALESCE(spend_usd, (
    SELECT AVG(spend_usd::numeric)::money
    FROM instagram_ads
    WHERE spend_usd IS NOT NULL
));
-- Final view of the table
select * from instagram_ads

