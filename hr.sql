-- HR 계정 생성하기
-- 11g 버전 이하는 어떤 이름으로도 계정생성 가능
-- 12c 버전 이상에서는 'C##' 접두어를 붙여서 생성하도록 규칙을 정함

-- C## 없이 계정 생성
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
-- CREATE USER 계정명 IDENTIFIED BY 비밀번호;
CREATE USER HR IDENTIFIED BY "1234567";
-- 계정이 사용할 수 있는 용량 설정(무한대)
ALTER USER HR QUOTA UNLIMITED ON users;
-- 계정에 권한 부여
GRANT connect, resource TO HR;

-- HR 계정이 잠겨있는 경우 : 대부분 비밀번호 오류
-- HR 계정 잠금 해제
ALTER USER HR ACCOUNT UNLOCK;

-- 계정 삭제
DROP USER HR CASCADE;

-----------------------
-- hr_main.sql 실행하여 HR 샘플 데이터 가져요기
-- 1. sql plus
-- 2.hr 계정으로 접속
-- 3.명령어 입력 : @[경로]\hr_main.sql
--    @? : 오라클 설치된 기본 경로
-- @?/demo/schema/human_resources/hr_main.sql → sql plus 에 붙여넣기
-- 1: 123456[비밀번호]
-- 2 users [tablespace]
-- 3 temp [temp tablespace]
-- 4 [log 경로]
-- C:\KS\WINDOWS.X64_193000_db_home\demo\schema\log
-------------------

-- 2. 테이블 EMPLOYEES의 테이블 구조를 조회하는 SQL문을 작성하시오
-- 테이블 : 행과 열로 데이터를 관리하는 기본구조
-- 행 =row = 레코드 : 각 속성에 대한 하나의 데이터를 의미
-- 열 = column = 속성 : 데이터의 이름(특성)을 정의
DESC employees;
-- yes -> null 가능 / no -> null 불가능

-- 3.
-- 테이블 EMPLOYEES 에서 EMPLOYEES_ID, FIRST_NAME(회원번호 이름)을
-- 조회하는 SQL문을 작성하라
SELECT employee_id, first_name
FROM employees;


-- 4
-- AS (alias) : 출력되니느 컬럼명에 별명을 짓는명령어
SELECT employees_id AS "사원번호" -- 의어쓰기가 있으면 "로 표기
	,first_name AS 이름
	,last_name AS 성
	,email AS 이메일
	,phone_number AS 전화번호
	,hire_date AS 입사일자
	,salary AS 급여
FROM employees;

-- 5
-- 테이블EMPLOYEES 의 JOB_ID 를 중복된 데이터를 제거하고
-- 조회하는 SQL문을 작성하시오.

SELECT DISTINCT job_id
FROM employees;

SELECT job_id
FROM employees;

-- 6. 테이블  EMPLOYEES의 SALARY가 6000을 초과하는
-- 사원의 모든 컬럼을 조회하는 SQL문을 작성하시오.
-- 2차 실무 면접 - 코딩 - 게시판 프로그램을 구현해라. SQL 데이터베이스 문제풀이 등
SELECT *
FROM employees
WHERE salary > 6000;

-- 7. 테이블 EMPLOYEES의 SALARY(급여)가 10000인
-- 사원의 모든 컬럼을 조회하는 SQL문을 작성하시오.
SELECT *
FROM employees
WHERE salary = 10000;

-- 8. 테이블 EMPLOYEES의 모든 속성들을
-- SALARY를 기분으로 내림차순으로 정렬
-- FIRST_NAME 를 기준으로 오름차순 정렬하여 조회하는 SQL문을 작성하시오

-- 정렬 명령어
-- ORDER BY 컬럼명 [ASC/DESC]
-- * ASC : 오름차순 : 낮은->높은
-- * DESC : 내림차순
-- * (생략) : 오름차순이 기본값
SELECT *
FROM employees
ORDER BY salary DESC, first_name ASC;

-- 9. 
-- 테이블 EMPLOYEES의 JOB_ID가 'FI_ACCOUNT' 이거나 'IT_PROG' 인
-- 사원의 모든 컬럼으 ㄹ조회하는 SQL문을 작성하시오
-- 조건연산
-- OR 연산 : ~ 또는 ~이거나
-- WHERE A OR B;
SELECT *
FROM employees
WHERE job_id = 'FI_ACCOUNT' OR job_id = 'IT_PROG';


-- 10.

-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
-- 단, IN 키워드를 사용하시오
SELECT *
FROM employees
WHERE job_id IN('FI_ACCOUNT', 'IT_PROG');

-- 11.
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오
-- 단, IN 키워드를 사용하시오
SELECT *
FROM employees
WHERE job_id NOT IN('FI_ACCOUNT', 'IT_PROG');

-- 12.
-- 테이블 EMPLOEES의 JOB_ID 가 'IT_PROG' 이면서 'IT_PROG' 이면서 salary가 6000이상인
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE job_id = 'IT_PROG' AND salary >= 6000;


-- 13. 테이블 emploees의 first_NAME이 's'로 시작하는
-- 사원의 모든 컬럼으 ㄹ조회하는SQL 문을 작성하시오.
-- LIKE
-- 대체 문자를 통해서 형식에 맞는 문자열 데이터를 조회
-- - 대체문자
-- *%: 여러글자 대체
-- *_:한 글자 대체

SELECT * FROM employees WHERE first_name LIKE 's%';

-- 14. 테이블 EMPLOEES 의 FIRST_NAME 이'S'로 끝나는 사원 조회
SELECT * FROM employees WHERE first_name LIKE '%S%';

-- 15.테이블 EMPLOEES의 FIRST_NAME에's'가 포함되는 사원 조회
SELECT * FROM employees WHERE first_name LIKE '%s%';

-- 16.
-- 테이블 EMPLOEES의 FIRST_NAME이 5글자인
-- 사원의 모든 컬럼으 ㄹ조회하는 SQL문을 작성하시오
SELECT * FROM employees WHERE first_name LIKE '_____';


-- LENGTH(컬럼명):글자수를 반환하는 함수
SELECT * FROM employees WHERE LENGTH(first_name) = 5;

-- 17.
-- 테이블 EMPLOEES의 COMMISION_PCT 가 NULL인 
-- 사원의 모든 컬럼을 조회하는 sql 문을 작성하시오

SELECT *
FROM employees
WHERE commission_pct IS NULL;

-- 18. 
-- 테이블 EMPLOEES의 COMMISION_PCT 가 NULL 이 아닌
-- 사원의 모든 컬럼을 조회하는 sql 문을 작성하시오

SELECT *
FROM employees
WHERE commission_pct IS NOT NULL;


-- 19.
-- 테이블 EMPLOEES의 사원의 HIRE_DATE 가 04년 이상인
-- 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT employees
FROM employees
WHERE hire_date >= '04/01/01';

-- 20.
-- 테이블 EMPLOEES의 사원의 HIRE_DATE가 04녀노부터 05년도인
-- 모든 컬럼을 조회하는 SQL 문을 작성하시오.

