

show user;
-- USER이(가) "FINALORAUSER1"입니다.


select *
from tbl_mail

desc tbl_mail;
--
--PK_MAIL_NUM         NOT NULL NUMBER(14)    메일번호
--FK_SENDUSER_NUM              NUMBER(8)     보낸사람 사원번호
--FK_RECEIVEUSER_NUM           NUMBER(8)     받는사람 사원번호
--EMPNAME                      VARCHAR2(10)  받는사람 이름
--SUBJECT                      VARCHAR2(100) 메일 제목
--CONTENT                      VARCHAR2(256) 메일 내용
--FILENAME                     VARCHAR2(100) 파일 저장되는 이름(disk)
--ORGFILENAME                  VARCHAR2(100) 파일 원래이름(저장시)
--FILESIZE                     NUMBER        파일크기
--IMPORTANCE                   NUMBER(2)     파일 중요표시 여부(1:중요표시선택O, 0: 중요표시안함X)
--RESERVATION_STATUS           NUMBER(2)     발송예약여부 (1: 발송예약O, 0: 발송예약X)
--READ_STATUS                  NUMBER(2)     받는사람 읽음 여부 (1:읽음O, 0 :안읽음X)
--REG_DATE                     DATE          메일쓰기 일자
--RESERVATION_DATE             DATE          발송예약 날짜
--SENDUSER_DEL_STATUS          NUMBER(2)     보낸사람 삭제 여부 (1:삭제O, 0:삭제X)
--RCVUSER_DEL_STATUS           NUMBER(2)    받는사람 삭제 여부 (1:삭제O, 0:삭제x)

alter table tbl_mail modify REG_DATE date default sysdate;

commit;	

desc tbl_mail

-- mail 시퀀스 생성
create sequence SEQ_MAIL
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_MAIL이(가) 생성되었습니다.

-- 제약조건 조회
select *
from user_constraints
where table_name = 'TBL_MAIL';


-- 받은메일함 목록 보여주기
-- 메일테이블에서 사원번호가 = ? 인 사람이 쓴 글을 보여주자. 
-- 메일번호, 사원명, 사원번호, 제목, 보낸날짜가 필요하다.
INSERT INTO tbl_mail(pk_mail_num, fk_senduser_num, empname, subject, reg_date) 
VALUES(SEQ_MAIL.nextval, 80000001, '관리자', '220503 DB 받은메일함보기 테스트 입니다!', sysdate);    
-- 1 행 이(가) 삽입되었습니다.

commit;
-- 커밋 완료.

INSERT INTO tbl_mail(pk_mail_num, fk_senduser_num, empname, subject, reg_date) 
VALUES(SEQ_MAIL.nextval, 80000001, '관리자', '220503 잘 들어왔는지 확인 테스트!', sysdate);    
-- 1 행 이(가) 삽입되었습니다.

INSERT INTO tbl_mail(pk_mail_num, fk_senduser_num, empname, subject, reg_date) 
VALUES(SEQ_MAIL.nextval, 80000001, '관리자', '220503 DB 관리자로 보낸 메일', sysdate);    
-- 1 행 이(가) 삽입되었습니다.

INSERT INTO tbl_mail(pk_mail_num, fk_senduser_num, empname, subject, reg_date) 
VALUES(SEQ_MAIL.nextval, 80000001, '관리자', '220503 DB 받은메일함보기 테스트 입니다!', sysdate);    
-- 1 행 이(가) 삽입되었습니다.
commit;

-- 사원 테이블 조회
select * 
from tbl_employees

select pk_mail_num, fk_senduser_num, empname, subject, to_char(reg_date,'yyyy-mm-dd hh24:mi:ss') as reg_date
from tbl_mail
order by pk_mail_num desc;



-- 총 받은메일 개수 구해오기
select count(*)
from tbl_mail

-- 임시보관함 테이블 조회
select * 
from tbl_mail_temp

-- 휴지통 테이블 조회
select * 
from tbl_mail_recyclebin


select *
from tbl_mail
order by pk_mail_num desc;

-- 페이징처리 한 받은 메일 목록 (검색 있든, 없든 모두 포함)
select pk_mail_num, fk_senduser_num, empname, subject, reg_date
from 
(
select row_number() over(order by pk_mail_num desc) AS rno,
       pk_mail_num, fk_senduser_num, empname, subject
       , to_char(reg_date,'yyyy-mm-dd hh24:mi:ss') as reg_date
from tbl_mail
where 1=1
and lower(subject) like '%'|| lower('') || '%'
) V
where rno between 1 and 4	

commit;

select count(*)
from tbl_mail
where 1=1
and lower(subject) like '%' || lower('') || '%'

select *
from tbl_mail
order by pk_mail_num desc;

select * 
from tbl_employees



-- 첨부파일 없는 메일쓰기
INSERT INTO tbl_mail(pk_mail_num, fk_senduser_num, fk_receiveuser_num, empname, email, subject, content, reg_date
                   , importance, reservation_status, read_status) 
