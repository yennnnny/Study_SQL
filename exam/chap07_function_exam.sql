/*
 * 주요 함수 
 * 작업 대상 테이블 : STUDENT, EMP, PROFESSOR 
 */

--Q1. STUDENT 테이블에서 JUMIN 칼럼을 사용하여 
-- 태어난 달이 8월인 사람의 이름과 생년월일 출력하기
-- 힌트 : substr() 함수 이용
SELECT NAME, BIRTHDAY
FROM STUDENT
WHERE SUBSTR(JUMIN, 3,2) = 08;


--Q2. EMP 테이블에서 사번이 홀수인 사람들을 검색하기
-- 힌트 : mod() 함수 이용
SELECT * FROM EMP WHERE MOD(EMPNO,2) != 0;


--Q3. Professor 테이블에서 교수명, 급여, 보너스, 연봉을 출력하기 
-- 조건) 연봉 = pay*12+bonus 으로 계산, bonus가 없으면 pay*12 처리
-- 힌트 : nvl2() 함수 이용
SELECT NAME, PAY, BONUS, PAY*12 + BONUS AS 연봉  --> BONUS가 NULL값긴 경우 연봉도 NULL로 표기됨, nvl2()을 통해 NULL값 제거 해야함
FROM PROFESSOR

-- 정답)
SELECT name, pay, bonus, pay*12 + nvl(bonus, 0) 연봉 FROM PROFESSOR;


