-- scott3_1 ~ 20 에서 ID 사용 가능함!  
 
 
 
 select * from emp;

select * from emp
order by empno desc, hiredate asc
;

select * from dept;

-- where : filter 효과
select * from emp
where deptno = 20;

-- 비교에는 null 제외
-- '같다'는 <= 항상 우측에 사용
select * from emp
where comm < 1000;

-- '=' 대신 'is' 사용한다.
select * from emp
where comm is NULL;

-- and로 두 개의 조건 검출
select * from emp
where deptno = 20 and sal >= 2000;

-- or
select * from emp
where deptno = 10 or deptno =20;

-- not or !
-- !=
-- <>
select * from emp
where comm is not null;

-- 조건이 많아질 경우 : in
select * from emp
where deptno in (10,20);

-- like 검색 : '문자표시' , 
-- 'A%' : A로 시작하는 모든 컬럼 탐색

-- 중간에 A가 포함된 컬럼 : '%A%'
select * from emp
where ename like '%AR%';

-- 대소문자 구분 : ename -> ENAME로 변경

-- concat & || :
select * from emp
where ename like '%' || 'AR' || '%';

-- 한 글자만 검색 : 비트연산 &와 or 가 중복되면 and가 우선 순위
-- 괄호로 묶어주기()
select * from emp
where (ename like '_' || 'AR' || '%');

-- Null 만 0으로 출력 되도록 수정함
-- int 값으로 출력하기.
select nvl(comm, 0) from emp;

select nvl(mgr, 0) from emp;

-- concat 

select 
empno, ename, empno || ';'|| ename from emp;

-- order by : asc 기본 : desc 내림차순 = 같은 sal이 겹칠 때,
-- ','넣고 뒤에 조건을 추가한다.
select * from emp
order by sal desc, ename;

-- group by : 컬럼명을 뒤에 추가로 넣어준다. 겹치는 애들을 한 줄로
select deptno,job from emp
group by deptno, job;

-- count : 1 줄로 표기됨
/*4*/select deptno, job, ename as name
/*1*/from emp
/*2*/where sal > 2000
/*3*/group by deptno, job, ename
/*5*/order by deptno, name;

-- 
select count(ename)from emp;

-- 다른 표현
select count(*)from emp;

-- ************* 04/17 case 문 ****************
select sal,
-- switch 문 처럼 사용법
-- case ~ when, then ~ end
-- 우선순위가 첫번쨰 case 문이 높다.
 case sal
    when 3000 then '삼천'
    when 5000 then '오천'
    else '그 외'
end, 
-- if문처럼 사용하는 방법
case
    when sal = 3000 then '3천'
    when sal>= 3000 then '고액'
    else '일반'
end
from emp;

-- emp 2 생성
select * from emp2;
create table emp2
as select * from emp;

-- union all
-- 중복된 내용 삭제함

select sal,ename from emp
where deptno =10
union all
select sal,ename from emp
where deptno =20;


-- 부서번호 10에 해당하는 사람들의 
-- 평균급여보다 높은 급여를 받는 
-- 부서번호 20에 해당하는 사람들만 조회하고 싶을 때,
select sum(sal),count(*), avg(sal) from emp
where deptno=10;
-- 평균급여 2900만원 이상만 도출
select * from emp
where deptno = 20
and sal > 2916.666666666666666666666666666666666667;

-- 서브쿼리문 만들어보기
select sum(sal),count(*), avg(sal) from emp
where deptno=10;

select * from emp
where deptno = 20
-- 서브쿼리 문: 평균연봉 값 서브쿼리로 도출
and sal > (select avg(sal) from emp
            where deptno=10);
            
-- 서브쿼리를 from 에 넣어주기
select rownum as rnum, ename from emp
where deptno =30;

-- 서브쿼리를 from 에 넣어주기
-- 급여가 고액인 사람 3명만 출력
-- 급여를 내림차순 정렬
-- 컬럼마다 줄 번호 부여
-- 줄 번호가 3 이하인 사람만 출력
-- order by 가 사용되면서 rownum이 무작위로 추출된다.
select rownum, ename, sal from emp
where deptno = 30
order by sal desc;

-- from 에 추가해서 서브쿼리문을 실행한다.
select rownum as rnum, ename, sal
from (select ename, sal from emp
where deptno = 30
order by sal desc);
--where rnum <=3;
-- from 다음에 whereㄱ ㅏ동작하는데 from 테이블에서는
-- rnum제공하지 않음

-- 서브쿼리를 사용하여
-- 또 다른 select가 어디든 들어갈 수 있다.
select *
from(select rownum as rnum, ename, sal 
from(select ename, sal from emp
    where deptno = 30
    order by sal desc))
where rnum <=5;

-- join 
select * from emp;

select * from dept;

-- 모든 테이블을 도출
-- 테이블 2개부터 1개 이상의 조건이 꼭 필요
-- 컬럼의 명칭을 축약, ename -> e/deptno->d
select ename, e.deptno, d.dname
from emp e,dept d
where e.deptno = d.deptno
order by ename;

-- select 로 emp 
select * from emp e1, emp e2
where e1.mgr = e2.empno;

select *
from emp e1
left outer join emp2 e2 on(e1.mgr = e2.empno);

