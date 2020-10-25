# 고양이와 개는 몇 마리 있을까
SELECT ANIMAL_TYPE, COUNT(ANIMAL_TYPE) AS 'count'
FROM ANIMAL_INS
GROUP BY ANIMAL_TYPE
ORDER BY ANIMAL_TYPE

# 동명 동물 수 찾기
SELECT NAME, COUNT(NAME) AS 'COUNT'
FROM ANIMAL_INS
GROUP BY NAME
HAVING COUNT(NAME) > 1
ORDER BY NAME

# 입양 시각 구하기(1)
SELECT EXTRACT(HOUR FROM DATETIME) AS HOUR,
COUNT(EXTRACT(HOUR FROM DATETIME)) AS COUNT
FROM ANIMAL_OUTS
GROUP BY HOUR
HAVING HOUR >= 9 AND HOUR <20
ORDER BY HOUR ASC

# 입양 시각 구하기(2)
# 방법1
SELECT T1.hour, ifnull(T2.count, 0)
from (
    select 0 as hour
    union select 1 union select 2 union select 3 union select 4 union select 5 
    union select 6 union select 7 union select 8 union select 9 union select 10
    union select 11 union select 12 union select 13 union select 14 union select 15
    union select 15 union select 16 union select 17 union select 18 union select 19
    union select 20 union select 21 union select 22 union select 23) T1
left join (
    select extract(hour from datetime) as hour, count(*) as count
    from animal_outs
    group by hour) T2
    on T2.hour = T1.hour
    
# 방법2
SET @hour := -1;
SELECT (@hour := @hour + 1) as HOUR,
(SELECT COUNT(*) FROM ANIMAL_OUTS WHERE HOUR(DATETIME) = @hour) as COUNT
FROM ANIMAL_OUTS
WHERE @hour < 23;