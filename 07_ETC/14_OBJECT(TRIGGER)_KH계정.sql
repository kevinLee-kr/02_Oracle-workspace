/*
 < 트리거 TRIGGER>
 내가 지정한 테이블에 INSERT, UPDATE, DELETE 등 DML문에 의해 변경사항이 생길떄
 (테이블에 이벤트가 발생했을떄)
 자동으로 매번 실행할 내용을 미리 정의해둘 수있는 객체
 
 EX) 
1. 회원 탈퇴시 기존의 회원테이블의 데이터를 DELETE 후 곧바로 탈퇴된 회원들만
 따로 보관하는 테이블에 자동으로 INSERT 처리 해야 된다. 
 
2. 신고횟수가 일정 수를 넘었을때 묵시적으로 해당 회원을 블랙 리스트로 처리 되게끔 트리거를 자주 사용한다. 
 
3. 입출곡에 대한 데이터가 기록(INSERT) 될때마다 해당 상품에 대한 재고수량을 매번 수정(UPDATE) 해야할 떄.

    * 트리거 종류
    1. SQL문의 실행 시기에따른 분류
        > BEFORE TRIGGER : 내가 지정한 테이블에 이벤트가 발생되기 전에 트리거 실행
        > AFTER TRIGGER : 내가 지정하나 테이블에 이벤트가 발생한 후에 트리거 실행한다.
        
    2. SQL문에 의해  영향을 받는 각 행에 따른 분류
        > STATEMENT TRIGGER(문장트리거) : 이벤트가 발생한 SQL문에 대해 딱 한번만 트리거 실행.
        > ROW TRIGGER(행 트리거)        : 해당 SQL문을 실행 할때마다 매번 트리거를 실행하겠다. 
            --> FOR EACH ROW 옵션 기술 해야한다.
            OLD - BEFORE UPDATE (수정전 자료), BEFORE DELETE (삭제 전 자료)
                -- 
            NEW - AFTER INSERT(추가된 자료), AFTER UPDATE(수정 후 자료)
                --
                
                
        * 트리거 생성 구문
        [표현식]
        CREATE [OR REPLACE] TRIGGER 트리거명
        [BEFORE|AFTER] [INSERT|UPDATE|DELETE] ON 테이블명
        [FOR EACH ROW] = 행트리거를 쓰려고 할때 사용함.
        ㄴ -> 프로시져로 ㄸ꼭 짜야함!
        ㄴ ->    DECLARE 
                    변수선언
                BEGIN
                    실행내용 -> 해당 위에 지정된 이벤트 발생시 묵시적으로(자동으로) 실행한다. 
                 EXCEPTION
                    예외처리구문
                EXID;
                /
*/

--EMPLOYEE 테이블에 새로운 행이 INSERT 될떄마다 자동으로 메세지를 출력해주는 트리거 정의
CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT ON EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE('신입 반갑고');
END;
/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, SAL_LEVEL, HIRE_DATE)
VALUES(500,'이순신','111111-1111111','D7','J7','S2',SYSDATE);

-----------
-- 상품 입고 및 출고 관련 예시
-->> 테스트를 위한 테이블 및 시퀀스 생성.
---> 1. 상품에 대한 데이터를 보관할 테아블 (TB_PRODUCT)
CREATE TABLE TB_PRODUCT(
    PCODE NUMBER PRIMARY KEY,  
    PNAME VARCHAR2(30) NOT NULL,       
    BRAND VARCHAR2(30) NOT NULL,         
    PRICE NUMBER,
    STOCK NUMBER DEFAULT 0             
    );

--상품번호 중복 안되게끔 매번 새로운 번호 발생시키는 시퀀스(SEQ_PCODE)
CREATE SEQUENCE SEQ_PCODE
START WITH 200
INCREMENT BY 5
NOCACHE;

--샘플 데이터 추가 해보기.
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '갤럭시S25','삼성', 1400000, DEFAULT);
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '아이폰16','애플', 1300000, 10);
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '대륙폰','샤오미', 600000, 20);

