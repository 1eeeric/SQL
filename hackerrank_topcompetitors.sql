/*This is the MS-SQL script for solving HackerRank SQL problem: Top Competitors
https://www.hackerrank.com/challenges/full-score/problem
*/

WITH myCTE1 AS
(
SELECT submissions.hacker_id, hackers.name, submissions.challenge_id, challenges.difficulty_level, difficulty.score AS difficulty_score, submissions.score AS submission_score
FROM submissions
INNER JOIN hackers
    ON submissions.hacker_id = hackers.hacker_id
INNER JOIN challenges
    ON submissions.challenge_id = challenges.challenge_id
INNER JOIN difficulty
    ON challenges.difficulty_level = difficulty.difficulty_level
),
myCTE2 AS 
(
SELECT hacker_id, name, difficulty_score, submission_score FROM myCTE1
WHERE difficulty_score = submission_score
)

SELECT hacker_id, name
FROM
(SELECT hacker_id, name, COUNT(hacker_id) AS counter FROM myCTE2
GROUP BY hacker_id, name
HAVING COUNT(hacker_id) > 1) AS mytbl1
ORDER BY mytbl1.counter DESC, hacker_id;