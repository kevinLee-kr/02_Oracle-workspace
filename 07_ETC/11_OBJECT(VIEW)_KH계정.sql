--

/*
    <VIEW 뷰>
    
    SELECT (쿼리문)(쿼리문)을 저장해 둘 수 있는 객체
    (자주 쓰는 긴 SELECT 문을 저장해두면 그 긴 SELECT 문을 매번 다시 기술할 필요가 없다. )
    
    임시 테이블 같은 존재 ! (실제 데이터가 담겨있는 건 아니다. ) (보여주기용 이라고 생각해도 좋다. 

    물리적인 테이블 : 실존한다.
    논리적인 테이블 : 가상적 -> 뷰는 논리적인 테이블이다. 
    
    VIEW 사용처 
    
    --뷰를 만들기 위한 복잡한 쿼리문 작성해보자.
    --관리자 페이지를 만들어보자.
    
    한국에서 근무하는 사번, 이름, 부서명, 급여, 근무국가명 조회 해보자.
    */
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING(NATIONAL_CODE)
    WHERE NATIONAL_NAME = '한국';
    
    -- 한국에서 근무하는 사번, 이름, 부서명, 급여, 근무국가명 조회 해보자.
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING(NATIONAL_CODE)
    WHERE NATIONAL_NAME = '러시아';
    
    -- 한국에서 근무하는 사번, 이름, 부서명, 급여, 근무국가명 조회 해보자.
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING(NATIONAL_CODE)
    WHERE NATIONAL_NAME = '일본';
    ------------------------------------------------------------------
    /*
    VIEW 생성 방법
    [표현법]
    CREATE VIEW 뷰이름
    AS (서브쿼리);    
    [OR REPLACE]
    뷰 생성시 기존에 중복된 이름의 뷰가 없다면 ~ 뷰를 생성하시오.
             기존에 중복된 이름의 뷰가 있다면 ~ 해당뷰를 갱신, 덮어씌우기를 하시오.
    */
    CREATE VIEW VW_EMPLOYEE
    AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
        FROM EMPLOYEE
        JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
        JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
        JOIN NATIONAL USING(NATIONAL_CODE);
        --ORA-01031: insufficient privileges
        
        --관리자 계정에 접속해서 권한부여
        GRANT CREATE VIEW TO KH;
        
        --이거는 실제있는 테이블이 아니다. 그래서 가상이라고 하는거나, 논리테이블로 불린다. 
        SELECT * FROM VM_EMPLOYEE;
        
    --한국 러시아 일본에 근무하는 사원. 
    SELECT * 
    FROM VM_EMPLOYEE
    WHERE NATIONAL_NAME = '한국';
    SELECT * 
    FROM VM_EMPLOYEE
    WHERE NATIONAL_NAME = '러시아';
    SELECT * 
    FROM VM_EMPLOYEE
    WHERE NATIONAL_NAME = '일본';
    
    --참고
    SELECT * 
    FROM USER_VIEWS;
    
    --만약에 뷰에다가 조회하고 싶은 걸 하나 추가 하고 싶다. 
    
     CREATE OR REPLACE VIEW VW_EMPLOYEE
    AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, BONUS
        FROM EMPLOYEE
        JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
        JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
        JOIN NATIONAL USING(NATIONAL_CODE);
    
    --------------------------------------------------
    --뷰에 별칭부여 해보기. 
    /*
    서브쿼리의 SELECT 절에 함수식이나 산술연산식이 기술되어 있을 경우 반드시 별칭을 지정해야 된다. 
    */
    --전체 사원의 사번, 이름, 직급명, 성별(남/여), 근무년수 를 조회 할 수 있는 SELECT 문을 뷰로 정의를 해보자. 
    --이떄 뷰의 이름은 (VM_EMP_JOB)으로 정의 해보자. 
    
    CREATE OR REPLACE VIEW VM_EMP_JOB
    AS SELECT EMP_ID, EMP_NAME, JOB_NAME,
            DECODE(SUBSTR(EMP_NO,8,1),1,'MAN',2,'WOMEN')AS"성별(남/여)",
            EXTRACT( YEAR FROM SYSDATE) - EXTRACT( YEAR FROM HIRE_DATE) AS "근무년수"
        FROM EMPLOYEE
        JOIN JOB USING(JOB_CODE);
  
  SELECT * FROM VM_EMP_JOB;
  --실제로 이런 테이블이 있는 것이 아니라, 아~! 이런 값들이 있구나~ 라고 확인용으로 사용이 된다. 
    
     CREATE OR REPLACE VIEW VM_EMP_JOB(사번, 이름, 직급명, 성별, 근무년수)
    AS SELECT EMP_ID, EMP_NAME, JOB_NAME,
            DECODE(SUBSTR(EMP_NO,8,1),1,'MAN',2,'WOMEN'),
            EXTRACT( YEAR FROM SYSDATE) - EXTRACT( YEAR FROM HIRE_DATE)
        FROM EMPLOYEE
        JOIN JOB USING(JOB_CODE);
    --이렇게 별칭을 부여 하는 방법도 있다. 단, 모든 컬럼에 대해서 별칭을 필수적으로 부여 해야 한다. 
    
    --뷰의 장점; 편하다. 손쉽다. ㅇ이미 다 툴을 만들어놧기에. 편하다. 
    SELECT 이름, 직급명
    FROM VM_EMP_JOB
    WHERE 성별 = '여';
    
    SELECT *
    FROM VM_EMP_JOB
    WHERE 근무년수 >=20;
    
    
    -----------------
    --뷰를 삭제 하고자 한다면. 
    DROP VIEW VM_EMP_JOB;
    
    --생성된 뷰를 이용해서 DML(INSERT, UPDATE, DELETE)사용가능하다.
    --뷰를 통해서 조작하더라도 실제 데이터가 담겨있는 베이스테이블에 반영된댜ㅏ.
    -- 그렇지만, 잘 안되는 경우가 많아서 실제로는 많이 쓰이지 않는다. 
    
    CREATE OR REPLACE VIEW VM_JOB
    AS SELECT JOB_CODE, JOB_NAME
        FROM JOB;
        
        SELECT * FROM VM_JOB; --논리적인 테이블, 가상이다~ 라고 한다.(실제 데이터값디 담겨있찌 않음)
        SELECT * FROM JOB;   -- 베이스 테이블, 실제다~ 라고 한다. (실제 데이터가 담겨 있다. )
        
        --VIEW 를 통해서 INSERT 를 해보자. 
        INSERT INTO VM_JOB VALUES('J8','인턴');
    
        --적용이 된다. 
        -- UPDATE도 되나?
        UPDATE VM_JOB
        SET JOB_NAME = '알바' --로 변경하고 싶다. 
        WHERE JOB_CODE = 'J8';
        --오 된다. 잘 적용 된다.
        --가상 테이블인VIEW 인데도 잘 적용이 되는 모습. 
        
        --뷰를 통해서 DELETE 도 해보자. 
        DELETE FROM VM_JOB
        WHERE JOB_CODE = 'J8';
        --삭제 됬다. 조작이 원활히 잘 되는 경우가 있다. 
        --하지만 위에서 적어놧듯, 안되는 경우가 있다. 
        --어떤 경우가 있나?
        ---------------------
        /*
        DML 명령어로 조작이 불가능한 경우가 훨~ 씬더 많다. 
        1. 뷰에 정의되어 있지 않은 컬럼을 조작하려고 하는 경우. 
        
        2. 뷰에 정의되어있지 않은 컬럼중에 베이스테이블 상에 NOT NULL 제약조건이 지정되어 있는 경우.  - 어떤건 되고 어떤건 안되는 경우가 생김
        3. 산술연산식 또는 함수식으로 정의되어있는 경우. 수정이 안됨
        4. 그룹함수나 GROUP BY 절이 포함된 경우
        5. DISTINCT 구문이 포함된 경우, DML 조작이 안될 수 있다. 
        6. 조인을 이용해서 여러테이블을 연결시켜놓은 경우 안된다. 
        -VIEW 는 조회하려고 만든 경우이기에, DML 문을 하지 말자. 
        --그니까, VIEW 
        */
          CREATE OR REPLACE  VIEW VW_JOB
            AS SELECT JOB_CODE
            FROM JOB;
