/*
 * 집합 함수(COUNT,MAX,MIN,SUM,AVG) 
 * 작업 대상 테이블 : EMP, STUDENT, PROFESSOR
 */
SELECT * FROM PROFESSOR

--Q1. PROFESSOR 테이블에서 POSITION의 수 출력하기
SELECT COUNT(DISTINCT POSITION) 직위수
FROM PROFESSOR;


--Q2. EMP 테이블에서 소속 부서별 최대 급여와 최소 급여 구하기
SELECT DEPTNO, MAX(SAL) 최대급여 , MIN(SAL) 최소급여
FROM EMP
GROUP BY DEPTNO;


--Q3. EMP 테이블에서 전체 사원의 급여에 대한 분산과 표준편차 구하기
SELECT VARIANCE(SAL), STDDEV(SAL) FROM EMP;


-- Q4. EMP 테이블에서 각 부서별 사원수와 수당을 받는 사원수를 카운트 하시오.
SELECT DEPTNO, COUNT(*) 전체사원수, COUNT(COMM) 수당사원수
FROM EMP
GROUP BY DEPTNO;

--<출력 결과>
/*
부서번호     전체사원수     수당사원수
30        6        4  
20        5        0
10        3        0 
*/

--Q5. PROFESSOR 테이블에서 학과별 급여(pay) 평균이 400 이상 레코드 출력하기
SELECT  DEPTNO,  AVG(PAY)
FROM PROFESSOR
GROUP BY DEPTNO
HAVING AVG(PAY) >= 400;


--Q6. PROFESSOR 테이블에서 학과별,직위별 급여(pay) 평균 구하기
SELECT  DEPTNO,  POSITION, AVG(NVL(PAY,0))
FROM PROFESSOR
GROUP BY DEPTNO, POSITION
ORDER BY DEPTNO;


--Q7. STUDENT 테이블에서 grade별로 
-- weight, height의 평균값, 최대값, 최소값을 구한 
-- 결과에서 키의 평균이 170 이하인 경우 구하기

SELECT GRADE, AVG(weight),AVG(HEIGHT), MAX(weight), MAX(HEIGHT), MIN(weight), MIN(HEIGHT)
FROM STUDENT
GROUP BY GRADE
HAVING AVG(HEIGHT) <= 170


-- Q8. [서브쿼리]를 이용하여 PROFESSOR 테이블에서 각 학과(deptno)별 최소 급여(pay) 수령자의 교수 정보를 출력하시오.
-- 단 HAVING절을 이용하여 학과번호 201,202,203은 제외
SELECT *
FROM PROFESSOR
WHERE PAY IN (SELECT MIN(PAY) FROM PROFESSOR GROUP BY DEPTNO HAVING DEPTNO NOT IN (201, 202, 203);

 -- 310 학과 허은(4007) 교수 제외
 SELECT * FROM PROFESSOR
 WHERE PAY IN (SELECT MIN(PAY) FROM PROFESSOR GROUP BY DEPTNO HAVING NOT IN (201,202,203) AND profno != 4007);





