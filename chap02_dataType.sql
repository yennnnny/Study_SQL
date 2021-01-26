-- dataType.sql : Oracle 주요 자료형 

create table student(
sid int primary key,               -- 학번 
name varchar(25) not null,   -- 이름 
phone varchar(30) unique,   -- 전화번호
email char(50),                     -- 이메일 
enter_date date not null       -- 입학년도 
);


/*
 * 스키마 : 데이터 베이스를 이루고 있는 구조, 정보
 * Oracle 주요 자료형 
 *  1. number(n) : n 크기 만큼 숫자(실수) 저장 
 *  2. int : 4바이트 정수 저장 (32bit --> 비교적 큰 숫자 저장 가능)
 *  3. varchar2(n) : n 크기 만큼 가변길이 문자 저장 
 *  4. char(n) : n 크기 만큼 고정길이 문자 저장
 *  5. date : 날짜/시간 저장 - sysdate : system(현재)의 날짜/시간 저장 
 */

/*
 * 제약조건 
 *  1. primary key : 해당 칼럼을 기본키로 지정(중복불가+null불가)
 *  2. not null : null값 허용 불가 
 *  3. unique : 중복 불가(null 허용)
 */

/*
 * sequence?
 *  - 시작값을 기준으로 일정한 값이 증가하는 객체 
 *  - 형식) create sequence 이름 increment by 증가값 start with 시작값;
 */


-- 학번 생성기
create sequence seq_sid increment by 1 start with 2021001;

-- 학번 생성기 이용 : 레코드 삽입
insert into student values(seq_sid.nextval, '홍길동', '010-111-222', 'hong@naver.com', sysdate);
insert into student values(seq_sid.nextval, '이순신', '010-222-222', 'lee@naver.com', sysdate);
insert into student values(seq_sid.nextval, '유관순', '010-333-222', 'yoo@naver.com', sysdate);

-- 레코드 조회
select * from student

commit work;


-- table 스키마 확인 : command line에서 확인
