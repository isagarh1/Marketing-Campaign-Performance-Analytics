SELECT * FROM ppc_campaign;


--# Campaign Performance Summary:
--Q.Which campaigns perform best overall?
------------------------------------------
SELECT 
	campaign_id,
	SUM(revenue) AS total_revenue,
	SUM(spend) AS total_Spend,
	SUM(conversions) AS total_conversions,
	ROUND(SUM(revenue)/SUM(spend),2) AS avg_roas,
	ROUND(SUM(spend)/SUM(conversions),2) AS avg_cpa
FROM ppc_campaign
GROUP BY campaign_id
ORDER BY total_revenue DESC;
-- Campaign_id C1002 is the best campaign overall

--Q.Top Revenue Campaigns?
--Which campaigns generate the highest revenue?
------------------------------------------------
SELECT 
	campaign_id,
	SUM(revenue) AS total_revenue
FROM ppc_campaign
GROUP BY campaign_id
ORDER BY total_revenue DESC
LIMIT 10;
-- C1002 generates high revenue

-- Q.Budget Efficiency?
--Are high-spend campaigns generating high revenue?
----------------------------------------------------
SELECT 
	campaign_id,
	SUM(revenue) AS total_revenue,
	SUM(spend) AS total_spend,
	SUM(revenue)/SUM(spend) AS calculated_roas
FROM ppc_campaign
GROUP BY campaign_id
ORDER BY calculated_roas DESC;
-- Campaign C1783 generated approximately ₹88 in revenue for every ₹1 spent


--Best & Worst Campaigns?
--Which campaigns are most and least efficient?
--------------------------------------------------
SELECT 
	campaign_id,
	ROUND(SUM(revenue)/SUM(spend),2) AS avg_roas,
	ROUND(SUM(spend)/SUM(conversions),2) AS avg_cpa
FROM ppc_campaign
GROUP BY campaign_id
ORDER BY avg_roas DESC, avg_cpa ASC;



--# Platform Performance Summary:
--Q.Which platform performs best overall?
------------------------------------------
SELECT 
	platform,
	SUM(revenue) AS total_revenue,
	SUM(spend) AS total_Spend,
	SUM(conversions) AS total_conversions,
	ROUND(SUM(revenue)/SUM(spend),2) AS avg_roas,
	ROUND(SUM(spend)/SUM(conversions),2) AS avg_cpa,
	ROUND(SUM(conversions)/SUM(clicks)*100,1) AS conversion_rate
FROM ppc_campaign
GROUP BY platform
ORDER BY total_revenue DESC; 

-- Budget Efficiency by Platform:
--Q.Which platform generates the highest return on ad spend?
-------------------------------------------------------------
SELECT 
	platform,
	SUM(revenue) AS total_revenue,
	SUM(spend) AS total_Spend,
	ROUND(SUM(revenue)/SUM(spend),2) AS calculated_roas
FROM ppc_campaign
GROUP BY platform
ORDER BY calculated_roas DESC;

-- Engagement Performance:
-- Which platform attracts the most user engagement?
-----------------------------------------------------
SELECT
    platform,
    SUM(impressions) AS total_impressions,
    SUM(clicks) AS total_clicks,
    ROUND(SUM(clicks)* 100.0/SUM(impressions),1)  AS avg_ctr
FROM ppc_campaign
GROUP BY platform
ORDER BY avg_ctr DESC;

-- Conversion Performance:
--Which platform converts users most efficiently?
---------------------------------------------------
SELECT
    platform,
    SUM(conversions) AS total_conversions,
    ROUND(SUM(conversions)/SUM(clicks)* 100,1) AS avg_conversion_rate,
    ROUND(SUM(spend)/SUM(conversions),1) AS avg_cpa
FROM ppc_campaign
GROUP BY platform
ORDER BY avg_conversion_rate DESC;



-- Content Performance Summary:
-- Evaluate which ad content types (Video, Image, Carousel, etc.) perform best.
SELECT 
	content_type,
	SUM(revenue) AS total_revenue,
	SUM(spend) AS total_Spend,
	SUM(conversions) AS total_conversions,
	ROUND(SUM(revenue)/SUM(spend),2) AS avg_roas,
	ROUND(SUM(spend)/SUM(conversions),2) AS avg_cpa,
	ROUND(SUM(conversions)/SUM(clicks)*100,1) AS conversion_rate
FROM ppc_campaign
GROUP BY content_type
ORDER BY total_revenue DESC; 

--Budget Efficiency by Content Type:
--Which content type delivers the highest ROAS?
---------------------------------------------------
SELECT 
	content_type,
	SUM(revenue) AS total_revenue,
	SUM(spend) AS total_Spend,
	ROUND(SUM(revenue)/SUM(spend),2) AS calculated_roas
FROM ppc_campaign
GROUP BY content_type
ORDER BY calculated_roas DESC;

--Engagement Performance:
--Which content type attracts the highest user engagement?
----------------------------------------------------------
SELECT
    content_type,
    SUM(impressions) AS total_impressions,
    SUM(clicks) AS total_clicks,
    ROUND(SUM(clicks)* 100.0/SUM(impressions),1) AS avg_ctr
FROM ppc_campaign
GROUP BY content_type
ORDER BY avg_ctr DESC;

--Conversion Performance:
--Which content type converts users most effectively?
------------------------------------------------------
SELECT
    content_type,
    SUM(conversions) AS total_conversions,
    ROUND(SUM(conversions)/SUM(clicks)* 100,2) AS avg_conversion_rate,
    ROUND(SUM(spend)/SUM(conversions),1) AS avg_cpa
FROM ppc_campaign
GROUP BY content_type
ORDER BY avg_conversion_rate DESC, avg_cpa ASC;



