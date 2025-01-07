/*
 DDL (DATA DEFINITION LANGUAGE) : 데이터 정의 언어
 오라클에서 제공하는 객체(OBJECT)를 새롭게 만들고, 구조를 변경하고, 구조 자체를 삭제하는 언어.
구조를 변경하고 (ALTER) , 구조자체를 삭제(
) 하는 언어. 
즉, 실제 데이터 값이 아닌 구조 자체를 정의하는 언어

주로, DB관리자, 또는 설계자가 사용하기에
주니어 개발자가 사용하는 일은 많이 없을 거지만, 그래도 알아두어서 나쁠것 없다. 

다음은, DDL이 다루는 객체들을 알아보자
오라클에서 제공하는 객체(구조) : 테이블(TABLE), 뷰(VIEW), 시퀀스(SEQUENCE), 
                                인덱스(INDEX), 패키지(PACKAGE), 트리거(TRIGGER), 
                                프로시져(PROCEDURE), 함수(FUNCTION), 동의어(SYNONYM), 사용자(USER)
                                
                                
        <CREATE> 에 대해 알아보고 어떻게 사용하는지 알아보자. 
        CREATE : 객체를 새로이 생성하는 구문이다.
        
        1번, 테이블을 생성하는 방법을 알아보자. 
        - 테이블이란 무엇인가 라고 했을떄, 행과 열 로 구성되어있는 가장 기본적인 데이터베이스 객체로 정의된다. 
        모든 데이터들은 테이블에 기록이 되어있다. 
        DBMS 용어 중 하나로, 데이터를 일종의 표 형태로 표현 한 것이다. 
        
        테이블을 만들고, 데이터를 넣어보고, 할 예정이다. 우리는 앞으로. 
        
        [표현식]
        CREATE TABLE 테이블명 ();  -> 테이블이 생성이 되었다. 다음은 컬럼들을 정의해 보자. 
        
        CREATE TABLE 테이블명(
            컬럼명 자료형(크기),
            컬럼명 자료형(크기),   -> 컬럼명을 쓰고, 자료형을 써야 하는구나. 크기를 정의해도 좋지만 필수적인건 아니다.
            컬럼명 자료형, 
            ...
        );
        
        - 자료형, 자료형은 크게 3가지로 나뉜다고 보면 된다. 
        1. CHAR : 문자 자료형.(CHAR(바이트크기)) | VARCHAR2(바이트크기)
            - 반드시 크기 지정을 해주어야 한다. 반면, 숫자, 날짜 타입은 크기 지정을 할 필요가 없다. 
            - 최대 2000BYTE까지만 지정이 가능하다. 초기 크기 지정후, 사이즈 변동은 앞으로 없으므로, 지정한 범위 안에서만 써야한다.  / 고정 길이
            - (지정한 크기보다 더 적은 값이 들어와도, 공백으로 채워짐, 메모리 낭비할 수 있음. 
            - 고정된 글자수의 데이터만이 담길 경우 주로 사용.
        2. VARCHAR2 : 문자 자료형(CHAR2(바이트크기)
            - 최대 4000바이트 까지 지정 가능.
            - 고정길이가 아닌 가변 길이이다. 
            - 담기는 값에 따라서 공간의 크기가 달라진다. 
            - 몇 글자의 데이터가 들어올지 모를 경우 사용이 된다. 
        2. 숫자 자료형. (NUMBER TYPE)
            정수, 실수,  숫자, 날짜 타입은 크기 지정을 할 필요가 없다. 
        3. 날짜 자료형. (DATE)
            날짜 타입  숫자, 날짜 타입은 크기 지정을 할 필요가 없다. 
*/

-- 회원에 대한 데이터를 담기 위한 테이블 MEMBER 생성하기.
CREATE TABLE MEMBER(
    MEM_NO NUMBER, 
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    GENDER  CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE
);
SELECT * FROM MEMBER;
--- 이미 존재하는 객체가 있기에 다시 생성이 불가능하다.
--- 따라서 생성하고자 하는 컬럼에 오타가 발생했을떄, 다시 만들면 될까? 덮어씌우기가 될까?
--- 안된다. 삭제하고 다시 만들어야 한다.

