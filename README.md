# SQL_human


★ HR 계정 생성

[SQL]
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE USER HR IDENTIFIED BY 123456;
ALTER USER HR QUOTA UNLIMITED ON users;
GRANT DBA TO HR;

★ HR 샘플 데이터 가져오기 

[SQL PLUS]
@?/demo/schema/human_resources/hr_main.sql
--> 1  : 123456 [비빌번호]                                  // HR 계정 비밀번호
--> 2  : users [tablespace]             
--> 3  : temp [temp tablespace]
--> 4  : [log 경로] - C:\~\db_home\demo\schema\log          // 샘플 데이터 가져올 때, 로그파일 저장하 경로



**human 계정 생성 및 덤프파일 가져오기**
★ human 계정 생성하기
[SQL]
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE USER human IDENTIFIED BY 123456;
ALTER USER human QUOTA UNLIMITED ON users;
GRANT DBA TO human;
★ human 계정 에 community.dmp 가져오기
[CMD]
imp userid=system/123456 file='경로\community.dmp' fromuser=human touser=human



human2 계정 생성 및 덤프파일 가져오기
★ human2 계정 생성하기
[SQL]
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE USER human2 IDENTIFIED BY 123456;
ALTER USER human2 QUOTA UNLIMITED ON users;
GRANT DBA TO human2;
★ human2 계정 에 human.dmp 가져오기
[CMD]
imp userid=system/123456 file='경로\human.dmp' fromuser=human touser=human2



계정 삭제하기
[system 계정 접속]
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
REVOKE DBA from 계정명;    -- DBA 권한 있을 시 삭제 안되므로, 권한 제거
DROP USER 계정명;



CMD 창에서 덤프 명령어 사용
덤프파일 가져오기
[CMD]
imp userid=system/123456 file='경로\덤프파일명.dmp' fromuser=덤프파일소유자명 touser=가져올계정명
덤프파일 내보내기
[CMD]
exp userid=system/123456 file='경로\덤프파일명.dmp' log='경로\로그파일명.log'
