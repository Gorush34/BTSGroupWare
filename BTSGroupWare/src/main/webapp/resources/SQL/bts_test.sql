show user;
-- USER이(가) "FINALORAUSER1"입니다.

create table bts_test
(no         number
,name       varchar2(100)
,writeday   date default sysdate
);

select *
from bts_test;