--Audience Performance Summary:
--Which audience segments perform best overall?
-----------------------------------------------
SELECT
    target_age,
    target_gender,
    SUM(revenue) AS total_revenue,
    SUM(spend) AS total_spend,
    SUM(conversions) AS total_conversions,
	ROUND(SUM(revenue)/NULLIF(SUM(spend),0),2) AS calculated_roas,
    ROUND(AVG(cpa),2) AS avg_cpa
FROM ppc_campaign
GROUP BY target_age, target_gender
ORDER BY total_revenue DESC;

--Budget Efficiency:
--Which audience segment provides the highest return?
-----------------------------------------------------
SELECT
    target_age,
    target_gender,
    SUM(revenue) AS total_revenue,
    SUM(spend) AS total_spend,
    ROUND(SUM(revenue)/NULLIF(SUM(spend),0),2) AS calculated_roas,
	ROUND(SUM(spend)/SUM(conversions),1) AS avg_cpa
FROM ppc_campaign
GROUP BY target_age, target_gender
ORDER BY calculated_roas DESC;

--Engagement Performance
--Which audience engages the most?
SELECT
    target_age,
    target_gender,
    SUM(impressions) AS total_impressions,
    SUM(clicks) AS total_clicks,
	ROUND(SUM(clicks)* 100.0/SUM(impressions),1) AS avg_ctr
FROM ppc_campaign
GROUP BY target_age, target_gender
ORDER BY avg_ctr DESC;

--Conversion Performance:
--Which audience converts most efficiently?
SELECT
    target_age,
    target_gender,
    SUM(conversions) AS total_conversions,
    SUM(conversions)/SUM(clicks)*100 AS avg_conversion_rate,
    SUM(spend)/SUM(conversions) AS avg_cpa
FROM ppc_campaign
GROUP BY target_age, target_gender
ORDER BY avg_conversion_rate DESC, avg_cpa ASC;



-- Regional Performance Analysis:
--Which regions perform best overall?
SELECT
    region,
    SUM(revenue) AS total_revenue,
    SUM(spend) AS total_spend,
    SUM(conversions) AS total_conversions,
	ROUND(SUM(revenue)/SUM(spend),1) AS roas,
    ROUND(SUM(spend)/SUM(conversions),2) AS cpa
FROM ppc_campaign
GROUP BY region
ORDER BY roas DESC;

--Budget Efficiency:
--Which region delivers the highest ROAS?
SELECT
    region,
    SUM(revenue) AS total_revenue,
    SUM(spend) AS total_spend,
    ROUND(SUM(revenue)/NULLIF(SUM(spend),0),2) AS roas
FROM ppc_campaign
GROUP BY region
ORDER BY roas DESC;

-- Engagement Performance
--Which region has the highest audience engagement?
SELECT
    region,
    SUM(impressions) AS total_impressions,
    SUM(clicks) AS total_clicks,
    ROUND((SUM(clicks)*100.0)/NULLIF(SUM(impressions),0),2) AS ctr
FROM ppc_campaign
GROUP BY region
ORDER BY ctr DESC;

--Conversion Performance:
--Which region converts customers most efficiently?
SELECT
    region,
    SUM(conversions) AS total_conversions,
    ROUND((SUM(conversions)*100.0)/NULLIF(SUM(clicks),0),2) AS conversion_rate,
    ROUND(SUM(spend)/NULLIF(SUM(conversions),0),2) AS cpa
FROM ppc_campaign
GROUP BY region
ORDER BY conversion_rate DESC, cpa ASC;


--Marketing Funnel Analysis 
--How effectively does the marketing funnel convert users?
--Provides an overall view of the marketing funnel.
SELECT
    SUM(impressions) AS total_impressions,
    SUM(clicks) AS total_clicks,
    SUM(conversions) AS total_conversions,
    ROUND((SUM(clicks) * 100.0) / NULLIF(SUM(impressions), 0), 2) AS ctr,
    ROUND((SUM(conversions) * 100.0) / NULLIF(SUM(clicks), 0), 2) AS conversion_rate
FROM ppc_campaign;


--Funnel Performance by Platform
--Which platform has the most efficient funnel?
SELECT
    platform,
    SUM(impressions) AS total_impressions,
    SUM(clicks) AS total_clicks,
    SUM(conversions) AS total_conversions,
    ROUND((SUM(clicks) * 100.0) / NULLIF(SUM(impressions), 0), 2) AS ctr,
    ROUND((SUM(conversions) * 100.0) / NULLIF(SUM(clicks), 0), 2) AS conversion_rate
FROM ppc_campaign
GROUP BY platform
ORDER BY conversion_rate DESC;

--Funnel Performance by Content Type
--Which content type moves users through the funnel most effectively?
SELECT
    content_type,
    SUM(impressions) AS total_impressions,
    SUM(clicks) AS total_clicks,
    SUM(conversions) AS total_conversions,
    ROUND((SUM(clicks) * 100.0) / NULLIF(SUM(impressions), 0), 2) AS ctr,
    ROUND((SUM(conversions) * 100.0) / NULLIF(SUM(clicks), 0), 2) AS conversion_rate
FROM ppc_campaign
GROUP BY content_type
ORDER BY conversion_rate DESC;

--Funnel Performance by Region
--Which region has the strongest conversion funnel?
SELECT
    region,
    SUM(impressions) AS total_impressions,
    SUM(clicks) AS total_clicks,
    SUM(conversions) AS total_conversions,
    ROUND((SUM(clicks) * 100.0) / NULLIF(SUM(impressions), 0), 2) AS ctr,
    ROUND((SUM(conversions) * 100.0) / NULLIF(SUM(clicks), 0), 2) AS conversion_rate
FROM ppc_campaign
GROUP BY region
ORDER BY conversion_rate DESC;




