SELECT * FROM    ALL_CONSTRAINTS
WHERE    TABLE_NAME = 'TBL_APPR';

select * from user_tables

--데이터 타입 변경 : NUMBER(4) -> VARCHAR2(4)
ALTER TABLE emp MODIFY editid VARCHAR2(4);
-- ALTER TABLE [테이블명] MODIFY [컬럼명] [새로운 데이터타입(길이)]

--데이터 길이(크기) 변경 : VARCHAR2(4) -> VARCHAR2(5)
ALTER TABLE emp MODIFY editid VARCHAR2(5);
-- ALTER TABLE [테이블명] MODIFY [컬럼명] [데이터타입(새로운 길이)]

-- 컬럼명 변경 : editid -> edit_id
ALTER TABLE emp RENAME COLUMN editid TO edit_id
-- ALTER TABLE [테이블명] RENAME COLUMN [이전 컬럼명] TO [새로운 컬럼명]

--기본 값 지정
ALTER TABLE emp MODIFY editid VARCHAR2(5) DEFAULT '1000';

--NOT NULL 지정
ALTER TABLE emp MODIFY editid VARCHAR2(5) NOT NULL;

--NOT NULL 제거(변경)
ALTER TABLE emp MODIFY editid VARCHAR2(5) NULL;

--기본 값 + NOT NULL 지정
ALTER TABLE emp MODIFY editid VARCHAR2(5) DEFAULT '1000' NOT NULL;

/*
데이터 타입 변경 시 주의사항
컬럼의 데이터 타입을 변경하기 위해서는 해당 컬럼의 값을 모두 지워야 변경이 가능하다.

그렇지 않으면 아래의 오류가 발생한다.
ORA-01439: column to be modified must be empty to change datatype 

작업순서
1. TEMP 컬럼 추가 한다.
2. TEMP 컬럼에 변경할 컬럼의 값을 옮긴다. (UPDATE)
3. 변경할 컬럼의 값을 모두 지운다다. (DELETE)
4. 컬럼의 데이터 타입을 변경한다.
5. TEMP 컬럼의 값을 원 컬럼으로 옮긴다. (UPDATE)
6. TEMP 컬럼을 삭제 한다.
*/

-- 제약조건 조회 (CONSTRAINT_TYPE => P : 기본키, U : 고유키, R : 외래키(Foreign key) C : 체크제약) 
SELECT * FROM    ALL_CONSTRAINTS
WHERE    TABLE_NAME = '테이블명(대문자)';


-- FK 제약조견 추가
ALTER TABLE '테이블명' ADD CONSTRAINT '제약조건명' FOREIGN KEY('외래키 칼럼명') 
REFERENCES '참조테이블'('참조테이블_PK') [ON DELET 옵션] [ON UPDATE 옵션]
 
/*
 *  ▶ [ ] 는 생략가능하다. 
 *
 *  ON DELETE : 참조 테이블의 튜플이 삭제되었을 때 기본 테이블에 취해야 할 사항을 지정
 *  ON UPDATE : 참조 테이블의 참조 속성 값이 변경되었을 때 기본 테이블에 취해야 할 사항을 지정
 */
 
 /*
  *  옵션 : 총 4가지 옵션이 있다.
  *  1. NO ACTION : 참조 테이블에 변화가 있어도 기본 테이블에는 아무 조취를 취하지 않는다.
  *  2. CASCADE : 참조 테이블의 튜플이 사제되면 기본 테이블의 관련 튜플도 삭제되고, 
  *                            속성이 변경되면 관련 튜플의 속성 값도 모두 변경된다.
  *  3. SET NULL : 참조 테이블에 변화가 있으면 기본 테이블의 과련 튜플의 속성 값을 NULL로 변경한다.
  *  4. SET DEFAULT : 참조 테이블에 변화가 있으면 기본 테이블의 관련 튜플의 속성 값을 기본값으로 변경한다.

*/

-- 제약조건 삭제
ALTER TABLE '테이블명' DROP CONSTRAINT '제약조건명';

-- 시퀀스 생성 예제
create sequence seqImgfileno
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


------------------------------------------------
desc tbl_employees

select *
from tbl_employees

--데이터 길이(크기) 변경 : VARCHAR2(4) -> VARCHAR2(5)
ALTER TABLE tbl_employees MODIFY UQ_PHONE VARCHAR2(100);
-- ALTER TABLE [테이블명] MODIFY [컬럼명] [데이터타입(새로운 길이)]


--컬럼 추가 1
ALTER TABLE tbl_employees ADD gender VARCHAR2(10);

commit;

--컬럼 추가 2 (기본 값, NOT NULL 지정)
ALTER TABLE emp ADD email VARCHAR(25) DEFAULT 'test@test.com' NOT NULL;

--컬럼 삭제
ALTER TABLE emp DROP COLUMN email;

-- *** 로그인을 처리하기 위한 SQL문 작성하기 *** --

select pk_emp_no, fk_department_id, fk_rank_id, fk_board_authority_no, fk_site_authority_no
     , emp_name, emp_pwd, com_tel, postal, address, detailaddress, extraaddress
     , birthyyyy, birthmm, birthdd, hire_date, pwdchangegap
     , gradelevel 
	      from
	      (
	      select pk_emp_no, fk_department_id, fk_rank_id, fk_board_authority_no, fk_site_authority_no
	      	   , emp_name, emp_pwd, com_tel, postal, address, detailaddress, extraaddress
			   , uq_phone, uq_email, img_path, img_name
	           , substr(birthday,1,4) as birthyyyy, substr(birthday,6,2) as birthmm, substr(birthday,9) as birthdd
	           , to_char(hire_date,'yyyy-mm-dd') as hire_date
	           , trunc( months_between(sysdate, lastpwdchangedate) ) as pwdchangegap
	           , gradelevel 
	      from tbl_employees
	      where ishired = 1 and pk_emp_no = '80000001' and emp_pwd = '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382'
	      ) M 
          
desc tbl_employees

select count(*)
       from tbl_employees
       where pk_emp_no =80000001
TBL_SITE_AUTHORITY
TBL_BOARD_AUTHORITY

select *
from tbl_employees;

insert into tbl_employees 
(pk_emp_no, fk_department_id, fk_rank_id, fk_board_authority_no, fk_site_authority_no, emp_name, emp_pwd, com_tel, postal, address, detailaddress, extraaddress
, gender, uq_phone, uq_email, img_path, img_name, birthday, gradelevel)
values                                  
(80000001, 500, 80, 100, 100, '관리자', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '02-123-4567', '21927	', '인천 연수구 먼우금로 218', '1505호', ' (연수동, 연수푸르지오3단지)'
, 1, 'by1uVzCwPeaeKBReQOpamA==', 'afZEvMW8JjDOVx8d/j7hT9f1xWAYk9lFpqDsqhHd5XY=', '11', 'img_name', '1992-01-16', '1')

-- 컬럼명 변경 : editid -> edit_id
ALTER TABLE tbl_employees RENAME COLUMN editid TO edit_id
-- ALTER TABLE [테이블명] RENAME COLUMN [이전 컬럼명] TO [새로운 컬럼명]


delete from tbl_commute
where 1=1;

commit;

select count(*)
from tbl_commute
where fk_emp_no = 80000001
and regdate like '2022'
|| '05'
||'%'