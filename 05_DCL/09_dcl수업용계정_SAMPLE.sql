--우효

CREATE TABLE TEST(
    TEST_ID NUMBER,
    TEST_NAME VARCHAR2(10)
);
--TEST 라는 테이블을 한번 만들어봐야지?

--CREATE TABLE 할수 있는 권한이 없어서 문제 발생! 
--3.1 CREATE TABLE 권한 받아보기.
--3.2 TABLESAPCE 할당 받기.

INSERT INTO TEST VALUES(10,'안녕');
SELECT * FROM TEST;
-- CREATE TABLE 권한을 받으면 테이블을 바로 조작 가능
--------------------------------------------------
--갑자기 여기서 EMPLOYEE 테이블을 조회 해 보고 싶어. 
--여기서.
--KH 계정에 있는 EMPLOYEE 테이블에 접근 해보자. 
--권한을 받으면 된다. 
--근데 나는 아직 조회 권한이 없다.  그래도 한번 해보자.
SELECT * FROM KH.EMPLOYEE;
SELECT * FROM KH.DEPARTMENT;

--4. SELECT ON KH.EMPLOYEE 권한이 필요하다. 

--5. INTO KH.DEPARTMENT
INSERT INTO KH.DEPARTMENT
VALUES('D0','회계부','L1');

ROLLBACK;
COMMIT;


