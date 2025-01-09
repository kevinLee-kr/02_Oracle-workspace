--SQL 에서도 심화과정이란다.
/*
    <PL / SQL >
    PROCEDURE LANGUAGE EXTENSION TO SQL
    
    오라클 자체에 내장되어 있는 절차적 언어이다. 
    SQL 문장내에서 변수의 정의, 조건처리(IF), 반복처리(LOOP, FOR, WHILE)등을 지원하여 SQL 단점 보완
    다수의SQL문을 한번에 실행 가능하다. (BLOCK 구조 ) + 예외 처리 가능
    
    PL / SQL 구조
 - [선언부] - DECLARE 로 시작을 한다. 변수나 상수를 선언 및 초기화 하는 부분
  - 실행부  - BEGIN으로 시작을 한다. 무조건 있어야함, 필수적임. SQL 또는 제어문(조건문, 반복문) 등의 로직을 기술하는 부분
  -[예외처리부] - EXCEPTION으로 시작을 한다. 예외가 발생하면 해결하기 위한 구문을 미리 기술해둘 수 있는 구문이다. 
  
*/

SET SERVEROUTPUT ON;
--간단하게 화면에 HELLO ORCLE 을 출력 해보는 걸 해보고 싶다. 
BEGIN
--자바로 예를 들면, System.out.println("Hello World");
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');

END ; 
/
-----------------------------------------
/*
DECLARE 선언부
변수 및 상수 선언하는 공간 (선언과 동시에 초기화도 가능)ㄷ
일반타입변수, 레퍼런스타입 변수, ROW타입 변수.

1_1 일반 타입 변수 선언 및 초기화
                [표현식] 변수명 [CONSTANT -> 상수로 변한다.] 자료형 : = 값;
*/
DECLARE
    EID NUMBER;
    ENAME VARCHAR(20);
    PI CONSTANT NUMBER := 3.14;
BEGIN
--    EID := 800;
--    ENAME := '배정남';
    
    EID := &번호;
    ENAME := '&이름';
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME :'|| ENAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/
------------------------------------------
/*
1_2) 레퍼런스 타입 변수 선언 및 초기화(어떤 테이블의 어떤 컬럼의 데이터 타입을 참조해서 그 타입으로 지정
        [표현식] 변수명 테이블명. 컬럼명%TYPE;
        --개발자가 크기를 지정하는 것이 아니라, 테이블명 또는 컬럼명에 따라서 크기가 정해진다. 
        */
        
        DECLARE
            EID EMPLOYEE.EMP_ID%TYPE; -- EMPLOYEE 에 가서 EMP_ID 컬럼이 있고, 그 컬럼의 값으로 설정되어라.
            ENAME EMPLOYEE.EMP_NAME%TYPE;
            SAL  EMPLOYEE.SALARY%TYPE;
        BEGIN
--            EID := '300';
--            ENAME := 'DLGHTJR';
--            SAL := 3000000;
            
            SELECT EMP_ID, EMP_NAME, SALARY
            INTO EID, ENAME, SAL
            FROM EMPLOYEE
            WHERE EMP_ID = &사번;

            
            DBMS_OUTPUT.PUT_LINE('EID: ' || EID);
            DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
            DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
            END;
        /
        
        
--사원이 200번인 사원의 사번, 사원명, 급여 조회해서 각 변수에 대입.
SELECT EMP_ID, EMP_NAME, SALARY
INTO EID, ENAME, SAL
FROM EMPLOYEE
WHERE EMP_ID = &사번;



--------------------------실습문제
/*
레퍼런스타입 변수로 EID, ENAME, JCODE, SAL, DTITLE 을 선언하고
각 자료형이 EMPLOYEE, DEPARTMENT 테이블들을 참조하고 
사용자가 입력한 사번의 사원의 사번, 사원명 직급코드, 급여 부서명 조회

각 변수에 담아 출력 해보자.
*/

 DECLARE
            EID EMPLOYEE.EMP_ID%TYPE;
            ENAME EMPLOYEE.EMP_NAME%TYPE;
            JCODE EMPLOYEE.JOB_CODE%TYPE;
            SAL  EMPLOYEE.SALARY%TYPE;
            DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
            
        BEGIN
