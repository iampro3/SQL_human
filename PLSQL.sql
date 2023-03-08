-- 프로시저 생성
CREATE OR REPLACE PROCEDURE pro_print
IS -- 선언부
    V_A NUMBER := 10;
    V_B NUMBER := 20;
    V_C NUMBER;
BEGIN -- 실행부
    V_C := V_A + V_B;
    -- 출력문
    DBMS_OUTPUT.PUT_LINE('V_C : ' || V_C);
END;
/
    
SET SERVEROUTPUT ON;
-- 프로시저 실행
EXECUTE pro_print();

HELP
EXECUTE

-- 파라미터 가져와서 실행하기
CREATE OR REPLACE PROCEDURE pro_emp_write
(
    IN_EMP_ID IN employee.emp_id%TYPE,
    IN_TITLE IN VARCHAR2,
    IN_CONTENT IN CLOB
)
IS
    V_EMP_NAME employee.emp_name%TYPE;
BEGIN
    -- INTO : 조회결과를 변수에 대입하는 키워드
    SELECT emp_name INTO V_EMP_NAME
    FROM employee
    WHERE emp_id = IN_EMP_ID;
    INSERT INTO ms_board(board_no, title, content, writer, hit, like_cnt)
    VALUES(SEQ_MS_BOARD.nextval, IN_TITLE, IN_CONTENT, V_EMP_NAME, 0,0);
    
    DBMS_OUTPUT.PUT_LINE('제목 : ' || IN_TITLE);
    DBMS_OUTPUT.PUT_LINE('내용 : ' || IN_CONTENT);
    DBMS_OUTPUT.PUT_LINE('작성자 : ' || V_EMP_NAME);
END;    
/

SELECT * FROM employee;
SELECT * FROM ms_board;

EXECUTE pro_emp_write('207', '제목', '내용');

-- 선동일 추가하기
EXECUTE pro_emp_write('203', '제목', '내용');