--        1. 뷰에 정의되어 있지 않은 컬럼을 조작하려고 하는 경우. 
            INSERT INTO VW_JOB(JOB_CODE, JOB_NAME) VALUES('J8','인턴');
            --ORA-00904: "JOB_NAME": invalid identifier
            UPDATE VW_JOB
            SET JOB_NAME = '인턴'
            WHERE JOB_CODE ='J7';
            -- ORA-00904: "JOB_NAME": invalid identifier
            
            DELETE FROM VW_JOB
            WHERE JOB_NAME = '사원';
            --ORA-00904: "JOB_NAME": invalid identifier
--        2. 뷰에 정의되어있지 않은 컬럼중에 베이스테이블 상에 NOT NULL 제약조건이 지정되어 있는 경우.  - 어떤건 되고 어떤건 안되는 경우가 생김
            CREATE OR REPLACE VIEW VW_JOB
            AS SELECT JOB_NAME FROM JOB;
            
            SELECT * FROM VW_JOB;
            SELECT * FROM JOB; --JOB_CODE 의 제약조건이NOT NULL이다. 
            
            INSERT INTO VW_JOB VALUES('인턴');
            --ORA-01400: cannot insert NULL into ("KH"."JOB"."JOB_CODE")
            
            UPDATE VW_JOB
            SET JOB_NAME = '알바'
            WHERE JOB_NAME = '사원';
            --1 행 이(가) 업데이트되었습니다.
            
            DELETE FROM VW_JOB
            WHERE JOB_NAME = '사원';
            --ORA-02292: integrity constraint (KH.SYS_C007167) violated - child record found
            
