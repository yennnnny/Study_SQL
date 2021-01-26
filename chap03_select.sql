-- select _work.sql

-- 1. 전체 검색(특정 컬럼 탐색)

-- 전체 컬럼 조회
SELECT * FROM emp;

-- 특정 컬럼 조회
SELECT empno, ename, sal, job FROM emp;
SELECT ename, sal, sal+300 FROM emp;     -- 산술표현
SELECT ename, sal, sal*1.1 as 급여인상 FROM emp;  -- rmqdu 10% 인상

-- NULL 처리
SELECT empno, ename, sal, comm, sal+comm/100 FROM emp; -- 처리 전
SELECT ename,sal,comm,sal*12+NVL(comm,0) as 연봉 FROM emp;       --  처리

-- 별칭
SELECT ename AS 이름, sal 급여, hiredate "입사 년도" FROM emp;

-- 연결연산자(||)
SELECT ename || ' ' || job FROM emp;
 SELECT ename || ' --> ' || job AS "employees" FROM emp;
 
 -- DISTINCT : 범주형(category) 칼럼(성별)
SELECT job FROM emp;
SELECT DISTINCT job FROM emp; 

-- 1차 : 부서번호 --> 2차 : 직책
SELECT DISTINCT deptno, job FROM emp;


--- 2. 조건 검색(특정 행 검색)
SELECT empno, ename, job, sal 
FROM emp 
WHERE sal >= 3000; -- 숫자컬럼

SELECT empno, ename, job, sal, deptno 
FROM emp 
WHERE job = 'MANAGER' -- char or varchar : 문자 상수(리터럴)

SELECT empno, ename, job, sal, hiredate, deptno
FROM emp
WHERE hiredate > = to_date('1982/01/01', 'yyyy/mm/dd')  -- 1982년 1월 1일 이후에 입사한 직원

-- to date() : 리터럴 --> 날짜형 변환

SELECT ename, job, sal, deptno
FROM emp
WHERE sal BETWEEN 1300 AND 1500;

SELECT empno,ename,job,sal,hiredate
FROM emp
WHERE empno IN (7902,7788,7566);

SELECT * FROM emp WHERE comm IS NULL; -- 10명
SELECT * FROM emp WHERE comm IS NOT NULL;  -- 4명

-- LIKE 연산자
SELECT * FROM emp WHERE ename LIKE ' M%';

SELECT * FROM student WHERE name LIKE '서%';     -- 시작문자
SELECT * FROM student WHERE name LIKE '%재%';   -- 포함문자
SELECT * FROM student WHERE name LIKE '%수';    --  종료문자

-- % : 여러문자열 대체
SELECT * FROM emp WHERE ename LIKE '%R%R%';  -- R문자가 2개 포함(위치 상관X)

-- _ : 하나의 문자 대체 : BLAKE
SELECT * FROM emp WHERE ename LIKE '%L__K%':


-- 논리 연산자  : AND, OR, NOT
SELECT empno,ename,job,sal,hiredate,deptno
FROM emp
WHERE sal >= 1100 OR job = 'MANAGER';
/*
 * 연산 우선 순위(기본 : 왼쪽 우선)
 * 1. 산술연산자
 * 2. 관계연산자
 * 3. 논리연산자 (NOT> AND > OR)
 */

SELECT empno,ename,job,sal,hiredate,deptno
FROM emp
WHERE sal >= 1100 OR job = 'MANAGER';

SELECT empno,ename,job,sal,deptno
FROM emp
WHERE job NOT IN ('MANAGER','CLERK','ANALYST');

-- 우선순위 : AND > OR
SELECT empno,ename,job,sal
FROM emp
WHERE job = 'SALESMAN' OR job = 'PRESIDENT' AND sal > 1500  --  5개

-- 우선순위 : 괄호 > AND
SELECT empno,ename,job,sal
FROM emp
WHERE (job = 'SALESMAN' OR job = 'PRESIDENT') AND sal > 1500;  -- 2개

-- 3. 검색 레코드 정렬
SELECT hiredate,empno,ename,job,sal,deptno
FROM emp
ORDER BY hiredate ASC;  -- 오름차순

SELECT hiredate,empno,ename,job,sal,deptno
FROM emp
ORDER BY hiredate DESC;  -- 내림차순

-- 별칭 이용 정렬
SELECT empno,ename,job,sal, sal*12 연봉 FROM emp ORDER BY 연봉;
-- 식 이용 정렬
SELECT empno,ename,job,sal,sal*12 연봉 FROM emp ORDER BY sal*12;
-- 순번 이용 정렬
 SELECT empno,ename,job,sal,sal*12 연봉 FROM emp ORDER BY 5;

 -- 두개 이상 컬럼으로 정렬
SELECT deptno, sal, empno, job
FROM EMP
ORDER BY deptno, sal DESC
-- 1차 : 부서번호 오름차순 -> 2차 : 급여 내림차순

-- 세 개 이상 컬럼
SELECT deptno,job,sal,empno,ename,hiredate
FROM emp
ORDER BY deptno,job,sal DESC;
-- 1차, 2차 내용이 같은경우 3차 적용


-- [추가]
-- 서로 다른 컬럼으로 논리곱을 적용
SELECT * FROM emp 
WHERE job = 'CLERK' AND deptno = 20;

-- 동일 컬럼으로 논리곱 적용(결과 없음)
SELECT * FROM emp 
WHERE job = 'CLERK' AND job = 'ANALYST';


-- 테이블 별칭 이용 : 논리적으로 분리(결과 있음)
SELECT DISTINCT e1.empno, e1.job, e2.job
FROM emp e1, emp e2
WHERE e1.job = 'CLERK' AND e2.job = 'ANALYST'
ORDER BY e1.empno;




