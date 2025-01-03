--DD

/*
DQL (QUERY 데이터 질의 언어) : SELELCT 

DML  MANIPULATION 데이터 조작언어 : INSERT, UPDATE, DELETE
DDL  ERFINITION 데이터 정의 언어) : CREATE , ALTER, DROP
DCL  CONTROL 데이터 제어언어 : GRANT , REVOKE

TCL  TRANSACTION 트랜젝션 제어 언어 : COMMIT, ROLLBACK
 
 DML DATA MANIPULATION LAGUAGE 
 데이터 조작 언어
 
 테이블에 값을 삽입 (INSERT ) 하거나, 수정(UPDATE)하거나, 삭제 (DELETE)하는 구문
 
 1. INSERT
 테이블에 새로운 행을 추가하는 구문
 [표현식]
 1. INSERT INTO [TABLE 명] VALUES(값1, 값2, 값3 ... )
 테이블에 모든 컬럼에 대한 값을 직접 제시해서 한행 INSERT 하고자 할떄 사용한다. 
 
 테이블 안에 한 행의 값을 넣어줄떄 사용한다. 
 컬럼 순번을 지켜서 VALUES 에 값을 나열해야함. 
 --> 테이블 생성떄 정의하는 타입에 따라 값을 넣어야 한다.
 
  */
  INSERT INTO EMPLOYEE
  VALUES(900,'차은우','900101-1111111','CHA_00@KH.CO.COM','01012345678','D1','J7','S3',400000,'0.2',200,SYSDATE,NULL,DEFAULT);
  
  
  SELECT * FROM EMPLOYEE;
--  2. 인서트 하는 다른 방법이 있다. 
--   2) INSERT INTO 테이블명(컬럼명, 컬럼명, 컬럼명) VALUES (값1, 값2, 값3 ... );
--  차이점 : 첫번째 INSERT 방식은 모든 컬럼을 전부 제시를 해야 했다.(NULL 이 있으면 , NULL 이라고 적으면서까지.)
--   하지만, 두 번쨰 방법은, 테이블명(컬럼명) 이라고 적은 컬럼의 수 만큼, 값을 넣는 방법이다. 
--  
--   그래도 한 행 단위로 추가되기 때문에 선택이 안된 컬럼은 기본적으로 NULL이 들어간다. 
--   NOT NULL 제약 조건이 걸려있는 컬럼은 반드시 선택해서 직접 값 제시해야된다. 
--   단, DEFAULT 값이 있는 경우는 NULL이 아닌 DDFAULT 값이 들어간다. 
  
  INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL, HIRE_DATE)
  VALUES(901, '주지훈', '990202-1111111', 'J1', 'S2',SYSDATE);
  SELECT * FROM EMPLOYEE;
  --조회한 내용과 같이, 제공하지 않은 값은, 디폴트 값이 들어가있다. 디폴트세팅이 없는 값은 NULL이 들어갔따. 
  
   
  INSERT 
    INTO EMPLOYEE
         (
            EMP_ID
            , EMP_NAME
            , EMP_NO
            , JOB_CODE
            , SAL_LEVE
            , HIRE_DATE)
  VALUES(
            901
            , '주지훈'
            , '990202-1111111'
            , 'J1'
            , 'S2'
            ,SYSDATE); 
  ---------------------------------------
  --INSERT 세 번째 방법
  --3. INSERT INTO 테이블명(서브쿼리);
  --ㅍVALUES 로 값 직접 명시하는거 대신에
 -- 서브쿼리로 조회된 결과값을 통쨰로 INSERT 가능 ! (여러행 INSERT 가능하다.)
  
  
  CREATE TABLE EMP_01(
  EMP_ID NUMBER,
  EMP_NAME VARCHAR2(20),
  DEPT_TITLE VARCHAR2(20)
  );
  
  SELECT * FROM EMP_01;
  
  --전체 사원들의 사번, 이름, 부서명 조회
  SELECT EMP_ID, EMP_NAME, DEPT_TITLE
  FROM EMPLOYEE
  LEFT JOIN DEPARTMENT ON(DEPT_CODE =  DEPT_ID);
  
  
  INSERT INTO EMP_01 (
                        SELECT EMP_ID, EMP_NAME, DEPT_TITLE
                         FROM EMPLOYEE
                         LEFT JOIN DEPARTMENT ON(DEPT_CODE =  DEPT_ID)  
  );
  
  SELECT * FROM EMP_01;
  ----------------------------------------------------------------
  --4. INSERT ALL
  --테스트 할 테이블 만들기
  --구조 배끼기.
  
  
  
  CREATE TABLE EMP_DEPT
  AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
    FROM EMPLOYEE
    WHERE 1 = 0;
  
  CREATE TABLE EMP_MANAGER
  AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
    FROM EMPLOYEE
    WHERE 1 = 0;
  
  SELECT * FROM EMP_MANAGER;
  --부서코드가 D1 인 사원들의 사번, 이름, 부서코드, 입사일, 사수사번, 조회
  SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
  FROM EMPLOYEE
  WHERE DEPT_CODE = 'D1';
  
  /*
  표현식 ]
  INSERT ALL
  INTO 테이블명 1 VALUES (컬럼명 컬럼명 컬럼명 ...)
  INTO 테이블명 1 VALUES (컬럼명 컬럼명 컬럼명 ...)
  INTO 테이블명 1 VALUES (컬럼명 컬럼명 컬럼명 ...)
    서브쿼리
    
    
    
    이런식으로 INSERT ALL을 사용하는데, 한번에 INSERT를 할 수 있다. 
  */
  INSERT ALL
  INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
  INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
   SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
  FROM EMPLOYEE
  WHERE DEPT_CODE = 'D1';
    SELECT * FROM EMP_MANAGER;
    
    
    
    -- 2000년도 이전에 입사한 입사자들에 대한 정보를 담을 테이블을 하나 만들어보자. 
    --1. 테이블 구조만 배껴서 먼저 만들어보기.
    CREATE TABLE EMP_OLD
    AS SELECT EMP_ID, EMP_NAME, HIRE_DATE , SALARY
        FROM EMPLOYEE
        WHERE 1 = 0;
        
    CREATE TABLE EMP_NEW
    AS SELECT EMP_ID, EMP_NAME, HIRE_DATE , SALARY
        FROM EMPLOYEE
        WHERE 1 = 0;