----------------------------
/*
컬럼의 주석 달기(컬럼에 대한 설명 같은 거)(COMMENT)
[표현법]
COMMENT ON COLUMN 테이블명, 컬럼명 IS '주석내용';
*/

COMMENT ON COLUMN MEMBER.MEM_NO IS '회원번호';
COMMENT ON COLUMN MEMBER.MEM_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.MEM_PWD IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.MEM_NAME IS '회원명';
COMMENT ON COLUMN MEMBER.GENDER IS '성별(남/여)';
COMMENT ON COLUMN MEMBER.PHONE IS '회원전화번호';
COMMENT ON COLUMN MEMBER.EMAIL IS '회원 이메일';
COMMENT ON COLUMN MEMBER.MEM_DATE IS '회원 가입일';

--테이블에 데이터 추가시키는 구문(DML : INSERT) 이때 자세하게 배움
--INSERT INTO 테이블명 VALUES (값, 값2, ..);

SELECT * FROM MEMBER;
INSERT INTO MEMBER VALUES(1,'user01','pass01','홍길동'); 
-- not enough values

INSERT INTO MEMBER VALUES(1,'user01','pass01','홍길동','남','010-1234-5678','kking@gmail.com','24/12/30'); 
INSERT INTO MEMBER VALUES(2,'user02','pass02','홍길녀','여',null,NULL,SYSDATE); 

INSERT INTO MEMBER VALUES(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
--유효하지 않은 데이터가 들어가고 있음.

---------------------------------------
/*
제약 조건 <CONSTRAINT> - 기본키 별칭
- 원하는 데이터값만 유지하기 위해서 특정 컬럼에 설정하는 제약조건

- 종류 :
1. NOT NULL
2. UNIQUE
3. CHECK
5. PRIMARY KEY
6. FOREIGN KEY

NOT NULL 제약조건- 
해당 컬럼에 반드시 값이 존재 해야만 할 경우
즉, 해당 컬럼에 절대적으로 NULL이 들어와서는 안되는 경우.
삽입 / 수정 시 NULL 값을 허용하지 않도록 제한하는 조건식이다. 

제약 조건을 부여하는 방식은 크게 2가지로 나뉜다. 
1. 컬럼레벨방식
2. 테이블레벨 방식.
NOT NULL 제약조건은 오로지 컬럼 레벨 방식 으로밖에 안된다. 
*/
--컬럼레벨 방식 : 컬럼명 자료형 제약조건
CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL, 
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER  CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);
CREATE TABLE RR();
SELECT * FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL VALUES(1,'user01','pass01','이병헌','남',null,null);
INSERT INTO MEM_NOTNULL VALUES(2,'user02',null,'레이디가가','여',null,'holywhat@gamil.com');
--의도했던대로 오류가 난다. (NOT NULL 제약조건에 위배되어 오류 발생!!)
INSERT INTO MEM_NOTNULL VALUES(2,'user01','pass01','박태환','남',null,'holywhat@null.com');
--데이터가 이미 존재하여 아이디가 중복이 되었는데, 잘 추가가 되고 있따.
------------------------
/*
unique제약조건
.해당 컬럼에 중복된 값이 들어가서는 안 될 경우.
컬럼값에 중복값을 제한 하는 제약 조건
삽입 / 수정시 기존에 있는 데이터 값중 중복값이 있을 경우 오류 발생.
*/

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL, 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, --컬럼 레벨 방식.
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER  CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);
SELECT * FROM MEM_UNIQUE;
DROP TABLE MEM_UNIQUE;

--테이블 레벨 방식 : 모든 컬럼들 다 나열 한 후 마지막에 기술한다. 
--제약조건명(컬럼명)

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL, 
    MEM_ID VARCHAR2(20) NOT NULL, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER  CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    UNIQUE(MEM_ID) --> 테이블 레벨방식. 나는 UNIQUE 조건을 걸고 싶은데 , MEM_ID에 걸고 싶다. 
);

