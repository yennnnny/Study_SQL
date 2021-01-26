-- <연습문제2>
SELECT * FROM  emp;
-- 문1) sal이 3000이상인 사원의 empno, ename, job, sal 출력 
SELECT empno, ename, job, sal
FROM emp
WHERE sal >= 3000;

-- 문2) empno가 7788인 사원의 ename과 deptno 출력 
SELECT ename, deptno
FROM emp
WHERE empno = 7788;

-- 문3) sal이 1500이상이고 deptno가 10,30인 사원의 ename과 sal를 출력
SELECT ename, sal
FROM emp
WHERE sal >= 1500 AND deptno IN (10, 30);

-- 문4) hiredate가 1982년 입사한 사원의 모든 정보 출력(힌트 : between ~ and ~) 
SELECT * 
FROM emp
WHERE hiredate BETWEEN '1982-01-01' AND '1982-12-31';

-- 문5) comm에 NULL이 아닌 사원의 모든 정보를 출력(힌트 : is not null)
SELECT * 
FROM emp
WHERE comm IS NOT NULL;

-- 문6) comm이 sal의 10%보다 많은 모든 사원에 대하여 ename, sal, comm 출력 
SELECT ename, sal, comm
FROM emp
WHERE comm > sal*1.1;

-- 문7) job이 CLERK이거나 ANALYST이고 sal이 1000,3000,5000이 아닌 모든 사원 출력(힌트 : in, not in)
SELECT * 
FROM emp
WHERE job IN ('CLERK', 'ANALYST') AND sal NOT IN (1000, 3000, 5000);

-- 문8) ename에 L이 두 자가 있고 deptno가 30이거나 또는 mgr이 7782인 모든 사원 출력(힌트 : like)
SELECT * 
FROM emp
WHERE ename LIKE '%L%L%' AND (deptno = 30 OR mgr = 7782);

