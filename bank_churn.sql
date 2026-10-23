create database bank_churn;

SELECT * FROM bank_churn;

SELECT COUNT(DISTINCT CustomerId) FROM bank_churn; -- 10000 unique cutsomers

ALTER TABLE bank_churn
MODIFY IsActiveMember VARCHAR(10),
MODIFY HasCrCard VARCHAR(10);

UPDATE bank_churn
SET IsActiveMember = 'Yes'
WHERE IsActiveMember = '1';

UPDATE bank_churn
SET IsActiveMember = 'No'
WHERE IsActiveMember = '0';

UPDATE bank_churn
SET HasCrCard = 'Yes'
WHERE HasCrCard = '1';

UPDATE bank_churn
SET HasCrCard = 'No'
WHERE HasCrCard = '0';

-- =========================================================================
-- BANK CUSTOMER CHURN ANALYSIS - SQL QUERIES
-- =========================================================================

-- 1. Overall Customer Churn Rate
-- What is our overall customer churn rate and total customer breakdown?
SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Exited = 0 THEN 1 ELSE 0 END) AS retained_customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND((SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2) AS churn_rate_pct
FROM bank_churn;


-- 2. Total Balance & Salary by Churn Status
-- How do financial totals (balances and salaries) compare between retained and churned customers?
SELECT 
    CASE 
        WHEN Exited = 1 THEN 'Churned Customers'
        ELSE 'Retained Customers'
    END AS customer_bracket,
    COUNT(*) AS total_customers,
    ROUND(SUM(Balance), 2) AS total_balance,
    ROUND(SUM(EstimatedSalary), 2) AS total_estimated_salary
FROM bank_churn
GROUP BY customer_bracket;


-- 3. Regional Churn Volumes & Rates
-- How do churn volumes and rates differ across our primary geographic regions?
SELECT
    Geography,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Exited = 0 THEN 1 ELSE 0 END) AS retained_customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(AVG(Exited) * 100, 2) AS churn_rate_pct
FROM bank_churn
GROUP BY Geography
ORDER BY churn_rate_pct DESC;


-- 4. Financial Impact: Averages & Balance Brackets
-- Part A: How do average account balances and estimated salaries correlate with churn?
SELECT 
    Exited,
    COUNT(*) AS total_customers,
    ROUND(AVG(Balance), 2) AS avg_balance,
    ROUND(AVG(EstimatedSalary), 2) AS avg_salary
FROM bank_churn
GROUP BY Exited;

-- Part B: Are we losing high-value accounts across specific balance brackets?
SELECT 
    CASE 
        WHEN Balance = 0 THEN '01. Zero Balance'
        WHEN Balance < 50000 THEN '02. Low Balance (<50k)'
        WHEN Balance < 100000 THEN '03. Mid Balance (50k-100k)'
        WHEN Balance < 150000 THEN '04. High Balance (100k-150k)'
        ELSE '05. Very High Balance (150k+)'
    END AS balance_bracket,
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned_customers,
    ROUND(AVG(Exited) * 100, 2) AS churn_rate_pct
FROM bank_churn
GROUP BY balance_bracket
ORDER BY balance_bracket;


-- 5. Product Adoption & Thresholds
-- How does the number of bank products utilized affect customer likelihood of churning?
SELECT 
    NumOfProducts,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Exited = 0 THEN 1 ELSE 0 END) AS retained_customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(AVG(Exited) * 100, 2) AS churn_rate_pct
FROM bank_churn
GROUP BY NumOfProducts
ORDER BY NumOfProducts;


-- 6. Engagement & Activity Impact
-- To what extent do active membership status and credit card ownership impact customer retention?
SELECT
    IsActiveMember,
    HasCrCard,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Exited = 0 THEN 1 ELSE 0 END) AS retained_customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(AVG(Exited) * 100, 2) AS churn_rate_pct
FROM bank_churn
GROUP BY IsActiveMember, HasCrCard
ORDER BY IsActiveMember DESC, HasCrCard DESC;


-- 7. Demographic Risk Factors (Age Group & Gender)
-- How do age groups and gender distributions influence churn behavior and risk?
SELECT 
    CASE 
        WHEN Age BETWEEN 18 AND 29 THEN '18-29'
        WHEN Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49'
        WHEN Age BETWEEN 50 AND 59 THEN '50-59'
        ELSE '60+'
    END AS age_group,
    Gender,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Exited = 0 THEN 1 ELSE 0 END) AS retained_customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(AVG(Exited) * 100, 2) AS churn_rate_pct
FROM bank_churn
GROUP BY age_group, Gender
ORDER BY churn_rate_pct DESC;


-- 8. Tenure & Loyalty Milestones
-- What is the relationship between customer tenure and churn rate, and at which milestones are customers most vulnerable?
SELECT
    Tenure,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Exited = 0 THEN 1 ELSE 0 END) AS retained_customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(AVG(Exited) * 100, 2) AS churn_rate_pct
FROM bank_churn
GROUP BY Tenure
ORDER BY Tenure;


-- 9. Credit Risk Profile
-- Part A: How do the average credit scores of churned customers compare to retained customers?
SELECT 
    Exited,
    COUNT(*) AS total_customers,
    ROUND(AVG(CreditScore), 2) AS avg_credit_score,
    MIN(CreditScore) AS min_credit_score,
    MAX(CreditScore) AS max_credit_score
FROM bank_churn
GROUP BY Exited;

-- Part B: Are customers with lower credit scores driving our attrition across credit tiers?
SELECT 
    CASE 
        WHEN CreditScore < 500 THEN '1. Poor (<500)'
        WHEN CreditScore BETWEEN 500 AND 650 THEN '2. Fair (500-650)'
        WHEN CreditScore BETWEEN 651 AND 750 THEN '3. Good (651-750)'
        ELSE '4. Excellent (751+)'
    END AS credit_score_tier,
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned_customers,
    ROUND(AVG(Exited) * 100, 2) AS churn_rate_pct
FROM bank_churn
GROUP BY credit_score_tier
ORDER BY credit_score_tier;