--        3. 산술연산식 또는 함수식으로 정의되어있는 경우. 수정이 안됨
            CREATE OR REPLACE VIEW VW_EMP_SALARY
            AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12 AS "연봉" FROM EMPLOYEE;
            
            SELECT * FROM VW_EMP_SALARY;       --논리 테이블
            SELECT * FROM EMPLOYEE;         --베이스 테이블
            
            INSERT INTO VW_EMP_SALARY VALUES(400,'차은우',3000000,3600000);
            --ORA-01733:virtual column not allowed here
            --EMPLOYEE 에 연봉이라는 컬럼이 없기 때문. 
            
            UPDATE VW_EMP_SAL
            SET 연봉 = 8000000
            WHERE WMP_ID = 200; -- 에러
            
            UPDATE VW_EMP_SALARY
            SET SALARY = 7000000
            WHERE EMP_ID = 200; -- 성공
            
            DELETE FROM VM_EMP_SALARY
            WHERE 연봉 = 72000000; --성공 된건 아니지만, 트렌젝션에 머물러 있을것이다. 
--        4. 그룹함수나 GROUP BY 절이 포함된 경우
            CREATE OR REPLACE VIEW VW_GROUPDEPT
            AS SELECT DEPT_CODE, SUM(SALARY) "합계", FLOOR(AVG(SALARY)) "평균"
            FROM EMPLOYEE
            GROUP BY DEPT_CODE;
            
            SELECT * FROM VW_GROUPDEPT;
            
            INSERT INTO VW_GROUPDEPT VALUES('D3',8000000,4000000); --에러
            --ORA-01733: virtual column not allowed here
            --베이스 데이터인 실제 EMPLOYEE에 넣을 수 없는 유형의 데이터이므로, INSERT가 안된다. 

            UPDATE VW_GROUPDEPT
            SET 합계 = 8000000
            WHERE DEPT_CODE = 'D1';
            
            DELETE FROM VW_GROUPDEPT
            WHERE 합계 = 5210000;
            
--        5. DISTINCT 구문이 포함된 경우, DML 조작이 안될 수 있다. 
            CREATE OR REPLACE VIEW VW_DT_JOB
            AS SELECT DISTINCT JOB_CODE FROM EMPLOYEE;
            
            SELECT * FROM VW_DT_JOB;
            SELECT * FROM EMPLOYEE;
            
            INSERT INTO VW_DT_JOB VALUES('J8');


            UPDATE VW_DT_JOB
            SET JOB_CODE = 'J8'
            WHERE JOB_CODE = 'J7';
            
            DELETE VW_DT_JOB
            WHERE JOB_CODE = 'J4';

