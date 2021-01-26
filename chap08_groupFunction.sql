-- GroupFuction.sql


-- [1]  sum(컬럼명), avg(컬럼명) : 합계, 평균

SELECT SUM(sal) FROM EMP; -- 14명(1차원) -> 상수(scala)

SELECT SUM(COMM) FROM EMP;  -- 14명(1차원) -> 상수(scala)

SELECT AVG(SAL) FROM EMP; 


-- <문제1> 'SCOTT'사원이 소속된 부서의 급여 합계와 평균을 구하시오(서브쿼리 사용)
SELECT SUM(SAL), AVG(SAL)
FROM EMP
WHERE DEPTNO = (SELECT DEPTNO FROM EMP WHERE ENAME = 'SCOTT')

-- [2] MAX(컬럼), MIN(컬럼) : 값의 범위(range)
SELECT MAB(SAL), MIN(SAL) FROM EMP;alter

-- <문제2> 가장 최근에 입사한 사원의 입사일과 입사한지 가장오래된 사원의 입사일 출력(MAX, MIN, eo_char사용)
SELECT to_char(MAX(hiredate), 'YY/MM/DD') 입사일, to_char(MIN(hiredate), 'YY/MM/DD') 입사일
FROM EMP;


-- [3] COUNT(*), COUNT(컬럼) : 레코드의 수 반환
SELECT COUNT(*), COUNT(COMM) FROM EMP;

SELECT COUNT(JOB) 업무수 FROM EMP;

SELECT COUNT(DISTINCT) JOB 업무수 FROM EMP;

--<문제3>  30번 부서 소속 사원중에서 커미션을 받는 사원의 수
SELECT COUNT(COMM) 사원수
FROM EMP
WHERE DEPTNO = 30  AND COMM > 0 ;

SELECT COMM, DEPTNO  FROM EMP WHERE DEPTNO = 30  AND COMM > 0 ;

-- [4] STDDEV(컬럼), VARIANCE(컬럼) : 산포도
SELECT AVG(SAL) FROM EMP;
SELECT VARIANCE(SAL), STDDEV(SAL) FROM EMP;

-- [5] GROUP BY 범주형 컬럼
SELECT DEPTNO
FROM EMP
GROUP BY DEPTNO -- 부서별 집단

-- 부서별 급여 평균
SELECT DEPTNO, AVG(SAL)
FROM EMP
GROUP BY DEPTNO;

-- 부서별 최대/최소 급여
SELECT DEPTNO, MAX(SAL), MIN(SAL)
FROM EMP
GROUP BY DEPTNO;


- [6] HAVING 조건식
/*
 * SQL문의 조건문
 * SELECT * FROM  테이블명 WHERE 조건식;
 * SELECT * FROM 테이블명 GROUP BY 컬럼명 HAVING 조건식;
 */

SELECT DEPTNO, AVG(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING AVG(SAL) > = 2000;

-- 최대 급여 2900 초과 부서
SELECT DEPTNO, MAX(SAL), MIN(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING MAX(SAL) > 2900;


-- <문제4> 부서별로 가장 급여를 많이 받는 사원의 정보(번호, 이름, 급여, 부서번호)출력
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL IN (SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO);


--<문제5> <문제4>의 결과에서 'SCOTT' 사원을 제외하고, 급여를 내림차순으로 정렬
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL IN (SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO) AND ENAME != 'SCOTT'
ORDER BY SAL DESC;
