--            EID := '300';
--            ENAME := 'DLGHTJR';
--            JCODE := 3000000;
--            SAL := 6000000;
--            DTITLE := '회계관리부';

            SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
            INTO EID, ENAME, JCODE, SAL, DTITLE
            FROM EMPLOYEE
            JOIN DEPARTMENT ON(DEPT_ID = DEPT_CODE)
            WHERE EMP_ID = &사번;
            
            DBMS_OUTPUT.PUT_LINE('EID: ' || EID);
            DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
            DBMS_OUTPUT.PUT_LINE('JCODE : ' || JCODE);
            DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
            DBMS_OUTPUT.PUT_LINE('DTITLE : ' || DTITLE);
            END;
        /
-----------------------------------------
--1_3) ROW 타입 변수
--          테이블의 한 행에 대한 모든 컬럼값을 한꺼번에 담을 수 있는 변수
--          [표현식] 변수명 테이블명%ROWTYPE;

DECLARE 
    E EMPLOYEE%ROWTYPE;
BEGIN
    SELECT *
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;

--    DBMS_OUTPUT.PUT_LINE(E);
    DBMS_OUTPUT.PUT_LINE('사원명 : ' ||E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || E.SALARY);
    DBMS_OUTPUT.PUT_LINE('보너스 : ' || NVL(E.BONUS,0)); --NVL 가능
END;
/
-----------------------------------------
/*
2. BEGIN 실행부
<조건문>
1) IF 조건식 THEN 실행내용 END IF;
--사번 입력 받은 후 해당 사원의 사번, 이름, 급여, 보너스율(%) 출력 해보자. 
단, 보너스를 받지 않는 사원은 보너스율 출력 전'보너스'를 지급받지 않는 사원입니다. 출력 하고 싶다. 
*/
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)
    INTO EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('사원번호 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('사원이름 : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('사원급여 : ' || SALARY);
    
    IF BONUS = 0
        THEN DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다. ');
    END IF ;
    
    DBMS_OUTPUT.PUT_LINE('사원보너스: ' || BONUS * 100 || '%');

END;
/ 

--2) IF 조건식 THEN 실행내용 ELSE 실행네용 END IF;
        -- (자바의 IF-ELSE 문과 굉장히 비슷하다.)
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)
    INTO EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('사원번호 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('사원이름 : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('사원급여 : ' || SALARY);
    
    IF BONUS = 0
        THEN DBMS_OUTPUT.PUT_LINE('이 사원은 보너스를 받지 않습니다. ');
    ELSE
      DBMS_OUTPUT.PUT_LINE('사원보너스: ' || BONUS * 100 || '%');
    END IF ;
END;
/        
-----------------------------------------------------------
--실습문제 ,프로시져를 만들어보자.
-- 변수.
--레퍼런스타입 변수(EID, ENAME, DTITLE, NCODE)
--참조할 테이블이 무엇이냐 .: EMPLOYEE, DEPARTMENT, NATIONAL)

--일반 타입 변수를 만들어주세요 .  TYPE 을 결정해야하는데 (TEAM 문자열) -> 이따가 '국내팀', '해외팀' 이라는 값을
-- 담을 예정임. 알아서 잘 만들어주라 ^^

--사용자가 입력한 사번의 사원의 사번, 이름, 부서명, 근무국가 코드를 조회한 후에  EID, ENAME, DTITLE, NCODE 에 
--값을 대입하라. 
--NCODE 의 값이 KO 인 경우에 -> TEAM 에 '국내팀'
-- NCODE 의 값이 US?EU? (KO가 아닌경우) -> TEAM에 '해외팀' 을 넣어라.