SELECT employees
FROM employees
WHERE hire_date >= '04/01/01';
AND hire_date <= '05/12/31';

SELECT *
FROM employees
WHERE hire_date BETWEEN '04/01/01' AND '05/12/31';


-- 21. : 12, -13
-- 12.45, -12.45 보다 크거나 같은 정수중 제일 작은 ㅇ수를
-- 계산하는 sql문을 각각 작성하시오
-- * dual?
-- :산술연산, 함수 결과 등을 확인해볼수 있는 임시테이믈
-- CEIL() : 천장, 큰 수를 의미
-- 지정한 값보다 크거나 같은 정수 중 제일 작승ㄴ 수를 반환하는 함수
SELECT CEIL(12.45) FROM dual;
SELECT CEIL(-12.45) FROM dual;
SELECT CEIL(12.45), CEIL(-12.45) FROM dual;

-- 22.12 -13
-- 12.55와 -12.55보다 작거나 같은 정수 중 가장 큰 수를
-- 걔산하는 SQL문을 각각 작성하시오.
-- FLOOR() "바닥"
-- 지정한 값보다 작거나 같은 정수 중 가장 큰 수를 반환하는 함수
SELECT FLOOR(12.55) FROM dual;
SELECT FLOOR(-12.55) FROM dual;
SELECT FLOOR(12.55), FLOOR(-12.55) FROM dual;


-- 23. 
-- ROUND (값, 반올림할 자릿수)
-- : 지정한 값을, 해당 자리수에서 반올림하는 함수
-- a a a a a.bbbbb
--   ..-2   -1.01234

-- 0.54를 소수점 아래 첫째 자리에서 반올림하시오--
SELECT ROUND(0.54, 0) FROM dual;
-- 0.54를 소수점 아래 둘째 자리에서 반올림하시오
SELECT ROUND(0.54, 1) FROM dual;
-- 125.67을 일의 자리에서 반올림하시오
SELECT ROUND(125.67,-1) FROM dual;
-- 125.67을 십의 자리에서 반올림하시오.
SELECT ROUND(125.67, -2) FROM dual;

-- 24.각 소문자에 제시된 두 쑤를 이용하여 나머지를 구하는 sql 문을 작성핫이ㅗ.
-- MOD(A,B)
-- A를 B로 나눈 나머지를 구하는 함수

-- 3을 0으로 나눈 나머지
SELECT MOD (3,8) FROM dual;

-- 3을 4로 나눈 나머지
SELECT MOD(30,4) FROM dual;

-- 25.제곱수 구하기
-- POWER(A,B)
-- A의 B 제곱을 구하는 함수
-- 2의 10 제곰을 구하시오
SELECT POWER(2,10) FROM dual;
-- 2의 31 제곱을 구하시오
SELECT POWER(2,310) FROM dual;

-- 26. 제곱근 구하기
-- SQRT(A)
-- :A의 B 제곱근을 구하는 함수
-- 2의 제곱근을 구하시오
SELECT SQRT(2) FROM dual;

-- 100의 제곱근을 구하시오.
SELECT SQRT(100) FROM dual;


--27.소수점을절삭하기
-- TRUNC(A,B)
-- 값 A를 자리수 B에서 절삭하는 함수

-- 527425.1234 소수점 아래 첫쨰 자리에서 절삭
SELECT TRUNC(527425.1234, 0) FROM dual;

-- 527425.1234 소수점 아래 둘째 자리에서 절삭
SELECT TRUNC(527425.1234, 1) FROM dual;

-- 527425.1234 일의 자리에서 절삭
SELECT TRUNC(527425.1234, -1) FROM dual;

-- 527425.1234 소수점 아래 둘째 자리에서 절삭
SELECT TRUNC(527425.1234, -2) FROM dual;

-- 28.
-- 절댓값 구하기
-- ABS(A)
-- 값 A의 ㅓㅈㄹ댓값을 구하여 반환하는 함수

-- -20 의 절댓값 구하기 : 20
SELECT ABS(-20) FROM dual;

-- -12.456의 절댓값 구하기 : 12.456
SELECT ABS(-12.456) FROM dual;

-- 29.
-- 문자열 대소문자 변환함수
SELECT 'ALOHA WORLD' AS 원문
	,UPPER('ALOHA WORLD') AS 대문자
	,LOWER('ALOHA WORLD') AS 소문자
	,INITCAP('ALOHA WORLD') AS "첫글자만 대문자"
FROM dual;

-- 30.
-- 글자수와 바이트 수를 구하는 함수
-- 영문, 숫자, 빈칸 : 1 byte
-- 한글,    	    : 3 byte
SELECT LENGTH('ALOHA WORLD') AS "글자 수"
	 ,LENGTHb('ALOHA WORLD') AS "글자 수"
FROM dual;

SELECT LENGTH('알로하 월드') AS "글자 수"
	 ,LENGTHB('알로하 월드') AS "바이트 수"
FROM dual;


-- 31.: ALOHAWORLD
-- 두 문자열을 연결하기
SELECT CONCAT('ALOHA', 'WORLD') AS "함수"
	 ,'ALOHA' || 'WORLD' AS "기호"
FROM dual;


-- 32
-- 문자열 부분 출력함수
-- SUBSTR(문자열, 시작번호, 글자수)
-- 'WWW.ALOHACAMPUS.COM'
SELECT SUBSTR('WWW.ALOHACAMPUS.COM', 1,3) AS "1"
	,SUBSTR('WWW.ALOHACAMPUS.COM', 5,11) AS "2"
	,SUBSTR('WWW.ALOHACAMPUS.COM', -3,3) AS "3"
FROM dual;

SELECT SUBSTRB('WWW.ALOHACAMPUS.COM', 1,3) AS "1"
	,SUBSTRB('WWW.ALOHACAMPUS.COM', 5,11) AS "2"
	,SUBSTRB('WWW.ALOHACAMPUS.COM', -3,3) AS "3"
FROM dual;


-- "WWW.알로하캠퍼스.com"
-- SUBSTR, SUBSTRB 함수로 각각, 구분기호 나눠 출력하기.
SELECT SUBSTR('WWW.알로하캠퍼스.com', 1,3) AS "1"
	,SUBSTR('WWW.알로하캠퍼스.com', 5,6) AS "2"
	,SUBSTR('WWW.알로하캠퍼스.com', -3,3) AS "3"
FROM dual;


SELECT SUBSTRB('WWW.알로하캠퍼스.com', 1,3) AS "1"
	,SUBSTRB('WWW.알로하캠퍼스.com', 5,18) AS "2"
	,SUBSTRB('WWW.알로하캠퍼스.com', -3,3) AS "3"
FROM dual;


-- 33. 1,5,7
-- 문자열에서 특정 문자의 위치를 구하는 함수
-- INSTR (문자열, 찾을 문자, 시작번호, 순서)
-- EX) 'ALOHACAMPUS'
-- 해당 문자열에서 첫글자부터 찾아서, 2번째 A의 위치를 구하시오
-- INSTR('ALOHACAMPUS', 'A' ,1,2)

