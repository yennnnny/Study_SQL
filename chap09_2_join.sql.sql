/* 
 * 카티션 조인(Cartesian Join)
 * 		- 물리적 join없이 논리적으로 테이블을 연결하는 기법
 * 		1. Cross join : 조건없이 테이블 연결
 * 		2. Self join : 동일 테이블 대상
 * 		3. Inner join : 양쪽 테이블 데이터 존재
 * 		4. Outer join : 한쪽 테이블 데이터 존재
 */

-- 1. Cross join
SELECT * FROM EMP, DEPT; -- ROW(56=14X4), COLUMN(11=8+3)

-- 2. Self Join : 동일 테이블 간의 조인
SELECT E1.*, E2.*
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO;

-- <실습>
SELECT E1.ENAME 사원명, E2. ENAME 상사명
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO;

-- <문제1> 직속상관이 KING인 사원들의 이름과 직급 출력
SELECT E1.ENAME 사원명, E1.JOB 직급
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO  AND E2.ENAME = 'KING' 

-- <문제2> SCOTT과 동일한 근무지에서 근무하는 사원의 이름
SELECT E1.ENAME 사원명, E2.ENAME
FROM EMP E1, EMP E2
WHERE E1.ENAME = 'SCOTT' AND E1.DEPTNO = E2.DEPTNO AND E1.ENAME != E2.ENAME;


-- 3. Inner join : 공통컬럼 기준
--	 	조인 대상 테이블에 모두 자료가 있는 경우 

SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO; -- ROW(14), COLUMN

SELECT E.ENAME, D.DNAME, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

-- AND 연산자  :  Oracl의  Inner Join
SELECT EMP.ENAME, DEPT.DNAME
FROM EMP, DEPT
WHERE EMP.DEPTNO=DEPT.DEPTNO AND ENAME = 'SCOTT';
--		유일 컬럼 명 : 테이블명 생략가능(EX: ENAME)


-- ANSI Inner Join
SELECT ENAME, DNAME
FROM EMP INNER JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO
WHERE  ENAME = 'SCOTT';


-- ANSI Inner Join : USING(공통컬럼)
SELECT ENAME, DNAME
FROM EMP INNER JOIN DEPT USING(DEPTNO)
WHERE  ENAME = 'SCOTT';


-- 공통 컬럼명 : 테이블명 입력
SELECT EMP.ENAME, DEPT.DNAME, EMP.DEPTNO
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.ENAME = 'SCOTT';

-- 별칭이용
SELECT E.ENAME, D.DNAME, E.DEPTNO
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO AND E.ENAME = 'SCOTT';


--<문제3>뉴욕에서 근무하는 사원의 이름과 급여 출력
SELECT E.ENAME, E.SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO AND D.LOC = 'NEW YORK';

--<문제4> ACCOUNTING 부서 소속 사원의 이름, 입사일, 근무지역 출력
SELECT E.ENAME, E.HIREDATE, D.LOC, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO AND D.DNAME = 'ACCOUNTING';

--<문제5> 직급이 MANAGER인 사원의 이름, 부서명을 출력
SELECT E.ENAME,  D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO AND E.JOB = 'MANAGER';

--<문제6>
SELECT * FROM STUDENT;  -- PROFNO
SELECT * FROM PROFESSOR;  -- PROFNO

SELECT S.NAME 학생명, S.STUDNO 학번, P.NAME 교수명, P.PROFNO 교수번호
FROM STUDENT S, PROFESSOR P
WHERE S.PROFNO = P.PROFNO;

--<문제7> <문제6>의 결과에서 101학과만 검색
SELECT S.NAME 학생명, S.STUDNO 학번, P.NAME 교수명, P.PROFNO 교수번호
FROM STUDENT S, PROFESSOR P
WHERE S.PROFNO = P.PROFNO AND S.DEPT01 - 101;;

-- 4. Outer join : 한쪽 테이블에 데이터 존재, 데이터가 없는 테이블에 + 기호
/*
 *  Left Outer join : 왼쪽 테이블 기준
 *  Right Outer join: 오른쪽 테이블 기준
 *  Full Outer join : 양쪽 테이블 기준
 */

-- 1) Left Outer join : 왼쪽 테이블 기준
SELECT E1.ENAME 사원명, E2.ENAME 상사명
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO(+);  -- INNER JOIN 

-- 		ANSI Outer Join
SELECT E1.ENAME 사원명, E2.ENAME 상사명
FROM EMP E1 LEFT OUTER JOIN EMP E2 ON E1.MGR = E2.EMPNO;  

-- 2) Right Outer join : 오른쪽 테이블 기준
SELECT E.ENAME, D.DEPTNO, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;

-- 		ANSI Outer Join
SELECT E1.ENAME 사원명, E2.ENAME 상사명
FROM EMP E1 RIGHT OUTER JOIN EMP E2 ON E1.MGR = E2.EMPNO;  

-- 3) FULL Outer join : 두 테이블 중 한개만 있어도 JOIN 가능  --> ANSI 표준 Outer Join만 가능
SELECT S.NAME 학생명, P.NAME 교수명
FROM STUDENT S FULL OUTER JOIN PROFESSOR P
USING(PROFNO)

SELECT E.ENAME, D.DEPTNO, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO(+); --> error

