-- DDL_work.sql

/*
 * DDL : 데이터 정의어 (테이블 생성, 구조변경, 삭제)
 * 	- 자동커밋(AUTO COMMIT)
 */

-- 1. 의사컬럼 : ROWNUM, ROWID
-- 		SELECT, WHERE 절에서 사용가능
SELECT ROWNUM, empno, ename, ROWID
FROM emp
WHERE ROWNUM <=10 ORDER BY ROWNUM DESC;

-- 중간 5~10 출력 --> 특정 영역, 중간범위 불가능(시작이 처음이어야함)
SELECT ROWNUM, empno, ename, ROWID
FROM emp
WHERE 5 <= ROWNUM AND ROWNUM  <=10 -- 검색결과 없음

-- 별칭 사용 : 5~10번 레코드 검색
SELECT empno, ename, rnum
FROM (SELECT empno, ename, ROWNUM AS rnum FROM emp)   -- 테이블 명 --> 서브쿼리로 대체
WHERE  rnum >= 5 AND rnum <= 10;  -- 조건식 

-- 서브쿼리 별칭 : SELECT, WHERE 사용
-- 메인쿼리 사용가능한 컬럼 : 서브쿼리의 컬럼만 사용 가능

-- 2. 서브쿼리 이용 테이블 생성
CREATE TABLE EMP02
AS
SELECT * FROM EMP;  -- 구조 +  내용 복제

-- 특정 컬럼 선택
CREATE TABLE EMP03
AS
SELECT empno, ename, sal FROM EMP;

-- 특정 행 선택
CREATE TABLE EMP05
AS
SELECT * FROM EMP
WHERE DEPTNO =10;

-- 스키마만 복제(구조)
CREATE TABLE EMP06
AS
SELECT * FROM EMP WHERE 1=0; --> 일부러 거짓인 조건을 넣음

--<과제2> DEPT --> DEPT02 구조만 복제
CREATE TABLE DEPT02
AS
SELECT * FROM DEPT WHERE 1 = 0; --> 일부러 거짓인 조건을 넣음


-- 3. 제약조건


-- 1) 기본키(Primary key)
CREATE TABLE test_table1(
			id NUMBER(2) PRIMARY KEY,
			name VARCHAR2(10)
			); -- 컬럼 level

CREATE TABLE test_table1(
			id NUMBER(2),
			name VARCHAR2(10),
			 PRIMARY KEY(id)
			); -- 테이블 level

-- 2) 외래키(FOREIGN KEY)
--		특정 테이블의 기본키를 다른 테이블에서 참조하는 키 (컬럼)
	
-- 		(1) 기본키를 포함하는 테이블 생성(master table)
CREATE TABLE dept_tab(
			deptno number(2) PRIMARY KEY,  -- 기본키
			danme VARCHAR(20),
			loc VARCHAR(10)
			);			
			
			
--		 (2) 레코드 추가
INSERT INTO dept_tab VALUES(1, '기획부', '서울');
INSERT INTO dept_tab VALUES(2, '영업부', '뉴욕');


--		 (3) 외래키를 포함하는 테이블 생성(TRANSACTION) --> 마스터 테이블을 참조하는 테이블
CREATE TABLE emp_tab(
		empno NUMBER(4) PRIMARY KEY,
		ename VARCHAR(30) NOT NULL,
		deptno NUMBER(2) NOT NULL,
		FOREIGN KEY (deptno) REFERENCES dept_tab(deptno)
		);

--		 (4) 레코드 추가
INSERT INTO emp_tab VALUES (1001, '홍길동', 2);
INSERT INTO emp_tab VALUES (1002, '홍길동', 1);
INSERT INTO emp_tab VALUES (1003, '강호동', 3); -- 참조무결성 제약조건 위배


-- 3) UNIQUE KEY : 유일값
CREATE TABLE UNI_TAB1 (
		DEPTNO NUMBER(2)  UNIQUE,
		DNAME CHAR(14),
		LOC CHAR(13)
		);

INSERT INTO UNI_TAB1 VALUES(1, 'AAAA', 'BBBB');
INSERT INTO UNI_TAB1(DNAME, LOC) VALUES('AAA', 'BBBB');


-- 4) NOT NULL:  컬럼 level만 사용 가능(생략불가능)

-- 5) CHECK 
CREATE TABLE CK_TAB1 (
			DEPTNO NUMBER(2) NOT NULL CHECK (DEPTNO IN (10,20,30,40,50)),
			DNAME CHAR(14),
			LOC CHAR(13)
			);
			
INSERT INTO CK_TAB1 VALUES(10, 'AAAA', 'BBBB');  -- 정상 레코드 삽입
INSERT INTO CK_TAB1 VALUES(60, 'AAAA', 'BBBB');   -- CHECK 항목에 위배된 레코드


-- 4. 테이블 구조 변경

-- 1) 컬럼 추가
CREATE TABLE emp01
AS
SELECT * FROM emp;

ALTER TABLE EMP01 ADD(JOB2 VARCHAR2(9)); 
SELECT * FROM emp01;


-- 2) 컬럼 수정 : 자료형, 크기, 기본값 수정만 가능
ALTER TABLE EMP01
MODIFY(JOB VARCHAR2(30)); 

DROP EMP01 -- commit line 확인


-- 3) 컬럼 삭제
ALTER TABLE EMP01 DROP COLUMN JOB2;
SELECT * FROM emp01;

-- 5. 레코드 삭제 & 테이블 삭제

-- 1) 레코드 삭제
DELETE FROM EMP01;
TRUNCATE TABLE EMP01;

-- 2) 테이블 삭제
DROP TABLE EMP01;
SELECT * FROM tab;

-- 임시파일 전용 삭제
purge recyclebin;

-- 6. 데이터 사전 뷰 : 데이터 사전 정보 확인용
SELECT TABLE_NAME FROM USER_TABLES
ORDER BY TABLE_NAME DESC;