SELECT INSTR('ALOHACAMPUS', 'A', 1,1) AS "1번째 A"
	,INSTR('ALOHACAMPUS', 'A', 1,2) AS "2번째 A"
	,INSTR('ALOHACAMPUS', 'A', 1,3) AS "3번째 A"
FROM dual;

-- 34. 문자열을 왼쪽.오른쪽에 출력하고 빈 공간을 특정 문자로 함수
-- load (문자열, 칸의 수, 채울 문자)
-- :문자열에 지정한 칸을 확보하고, 왼쪽에 지정한 특정 문자로 채움

-- LAPD(문자열, 칸의 수, 채울 문자)
-- 문자열에 지정한 칸을 확보하고 오른쪽에 특정 문자로 채움

SELECT LPAD('ALOHACAMPUS', 20,'#') AS "왼쪽"
	,RPAD('ALOHACAMPUS', 20,'#') AS "오른쪽"
FROM dual;


-- TO_CHAR(데이터, '날짜/숫자 형식')
-- :특정 데이터를 문자열 형식으로 변환하는 함수
SELECT first_name AS 이름
	,TO_CHAR(hire_date, 'yyyy-mm-dd (dy) HH:MI:SS') AS 입사일자
FROM employees;

-- 36.
-- SALARY 급여를 통화형식을 지정하여 출력하시오
SELECT first_name AS 이름
	,TO_CHAR(salary, '$999,999,999.00') AS 급여
FROM employees;

-- 37.
-- TO_DATE(데이터)
-- 문자형 데이터를 날짜형 데이터로 변환하는 함수

SELECT 20230228 AS 문자
	, TO_DATE(20230228) AS 문자
FROM employees; 

-- 38. 
-- TO_NUMBER(데이터)
-- 문자형 데이터를 숫자형 데이터로 변환하는 함수
SELECT '1,200,000' AS 문자
	,TO_NUMBER('1,200,000', '999,999,999') AS 숫자
FROM dual;

-- 39.어제 오늘 내일 날짜를 출력하시오.
-- sysdate : 현재 날짜/ 시간 정보를 가지고 있는 키워드
-- 2023/02/02 - YYYY/MM/DD 형식으로 출력
-- 날짜 데이터
SELECT sysdate FROM dual;

SELECT TO_CHAR( sysdate-1, 'YYYY/MM/DD') AS 어제
,TO_CHAR( sysdate, 'YYYY/MM/DD') AS 오늘
,TO_CHAR( sysdate+1, 'YYYY/MM/DD') AS 내일
FROM dual;

-- 40.
-- 사원의 근무달수/근속연수 구하라
-- A날짜, B 날짜 사이의 개월수를 구하는 함수
-- MONTHS_BETWEEN(A,B)
-- (단, A > B 즉, A가 더 최근 날짜로 지정해야 양수로 반환)
SELECT first_name 이름
,TO_CHAR(hire_date, 'YYYY.MM.DD') 입사일자
,TO_CHAR(sysdate, 'YYYY.MM.DD') 오늘
,TRUNC(MONTHS_BETWEEN(sysdate, hire_date)) || '개월' 근무달수
,TRUNC(MONTHS_BETWEEN(sysdate, hire_date) /12) || '년' 근무연수
FROM employees;
-- 41.오늘로부터 6개월 후의 날짜를 구하시오
-- AND_MONTHS(날짜, 추가할 개월 수)
-- : 지정한 날짜로부터 개월수를 후의 날짜를 반환하는 함수
SELECT sysdate 오늘
,ADD_MONTHS(sysdate, 6) "6개월후"
FROM dual;
-- 42.
-- 오늘이후 돌아오는 토요일을 구하라
-- NEXT_DAY(날짜, 요일)
-- 지정한 날짜 이후 돌아오는 요일을 반환하는 함수
-- 일요일 월 화 수 목 금 토
1 2 3 4 5 6 7
SELECT sysdate 오늘
,NEXT_DAY(sysdate, 7) "다음 토요일"
FROM dual;

SELECT '2023/02/27' "DB1일차"
,NEXT_DAY(sysdate, 1) "다음 일요일"
,NEXT_DAY(sysdate, 2) "다음 월요일"
,NEXT_DAY(sysdate, 3) "다음 화요일"
,NEXT_DAY(sysdate, 4) "다음 수요일"
,NEXT_DAY(sysdate, 5) "다음 목요일"
,NEXT_DAY(sysdate, 6) "다음 금요일"
,NEXT_DAY(sysdate, 7) "다음 토요일"
FROM dual;

-- 43.
-- 오늘 날짜와 해당 월의 월초,월말 일자를 구하라
-- LAST_DAY(날짜)
-- 지정한 날짜와 동일한 월의 월말 일자를 반환하는 함수
-- 날짜 : xxxxxxxx.yyyyyyy
-- 1970년 01월01일 00시00분00초00ms - > 2023년3월02일....
-- 몇 일이 지났는지 지난 일자를 정수로 계산, 시간정보는 소수부분으로 계산
-- xxxxx.yyyyy -->2023년 3월 20일
-- 월 단위 아래로 절삭하면, 월초를 구할 수있다.
SELECT TRUNC(sysdate, 'MM') 월초
,sysdate 오늘
,LAST_DAY(sysdate) 월말
FROM dual;

SELECT TRUNC(TO_DATE('2023/04/20'), 'MM') 월초
,TO_DATE('2023/04/20') 오늘
,LAST_DAY(TO_DATE('2023/04/20')) 월말
FROM dual;

SELECT TO_CHAR(TRUNC(TO_DATE('2023/04/20'), 'MM') 'YY/MM')월초
,TO_DATE('2023/04/20') 오늘
,LAST_DAY(TO_DATE('2023/04/20')) 월말
FROM dual;

-- 44.
-- 테이블 employees의 커미션 pct를 중복없이 검색
-- null 이면 0으로 조회, 내림차순 정렬
-- DISTINCT : 중복없이 검색
-- NVL : (컬럼값, 대체값):해당 값이 null 이면 지정된 값으로 변환하는 함수
-- NULL - 0으로 조회,
-- NVL(c_pct, 0) ㅣ null 이 0일 경우
-- 내림차순 정렬 : ORDER BY c_pct DESC
SELECT DISTINCT NVL(commission_pct, 0)"커미션(%)"
FROM employees
ORDER BY NVL(commission_pct, 0) DESC
;

SELECT DISTINCT NVL(commission_pct, 0)"커미션(%)"
FROM employees
ORDER BY "커미션(%)" DESC
;
-- 조회한 컬럼의 별칭"NVL(commission_pct, 0)" 으로 ORDER BY 절에서 사용할 수 있다.