SELECT * FROM TB_PRODUCT;
COMMIT; --데이터를 확정 시키고 싶다.!  

--2. 상품 입출고 상세 이력 테이블 (TB_PRODETAIL)
--어떤 상품이 어떤 날짜에 몇개가 입고가 되었는지, 또는 몇개가 출고 되었는지에 대한 데이터를 기록하는 테이블.

CREATE TABLE TB_PRODETAIL(
    DCODE NUMBER PRIMARY KEY,--이력번호
    PCODE NUMBER REFERENCES TB_PRODUCT,  --상춤번호
    PDATE DATE NOT NULL,                --상품을 입출고 날짜.
    AMOUNT NUMBER NOT NULL,             --입출고 수량
    STATUS CHAR(6) CHECK(STATUS IN('입고','출고')) --상태(입고/출
);

--이력번호로 매번 새로운 번호 발생시켜서 들어갈 수 있게 도와주는 시퀀스(SEQ_DCODE)
CREATE SEQUENCE SEQ_DCODE
NOCACHE;

--20번 상품이 오늘 날짜로 10개가 입고가 되었다고 가정을 해보자. 
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 200, SYSDATE,10, '입고');
--200번 상품의 재고수량을 10개 증가 되야됨.
UPDATE TB_PRODUCT
SET STOCK = STOCK + 10
WHERE PCODE = 200;
COMMIT; -- 해당 트랜젝션 을 커닛해준다.

--210번 상품이 오늘 날짜로 5개 출고.
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 210, SYSDATE,5, '출고');
--210번 삼품의 재고수량을 5 감소
UPDATE TB_PRODUCT
SET STOCK = STOCK - 5 
WHERE PCODE = 210;
COMMIT;

--205번 상품이 오늘 날짜로 20개 입고를 했다.
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 205, SYSDATE, 20, '입고');

--205번 상품의 재고수량을 20 증가
UPDATE TB_PRODUCT
SET STOCK = STOCK + 20
WHERE PCODE = 200;--잘못 오기입 함..

ROLLBACK;
--205번 상품이 오늘 날짜로 20개 입고함
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 205,SYSDATE,20,'입고');

--205번 상품의 재고수량을 20 증가 시켜야 겠따. 
UPDATE TB_PRODUCT
SET STOCK = STOCK + 20
WHERE PCODE = 205;
COMMIT;

--TB_PRODETAIL 테이블에 INSERT 이벤트 발생시
--TB_PRODUCT 테이블에 매번 자동으로 재고수량 UPDATE 되게끔 트리거 정의하자

--상품이 입고된 경우
--> 해당 상품을 찾아서 재겨수량 증가...
--UPDATE TB_PRODUCT
--SET STOCK = STOCK + 현재입고된 수량(INSERT된 자료의 A MOUNT 값)
--WHERE PCODE = 현재 입고된 상품번호(INSERT가된 자료의 PCODE 의 값);
----상품이 출고된 경우 -> 해당 상품 찾아서 재고수량 감소.UPDATE
--UPDATE TB_PRODUCT
--SET STOCK = STOCK - 현재 출고된 수량(INSERT된 자료의 A MOUNT 값)
--WHERE  PCODE = 현재 출구된 상품 번호. (INSERT가된 자료의 PCODE 의 값);

CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON TB_PRODETAIL
FOR EACH ROW
BEGIN
    IF (:NEW.STATUS = '입고')    --상품이 입고된 경우 -> 재고수량  증가.
        THEN
            UPDATE TB_PRODUCT
            SET STOCK = STOCK +:NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
    END IF; 
    
     -- 상품이 출고된 경우 -> 재고슈량 감소
    IF(:NEW.STATUS = '출고')
        THEN    
            UPDATE TB_PRODUCT
            SET STOCK = STOCK - :NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
        END IF;
END;
/
--210번 상품이 오늘날짜로 7개 출고

INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL,210,SYSDATE, 7,'출고');

--200번 상품이 오늘날짜로 100개 입고
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL,200,SYSDATE, 100,'입고');