INSERT INTO MEM_UNIQUE VALUES(1,'user01','pass01','페이커',null,null,null);
INSERT INTO MEM_UNIQUE VALUES(2,'user01','pass02','제우스',null,null,null);
--ORA-00001: unique constraint (DDL.SYS_C007100) violated
/*
제약조건 부여시 제약조건 명 까지 지어주는 방법
현재 우리는 2가지 방법으로 객체들을 생성하고 있다. 

컬럼 레벨 방식
CREATE TABLE 테이블명(
컬럼명 자료형 [CONSTRAINT 제약조건명] 제약조건, 
컬럼명 자료형 
);

테이블 레벨 방식
CREATE TABLE 테이블명(
컬럼명 자료형, 
컬럼명 자료형, 
[CONSTRAINT 제약조건명] 제약조건(컬럼명)
);
*/
select * from MEM_UNIQUE;

 --> 테이블 레벨 방식. 


CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL, 
    MEM_ID VARCHAR2(20) NOT NULL, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER  CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    CONSTRAINT MEMID_UQ UNIQUE(MEM_ID) --> 테이블 레벨방식. 나는 UNIQUE 조건을 걸고 싶은데 , MEM_ID에 걸고 싶다. 
);

INSERT INTO MEM_UNIQUE VALUES(1,'user01','pass01','페이커',null,null,null);
INSERT INTO MEM_UNIQUE VALUES(2,'user01','pass02','제우스',null,null,null);
--ORA-00001: unique constraint (DDL.MEMID_UQ) violated
INSERT INTO MEM_UNIQUE VALUES(2,'user02','pass02','마린',null,null,null);
INSERT INTO MEM_UNIQUE VALUES(3,'user03','pass03','피글렛','ㄴ',null,null);

SELECT * FROM MEM_UNIQUE;
/*
CHECK(조건식 제약조건
해당 컬럼에 들어올 수 있는 값에 대한 조건을 제시해둘 수 있음.
해당 조건에 만족하는 데이터값만 담길 수 있음. 
*/
CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL, 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER  CHAR(3) CHECK(GENDER IN('남','여')), --컬럼 레벨 방식
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    
    --CHECK(GENDER IN('남','여')) --테이블 레벨 방식
);
SELECT * FROM MEM_CHECK;
INSERT INTO MEM_CHECK VALUES(1,'user01','pass01','손흥밍','남',null,null);
INSERT INTO MEM_CHECK VALUES(2,'user02','pass02','이천수',null,null,null);
--ORA-02290: check constraint (DDL.SYS_C007110) violated
-- 만일, GENDER ㅋ러럼ㅇ에 데이터 값을 넣으려면, 제대로 기입 해야 한다. 
-- CHECK 제약조건에 만족하는 값을 넣어야 함. 
--NOT NULL이 아닌 이상, NULL 값이 들어 갈 수 있다. 

INSERT INTO MEM_CHECK VALUES(2,'user03','pass03','이강준',null,null,null);
--이 구문에서 문제점은, 회원번호가 중복이 되었음에도 불구하고 , 데이터기록이 너무 잘 되고있다. 

--------
/*
이때 사용하는 것이 
PRIMARY KEY
테이블에서 각 행들을 식별하기 위해 사용될 컬럼에 부여하는 제약조건 (씩별자의 역할)

EX)회원번호, 학번, 사원번호(EMP_ID), 부서코드(DEPT_ID), 직급코드(JOB_CODE), 주문번호, 예약번호, 
운송장 번호
PRIMARY KEY 제약조겅ㄴ을 부여하면 그 컬럼에 자동으로 NOT NULL + UNIQUE 제약조건을 가진다.

유의사항 : 한 테이블당 오로지, 한개만 설정 가능하다. 
*/