-- NULL이 상단에 항상 출력됨
SELECT DISTINCT commission_pct
FROM employees
ORDER BY commission_pct DESC
;
-- 45.
-- 급여+(급여X 커미션)=최종 급여를 조회하라 / 최종 급여 :DESC 정렬
-- FIRST_NAME, SALARY, COMMISSION_PCT
-- NVL2(값, NULL이 아닐때, NULL일 때 값)
SELECT first_name 이름
,last_name
,salary 급여
,NVL(commission_pct,0) 커미션
,NVL2(commission_pct, salary+(salary*commission_pct), salary) 최종급여 --(COM~., NULL이 아닐때, NULL일떄)
FROM employees
ORDER BY 최종급여 DESC
;
-- 46.
-- EMPLOYEES 의 테이블 참조하여, 사원명, 부서명 출력
-- FIRST_NAME DEPARTMENNT_ID 속성 이용하여 SQL문 작성
-- 정규화
-- DECODE(컬럼명, 조건값1, 반환값1, 조건값2, 반환값2,.....)
-- 지정한 컬럼의값이 조건값에 일치하면 바로 뒤의반환값을 출력하는하무
SELECT first_name 이름
,DECODE( department_id, 10, 'Administration',
20, 'Marketing',
30, 'Purchasing',
40, 'HUMAN RESOURCES',
50, 'Shipping'
) 부서
FROM employees;

SELECT * FROM departments;

-- 47.
-- case문
-- 조건식을 만족할 떄, 출력할 값을지정하는 구문
/* CASE
WHEN 조건식 1 THEN 반환값1
WHEN 조건식 2 THEN 반환값2
WHEN 조건식 3 THEN 반환값3
END
*/
SELECT first_name 이름
,CASE WHEN department_id = 10 THEN 'Administration'
WHEN department_id = 20 THEN 'Marketing'
WHEN department_id = 30 THEN 'Purchasing'
WHEN department_id = 40 THEN 'HUMAN RESOURCES'
WHEN department_id = 50 THEN 'Shipping'
WHEN department_id = 60 THEN 'IT'
WHEN department_id = 80 THEN 'Sales'
END 부서
FROM employees;
 
-- 48.
-- SELECT columnname
-- FROM tablename
-- WHERE condition
-- GROUP BY columnname
-- HAVING condition
-- EMPLOYEES 테이블에서 전체 사원수 조회
-- COUNT(first_name) column name 입력: 컬럼 지정하여 null 제외한 데이터 개수를반환
-- null이 없는 데이터라면 어떤 컬럼을 지정하더라도 개수가 같으므로,
-- count(*)개수를 구함
SELECT COUNT(commission_pct) 사원수 --count(*) *에 인자를 입력가능:first_name
FROM employees;

-- 49.
-- 최고/최저급여
-- MAX/MIN 값
SELECT MAX(salary) 최고급여
,MIN(salary) 최저급여
FROM employees;
-- 50.
-- 합계 평균
-- 사원들의 합계와 급여를 구하시오.
-- SELECT JOB, TO_CHAR(avg(salary),'999,999,999.99') AS avg_salary
-- FROM employees
-- GROUP BY JOB_ID
-- ORDER BY avg(salary) DESC;
-- ROUND - 소수점 자릿수 절삭 : 2 2자릿수까지 ROUND(AVG(salary),2)
SELECT SUM(salary) 급여합계
,ROUND(AVG(salary),2) 급여평균
FROM employees;
-- 51.사원들의 급여 표준편차와 분산을 출력
SELECT ROUND(STDDEV(salary),4)급여표준편차
,ROUND(VARIANCE(salary),2)급여분산
FROM employees;
-- 52. ms_student 테이블을 생성하라
-- table 기술서 참고
-- CTRL + SHIFT + D
/* 테이블 생성
CREATE TABLE 테이블명(
컬럼명 1 타입[NOT NULL.NULL][제약조건],
컬럼명 2 타입[NOT NULL.NULL][제약조건],
컬럼명 3 타입[NOT NULL.NULL][제약조건],
);
*/

-- 51.

