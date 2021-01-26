-- subQuery_work.sql

/*
 * 형식1)
 * main query  --> 2차 실행
 * AS
 * sub query  --> 1차 실행
 * 
 * 형식2)
 * main query 조건식 (sub query); 
 */
 

-- 형식1)
CREATE TABLE dept01  -- dept 내용 + 구조 복제
AS 
SELECT * FROM dept;

SELECT * FROM dept01;


-- 형식2) main(dept), sub(emp)
SELECT * FROM dept 
WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'SCOTT'); -- deptnp = 20


-- 1. 단일행 서브쿼리 : 서브쿼리 조회 레코드 1개
--		형식) main query 관계연산자 (sub query);

-- <실습1> SCOTT과 같은 부서에서 근무하는 사원의 이름과 부서 번호 출력
SELECT ename, deptno FROM emp
WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'SCOTT'); -- 20번 부서에 일하는 모든 직원

--<실습2> SCOTT와 동일한 직속상관 (MGR)을 가진 사원을 출력
SELECT * FROM emp
WHERE mgr = (SELECT mgr FROM emp WHERE ename = 'SCOTT'); -- 7566 상사

-- <실습3> SCOTT의 급여와 동일하거나 더 많은 사원 출력
SELECT * FROM emp
WHERE sal >= (SELECT sal FROM emp WHERE ename = 'SCOTT');
SELECT * FROM emp
WHERE ename = (SELECT sal FROM emp WHERE sal >= 'SCOTT');

-- <실습4> DALLAS에서 근무하는 사원의 이름, 부서번호를 출력
SELECT ename, deptno FROM emp
WHERE deptno = (SELECT deptno FROM dept01 WHERE loc = 'DALLAS')

-- <실습5>SALES(영업부) 부서에서 근무하는 모든 사원의 이름과 급여 출력
SELECT ename, sal FROM emp
WHERE deptno = (SELECT deptno FROM dept01 WHERE dname = 'SALES')


-- 서브 쿼리에서 그룹함수 사용
SELECT ename, sal
FROM emp
WHERE sal > (SELECT AVG(sal) FROM emp);


-- 2. 다중 행 서브 쿼리
--	 	형식) main query IN/ALL/ANY 연산자(sub query)

-- 1) IN 연산자 : IN (리스트)
SELECT ENAME, SAL, DEPTNO 
FROM EMP
WHERE DEPTNO IN (SELECT DISTINCT DEPTNO
								FROM EMP 
								WHERE SAL>=3000);

-- 단일 쿼리
SELECT ENAME, SAL, DEPTNO 
FROM EMP
WHERE DEPTNO IN (10, 20) 

-- <실습7> 직급(JOB)이 MANAGER인 사람이 속한 부서의 부서 번호와  서명과 지역을 출력
SELECT deptno, loc
FROM dept01
WHERE deptno IN (SELECT DISTINCT deptno FROM emp WHERE job = 'MANAGER')
ORDER BY deptno ASC;

-- 2) ALL 연산자( AND 연산자 ) : 최댓값 기준
SELECT ENAME, SAL
FROM EMP
WHERE SAL > ALL(SELECT SAL
							FROM EMP
							WHERE DEPTNO =30);

-- <실습8> 영업 사원들 보다 급여를 많이 받는 사원들의 이름과 급여와 직급
SELECT ename, sal, job
FROM EMP
WHERE sal > ALL (SELECT sal FROM emp WHERE job = 'SALESMAN'); -- 1250~1600

-- 3) ANY 연산자( OR 연산자 ) : 최솟값 기준
SELECT ename, sal
FROM emp
WHERE sal > ANY (SELECT sal FROM emp WHERE deptno = 30);  -- 950~2850

-- <실습9> 영업 사원들의 최소 급여보다 많이 받는 사원들의 이름과 급여와 직급(담당 업무)를 출력
SELECT ename, sal, job
FROM EMP
WHERE sal > ANY (SELECT sal FROM emp WHERE job ='SALESMAN') AND job != 'SALESMAN';











