-- step01_sql.sql

/*
  SQL(Structured Query Language) : 구조화된 질의 언어 
  - DDL, DML, DCL
  1. DDL : 데이터 정의어 -> DBA, USER(TABLE 생성, 구조변경, 삭제)
  2. DML : 데이터 조작어 -> USER(SELECT, INSERT, DELETE, UPDATE)
  3. DCL : 데이터 제어어 -> DBA(권한설정, 사용자 등록 등) 
*/

-- 1. DDL : 데이터 정의어
-- 1) Table 생성 
/*
 * create table 테이블명(
 *   칼럼명 데이터형 [제약조건],
 *   칼럼명 데이터형
 *   );
 */

-- DA : XE
create table test2(
id varchar(20) primary key,
passwd varchar(50) not null,
name varchar(25) not null
);

-- scott 테이블 목록 확인
select * from tab;


-- 2) Table 구조변경
-- 		(1) table 이름 변경
-- 				(형식) alter table 기존table rename to 새이름;
alter table test2 rename to member;

-- 		(2) table 컬럼 추가
alter table member add (reg_date date);

-- 		(3) table 컬럼 수정
alter table member modify (passwd varchar(25)); -- (50) -> (25)

-- 		(4) table 컬럼 삭제
alter table member drop column reg_date;


-- 3) Table 제거
-- 		(형식) drop table 테이블명 purge;
-- 		purge : 임시 파일을 테이블과 함께 제거

drop table member purge;


-- 2. DML : 데이터 조작어
create table depart(
dno number(4),
dname varchar(50),
daddress varchar(100)
);

-- 1) insert : 레코드 삽입
	-- 형식) insert into 테이블명(칼럼명1, .. 칼럼명n) values(값1, ... 값n);
insert into depart(dno, dname, daddress) values(1001, '기획실', '서울특별시');
insert into depart values(1002, '영업부', '싱가풀'); -- 컬럼 생략(모든 컬럼에 값 입력 시)
insert into depart(dno, dname)  values(1003, '총무부') -- null 허용


-- 2) select : 레코드 검색 
	-- 형식) select 칼럼명 from 테이블명 [where 조건식];
select *  from depart; 
select dno, dname from depart where dno >= 1002;
select dno, dname from depart where dno = 1002 or dname = '총무부';
select * from depart where daddress is null;


-- 3) update : 레코드 수정 
	-- 형식) update 테이블명 set 칼럼명 = 값 where 조건식;
update depart set daddress = '대전시'  where dno = 1003;


-- 4) delete : 레코드 삭제 
	-- 형식) delete from 테이블명 where 조건식;
delete from depart where dno = 1002;
select * from depart


-- db 반영 : 작업 내용
commit work ;