CREATE TABLE MEM_PRI(
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY, --컬럼 레벨 방식. 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER  CHAR(3) CHECK(GENDER IN('남','여')), 
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    --CONSTRAINT MEMNO_PK PRIMARY KEY(MEM_NO) --테이블 레벨 방식. 
);
SELECT * FROM MEM_PRI;
INSERT INTO MEM_PRI VALUES(1,'user01','pass01','손흥밍','남','12-12-12',null);
INSERT INTO MEM_PRI VALUES(2,'user02','pass02','자메인 대포',null,null,null);
--ORA-00001: unique constraint (DDL.MEMNO_PK) violated
--기본키에 NULL을 담으려고 할떄(NOT NULL 제약조건에 위배된다. )

/*
Composite key (복합키)
두개 이상의 컬럼을 묶어서 하나의 기본키로 지정하는것.
기본키는 하나의 테이블에 하나만 존재할 수 있다, 또한 기본키는 하나 이상의 컬럼으로 구성되어 있다.
기본키가 만약 복합키라면, 복합키 또한 당연히 유일성과 최소성을 만족해야한다.
*/


CREATE TABLE MEM_PRI2(
    MEM_NO NUMBER ,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER  CHAR(3) CHECK(GENDER IN('남','여')), 
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    PRIMARY KEY(MEM_NO,MEM_ID) --묶어서 PRIMARY KEY 제약조건 부여 (복합키)
);
SELECT * FROM MEM_PRI2;
INSERT INTO MEM_PRI2 VALUES(1,'user01','pass01','손흥밍','남','12-12-12',null);
--1 행 이(가) 삽입되었습니다.
INSERT INTO MEM_PRI2 VALUES(1,'user02','pass02','손흥밍','남','12-12-12',null);
--1 행 이(가) 삽입되었습니다.
INSERT INTO MEM_PRI2 VALUES(NULL,'user02','pass02','손흥밍','남','12-12-12',null);
--ORA-01400: cannot insert NULL into ("DDL"."MEM_PRI2"."MEM_NO")
--PRIMARY KEY 로 묶여있는 각 컬럼에는 절대 NULL 을 허용하지 않는다.

--복합키 사용 예시)
--(찜하기, 좋아요, 구독)
--찜하기 : 한 상품은 오로지 한번만 찜할 수 있음
-- 어떤 회원이 어떤 상품을 찜하는지에 대한 데이터를 보관하는 테이블.
*/

    CREATE TABLE TB_LIKE(
    MEM_NO NUMBER, 
    PRODUCT_NAME VARCHAR2(30),
    LIKE_DATE DATE,
    PRIMARY KEY(MEM_NO,PRODUCT_NAME)
    );
    
    SELECT * FROM TB_LIKE;
    
    INSERT INTO TB_LIKE VALUES(1,'테디베어',SYSDATE);
    INSERT INTO TB_LIKE VALUES(1,'테디레어',SYSDATE);
    INSERT INTO TB_LIKE VALUES(2,'테디베어',SYSDATE);
    INSERT INTO TB_LIKE VALUES(1,'테디베어',SYSDATE);
    
    ----------------------------------------------------------
    --회원등급에 대한 데이터를 따로 보괂 하는 테이블
    CREATE TABLE MEM_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
    );
    
    SELECT * FROM MEM_GRADE;
    
    INSERT INTO MEM_GRADE VALUES(10,'일반회원');
    INSERT INTO MEM_GRADE VALUES(20,'우수회원');
    INSERT INTO MEM_GRADE VALUES(30,'특별회원');
    
    CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY, 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER  CHAR(3) CHECK(GENDER IN('남','여')), 
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER     --회원 드급번호 같이 보관을 해볼려고 생성함.
);
    SELECT * FROM MEM;
    INSERT INTO MEM VALUES(1,'user01','pass01','해리 케인','남',null,null,null);
    INSERT INTO MEM VALUES(2,'user02','pass02','카시야스',null,null,null,10);
    INSERT INTO MEM VALUES(3,'user03','pass03','살라',null,null,null,99);
--현재 유효한 회원의 등급이 아닌에도 불구하고 삽입(insert_)가 잘 되고 있다. 이러면 안된다. 
--유요한 회원이 아니면(99번) 삽입되지 않게 막아야 한다. 

