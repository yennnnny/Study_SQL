-- <연습문제3>
--1. EMP 테이블에서 hiredate가 1981년 2월 20과 1981년 5월 1일 사이에 입사한 사원의 
-- ename, job, hiredate을 출력하는 SELECT 문장을 작성(단 hiredate 순으로 정렬) 
SELECT ename, job, hiredate
FROM emp
WHERE hiredate BETWEEN '1981-02-20' AND '1981-05-01' 
ORDER BY hiredate

-- 2. EMP 테이블에서 deptno가 10,20인 사원의 모든 정보를 출력하는 SELECT 문장을작성
-- (단 ename순으로 정렬)
SELECT * FROM emp WHERE deptno IN (10, 20) ORDER BY ename