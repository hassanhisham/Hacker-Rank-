-- Contest Leaderboard
-- You did such a great job helping Julia with her last coding contest challenge that she wants you to work on this one, too!
The total score of a hacker is the sum of their maximum scores for all of the challenges. Write a query to print the hacker_id, name, and total score of the hackers ordered by the descending score. If more than one hacker achieved the same total score, then sort the result by ascending hacker_id. Exclude all hackers with a total score of  from your result.
-- https://www.hackerrank.com/challenges/contest-leaderboard/problem
--solved in oracle

with temp as (
select tp.hacker_id,h.name, sum(tp.score) s from (
select hacker_id ,submission_id, challenge_id ,score, rank() over (partition by hacker_id, challenge_id order by score desc,submission_id  )as rank from submissions)tp
join hackers h on h.hacker_id=tp.hacker_id
where tp.rank=1 
group by tp.hacker_id,h.name
order by s desc,tp.hacker_id)
select hacker_id,name,s from temp where s <> 0 order by s desc,hacker_id ;
