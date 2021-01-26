-- Function_work.sql

/* 
 * 	함수명(인수1, 인수2, ...)
 * 		- 특정 기능을 정의해 놓은 라이브러리
 */

-- 1. 숫자 함수

-- 1) ABS 함수 : 절댓값
SELECT -10, ABS(-10) FROM DUAL; -- 의사테이블 DUAL

-- 2) FLOOR 함수 : 버림
SELECT 34.5678, FLOOR(34.5678) FROM DUAL;  -- 34

-- 3) ROUND 함수 : 반올림
SELECT 34.5678, ROUND(34.5678) FROM DUAL;  -- 35
-- 		ROUND(대상, 자릿수)
SELECT 34.5678, ROUND(34.5678, 2) FROM DUAL; -- 34.57 --> 소숫점 2째 자리부터 반올림
SELECT 34.5678, ROUND(34.5678, -1) FROM DUAL;  -- -1 : 정수 첫째 자리수를 기준으로 반올림 

-- 4) MOD 함수 : 나머지 값 반환
SELECT MOD(27,2), MOD(27,5), MOD(27,7) FROM DUAL;

-- 짝수/홀수 판별 OR 배수판열
SELECT MOD(10, 5), MOD(11, 2) FROM DULA;
-- fi num % 2 == 0

-- < 실습1 >  사번이 홀수인 사람들을 검색해 보십시오,(EMP 테이블)
SELECT * FROM EMP WHERE MOD(EMPNO, 2) != 0;

-- 5) LOG 함수 : 자연로그 (밑수 2:  밑수 : e)
SELECT LOG(2, 8) FROM DUAL;  -- 2.9999 : 8 = 2^3 --> 2에 대한 몇승 면환
SELECT LOG(2.7182,8) FROM DUAL; -- 2.079 : 8 = e^2.073 --> e에 대한 몇승 변환
SELECT LOG( EXP(1) ,8) FROM DUAL; 

-- 6) EXP 함수 : 지수함수
SELECT EXP(1) FROM DUAL;  -- e = 2.718
SELECT EXP(2.079) FROM DUAL;  -- 7.99 = e^2.079  --> e에 대한 인수 제곱

-- 7) POWER 함수 : 제곱
SELECT POWER(EXP(1), 2.079)  FROM DUAL;  -->  e^2.079

-- 		EXP  VS   LOG  역합수 관계
--		EXP(2.079) : log값 반환
-- 		LOG(EXP(1), 8)  : exp 값 반환  -> 2.079

--  값의 정규화  : 일정한 범위 조정
--  x = [10, 1.125, 100]
SELECT LOG(2, 10), LOG(2, 1.125), LOG(2,100) FROM DUAL; -- > 0.16~6.64
SELECT EXP(10), EXP(1.125), EXP(100) FROM DUAL;  -- >  3.0 ~ 무한대

/*
 * f(x)와 x의 관계
 * log : x의 변화에 따른 완만한 변화  --> 정규화 이용
 * exp : x의 변화에 따른 급격한 변화  --> 이항분류 이용
 */*
/

-- 8) SQRT 함수 : 제곱근
SELECT SQRT(49) FROM DULA:  --> 7


-- 2. 문자 처리 함수

-- 1) UPPER 함수
SELECT 'Welcome to Oracle', UPPER('Welcome to Oracle') FROM DUAL;

-- 2) LOWER 함수
SELECT 'Welcome to Oracle', LOWER('Welcome to Oracle')  FROM DUAL;

-- 3) INITCAP 함수
SELECT 'WELCOME TO ORACLE', INITCAP('WELCOME TO ORACLE') FROM DUAL;

-- <실습2>
SELECT EMPNO, ENAME, JOB 
FROM EMP 
WHERE JOB=UPPER('manager');

-- 4) LENGTH
SELECT LENGTH('Oracle'), LENGTH('오라클') FROM DUAL; --> 음절의 길이

SELECT LENGTHB('Oracle'), LENGTHB('오라클') FROM DUAL;  --> bite 수

-- 5) SUBSTR 함수
SELECT SUBSTR('Welcome to Oracle', 4, 3) FROM DUAL;  -- com : (string, start, len)
SELECT SUBSTR('Welcome to Oracle', -4, 3) FROM DUAL;  -- 오른쪽 부터 시작

-- HIREDATE 에서 입사년도 추출 : 'YY/MM/DD'
SELECT SUBSTR(HIREDATE, 1, 2) 년도, SUBSTR(HIREDATE, 4, 2) 달
FROM EMP;

-- <실습3> 9월에 입사한 사원을 출력해 보세요. (EMP 테이블)
SELECT * FROM EMP WHERE SUBSTR(HIREDATE, 4, 2) = '09';

--  6) TRIM  함수
SELECT TRIM('      Oracle') FROM DUAL;  -- 


-- 3. 날짜 함수

-- 1) SYSDATE
SELECT SYSDATE FROM DUAL;  -- YYYY-MM-DD  HH:MI:SS

-- 2) MONTHS_BETWEEN 함수
SELECT ENAME, SYSDATE, HIREDATE, ROUND(MONTHS_BETWEEN (SYSDATE, HIREDATE))
FROM EMP;

-- 3) ADD_MONTHS
SELECT ENAME, HIREDATE, ADD_MONTHS(HIREDATE, 6) FROM EMP;
SELECT ENAME, HIREDATE, ADD_MONTHS(HIREDATE, 12) FROM EMP;  --> 입사후 1년이 되는 날짜

-- 4) NEXT_DAY 함수
SELECT SYSDATE, NEXT_DAY(SYSDATE, '수요일')  FROM DUAL;

-- 5) LAST_DAY 함수 : 특정 달의 마지막 날
 SELECT HIREDATE, LAST_DAY(HIREDATE) FROM EMP;


 --  4. 형 변환 함수
 /*
  * to_char() :  날짜, 숫자 --> 양식을 이용한 문자형 변환
  * to_date() : 문자, 숫자 -->  양식을 이용한 날짜형 변환
  * to_number() : 문자 --> 양식을 이용한 숫자형 변환
  */
 
 -- 1) to_char()
 SELECT SYSDATE, TO_CHAR(SYSDATE,  'YYYY-MM-DD') FROM DUAL;  -- 날짜 양식 적용
 
SELECT HIREDATE, TO_CHAR (HIREDATE, 'YYYY/MM/DD DAY') FROM EMP;  -- 요일 확인
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD, HH24:MI:SS') FROM DUAL;  -- 시간 양식 적용
 
SELECT ENAME, SAL, TO_CHAR (SAL, 'L999,999') FROM EMP;  -- 숫자양식 적용 -> 1,234(부족한 자리 공백으로 처리)
SELECT ENAME, SAL, TO_CHAR (SAL, 'L000,000') FROM EMP;  -- 숫자양식 적용 -> 001,234(부족한 자리 0으로 처리) 

 
 -- 2)TO_DATE()
 SELECT ENAME, HIREDATE FROM EMP
 WHERE HIREDATE = TO_DATE(19810220, 'YYYYMMDD');  --> ['19811023]  입력창
 
 -- 3) TO_NU,BER 함수
SELECT '20,000' - '10,000'  FROM DUAL;  --> FAIL

 SELECT TO_NUMBER('20,000', '99,999') - TO_NUMBER('10,000', '99,999')
 FROM DUAL;
 
 
 
 
 
 
 




