CREATE TABLE IF NOT EXISTS public."GlobalHealth"
(
    country character varying(100) COLLATE pg_catalog."default",
    year_name integer,
    disease_name character varying(100) COLLATE pg_catalog."default",
    disease_category character varying(100) COLLATE pg_catalog."default",
    prevalence_rate_percentage double precision,
    incidence_rate_percentage double precision,
    mortality_rate_percentage double precision,
    age_group character varying(20) COLLATE pg_catalog."default",
    gender character varying(100) COLLATE pg_catalog."default",
    population_affected integer,
    healthcare_access_percentage double precision,
    doctors_per_1000 double precision,
    hospital_beds_per_1000 double precision,
    treatment_type character varying(100) COLLATE pg_catalog."default",
    average_treatment_cost_usd integer,
    availability_of_vaccines character varying(100) COLLATE pg_catalog."default",
    recovery_rate_percentage double precision,
    dalys integer,
    improvement_in_5_years double precision,
    per_capita_income_usd integer,
    education_index double precision,
    urbanisation_rate_percentage double precision
)
#Verify the data in table

SELECT * from public."GlobalHealth"
SELECT COUNT(*) AS total_records FROM public."GlobalHealth";

SELECT average_treatment_cost_usd, COUNT(*) AS treatment_count
FROM public."GlobalHealth"
GROUP BY average_treatment_cost_usd;

#Calculate Summary Statistics: For numerical columns:

SELECT 
    AVG(Prevalence_Rate_Percentage) AS avg_prevalence_rate,
    MIN(Prevalence_Rate_Percentage) AS min_prevalence_rate,
    MAX(Prevalence_Rate_Percentage) AS max_prevalence_rate,
    SUM(Population_Affected) AS total_population_affected
FROM public."GlobalHealth";

Gender-Based Analysis:

SELECT Gender, max(Mortality_Rate_Percentage) AS max_mortality_rate
FROM public."GlobalHealth"
GROUP BY Gender;

#Yearly Trends: Calculate yearly trends for prevalence rates

SELECT year_name,avg(prevalence_rate_Percentage) as avg_prevalence_rate
from public."GlobalHealth"
group by year_name
Order by year_name

#Disease-Specific Insights: Identify the most prevalent diseases:

select disease_name,sum(population_affected) as total_affected
from public."GlobalHealth"
Group by disease_name
order by total_affected desc
Limit 10;

#Recovery-Rate Analysis:

Select country,avg(recovery_rate_percentage) as avg_recovery_rate
from public."GlobalHealth"
Group by country
order by avg_recovery_rate desc

Select disease_name,avg(recovery_rate_percentage) as avg_recovery_rate
from public."GlobalHealth"
Group by disease_name
order by avg_recovery_rate desc

#Healthcare Access Analysis

select country,sum(healthcare_access_percentage) as total_healthcare_access
from public."GlobalHealth"
Group by country
order by total_healthcare_acces

#Urbanisation And Disease Impact

select 
disease_category,
AVG(urbanisation_rate_percentage) as avg_urbanisation,
SUM(population_affected) as total_affected
from public."GlobalHealth"
Group by disease_category
order by total_affected desc;

#Correlation Analysis: Determine relationships between columns:

SELECT 
    CORR(Healthcare_Access_Percentage, Mortality_Rate_Percentage) AS correlation_healthcare_mortality
FROM public."GlobalHealth";

#Top Recovery Countries for a Disease:

SELECT Country, AVG(Recovery_Rate_Percentage) AS avg_recovery_rate
FROM public."GlobalHealth"
WHERE Disease_Name = 'Tuberculosis'
GROUP BY Country
ORDER BY avg_recovery_rate DESC;