/*
FOREIGN KEY(외래키) 제약 조건
다른 테이블에 존재하는 값만 들어와야 하는 특정 컬럼에 부여하는 제약조건.
--> 다른 테이블을 참조한다. 
--> 주로 FOREIGN KEY 제약 조건에 의해 테이블 간의 관계가 형성된다. 

1. 컬럼 레벨 방식. 
 컬럼명 자료형 [CONSTRAINT 제약조건명]REFERENCES 참조할 테이블명 (참조할 컬럼명)
 
2. 테이블 레벨 방식. 
 [CONSTRAINT 제약조건명]FOREIGN KEY(컬럼명) REFERENCES 참조할 테이블명(참조할 컬럼명)
 -> 참조할 컬럼명 생략시 참조할 테이블의PRIMARY KEY 로 지정된 컬럼으로 매칭

*/
DROP TABLE MEM;

   CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY, 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER  CHAR(3) CHECK(GENDER IN('남','여')), 
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER  REFERENCES MEM_GRADE(GRADE_CODE)  
--    GRADE_ID NUMBER  REFERENCES MEM_GRADE 이렇게 (GRADE_CODE) 을 쓰지 않으면 , 프라이머리키로 자동 설정 됨. / 컬럼 레벨 방식이다. 
--     FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) --> TABLE LEVEL 방식. 
);

SELECT * FROM MEM;
    INSERT INTO MEM VALUES(1,'user01','pass01','해리 케인','남',null,null,null);
    INSERT INTO MEM VALUES(2,'user02','pass02','카시야스',null,null,null,10);
    INSERT INTO MEM VALUES(3,'user03','pass03','살라',null,null,null,99);
-- ORA-02291: integrity constraint (DDL.SYS_C007139) violated - parent key not found
--PARENT KEY 를 찾을 수 없다는 오류 발생.
--10,1\20,30 으로 제한이 되어있는데 99가 나왔으니, 오류가 난다.
    INSERT INTO MEM VALUES(4,'user04','pass04','클로제',null,null,null,30);

--mem+grade(부모테이블  --- < mem 자식 테이블

SELECT * FROM MEM_GRADE;
SELECT * FROM MEM;

--MEM_GRADE 테이블에서 10번 등급 삭제 해보자
DELETE
FROM MEM_GRADE
WHERE GRADE_CODE = 10;
-- ORA-02292: integrity constraint (DDL.SYS_C007139) violated - child record found
-- 자식기록에서 NULL을 쓰고 있으니 삭제가 안된다. 
--자식테이블 (MEM)에 10이라는 값을 사용하고 있기에 삭제가 안된다. 

--40번 이라는 코드를 추가해보자. 
INSERT INTO MEM_GRADE VALUES(40,'VIP회원');
SELECT * FROM MEM_GRADE;

--추가한 40번 코드를 다시 삭제해보자. 
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 40;
--자식 테이블(MEM)에 40이라는 값을 사용하고 있지 않기 때문에 삭제가 잘 된다. 
--확인해보면, MEM_GRADE 의 GRADE_ID 를 보면 코드들을 사용하고 있는 것을 확인할 수 있을것이다. 

/*
    자식 테이블 생성시 외래키 (FORIGN KEY) 제약조건을 부여할 떄. 삭제 옵션을 지정 할 수 있다. 
    삭제옵션이란 : 부모테이블의 데이터 삭제시 그 데이터를 사용하고 있는 자식테이블의 값을 어떻게 처리할 껀지. 3가지가 있다. 
    
    1. ON DELETE RESTRICTED(기본값) : 삭제제한옵션으로, 자식데이터로 쓰이는 부모데이터는 삭제 아예 안되게끔 막아준다.
    위에 상황처럼, GRADE_ID 10 값을 삭제하고자 할떄, 시스템에서 자식테이블에 그 값이 사용되고 있으니, 현재는 삭제가 안된다. 라고 막아준다. 
    
    2. ON DELETE SET NULL :  삭제제한 두 번쨰 옵션으로, 부모데이터를 지우면 해당 데이터를 사용하고 있는 자식 테이블의 값을 NULL로 변경한다. 
    만약, 위에 상황에서 SET NULL 로 설정하고 10을 삭제 한다고 했을떄, 부모테이블에서는 10이 잘 삭제가 되고, 자식 테이블은 값이 삭제가 되고 NULL로 변경이 된다. 
    
    3. ON DELETE CASCADE : 부모데이터 삭제시 해당 데이터를 사용하고있는 자식 데이터도 연쇄적으로 같이 삭제를 시킨다. (연대책임)??
*/
    
    
    DROP TABLE MEM;
-- ON DELETE SET NULL 을 사용해보자.
    CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY, 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER  CHAR(3) CHECK(GENDER IN('남','여')), 
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER  REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE SET NULL
    );
