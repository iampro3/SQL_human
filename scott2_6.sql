-- 0607 scott2_6연결
SELECT * 
FROM EMP;

-- test
select * from emp2;

select * from emp2
where sal > 3000;

delete from emp2
where sal >3000;

truncate emp2;

SELECT * 
FROM EMP_2;

CREATE TABLE myuser (
    id varchar2(10) PRIMARY KEY,
    name varchar2(10) NOT NULL    
)
INSERT INTO myuser (id, name)
VALUES ('test1,'홍길동1');

INSERT INTO myuser (id, name)
VALUES ('test2,'홍길동2');

INSERT INTO myuser (id, name)
VALUES ('test3,'홍길동3');

SELECT * FROM myuser