INSERT INTO MS_STUDENT( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,MJ_NO,GENDER,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ('20180001','최서아','991005','csa@univ.ac.kr', '서울', 'I01', '여','재학','2018/03/01', NULL, sysdate, sysdate, NULL);

INSERT INTO MS_STUDENT( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,MJ_NO,GENDER,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ('201210001','박서준','020504','csa@univ.ac.kr', '서울', 'B02', '남','재학','2020/03/01', NULL, sysdate, sysdate, NULL);

INSERT INTO MS_STUDENT( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,MJ_NO,GENDER,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ('20120002','김아윤','020724','psj@univ.ac.kr', '인천', 'S01', '여','재학','2021/03/01', NULL, sysdate, sysdate, NULL);

INSERT INTO MS_STUDENT( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,MJ_NO,GENDER,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ('20160001','정수안','970210','kay@univ.ac.kr', '경남', 'J02', '여','재학','2016/03/01', NULL, sysdate, sysdate, NULL);

INSERT INTO MS_STUDENT( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,MJ_NO,GENDER,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ('20150010','윤도현','960311','jsa@univ.ac.kr', '제주', 'K01', '남','재학','2015/03/01', NULL, sysdate, sysdate, NULL);

INSERT INTO MS_STUDENT( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,MJ_NO,GENDER,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ('20130007','안아람','941124','ydh@univ.ac.kr', '경기', 'Y01', '여','재학','2013/03/01', NULL, sysdate, sysdate, '영상예술특기자');

INSERT INTO MS_STUDENT( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,MJ_NO,GENDER,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ('20110002','한성호','921007','hsh@univ.ac.kr', '서울', 'E03', '기타','재학','2011/03/01', NULL, sysdate, sysdate, NULL);
COMMIT;

UPDATE MS_STUDENT
SET MJ_NO = 'I01,B02';


SELECT * FROM ms_student;

COMMIT;


CREATE TABLE MS_STUDENT 
(
  ST_NO NUMBER NOT NULL 
, NAME VARCHAR2(20 BYTE) NOT NULL 
/* , BIRTH DATE NOT NULL  */
, EMAIL VARCHAR2(100 BYTE) NOT NULL 
, ADDRESS VARCHAR2(1000 BYTE) 
, MJ_NO VARCHAR2(10 BYTE) NOT NULL 
, GENDER CHAR(6 BYTE) DEFAULT '기타' NOT NULL 
, STATUS VARCHAR2(10 BYTE) DEFAULT '대기' NOT NULL 
, ADM_DATE DATE 
, GRD_DATE DATE 
, REG_DATE DATE DEFAULT SYSDATE NOT NULL 
, UPD_DATE DATE DEFAULT SYSDATE NOT NULL 
, ETC VARCHAR2(1000 BYTE) DEFAULT '없음' 
, CONSTRAINT MS_STUDENT_PK PRIMARY KEY 
  (
    ST_NO 
  )
  USING INDEX 
  (
      CREATE UNIQUE INDEX MS_STUDENT_PK ON MS_STUDENT (ST_NO ASC) 
      LOGGING 
      TABLESPACE USERS 
      PCTFREE 10 
      INITRANS 2 
      STORAGE 
      ( 
        INITIAL 65536 
        NEXT 1048576 
        MINEXTENTS 1 
        MAXEXTENTS UNLIMITED 
        BUFFER_POOL DEFAULT 
      ) 
      NOPARALLEL 
  )
  ENABLE 
) 
LOGGING 
TABLESPACE USERS 
PCTFREE 10 
INITRANS 1 
STORAGE 
( 
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1 
  MAXEXTENTS UNLIMITED 
  BUFFER_POOL DEFAULT 
) 
NOCOMPRESS 
NO INMEMORY 
NOPARALLEL;

ALTER TABLE MS_STUDENT
ADD CONSTRAINT MS_STUDENT_UK1 UNIQUE 
(
  EMAIL 
)
USING INDEX 
(
    CREATE UNIQUE INDEX MS_STUDENT_UK1 ON MS_STUDENT (EMAIL ASC) 
    LOGGING 
    TABLESPACE USERS 
    PCTFREE 10 
    INITRANS 2 
    STORAGE 
    ( 
      INITIAL 65536 
      NEXT 1048576 
      MINEXTENTS 1 
      MAXEXTENTS UNLIMITED 
      BUFFER_POOL DEFAULT 
    ) 
    NOPARALLEL 
)
 ENABLE;

COMMENT ON TABLE MS_STUDENT IS '학생들의 정보를 관리한다.';

COMMENT ON COLUMN MS_STUDENT.ST_NO IS '학생번호';

COMMENT ON COLUMN MS_STUDENT.NAME IS '이름';

COMMENT ON COLUMN MS_STUDENT.BIRTH IS '생년월일';

COMMENT ON COLUMN MS_STUDENT.EMAIL IS '이메일';

COMMENT ON COLUMN MS_STUDENT.ADDRESS IS '주소';

COMMENT ON COLUMN MS_STUDENT.MJ_NO IS '전공번호';

COMMENT ON COLUMN MS_STUDENT.GENDER IS '성별';

COMMENT ON COLUMN MS_STUDENT.STATUS IS '재적';

COMMENT ON COLUMN MS_STUDENT.ADM_DATE IS '입학일자';

COMMENT ON COLUMN MS_STUDENT.GRD_DATE IS '졸업일자';

COMMENT ON COLUMN MS_STUDENT.REG_DATE IS '등록일자';

COMMENT ON COLUMN MS_STUDENT.UPD_DATE IS '수정일자';

COMMENT ON COLUMN MS_STUDENT.ETC IS '특이사항';

-- 56 MS_STUDENT 테이블 삭제하기
DROP TABLE MS_STUDENT;


-- 57.
-- 0302일 학원에서 마지막에 데이터 추가한 내용,-선생님이 채팅창으로 오후에 보내줌
-- 0303일 VS CODE에서 접속하면서 다시 보내준 데이터 파일이다.
INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20180001', '최서아', '991005', 'csa@univ.ac.kr', '서울', '여', 'I01', '재학', '2018/03/01', NULL, sysdate, sysdate, NULL );

SELECT * FROM ms_student;

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20210001', '박서준', '020504', 'psj@univ.ac.kr', '서울', '남', 'B02', '재학', '2021/03/01', NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20210002', '김아윤', '020504', 'kay@univ.ac.kr', '인천', '여', 'S01', '재학', '2021/03/01', NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20160001', '정수안','970210', 'jsa@univ.ac.kr', '경남', '여', 'J02', '재학', '2016/03/01', NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20150010', '윤도현', '960311', 'ydh@univ.ac.kr', '제주', '남', 'K01', '재학', '2015/03/01', NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20130007', '안아람', '941124', 'aar@univ.ac.kr', '경기', '여', 'Y01', '재학', '2013/03/01', NULL, sysdate, sysdate, '영상예술 특기자' );

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20110002', '한성호', '921007', 'hsh@univ.ac.kr', '서울', '기타', 'E03', '재학', '2015/03/01', NULL, sysdate, sysdate, NULL );

COMMIT;

-- 0303 커밋해서 생성된 테이블의 DLL -- 선생님이 채팅창으로 보내줌
-- 57.
CREATE TABLE MS_STUDENT 
(
      ST_NO NUMBER NOT NULL PRIMARY KEY
    , NAME VARCHAR2(20) NOT NULL 
   /*  , BIRTH DATE NOT NULL  */
    , EMAIL VARCHAR2(100) NOT NULL UNIQUE
    , ADDRESS VARCHAR2(1000) 
    , GENDER CHAR(6) DEFAULT '기타' NOT NULL
    , MJ_NO VARCHAR2(10) NOT NULL     
    , STATUS VARCHAR2(10) DEFAULT '대기' NOT NULL
    , ADM_DATE DATE NULL
    , GRD_DATE DATE NULL
    , REG_DATE DATE DEFAULT sysdate NOT NULL 
    , UPD_DATE DATE DEFAULT sysdate NOT NULL 
    , ETC VARCHAR2(1000) DEFAULT '없음' 
   
);

COMMENT ON TABLE MS_STUDENT IS '학생들의 정보를 관리한다.';
COMMENT ON COLUMN MS_STUDENT.ST_NO IS '학생 번호';
COMMENT ON COLUMN MS_STUDENT.NAME IS '이름';
/* COMMENT ON COLUMN MS_STUDENT.BIRTH IS '생년월일'; */
COMMENT ON COLUMN MS_STUDENT.EMAIL IS '이메일';
COMMENT ON COLUMN MS_STUDENT.ADDRESS IS '주소';
COMMENT ON COLUMN MS_STUDENT.GENDER IS '성별';
COMMENT ON COLUMN MS_STUDENT.MJ_NO IS '전공번호';
COMMENT ON COLUMN MS_STUDENT.STATUS IS '재적';
COMMENT ON COLUMN MS_STUDENT.ADM_DATE IS '입학일자';
COMMENT ON COLUMN MS_STUDENT.GRD_DATE IS '졸업일자';
COMMENT ON COLUMN MS_STUDENT.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_STUDENT.UPD_DATE IS '수정일자';
COMMENT ON COLUMN MS_STUDENT.ETC IS '특이사항';


-- 57. 안 된다 테이블 없다고 나온다.- 다시 해 볼 것
-- 0302일 학원에서 마지막에 데이터 추가한 내용,-선생님이 채팅창으로 오후에 보내줌
-- 0303일 VS CODE에서 접속하면서 다시 보내준 데이터 파일이다.
INSERT INTO MS_STUDENT ( ST_NO,NAME,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20180001', '최서아', 'csa@univ.ac.kr', '서울', '여', 'I01', '재학', '2018/03/01', NULL, sysdate, sysdate, NULL );

-- date, month 설정이 안 맞아서 그런다고 함.
-- varchar2를 date로 전환할 때 오류난 다고 함.
/* SELECT TO_DATE('2020-01-01', ''YY-MM-DD)
FROM dual; */

-- 현재 설정 정보 확인 sql문이다 : DD-MON-RR 로 되어 있음
SELECT *
FROM NLS_SESSION_PARAMETERS;

-- 날짜 형식 변경하기
SELECT TO_DATE(날짜컬럼, 'YYYY-MM-DD') FROM MS_STUDENT;

SELECT * FROM ms_student;

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20180001','최서아','991005','csa@univ.ac.kr', '서울', '여', 'I01', '재학', '2018/03/01', NULL, sysdate, sysdate, NULL );

SELECT * FROM ms_student;

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20210001', '박서준', '020504', 'psj@univ.ac.kr', '서울', '남', 'B02', '재학', '2021/03/01', NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20210002', '김아윤', '020504', 'kay@univ.ac.kr', '인천', '여', 'S01', '재학', '2021/03/01', NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20160001', '정수안', '970210', 'jsa@univ.ac.kr', '경남', '여', 'J02', '재학', '2016/03/01', NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20150010', '윤도현', '960311', 'ydh@univ.ac.kr', '제주', '남', 'K01', '재학', '2015/03/01', NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20130007', '안아람', '941124', 'aar@univ.ac.kr', '경기', '여', 'Y01', '재학', '2013/03/01', NULL, sysdate, sysdate, '영상예술 특기자' );

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20110002', '한성호', '921007', 'hsh@univ.ac.kr', '서울', '기타', 'E03', '재학', '2015/03/01', NULL, sysdate, sysdate, NULL );

COMMIT;


-- 57  다시 보내준 내용 받음

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20180001','최서아','991005','csa@univ.ac.kr', '서울', '여', 'I01', '재학', '2018/03/01', NULL, sysdate, sysdate, NULL );

SELECT * FROM ms_student;

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20210001', '박서준', '020504', 'psj@univ.ac.kr', '서울', '남', 'B02', '재학', '2021/03/01', NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20210002', '김아윤', '020504', 'kay@univ.ac.kr', '인천', '여', 'S01', '재학', '2021/03/01', NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20160001', '정수안', '970210', 'jsa@univ.ac.kr', '경남', '여', 'J02', '재학', '2016/03/01', NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20150010', '윤도현', '960311', 'ydh@univ.ac.kr', '제주', '남', 'K01', '재학', '2015/03/01', NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20130007', '안아람', '941124', 'aar@univ.ac.kr', '경기', '여', 'Y01', '재학', '2013/03/01', NULL, sysdate, sysdate, '영상예술 특기자' );

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20110002', '한성호', '921007', 'hsh@univ.ac.kr', '서울', '기타', 'E03', '재학', '2015/03/01', NULL, sysdate, sysdate, NULL );

COMMIT;


-- 60.
-- 

-- 61. ms_student 테이블의 모든 속성을 조회하기
SELECT *
FROM MS_STUDENT;

-- 62.
-- MS_STUDENT 테이블을 조회하라
-- 백업테이블 만들기

CREATE TABLE MS_STUDENT_BACK
AS SELECT * FROM MS_STUDENT;

-- 아래도 동일하게 적용되
SELECT * FROM MS_STUDENT_BACK;


-- 63. 
-- MS_STUDENT 테이블의 튜플을 모두 삭제해라,테이블을 삭제해라.
DELETE FROM MS_STUDENT;


-- 데이터가 있는지 확인해봄 -- 삭제해서 없음
SELECT * FROM MS_STUDENT;

-- 64.
-- MS_STUDENT_BACK 테이블 모든 속성을 조회해서
-- MS_STUDENT 테이블에 삽입해라.
INSERT INTO MS_STUDENT SELECT * FROM MS_STUDENT_BACK;

-- 데이터가 있는지 확인해봄 -- 백업 데이터가 생성됨
SELECT * FROM MS_STUDENT;

-- 65.
-- ALTER TABLE MS_STUDENT; 
-- (여, 남, 기타 )값만 입력 가능하도록 함
ALTER TABLE MS_STUDENT
ADD CONSTRAINT MS_STD_GENDER_CHECK
CHECK (gender IN('여','남','기타'))
;

SELECT * FROM MS_STUDENT;

DELETE FROM MS_STUDENT;


-- 66.
-- MS_USER 테이블기술서 기반 생성하기

CREATE TABLE MS_USER 
(
     USER_NO   NUMBER        NOT NULL PRIMARY KEY ,
     USER_ID   VARCHAR2(100) NOT NULL UNIQUE ,
     USER_PW   VARCHAR2(100) NOT NULL ,
     USER_NAME VARCHAR2(50)  NOT NULL ,
     BIRTH     DATE          NOT NULL , 
     TEL       VARCHAR2(20)  NOT NULL UNIQUE ,  
     ADDRESS   VARCHAR2(200) NULL ,
     REG_DATE  DATE    DEFAULT sysdate NOT NULL ,
     UPD_DATE  DATE    DEFAULT sysdate NOT NULL
);

COMMENT ON TABLE MS_USER IS '회원';
COMMENT ON COLUMN MS_USER.USER_NO IS '회원정보';
COMMENT ON COLUMN MS_USER.USER_ID IS '아이디';
COMMENT ON COLUMN MS_USER.USER_PW '비밀번호';
COMMENT ON COLUMN MS_USER.USER_NAME IS '이름';
COMMENT ON COLUMN MS_USER.BIRTH IS '생년월일';
COMMENT ON COLUMN MS_USER.TEL IS '전화번호';
COMMENT ON COLUMN MS_USER.ADDRESS IS '주소';
COMMENT ON COLUMN MS_USER.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_USER.UPD_DATE IS '수정일자';


-- 67.MS_BOARD 기술서를 기준으로 테이블을 생성하라.

CREATE TABLE MS_BOARD 
(
     BOARD_NO   NUMBER       NOT NULL PRIMARY KEY ,
     TITLE   VARCHAR2(200)   NOT NULL ,
     CONTENT  CLOB           NOT NULL ,
     WRITER VARCHAR2(100)    NOT NULL ,
     HIT       NUMBER        NOT NULL , 
     LIKE_CNT  NUMBER        NOT NULL ,  
     DEL_YN    CHAR(2)       NULL ,     
     DEL_DATE  DATE          NULL ,
     REG_DATE  DATE    DEFAULT sysdate NOT NULL ,
     UPD_DATE  DATE    DEFAULT sysdate NOT NULL
);

COMMENT ON TABLE MS_BOARD IS '게시판';
COMMENT ON COLUMN MS_BOARD.BOARD_NO IS '글번호';
COMMENT ON COLUMN MS_BOARD.TITLE IS '제목';
COMMENT ON COLUMN MS_BOARD.CONTENT IS '내용';
COMMENT ON COLUMN MS_BOARD.WRITER IS '작성자';
COMMENT ON COLUMN MS_BOARD.HIT IS '조회수';
COMMENT ON COLUMN MS_BOARD.LIKE_CNT IS '좋아요 수';
COMMENT ON COLUMN MS_BOARD.DEL_YN IS '삭제여부';
COMMENT ON COLUMN MS_BOARD.DEL_DATE IS '삭제일자';
COMMENT ON COLUMN MS_BOARD.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_BOARD.UPD_DATE IS '수정일자';

-- 68.
-- FILE 테이블
CREATE TABLE MS_FILE 
(
     FILE_NO    NUMBER           NOT NULL PRIMARY KEY ,
     BOARD_NO   NUMBER           NOT NULL ,
     FILE_NAME  VARCHAR2(2000)   NOT NULL ,
     FILE_DATA  BLOB             NOT NULL ,     
     REG_DATE  DATE    DEFAULT sysdate NOT NULL ,
     UPD_DATE  DATE    DEFAULT sysdate NOT NULL
);

COMMENT ON TABLE MS_FILE IS '게시판 첨부파일';
COMMENT ON COLUMN MS_FILE.FILE_NO IS '파일번호';
COMMENT ON COLUMN MS_FILE.BOARD_NO IS '글번호';
COMMENT ON COLUMN MS_FILE.FILE_NAME IS '파일명';
COMMENT ON COLUMN MS_FILE.FILE_DATA IS '파일';
COMMENT ON COLUMN MS_FILE.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_FILE.UPD_DATE IS '수정일자';

-- 69.
-- REPLY 테이블
CREATE TABLE MS_REPLY 
(     
     REPLY_NO   NUMBER           NOT NULL PRIMARY KEY ,
     BOARD_NO   NUMBER           NOT NULL ,
     CONTENT    VARCHAR2(2000)   NOT NULL ,
     WRITER    VARCHAR2(100)     NOT NULL ,    
     DEL_YN    CHAR(2) DEFAULT 'N'  NULL ,     
     DEL_DATE  DATE          NULL , 
     REG_DATE  DATE    DEFAULT sysdate NOT NULL ,
     UPD_DATE  DATE    DEFAULT sysdate NOT NULL
);

COMMENT ON TABLE MS_REPLY IS '게시판 댓글';
COMMENT ON COLUMN MS_REPLY.REPLY_NO IS '댓글번호';
COMMENT ON COLUMN MS_REPLY.BOARD_NO IS '글번호';
COMMENT ON COLUMN MS_REPLY.CONTENT IS '내용';
COMMENT ON COLUMN MS_REPLY.WRITER IS '작성자';
COMMENT ON COLUMN MS_REPLY.DEL_YN IS '삭제여부';
COMMENT ON COLUMN MS_REPLY.DEL_DATE IS '삭제일자';
COMMENT ON COLUMN MS_REPLY.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_REPLY.UPD_DATE IS '수정일자';

-- ALT + SHIFT KEY : 누르고 마우스를 같은 항목들 아래로 드래그 하면 선택해서 공동수정 가능

-- 70. *** human/human2 를 설정하는 전체 방법***
-- human 계정에 있는 모든 데이터를ㄹhuman2 계정으로 가져오기 위해
-- hunam.dmp 파일을 만들었다. human2 계정으로 접속하여 
-- human.dmp 파일을 import 하시오

-- 1.human human2 계정 생성
-- 2.human.dmp 파일 import 하기 

-- 덤프파일 가져오기, import
-- import 할 때, dmp 파일을 생성한 계정과 다른 계정으로 가져올 때는 
-- system 계정 또는 가져올 계정으로 접속하여 명령어를 실행해야 한다.
-- import 명령 : imp (cmd에서 실행.)

/*   -- 자신의 컴퓨터 로컬의 저장 위치를 입력하면 된다.
human 에서 만든 파일이다.
imp userid=system/123456 file=c:\KS\sql\SQL_human\community.dmp fromuser=human touser=human  

imp userid=system/123456 file=c:\KS\sql\SQL_human\human.dmp fromuser=human touser=human2 
*/

-- human 계정 생성
-- 미리 system 계정으로 sql developer 에서 변경하고 오기
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
-- CREATE USER 계정명 IDENTIFIED BY 비밀번호;
CREATE USER human IDENTIFIED BY "123456";
-- 계정이 사용할 수 있는 용량 설정(무한대)
ALTER USER human QUOTA UNLIMITED ON users;
-- 계정에 권한 부여 : 원본크드
--GRANT connect, resource TO human;
-- human 계정에 DBA 권한 부여
GRANT DBA TO human;

-- human2 계정 생성
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
-- CREATE USER 계정명 IDENTIFIED BY 비밀번호;
CREATE USER human2 IDENTIFIED BY "123456";
-- 계정이 사용할 수 있는 용량 설정(무한대)
ALTER USER human2 QUOTA UNLIMITED ON users;
-- 계정에 권한 부여 : 원본 코드
-- GRANT connect, resource TO human2;
-- human2 계정에 DBA 권한 부여 : human 코드
GRANT DBA TO human2;

-- 1. 하기 명령 을 cmd 에 입력한다
-- revoke -> alter set ~ 실행 -> drop 실행 -> database에서 human 삭제. -> human 2 생성 코드 실행 -> cmd 에 imp명령 실행 -> 

/*
imp userid=system/123456 file=c:\KS\sql\SQL_human\community.dmp fromuser=human touser=human 
*/
-- import 중이라고 나온다.
-- 2. 하기 명령 을 cmd 에 입력한다.
/*
imp userid=system/123456 file=c:\KS\sql\SQL_human\human.dmp fromuser=human touser=human2 
*/
-- import 중이라고 나온다.
-- system 권한이 없다고 나온다.


-- ****** human/human2가 cmd에서 import 오류 생길 때 하기 전체 명령 실행하고 dump파일과 human/human2 재설정하기
--  하기 명령 실행하고 아래 REVOKE 명령 실행하기

-- 1. human, human2 의 dba 권한 제거(REVOKE))한 후에, 계정 삭제하기. system 권한에서 할 것.
-- 아래 drop 명령에서 안 된다면 dba권한 때문일 수 있다.
REVOKE DBA from human;
REVOKE DBA from human2;

-- revoke 후에, 다음 메시지가 뜬다면 --- ORA-01922: CASCADE must be specified to drop 'HUMAN2'
-- 다음을 순서대로 실행해야 한다.
-- 1. ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
-- 2. DROP USER human2 CASCADE; 
/*
SQL> DROP USER human2;

DROP USER human2
*
ERROR at line 1086:
ORA-01922: CASCADE must be specified to drop 'HUMAN2'
SQL> DROP USER human2 CASCADE;

USER dropped.
*/

-- cmd 에서 문제생기면 계정 삭제하고 다시 시작하기
-- DATABASE에서 HUMAN/HUMAN2 접속 모두 끊고, system.orcl로 설정 후 실행하고, 
-- 안 되면 DATABASE에서 우클릭->DELETE하고 다시 실행하면 된다.
-- 2.계정 삭제 및 생성 시, 세션 속성 true로 변경 후 진행.
-- ORA-28014: cannot drop administrative user or role 오류가 뜨면 아래 명령 실행해라.
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
DROP USER human;
DROP USER human2;
-- 위의 drop 문제생기면 하기 내용 추가해서 다시 하기
DROP USER human CASCADE;
DROP USER human2 CASCADE;

-- **** dump와 log 파일을 생성해서 import 하고 export 하는 이유 : db를 잘 설계하는 사람이 설계하고
-- export해서 팀원들이 이 파일을 import해서 팀원들이 같은 내용을 테스트 하는 동일화단계다.

--71. 
-- human 계정이 소유하고 있는 데이터를 
-- "human_exp.dmp"파일로 export하는 명령어를 작성하시오.
exp userid=human/123456 file=c:\KS\sql\sql_human\human_exp.dmp log=c:\KS\sql\sql_human\human_exp.log 

-- 72. 
-- ms_board 의 writer 속성을 number속성으로 변경
-- ms_user의 user_no를 참조하는 외래키로 지정하라

-- 데이터 타입 변경
ALTER TABLE MS_BOARD MODIFY WRITER NUMBER;
-- 제약조건 삭제
ALTER TABLE MS_BOARD DROP CONSTRAINT MS_BOARD_WRITER_FK;
-- 외래키 지정
ALTER TABLE MS_BOARD ADD CONSTRAINT MS_BOARD_WRITER_FK
FOREIGN KEY (WRITER) REFERENCES MS_USER(USER_NO);

-- 2)외래키 :  MS_FILE의 (BOARD_NO)를 --> MS BOARD(BOARD_NO)로 참조하기
ALTER TABLE MS_FILE ADD CONSTRAINT MS_FILE
FOREIGN KEY (BOARD_NO) REFERENCES MS_BOARD(BOARD_NO); 

-- 3) 외래키 : MS_REPLY (BOARD_NO) --> MS_BOARD (BOARD_NO)
ALTER TABLE MS_REPLY ADD CONSTRAINT MS_REPLY_BOARD_NO_FK
FOREIGN KEY (BOARD_NO) REFERENCES MS_BOARD(BOARD_NO); 

-- 73. 
-- MS 테이블에 속성을 추가하라.
-- 
ALTER TABLE MS_USER ADD CTZ_NO CHAR(14) NOT NULL UNIQUE;
ALTER TABLE MS_USER ADD GENDER CHAR(6) NOT NULL;

COMMENT ON COLUMN MS_USER.CTZ_NO IS '주민번호';
COMMENT ON COLUMN MS_USER.GENDER IS '성별';

-- 생성된 MS_USER 테이블 확인해서 추가된 행 확인하기.
DESC MS_USER;

-- 74.
-- MS_USER의 GENDER 속성 이 (여,남,'기타 ') 값만 갖도록 제약조건 추가
ALTER TABLE MS_USER
ADD CONSTRAINT MS_USER_GENDER_CHECK
CHECK (gender IN('여','남','기타'))
;

SELECT * FROM MS_USER;

-- 75.
-- MS_FILE 테이블에 확장자 속성 추가
ALTER TABLE MS_FILE ADD EXT VARCHAR2(10) NULL;
COMMENT ON COLUMN MS_FILE.EXT IS '확장자';

-- 76.
MERGE INTO MS_FILE T       -- 대상 테이블 지정
-- 사용할 데이터의 자원을 지정하라. 
USING (SELECT FILE_NO, FILE_NAME FROM MS_FILE) F 
-- ON (UPDATE 될 조건)
ON(T.FILE_NO = F.FILE_NO)
-- 매치 조건에 만족한 경우 : SUBSTR : 문자열을 부분만 추출하는 명령어
-- ex. SUBSTR('/UPLOAD/강아지.PNG', 12)  ---- PNG를 추출해준다.

-- INSTR()
WHEN MATCHED THEN
--                      확장자 추출명령(~)    
    UPDATE SET T.EXT = SUBSTR(F.FILE_NAME, INSTR(F.FILE_NAME, '.', -1) +1)
--                확장자 추출명령(~)                  
    DELETE WHERE SUBSTR(F.FILE_NAME, INSTR(F.FILE_NAME, '.', -1) +1)
            NOT IN ( 'JPG', 'JPEG', 'PNG', 'GIF')
-- WHEN NOT MATCHED THEN 
-- 매치가 안 될때
;


-- 유저 추가 : CTZ_NO, GENDER c=추가함
INSERT INTO MS_USER(USER_NO, USER_ID, USER_PW, USER_NAME, BIRTH,
TEL, ADDRESS, REG_DATE, UPD_DATE, CTZ_NO, GENDER
)  
VALUES (
        1, 'FLOWR', '123456', '김휴먼', '2003/01/01',
        '010-1234-1234', '영등포', sysdate, sysdate,
        '200101-1111222', '기타'
        );
-- 게시글 추가
INSERT INTO MS_BOARD(
            BOARD_NO, TITLE, CONTENT, WRITER, HIT, LIKE_CNT,
            DEL_YN, DEL_DATE, REG_DATE, UPD_DATE    
            )
VALUES (
        2, '제목', '내용', 1,0,0, 'N', NULL, sysdate, sysdate
        );
        
-- 파일추가
INSERT INTO MS_FILE(FILE_NO, BOARD_NO, FILE_NAME, FILE_DATA, REG_DATE,
            UPD_DATE, EXT
            )
VALUES (2, 2, '강아지.PNG', '123', sysdate, sysdate, 'jpg');         

SELECT * FROM MS_USER;
SELECT * FROM MS_BOARD;
SELECT * FROM MS_FILE;

-- ** 실행 안됨, 무결성 조건에 위배된다고 나옴 DATE문제 -- 해결하기

-- 77. 4
-- 테이블MS_FILE의 EXT속성이
-- ('jpg', 'jpeg', 'png', 'gif')값을 갖도록 하는 제약조건 추가하라
ALTER TABLE MS_FILE
ADD CONSTRAINT MS_FILE_EXT_CHECK
CHECK (EXT IN('jpg', 'jpeg', 'png', 'gif'));

-- 78. 
-- MS_USER, MS_BOARD, MS_FILE, MS_REPLY 테이블 의
-- 모든 데이터를 삭제하는 명령어를 작성하라 -- 밑에서 부터 실행하기- 제약조건 때문에
TRUNCATE TABLE MS_USER;
TRUNCATE TABLE MS_BOARD;
TRUNCATE TABLE MS_FILE;
TRUNCATE TABLE MS_REPLY;

-- 삭제하고 하기 코드 실행하기
SELECT * FROM MS_USER;
SELECT * FROM MS_BOARD;
SELECT * FROM MS_FILE;

SELETE * FROM MS_REPLY;

-- DELETE VS TRUNCATE
-- * DELETE = 데이터 조작어(DML)
--   -한 행 단위로 데이터를 삭제 처리한다.
--   -COMMIT, ROLLBACK 으로 변경사항을 적용/되돌릴 수 있다.
-- * TRUNCATE = 데이터 정의어(DDL)
--    -모든 행을 삭제한다.
--    -되돌릴 방법이 없다.

-- -> 현재 스키마의 모든 테이블 목록을 검색
-- -> GIT 연결
-- -> 연결 다시하기 - SQL_human --
SELECT * FROM TAB;