--사번, 이름, 부서, 소속(국내팀 또는 해외팀 이라고 출력이 되게  프로그래밍을 해보자. 

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.NATIONAL_CODE%TYPE;
    TEAM VARCHAR(20);
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EID, ENAME, DTITLE, NCODE
    FROM EMPLOYEE
    JOIN  DEPARTMENT ON(DEPT_ID = DEPT_CODE)
    JOIN  LOCATION ON(LOCATION_ID = LOCAL_CODE)
    WHERE EMP_ID = &사번;
    
    IF NCODE = 'KO'
        THEN TEAM := '국내팀';
    ELSE
        TEAM := '해외팀';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('사원이름 : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('부서이름 : ' || DTITLE);
    DBMS_OUTPUT.PUT_LINE('지역코드 : ' || NCODE);
    DBMS_OUTPUT.PUT_LINE('소속 팀 : ' || TEAM);
END;
/

----------------------------------------------
--3) IF 조건식1 THEN 실행내용1 ELSE 조건식2 THEN 실행내용2 ... END IF;
--점수를 입력받아 SCORE 변수에 저장한 후
--90이상은 'A' , 80 점 'B',  70점 이상은 'C', 60점 이상은 'D', 60점 미만은 'F'

--GRADE 라는 변수에 저장을 해보자. (A,B,C,D,F,)
--결과적으로
--당신의 점수는 XX점이고, 학점은 X학점 입니다. 가 보고 시파.


DECLARE
    SCORE NUMBER;
    GRADE VARCHAR2(1);
BEGIN
    SCORE := &점수;
    
    IF SCORE >= 90 THEN GRADE := 'A';
    ELSIF SCORE >= 80 THEN GRADE := 'B';
    ELSIF SCORE >= 70 THEN GRADE := 'C';
    ELSIF SCORE >= 60 THEN GRADE := 'D';
    ELSE GRADE := 'F';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('당신의 점수는 '|| SCORE ||'점이고,학점은 '||GRADE||'학점 입니다.');
END;
/

--------------------------실습문제---------------
--프로시저 만들기
--변수 2개 (레퍼런스타입 변수 : SAL, 일반 타입 변수 : GRADE -> 초급, 중급, 고급

--입력한 사번의 사원의 급여가 500만원 이상이면 GRADE -> 고급
--                            300만원 이상이면 GREADE -> 중금
--                            300만원 미만이면 GRADE -> 초급
--                            
--        해당 하사원의 급여 등급은 XX입니다.

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENM EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    GRADE VARCHAR(10);
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EID, ENM, SAL
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;

    IF  SAL >=5000000 THEN GRADE := '고급';
    ELSIF SAL >=3000000 THEN GRADE := '중급';
    ELSE GRADE := '초급';
    END IF ;

    DBMS_OUTPUT.PUT_LINE('해당 사원의 급여등급은 ' || GRADE || '입니다. ');

END;
/
------------------------------------------------------------
--4) CASE 비교대상자  WHEN 동등비교할 값1 THEN 결과값1 WHEN  동등비교할값2 THEN THEN 결과값2 .... END;

DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DNAME VARCHAR2(30);
    --> 부서명 보관 변수
    
BEGIN
    SELECT *
    INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    DNAME := CASE EMP.DEPT_CODE
                        WHEN 'D1' THEN '인사팀'
                        WHEN 'D2' THEN '회계팀'
                        WHEN 'D3' THEN '마케팅팀'
                        WHEN 'D4' THEN '국내영업팀'
                        WHEN 'D9' THEN '총무팀'
                        ELSE '해외영업팀'
            END;
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_NAME || '은(는) ' || DNAME|| '입니다.');
END;
/
-----------------------------------------------------------
--사원의 연봉을 구하는 PL/SQL 블럭 작성 해보자.

-- 보너스가 있는 사원은 보너스도 포함해서 계산해라.
--보너스가 없으면 보너스미포함 연봉으로 계산
--보너스가 있으면 보너스포함해서 연봉계산 하면 되는데
-- 마지막 계산은 해당 사람의
--급여, 이름, L999,999,999
--(8000000 선동일 )

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, BONUS
    INTO EID, ENAME, SAL, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &사원;
    
    DBMS_OUTPUT.PUT_LINE('사원번호 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('사원이름 : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || SAL);
    DBMS_OUTPUT.PUT_LINE('보너스 : ' || BONUS);
    
    IF BONUS IS NULL THEN  DBMS_OUTPUT.PUT_LINE('연봉 : ' || TO_CHAR(SAL *12,'L99,999,999'));
    ELSE DBMS_OUTPUT.PUT_LINE('연봉 : ' || TO_CHAR((SAL + (SAL * BONUS)) * 12,'L99,999,999'));
    END IF;
    
    
END;
/

IF EMP.BONUS IS NULL
    THEN SALARY := EMP.SALARY * 12;
ELSE SALARY := (EMP.SALARY + (EMP.SALARY * EMP.BONUS))*12;
END IF;

DBMS_OUTPUT.PUT_LINE(EMP.SALARY || ' ' || EMP.EMP_NAME || TO_CHAR(SALARY,'L999,999,999'));

