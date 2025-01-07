--tcl
/*
TCL]
TRANSACTION CONTROL LANGUAGE
트랜젝션 제어 언어. 

트랜젝션 / TRANSACTION
데이터 베이스의 논리적 연산단위
- 데이터의 변경사항(DML 추가 ,수정, 삭제)들을 하나의 트랜젝션에 묶어서 처리
- DML문 한개를 수행할때 트랜젝션이 존재하면 해당 트랜젝션에 같이 묶어서 처리 해야 한다. 
- 만일 트랜젝션이 존재하지 않으면 트랜젝션을 만들어서 묶어줘야 한다. 

내가 INSERT 를 게시판이라는 TABLE 에 INSERT 하는데 트랜젝션이 안보인다. 
하나를 만든다. 
INSERTF를 트랜젝션에 넣는다. 
커밋한다.
실제 DB에 반영한다. 


DB에서 어떠한 작업을 수행 하더라고 COMMIT 하기 전까지 변경사항들을 하나의 트랜젝션에 담게 된다. 
커밋을 해야만이 실제 DB에 반영이 된다고 생각해야한다. 

- 트랜젝션의 대상이 되는 SQL : INSERT, UPDATE, DELETE (DML)

COMMIT(트랜젝션 종료 처리 후 확정)
ROLLBACK(트랜젝션 취소)
SAVEPOINT(임시저장)
*/

--COMMIT : 한 트랜젝션에 담겨있는 변경 사항들을 실제 DB에 반영시키겠다는 의미. 
--ROLLBACK : 한 트랜젝션에 담겨있는 변경사항들 삭제(취소) 한 후 마지막 COMMIT 시점으로 돌아간다. 
-- SAVEPOINT 포인트 명: 현재 이시점에 해당 포인트명으로 임시저장점을 정의해두는 것. 

SELECT * FROM EMP_01;
--사번이 900번 사원 지워보기. 
DELETE FROM EMP_01
WHERE EMP_ID = 900;
--사번이 901번인 사원 지워보기.
DELETE FROM EMP_01
WHERE EMP_ID = 901;


ROLLBACK;
--변경 사항들이 취소되고, 트랜젝션도 없어짐, 데이터가 다시 되살아난다. 
--------------------------------------------------------------------
--200번 사원 지우기.
DELETE FROM EMP_01
WHERE EMP_ID = 200;

SELECT * FROM EMP_01;

ROLLBACK; -- 이미 커밋해서 못돌아간다. .. .
-----------------------------------------------
--217, 216, 214 번 사원을 지워보자. 
DELETE FROM EMP_01
WHERE EMP_ID IN(217,216,214);
SELECT * FROM EMP_01;

--임시저장 점
SAVEPOINT SP;


--801 안효섭, 인사관리부 추가해보자. 
INSERT INTO EMP_01
VALUES(801,'안효섭','인사관리부');

--218사원 해고
DELETE FROM EMP_01
WHERE EMP_ID = 218;

--여기서 ROLLBACK 해버리면 전부 다 취소ㅈ됨, 마지막 커밋 시점으로 돌아감. 

-- 801 추가량, 218 삭제만 취소하고 싶다. 

ROLLBACK TO SP;

COMMIT ; 

--야 이거 트랜젝션 처리했냐? 하면 뭘 해야 하지? 
DELETE FROM EMP_01 
WHERE EMP_ID IN(900,901);

--218 사원 지우자
DELETE FROM EMP_01
WHERE EMP_ID = 218;

--DDL 문을 만들 일이 생겼다. 
CREATE TABLE TEST(
    TID NUMBER
    );
    
    ROLLBACK; -- 어 218이 아니라 118 이었다. 다시 되돌려라.  ROLLBACK~ 해버렸다. 그러면 DDL문또한 사지게 되는 것이다. 
    --DDL문을 수행하는 순간 트랜젝션이 실제 DB에 반영되고 DDL 문이 수행된다. 

--DDL문(DATE DEFINITION LANGUAGE)
--CREATE, ALTER, DROP)을 수행하는 순간 기존에 트랜젝션에 있던 변경사항들을
--무조건 COMMIT 하게됨 (실제 DB에 반영된다는 소리)
-- 즉, DDL문 수행 전 변경사하들이 있었다면 정확히 픽스(COMMIT, ROLLBACK) 을 하자
-- 그렇게 하지 않으면, DDL 문이 실행되기 전 트랜젝션에 담겨있는 DML 문들이 
--DDL 문이 실행 되는 순간 다 같이 실제 DB 로 우르르 몰려 나가기 때문이다. 
-- 조심해야 한다. 



