--        6. 조인을 이용해서 여러테이블을 연결시켜놓은 경우 안된다. 
--        -VIEW 는 조회하려고 만든 경우이기에, DML 문을 하지 말자. 

            CREATE OR REPLACE VIEW BVW_JOINEMP
            AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE
            FROM EMPLOYEE
            JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
            
            SELECT * FROM BVW_JOINEMP;
            
            INSERT INTO BVW_JOINEMP VALUES(300,'장원영','총무부');
            
            UPDATE BVW_JOINEMP
            SET EMP_NAME = '서동일'
            WHERE EMP_ID = 200;
            
            UPDATE BVW_JOINEMP
            SET DEPT_TITLE = '회계부'
            WHERE EMP_ID = 200;
            
            
            DELETE FROM BVW_JOINEMP
            WHERE EMP_ID = 200;
    
    
            ROLLBACK;
    
    
    -----------------------------------
    /*
    VIEW 옵션
    [상세 표현식]
    CREATE OR REPLACE [FORCE|"NOFORCE"] VIEW 뷰 이름
    AS 서브쿼리. 
    
    [WITH CHECK OPTION]
    [WITH READ ONLY]        --VIEW 사용시 DML기능이 작동하는걸 완전히 틀어막는 기능. 즉, 오로지 조회만 가능
    
    1) OR REPALCE : 기존에 동일한 뷰가 있을 경우 갱신시키고, 
                                    없을 경우 새로이 생성시킨다.
    2) FORCE | NOFORCE
    > FORCE : 서브쿼리에 기술된 테이블이 존재하지 않아도 뷰가 생성되게 한다. 
    > NOFORCE : 서브쿼리에 기술된 테이블이 존재하는 테이블이여만 뷰가 생성되게 하는 기능.
    --FORCE 또는 NOFORCE를 생략하게 되면 기본값인 NOFORCE 로 세팅이 된다. 
    3) WITH CHECK OPTION : DML시 서브쿼리에 기술된 조건에 부합한 값으로만 DML가능하도록 하는 기능.
    4) WITH READ ONLY : VIEW 에 대해서 조회만 가능하게 만드는 기능, DML 기능을 완전히 틀어막음.
    */
    

   -- NOFORCE : 서브쿼리에 기술된 테이블이 존재하는ㅌ 테이블이여야만 뷰가 생성되게 하는 옵션;
    
    CREATE OR REPLACE FORCE VIEW VW_EMP
    AS SELECT TCODE, TNAME, TCONTENT
    FROM TT;
    --경고: 컴파일 오류와 함께 뷰가 생성되었습니다.
    
    SELECT * FROM VW_EMP; --조회는 안됨
    
    CREATE TABLE TT(
        TCODE NUMBER,
        TNAME VARCHAR2(20),
        TCONTENT VARCHAR2(30)
    );
    
    --3) WITH CHECK OPTION : 서브쿼리에 기술된 조건에 부합하지 않는 값으로 수정시 오류 발생.
    -- WITH CHECK OPTION 안쓰고 만들수도 있다. 한번 해보자. 
    CREATE OR REPLACE VIEW VW_EMP
    AS SELECT * 
        FROM EMPLOYEE
        WHERE SALARY >= 3000000;
        
    SELECT *
    FROM VW_EMP; --8명 조회됨
    --200번 사원의 급여를 200만원으로 변경(서브쿼리의 조건에 부합되지 않는 값으로 값을 변경 시도.)
    UPDATE 
    SET SALARY = 3000000
    WHERE EMP_ID = 200;
    ROLLBACK;
    
    CREATE OR REPLACE VIEW VW_EMP
    AS SELECT * 
        FROM EMPLOYEE
        WHERE SALARY >= 3000000
    WITH CHECK OPTION;

SELECT * FROM VW_EMP;    
    
    UPDATE VW_EMP
    SET SALARY = 3000000
    WHERE EMP_ID = 200; -- 오류
    --서브쿼리에 기술한 조건에 부합되지 않기 때문에 변경이 불가하다.
    -- 서브쿼리에 기술한 조건에 부합되기 때문에 변경이 가능하다. 
    ROLLBACK;
    SELECT * FROM EMPLOYEE;
    
    
    /*
    
    4) WITH READ ONLY : 뷰에 대해서 조회만 가능 (DML문 절대 사용 못함)
    
    */
    CREATE OR REPLACE VIEW VW_EMP
    AS SELECT EMP_ID, EMP_NAME, BONUS
        FROM EMPLOYEE
        WHERE BONUS IS NOT NULL
    WITH READ ONLY; 
    
    SELECT * FROM VW_EMP;
    
    DELETE FROM VW_EMP
    WHERE EMP_ID = 200;
    --ORA-42399: cannot perform a DML operation on a read-only view
    
    SELECT * FROM EMPLOYEE;
    SELECT *
    FROM(
        SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
        FROM EMPLOYEE));
        
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    