SELECT * FROM MEM_GRADE;
SELECT * FROM MEM;


INSERT INTO MEM VALUES(1,'user01','pass01','해리 케인','남',null,null,null);
    INSERT INTO MEM VALUES(2,'user02','pass02','카시야스',null,null,null,10);

    INSERT INTO MEM VALUES(3,'user04','pass04','클로제',null,null,null,30);

--GRADE_ID(10)등급 삭제
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;
--삭제 잘된
ROLLBACK;

SELECT * FROM MEM;
SELECT * FROM MEM_GRADE;
  DROP TABLE MEM;
-- ON DELETE CASCADE를 사용해보자.
 CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY, 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER  CHAR(3) CHECK(GENDER IN('남','여')), 
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER  REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE
    );
    INSERT INTO MEM VALUES(1,'user01','pass01','해리 케인','남',null,null,null);
    INSERT INTO MEM VALUES(2,'user02','pass02','카시야스',null,null,null,10);
    INSERT INTO MEM VALUES(3,'user04','pass04','클로제',null,null,null,30);
    INSERT INTO MEM VALUES(4,'user05','pass02','드록바',null,null,null,40);

DELETE FROM MEM_GRADE 10;
--해당 데이터(MEM_GRADE 10) 를 사용하고 있던 자식 데이터도 다 같이 DELETE 된다. 
----------------------------

SELECT * FROM MEMBER;

DROP TABLE MEMBER;