VALUES(SEQ_MAIL.nextval, 80000001, 80000002, '관리자', 'admin@bts.com', '220506 금요일 메일쓰기 subject', '220506 금요일 메일쓰기 content', sysdate, 0, 0, 0);    
-- 1 행 이(가) 삽입되었습니다.
commit;

INSERT INTO tbl_mail(pk_mail_num, fk_senduser_num, fk_receiveuser_num, empname, email, subject, content, reg_date
                   , importance, reservation_status, read_status) 
VALUES(SEQ_MAIL.nextval, 80000001, 80000002, '관리자', 'admin@bts.com', '220506 금요일 메일쓰기 subject 222', '220506 금요일 메일쓰기 content 222', sysdate, 0, 0, 0);   

commit;
-- 1 행 이(가) 삽입되었습니다.

INSERT INTO tbl_mail(pk_mail_num, fk_senduser_num, fk_receiveuser_num, empname, email, subject, content, reg_date
                   , importance, reservation_status, read_status) 
VALUES(SEQ_MAIL.nextval, 80000001, 80000002, '관리자', 'admin@bts.com', '220506 금요일 메일쓰기 subject', '220506 금요일 메일쓰기 content', sysdate, 0, 0, 0);  

-- default 값 조회하기
SELECT DATA_DEFAULT FROM ALL_TAB_COLS WHERE OWNER='유저명' AND TABLE_NAME='테이블명' AND COLUMN_NAME='컬럼명'

insert into tbl_mail(pk_mail_num, fk_senduser_num, fk_receiveuser_num, empname, email, subject, content, reg_date
                   , importance, reservation_status, read_status) 
values(SEQ_MAIL.nextval, #{fk_senduser_num}, #{fk_receiveuser_num}, #{empname}, #{email}, #{subject}, #{content}, default
      , default, default, default)

select pk_mail_num, fk_senduser_num, fk_receiveuser_num, empname, email, subject, content, to_char( reg_date, 'yyyy-mm-dd hh24:mi:ss') as reg_date
from tbl_mail;


-- 첨부파일 있는 메일쓰기 (아직 commit 안함)
insert into tbl_mail(pk_mail_num, fk_senduser_num, fk_receiveuser_num, empname, email, subject, content, reg_date
                   , importance, reservation_status, read_status, filename, orgfilename, filesize) 
values(SEQ_MAIL.nextval, 80000001, 80000002, '관리자', 'admin@bts.com', '220506 금요일 메일쓰기 subject', '220506 금요일 메일쓰기 content', sysdate
      , 0, 0, 0, filename, orgfilename, filesize);    


-- 이메일 컬럼 추가
alter table tbl_mail modify email varchar2(100);
commit;




select seq, fk_userid, name, subject, content, readCount, regDate, pw
      , nextseq, nextsubject
      , groupno, fk_seq, depthno
      , fileName, orgFilename, fileSize
        from
        (
            select lag(seq,1) over(order by seq desc) AS previousseq            
                 , lag(subject,1) over(order by seq desc) AS previoussubject                                         
                 
                 , seq, fk_userid, name, subject, content, readCount
                 , to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate
                 , pw
                 
                 , lead(seq,1) over(order by seq desc) AS nextseq
                 , lead(subject,1) over(order by seq desc)AS nextsubject
                 
                 , groupno, fk_seq, depthno
                 
                 , fileName, orgFilename, fileSize
            from tbl_board
            where status = 1
            <if test='searchType != "" and searchWord != "" '>
            and lower(${searchType}) like '%'|| lower(#{searchWord}) || '%'
            </if>	    
        ) V
where V.seq = #{seq}


update tbl_mail set RCVUSER_DEL_STATUS = 0, SENDUSER_DEL_STATUS =0

commit;
-- 커밋 완료.
select * 
from tbl_mail
order by pk_mail_num desc;

select emp_name, pk_emp_no
from tbl_employees
where uq_email = 'kimmj@bts.com'



select emp_name, pk_emp_no
from tbl_employees
where uq_email = 'BCrlQgZmIadBjB5K7k8jhA=='

-- 받은메일함 목록 보기
select pk_mail_num, fk_senduser_num, sendempname, subject, reg_date
from 
(
select row_number() over(order by pk_mail_num desc) AS rno,
       pk_mail_num, fk_senduser_num, sendempname, subject
       , to_char(reg_date,'yyyy-mm-dd hh24:mi:ss') as reg_date
from tbl_mail
where fk_receiveuser_num = '80000010' and del_status = 0
) V

-- 보낸메일함 목록 보기
select pk_mail_num, fk_receiveuser_num, recempname, subject, reg_date
from 
(
select row_number() over(order by pk_mail_num desc) AS rno,
       pk_mail_num, fk_receiveuser_num, recempname, subject
       , to_char(reg_date,'yyyy-mm-dd hh24:mi:ss') as reg_date
from tbl_mail
where fk_senduser_num = '80000010' and del_status = 0
) V




describe tbl_mail;

