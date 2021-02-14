SELECT *
INTO total_votes_over20
FROM vine_table
WHERE total_votes >=20;

SELECT *
INTO helpful_votes_over50
FROM total_votes_over20
WHERE CAST(helpful_votes AS float)/CAST(total_votes AS float) >=0.5;

SELECT * 
INTO paid_reviews
FROM helpful_votes_over50
WHERE vine = 'Y';

SELECT * 
INTO unpaid_reviews
FROM helpful_votes_over50
WHERE vine = 'N';

CREATE TABLE total_paid_reviews (
    total_reviews int);
	
CREATE TABLE fivestar_paid_reviews (
    total_5star_reviews int);

INSERT INTO total_paid_reviews(total_reviews) 
SELECT COUNT(total_votes) 
FROM paid_reviews;

INSERT INTO fivestar_paid_reviews(total_5star_reviews) 
SELECT COUNT(star_rating)
FROM paid_reviews
WHERE star_rating= 5;


SELECT tpr.total_reviews, fspr.total_5star_reviews
INTO paid_review_temp
FROM total_paid_reviews as tpr
INNER JOIN fivestar_paid_reviews as fspr ON 1 = 1;


SELECT total_reviews, total_5star_reviews,
	CAST(total_5star_reviews AS FLOAT)/ CAST(total_reviews AS FLOAT)*100 AS percent_five_star 
INTO paid_review_analysis
FROM paid_review_temp;

SELECT * FROM paid_review_analysis;

CREATE TABLE total_unpaid_reviews (
    total_reviews int);


CREATE TABLE fivestar_unpaid_reviews (
    total_5star_reviews int);

INSERT INTO total_unpaid_reviews(total_reviews) 
SELECT COUNT(total_votes) 
FROM unpaid_reviews;

INSERT INTO fivestar_unpaid_reviews(total_5star_reviews) 
SELECT COUNT(star_rating)
FROM unpaid_reviews
WHERE star_rating= 5;


SELECT tupr.total_reviews, fsupr.total_5star_reviews
INTO unpaid_review_temp
FROM total_unpaid_reviews as tupr
INNER JOIN fivestar_unpaid_reviews as fsupr ON 1 = 1;


SELECT total_reviews, total_5star_reviews,
	CAST(total_5star_reviews AS FLOAT)/ CAST(total_reviews AS FLOAT)*100 AS percent_five_star 
INTO unpaid_review_analysis
FROM unpaid_review_temp;

SELECT * FROM unpaid_review_analysis;