--컬럼명 자료형 DEFALUT 기본값 [제약조건]
CREATE TABLE MEMBER(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_NAME VARCHAR2(20) NOT NULL,
    MEM_AHE NUMBER,
    HOBBY VARCHAR2(20) DEFAULT '없음',
    ENROLL_DATE DATE DEFAULT SYSDATE
);
SELECT * FROM MEMBER;
INSERT INTO MEMBER VALUES(1,'호날듀',20,'축구','25/01/01');
INSERT INTO MEMBER VALUES(2,'메쉬',21,'축구','25/01/02');
INSERT INTO MEMBER VALUES(3,'제라드',NULL,'축구',NULL);
INSERT INTO MEMBER VALUES(4,'조 하트',NULL,'NULL',DEFAULT);
INSERT INTO MEMBER VALUES(5,'스콜피온',NULL,DEFAULT,DEFAULT);
--내가 설정한 디폴트 값으로 들어감.
--INSERT INTO(테이블명(컬럼명, 컬럼명, 컬럼명..) VALUES(값1, 값2, 값3...);
--NOT NULL 인거 꼭 써야함.

INSERT INTO MEMBER(MEM_NO,MEM_NAME) VALUES(4,'이강인');
--지정(선택) 하지 않은 컬럼에 대해서는 NULL이 들어가는게 맞다. 
--3, 이강인 , NULL, NULL, NULL 이 들어가는게 맞는데 해당 컬럼에ㅐ DEFAULT 값으로 세팅되어있을 경우
--NULL이 아닌 DEFAULT 값이 자동으로 들어가니 편안하다. 

--=====================
-- 이전까지는 DDL 계정으로 진행했는데, 지금부터는 KH 로 진행해 보겠다. 
/*
서브 쿼리를 통해, 테이블을 생성해보는 방법을 해보자.
테이블 복사 뜨는 개념이라고 생각해도 좋다. 
[표현식]
CREATE TABLE 테이블명
AS 서브쿼리;
*/

--EMPLOYEE 테이블을 복제한 새로운 테이블 생성
CREATE TABLE EMPLOYEE_COPY
AS  SELECT * 
    FROM EMPLOYEE;
SELECT* FROM EMPLOYEE_COPY;
--컬럼, 데이터값, 제약조건 같은 경우는 NOT NULL로만 복사가 된다. 


CREATE TABLE EMPLOYEE_COPY2
AS SELECT EMP_ID, EMP_NAME, SALARY, BONUS 
    FROM EMPLOYEE
    WHERE 조건 ; -- 무조건 FALSE 인 조건을 기재 해야 한다.
    
CREATE TABLE EMPLOYEE_COPY2
AS SELECT EMP_ID, EMP_NAME, SALARY, BONUS 
    FROM EMPLOYEE
    WHERE 1 = 0; --무조건 FALSE인 조건 : 구조만을 복사하고자 할 때 쓰이는 구문(데이터 값은 필요가 없을때)
SELECT * FROM EMPLOYEE_COPY2;

CREATE TABLE EMPLOYEE_COPY3
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12 AS " 연봉"
    FROM EMPLOYEE; --00998. 00000 -  "must name this expression with a column alias"
    --alias : 별칭.  즉, 별칭을 붙혀줘라 라는 뜻.
    --서브쿼리 SELECT 절에 산술식 또는 함수식이 기술된 경우 반드시 별칭을 지정 해줘야 한다. 그래야 오류가 안난다. 
    --SALARY *12 때문에 오류가 난거니까, AS "연봉" 같이 별칭을 붙혀주자.
SELECT * FROM EMPLOYEE_COPY3;

----------------------------------------
/*
테이블 다 생성된 후에 뒤늦게 재약조건 추가해보기.
ALTER 기능을 통해 뒤늦게 제약조건 추가 가능.

ALTER TABLE 테이블명 변경할 내용;
1. PRIMARY KEY 
    ALTER TABLE 테이블명 ADD PRIMARY KEY(컬럼명);

2. FOREIGN KEY
    ALTER TABLE 테이블명 ADD FOREIGN KEY(컬럼명) REFERENCES 참조할 테이블명(참조할 컬럼명)
    
3. UNIQUE 
    ALTER TABLE 테이블명 ADD UNIQUE (컬럼명);

4. CHECK
    ALTER TABLE 테이블명 ADD CHECK(컬럼명);

5. NOT NULL
    ALTER TABLE 테이블명 MODIFY 컬럼명 NOT NULL;    */
--서브쿼리를 이용해서 복제한 테이블은 NN 제약조건 빼고는 복제가 안됨.
--EMPLOYEE_COPY 테이블에 PRIMARY KEY 제약조건을 추가해보자. (EMP_ID)

ALTER TABLE EMPLOYEE_COPY ADD PRIMARY KEY(EMP_ID);
--EMPLOYEE_COPY 라는 테이블에 PRIMARY KEY 를 EMP_ID 컬럼에 넣고 싶다~


--EMPLOYEE 테이블에 DEPT_CODE 에 외래키 제약조건 추가해보기(참조하는 테이블(부모) : DEPARTEMNT(DEPT_ID)

ALTER TABLE EMPLOYEE ADD FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT;
--해당(참조하는 테이블(부모) : DEPARTEMNT(DEPT_ID)에 참조하는 컬럼을 적지 않으면, 부모 테이블에서 설정된 DEPT_ID가 기본값이 되어 , 
--DEPARTMENT(DEPT_ID) 으로 설정된다. 

--EMPLOYEE 테이블에 HOB_CODE 에 외래키 제약조건 추가. 
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(JOB_CODE) REFERENCES JOB;
SELECT * FROM EMPLOYEE;
--EMPLOYEE 라는 테이블에 SAL_LEVEL에 외래키 제약조건 추가. 
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(SAL_LEVEL) REFERENCES SAL_GRADE;
--DEPARTMENT 테이블에 LOCATION_ID에 외래키 제약조건 추가해보기.
ALTER TABLE DEPARTMENT ADD FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION;




