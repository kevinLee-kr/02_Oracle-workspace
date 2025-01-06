/*
DDL( DATE DEFINITION LANGUAGE) : 데이터 정의 언어

객체들을 생성(CREATE), 변경(ALTER) , 삭제(DROP) 하는 구문.

<ALTER>
객체를 변경하는 구문. 
[표현식]
ALTER TABLE 테이블명 변경할내용;

*변경할 내용
1) 컬럼 추가 OR 수정 OR 삭제할떄 ALTER를 사용할 수 있음
2) 제약조건 추가 / 삭제 --> 수정은 아니된다. (하고자 한다면, 삭제후 재생성 해야한다. )
3) 컬럼명 / 제약조건명 / 테이블명 변경
*/

--1) 컬럼 추가 / 수정 / 삭제
--1-1 ) 컬럼 추가 (ADD) : ADD 컬럼명 자료형 [DEFAULT 기본값 제약조건]
--DEPT_COPY 에 CNAME 이라는 컬럼을 추가해보쟈ㅏ. 

SELECT * FROM DEPT_COPY;

ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);
-->새로운 컬럼이 만들어지고 기본적으로는 NULL로 채워진다. 

ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '한국';


--1-2) 컬럼 수정 해보기~
-->표현법 : MODIFY 컬럼명 바꾸고자 하는 자료형
--DEFUALT: MODIFY 컬럼명 DEFAULT 바꾸고자 하는 기본값

ALTER TABLE DEPT_COPY 변경할 내용;
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);
ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER; -- 오류남, 이미 데이터가 숫자 아닌것들이 들어있기에...
-- 존재하는 데이터가 없어야만 바꿀 수 있다. 

ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(10);
--01441. 00000 -  "cannot decrease column length because some value is too big"
--이미 컬럼에 값들이 담겨있는데, 그것들이 설정할려는 사이즈보다 크기에, 바꿀 수가 없다. 


--DEPT_TITLE 컬럼을 VARCHAR2(50)로 -> DEPT_COPY 테이블로 바꾸어보기
--LOCATION_ID 컬럼을 VARCHAR2(4) 로
--LNAME 컬럼의 기본값을 '영국'으로 바꾸어보기.

ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(50);
ALTER TABLE DEPT_COPY MODIFY LOCATION_ID VARCHAR2(4);
ALTER TABLE DEPT_COPY MODIFY LNAME DEFAULT '영국';

SELECT * FROM DEPT_COPY;
---------------다중 변경이 가능하다.
ALTER TABLE DEPT_COPY
    MODIFY DEPT_TITLE VARCHAR2(50)
    MODIFY LOCATION_ID VARCHAR(4)
    MODIFY LNAME DEFAULT '영국';

--------------------
--1-3)컬럼삭제( DROP COLNUM ) : DROP COLUMN 삭제 하고자 하는 컬럼명
--삭제를 위한 복사본 테이블 생성
CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;

SELECT * 
FROM DEPT_COPY2;
--DEPT_COPY2 로 부터 DEPT_ID  컬럼 지워보기.
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;
--DROP COLUMN은 다중으로 작성이 불가능하다. 
ALTER TABLE DEPT_COPY2 DOPR COLUMN LOCATION_ID;

/*
--2) 제약조건 / 추가 / 삭제
--PRIMARY,      : ADD PRIMARY KEY(컬럼명) 
--FOREIGN       : ADD FOREIGN KEY(컬러명) : REFERTENCES참조할 티이블명
--UNIQUE        : ADD UNIQUE(컬렴명)
--CHECK         : ADD CHECK(컬럼에 대한 조건)
--NOT NULL      : MODIFY 컬럼명 NOT NULL | NULL
제약조건명을 지정하고자 한다면, [컨스트레잍트 제약고건명) 제약 조건
*/

--DEPT_ID 에 PRIMARY KEY  제약조건 추가 ADD
--DEPT_TITLE 에 UNIQUE 제약조건 추가.
--LNAME 에 NOT NULL 제약조건 추가 MODIFY

ALTER TABLE DEPT_COPY
    ADD CONSTRAINT DCOPY_PK PRIMARY KEY(DEPT_NO)
    ADD CONSTRAINT DCOPY_UQ UNIQUE(DEPT_TITLE)
    MODIFY LANEM CONSTRAINT DCOPY_NN NOT NUILL;
--요런식으로 뒤늦게 제약조건을 추가 해줄 수 있다. 

--2-2) 제약조건 삭제 : DROP CONSTAT 제약조건명
--NOT NUMM 은 삭제가 안되고 MODIFY NULL이걸로 수정해줘야 한다. 
ALTER TABLE DEPT_변경할 내용;
ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_PK;

ALTER TABLE DEPT_COPY
    DROPT CONSTRAINT DCOPY)QU
    MODAFY LANME NULL;
    ==현재 지금 ALTER 수업을 하고 있다. 
    3)
--3_1)컬럼명 변경해보기.
RENAME COLUMN 기본컬럼명 TO 바꿀 컬럼명

현재 DEPT_TITLE 을 DEPT_NAME 
ALTER TABLE DEPT_COPY 변경할 내용
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_COPY INTO DEPT_NAME;

--E_2) 제약조건명 변경 : RENAME CONSTRAINT 제약조건명 TO 바꿀 제약 조건명;
--DEPT_COPY 테이블에서 SYS_C007173를 DCOPY_DID_NN로 바꾸기
ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007173 TO DCOPY_DID_NN;

--3-3) 테이블명 변경 : RENAME 기본 테이블명 TO 바꿀 테이블명;
--DEPT_COPY 테이블 이름을 DEPT_TEST로 변경해보기
ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST;
SELECT * FROM DEPT_TEST;

-----------------------------------------------------------------
/*
2. DROP 객체를 삭제하는 구문
[표현법]
DROP TABLE 삭제하고자 하는 테이블명;
*/
--EMP_NEW 삭제
DROP TABLE EMP_NEW ;

--부모테이블을 삭제할 경우, 테스트 할 환경 만들기. 
--1) DEPT_TEST 테이블을 조회해 보면, DEPT_ID가 있다. 
--그 컬럼을 먼저 PRIMARY KEY 제약조건 추가 해보기.
 ALTER TABLE DEPT_TEST
 ADD CONSTRAINT DTEST_PK PRIMARY KEY (DEPT_ID);

SELECT * FROM DEPT_TEST;
--2) EMPLOYEE_COPY3 에 컬럼 추가 -> 외래키 제약조건
ALTER TABLE EMPLOYEE_COPY3
ADD DEPT_CODE CHAR(3);

ALTER TABLE EMPLOYEE_COPY3 FOREIGN K

ALTER TABLE EMPLOYEE_COPT3
변경할 내용
ALTER TABLE EMPLOYEE_COPY3 CONSTRAINT ECOPY_FK FOREIGN KEY(DEPT_CODE) REFERENCES DEPT_TEST;

DROP TABLE DEPT_TEST;
--단, 참조되고 있는 부모테이블은 삭제되지 않음
--만약에 부모테이블을 삭제하고자 한다면, 
--방법 1) 자식테이블을 먼저 삭제, 즉, 참조하고있는 자식을 먼저 지우고ㅓ, 삭제
--방법 2)자식테이블에서 외래키 제약조건 삭제 후 부모테이블 지우기.

--CNS DDL풀어보기. 