/*  
    INSERT ALL
    WHEN 조건1 THEN
        INTO 테이블명1 VALUES(컬럼명, 컬럼명, ...)
    WHEN 조건 2 THEN
        INTO 테이블명1 VALUES(컬럼명, 컬럼명, ...)
   서브쿼리
   */
   
   INSERT ALL
   WHEN HIRE_DATE <'2000/01/01' THEN
        INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
    WHEN HIRE_DATE>= '2000/01/01' THEN
        INTO EMP_NEW VALUES(EMP_ID,EMP_NAME, HIRE_DATE, SALARY)
    SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE;
    
    SELECT * FROM EMP_OLD;
    SELECT * FROM EMP_NEW;
  
  
  --------------------인서트 끝 INSERT 끝 INSERT END----------------------
  /*
  UPDATE
  테이블에 기록이 되어있는 기존의 데이터를 수정하는 구문.
  
  [표현법]
  UPDATE 테이블명
  SET 바꾸고 싶은 컬럼명 = 바꿀 값, 
        바꾸고 싶은 컬럼명 = 바꿀 값,
        ...
        -> 여러개의 컬럼값 동시 변동 가능
    WHERE          -> WHERE 을 생략하면 모든 행들의 값들이 위에 SET으로 인해 변경되기 때문에 무조건 WHERE 을 쓰자.
    
  */
  --복사본 테이블 만든 후 작업 해보자. 
  CREATE TABLE DEPT_COPY
  AS SELECT * FROM DEPARTMENT;

  SELECT * FROM DEPT_COPY;
  --'D9'부서의 부서명을 전략기획팀으로 수정해달라.
  UPDATE DAPT_COPY
  SET DEPT_TITLE = '전략기획팀';
 
  UPDATE DEPT_COPY
  SET DEPT_TITLE = '전략기획팀'
  WHERE DEPT_ID='D9';
  
 
    CREATE TABLE EMP_SALARY
    AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
    FROM EMPLOYEE;
    --직접 해보기. 
    --노옹철 사원의 급여를 1백만원으로 변경. 데이터 백업 하고 하자. 
    --다 끝냈으면, 성동일 급여를 7백만원으로 변동, 보너스를 0.3 -> 0.2 로 변동
    --전체사원의 급여를 기존의 급여의 10프로 인상한 금액(기존급*1.1)
    --WHERE 절은 식별키. 고유키로 설정하자. 
    UPDATE EMP_SALARY
    SET SALARY = 1000000
    WHERE EMP_ID = 202;
    SELECT * FROM EMP_SALARY;
    
    SELECT EMP_ID, EMP_NAME, SALARY
    FROM EMP_SALARY
    WHERE EMP_NAME = '선동일';
    
    UPDATE EMP_SALARY
    SET SALARY = 7000000, BONUS = 0.2
    WHERE EMP_ID = 200;
    SELECT EMP_NAME ,SALARY 
    FROM EMP_SALARY;
    
    UPDATE EMP_SALARY
    SET SALARY = SALARY * 1.1;
    
  --  UPDATE 시 서브쿼리를 사용가능
  /*
        UPDATE 테이블명
        SET 컬럼명 = (서브쿼리)
        WHERE  조건;
        
        박명수 사원의 급여와 보너스값을 유재석 사원의 급여와 보너스 값으로 변경하라. 
        */
        SELECT * FROM EMP_SALARY
        WHERE EMP_NAME = '방명수'; -- 1518000
        
        --아래의 코드는 단일 열 서브쿼리이다. 
        UPDATE EMP_SALARY
        SET SALARY = (SELECT SALARY FROM EMP_SALARY WHERE EMP_NAME='유재식'),
            BONUS = (SELECT BONUS FROM EMP_SALARY WHERE EMP_NAME='유재식')
        WHERE EMP_ID = 214;
        --아래의 코드는 다중열 서브쿼리이다.
        UPDATE EMP_SALARY
        SET(sALARY, BONUS) = (SELECT SALARY, BONUS FROM EMP_SALARY WHERE EMP_NAME = '유재식')
        WHERE EMP_ID = 214;
    
        --ASIA 지역에서 근무하는 사원들의 보너스 값을 0.3으로 변경
        --ASIA 지역에서 근무하는 사원들 조회
        
        SELECT * 
        FROM EMP_SALARY
        JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
        JOIN LOCATION ON( LOCATION_ID = LOCAL_CODE)
        WHERE LOCAL_NAME LIKE 'ASIA%';
        
        SELECT * FROM DEPARTMENT;
        
        UPDATE EMP_SALARY
        SET BONUS = 0.3
        WHERE EMP_ID IN (SELECT EMP_ID
                        FROM EMP_SALARY
                        JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
                        JOIN LOCATION ON( LOCATION_ID = LOCAL_CODE)
                        WHERE LOCAL_NAME LIKE 'ASIA%');
        --UPDATE 할때 서브쿼리를 사용할 수 있다 정도 로 알고 있으면 될것같다.
        
        ----UPDATE
        --사번 200번인 사원의 이름을 NULL로 변경
        
        UPDATE EMPLOYEE
        SET EMP_NAME = NULL
        WHERE EMP_ID = 200;
        --ORA-01407: cannot update ("KH"."EMPLOYEE"."EMP_NAME") to NULL
        --EMPLOYEE 테이블에 EMP_NAME 컬럼에 NULL을 넣을려고 하는데, 세팅을 보면 NOT NULL 이기에 충돌 되어 오류남
        --힘들게 제약조건 다 만들어놨더니 안지키니 프로그램에서 오류난다. 
        
        --노옹철 사월의 직급코드를 J9로 변경해보자.
        UPDATE EMPLOYEE
        SET JOB_CODE = 'J9'
        WHERE EMP_NAME = '노옹철';
        --ORA-02291: integrity constraint (KH.SYS_C007167) violated - parent key not found
        --FOREIGN KEY 제약조건 위배...되었다. 
        
        -------------------------------
        /*
        DELETE
        테이블에 기록된 데이터를 삭제하는 구문 (한 행 단위로 삭제됨)
       
       [표현식]
       DELETE FROM 테이블명
       [WHERE 조건] --> WHERE 을 제시 하지 않으면 전체 행이 싹 다 삭제가 된다.       
        */
        
        DELETE FROM EMPLOYEE;
        
        ROLLBACK; -- 마지막 커밋 시전으로 돌아간다.
        DELETE FROM EMPLOYEE
        WHERE EMP_NAME = '차은우';
        
        DELETE FROM EMPLOYEE
        WHERE EMP_NAME = '주지훈';
        
        COMMIT;
        
        SELECT * FROM EMPLOYEE;
        
        --DEPARTMENT 테이블에서 DEPT_ID가 D1인 부서를 삭제 해보자. 
        DELETE FROM DEPARTMENT
        WHERE DEPT_ID = 'D1';
        --ORA-02292: integrity constraint (KH.SYS_C007166) violated - child record found
        --혹시 기억나니, --> 해석) 너 이거 삭제 못해 왜냐하면, 해당 테이블의 자식들이 이 값을 사용하고 있어. 
        
        --D1의 값을 가져다 쓰는 자식데이터가 있기 때문에 삭제가 안됨.
        
        DELETE FROM DEPARTMENT
        WHERE DEPT_ID = 'D3';
        -->반대로 D3의 경우에 가져다 쓰는 자식 데이터가 없기 때문에 삭제가 가능하다. 
        ROLLBACK; --> 아직 KH 는 계속 공부자료로 써야 하기때문에 ROLLBACK 해줘서 정상화 시키자. 
        
        --TRUNCATE : 테이블의 전체 생을 삭제할 때 사용하는 구문이다. DELETE 보다 수행 속도가 훨씬 빠르다. 
        -- 별도의 조건 제시 불가하다, 그냥 싹다 삭제시킨다고 보면 된다. 
        --ROLLBACK 도 불가하다. 휴지통 비우기라고 생각하면 편하다. 강력한 삭제
        --[표현식] TRUNCATE TABLE 테이블명;

        TRUNCATE TABLE EMP_SALARY;