-- ****************** 매우 중요 ********************
-- left outer join
-- 교집합 부분도 제외할 수 있는가? -- 공부하기.
-- 댓글 트리 구조 무한정 생성 가능 tree구조로 깊이를 구축 가능
-- 댓글 1개 ~ 댓글 무한 루프 가능 : 재귀호출 사용함
-- 추가 ++ e1.job / e2.job / e3.job 추가함
-- ** 두 개 또는 그 이상의 테이블에서 공통된 컬럼이 존재할 때, 그 값을 출력할 때 사용.
select e1.empno, e1.ename, e1.job, e2.empno, e2.ename, e2.job, e3.empno, e3.ename, e3.job
from emp e1
left outer join emp2 e2 on(e1.mgr = e2.empno)
left outer join emp e3 on(e2.mgr = e3.empno)
--left outer join emp e1 on(e1.job = e2.job) -- emp에서 e2.job 출력 -- 행이 증가함
--left outer join emp e3 on(e2.job = e3.job)  -- emp에서 e3.job 출력  -- 행이 증가함
where e1.empno = 7654;


-- scott의 mgr 출력하기
select e1.empno, e1.ename, e1.job, e2.empno, e2.ename, e2.job, e3.empno, e3.ename, e3.job
from emp e1
left outer join emp2 e2 on(e1.mgr = e2.empno)
left outer join emp e3 on(e2.mgr = e3.empno)
--left outer join emp e1 on(e1.job = e2.job) -- emp에서 e2.job 출력 -- 행이 증가함
--left outer join emp e3 on(e2.job = e3.job)  -- emp에서 e3.job 출력  -- 행이 증가함
where e1.empno = 7788;


-- 재귀호출
--with as lower select * from emp where sal < 2000;

-- insert
insert into 테이블명(컬럼명,컬럼명)
values(1,'이름')


-- update, delete
-- ** where 필수!!!! **, select 에서 테스트해 보기
-- select에서 검증된 where를 복사해서 붙여넣기
update 테이블 명
set 컬럼명 = 값, 컬럼 = 값
where deptno =20

-- where 필수
delete from 테이블명
where deptno =20
-- ****************** DML 언어 끝!!!! *******************




-- ****************** DDl 언어 시작 !!*******************
create table emp3
(
-- 숫자 , 가변 글자, 글자, 날짜   
    number(자릿 수:10), varchar2(100), text(100), date
    join_date date default sysdate 
    emp3_id number primary key, 
    primary key (id, name)
)

-- 제약조건을 주는 것이다.
1. primary key
2. foreign key : 다른 테이블에 있는 키를 사용
3. not null 
4. default

select sysdate from dual;

-- 테이블 수정
alter table emp2
-- 컬럼 추가
add join_date date default sysdate
-- 컬럼 수정
modify join_date varchar()
-- 컬럼 삭제
drop column join_date


-- 테이블 삭제
drop table emp2

-- 테이블 내용만 전체 삭제
delete from emp2 -- DML : rallback 가능
TRUNCATE emp2    -- DDL : 삭제 속도 빠름

-- sequence 
create sequence seq_emp_cks
start with 10000;   -- 생략 가능:1부터 시작함

select seq_emp_cks.nextval from dual;

-- 생성 후에 nextval이 최소 한 번은 호출해야 생성 가능함
select seq_emp_cks.currval from dual; 

insert into emp(empno, ename)
values(seq_emp_cks.nextval, '조경선');

-- ****************** index 매우 중요 !!! ************************
-- index : 미리정렬 / 색인이다.
-- where 나 order by에서 활용
create index idx_emp
on emp(empno desc);

-- plan : index를 사용하고 있는 지, 확인한다. 
-- 실행계획까지 확인 가능
select * from emp
order by empno;

-- DB 구조를 알면 서비스를 만들 수 있다.
-- 프로시저
-- 트리거 

-- 제 1정규화 : 반복되는 내용을 테이블로 쪼개는 작업, 기본키를 지정한다.
-- 데이터의 일관성 및 데이터 중복 최소화
-- 중복 데이터가 사라지는 장점이 있다. 쪼개진 테이블들을 join하여 합집합으로 합칠 수 있다.
-- 제 2정규화 : 기본키가 2개 이상 생성될 경우
-- 제3 정규화 : 이행종속 제거
-- 반 정규화 : 자주 사용하는 다량의 데잍어를 사용하기 편하도록 설정

/*
[설문지]
설문지id PK
관리용 이름 
상세설명

[질문]
질문id
설문지id
질문
타입

[답변]
답변id
질문id
응답내용
회원 id
*/

-- 0503 Ex13
drop table myuser;
create table myuser (
    id varchar2(10),
    name varchar2(10)
);

-- 샘플 데이터 추가
insert into myuser values('test1', '홍길동');
insert into myuser values('test2', '박길동');
insert into myuser values('test3', '김길동');

select * from myuser;


-- 0503 Ex14
drop table simple_bbs;

create table simple_bbs(
    id number(4) primary key,
    writer varchar2(100),
    title varchar2(100),
    content varchar2(100)
);

drop sequence simple_bbs_seq;
create sequence simple_bbs_seq;


select * from simple_bbs;


-- commit
select * from tab;