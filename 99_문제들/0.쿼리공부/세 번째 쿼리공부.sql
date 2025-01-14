--복습 드가자

--QUIZ 1 (DCL)복습


--CREATE USER TEST IDENTIFIED BY 12344;실행
--USER TEST(이)가 생성 되었습니다. 
-- 계정 생성만 하고 접속시 에러발생 

--왜 오류가 났을까여ㅛ? 해결방안을 적으시오. 

--문제점 : 계정 생성만 했고, 접속 권한을 부여하지 않았기 때문.

--GRANT CONNECT , RESOURCE TO TEST 로 썻겠지? <--문제에서 딱히 다른 말이 없으면 이렇게 썻겠지
--GRANT CREATE SESSION TO TEST;
-- CREATE SESSION 접속 할 수 있는 권한. 이것 처럼. 접속할수 있는 롤을 적어라~ 라고 좀 난이도 있게 낼 수도 있다. 

--QUIZ2(JOIN 복습)
CREATE TABLE TB_JOB(
    JOBCODE NUMBER PRIMARY KEY, 
    JOBNAME VARCHAR2(10) NOT NULL   
);
--하나 더 테이블이 필요한거 같다.  어떤 테이블을 만들거냐면
CREATE TABLE TB_EMP(
    EMPNO NUMBER PRIMARY KEY,
    EMPNAME VARCHAR2(10) NOT NULL,
    JOBNO NUMBER REFERENCES TB_JOB(JOBCODE)
);


--위의 두 테이블이 있다는 가정하에 
--두 테이블 을 조인해서 EMPNO, EMPNAME, JOBNO, JOBNAME컬럼 을 조회 하고 싶다. 
--이떄 실행한 SQL문은 이렇다.  오류가 났다, 조치를 취해주라.  라고 나올 수 있다. 

SELECT EMPNO, EMPNAME, JOBNO, JOBNAME
FROM TB_EMP
JOIN TB_JOB USING(JOBNO);
--ORA-00904: "TB_JOB"."JOBNO": invalid identifier
--문제점. JOBNO라는 컬럼이 TB_EMP에는 존재하지만, TB_JOB에는 존재하지 않기 떄문에 USING 구문에 문제가 있음.
--조치내용:USING이 아닌 ON절을 사용해서 원활하게 JOIN해 주는 것이 바람직 하다.
--조치한 내용 코드는 아래와 같다.
SELECT EMPNO, EMPNAME, JOBNO, JOBNAME
FROM TB_EMP
JOIN TB_JOB ON(JOBNO = JOBCODE);



--테이블을 생서할떄 데이터 타입이 여러가지 존재한다. 
--(CHAR, VARCHAR2() 의 차이점을 설명하라. )
--오라클 객체 각각뭔지
--커밋 롤백 뭘까? 
--QUIZ_3 ( WHERE OR HAVING ? )
--아래의 SQL구문은 부서별 월급 합계가 1500만원을 초과하는 부서를 조회한 것이다. 
--결과가 올바르지 않다. 원인이 무엇이고, 조취를 취하라. 
--문제의 쿼리는아래와 같다. 
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE SUM(SALARY) >= 15000000
GROUP BY DEPT_CODE;

--조심해야 할 점 : GROUP BY 절 할떄는 WHERE 절이 안된다.   (x)
--이것은 아니다. 위에 구문도  SUM(sALARY)이 아닌 그냥 SALARY 라고 썻으면 빈 결과가 나올 거지만 오류는 안난다.
--올바르게 표현하고 싶으면, 
--GROUP 함수식(SUM) 을 사용하고 싶으면, WHERE 이 아닌 HAVING을 적었어야 했다.
--GROUP 에 대한 조건을 제시할떄는 WHERE 절로 쓰는게 아니다. -> ㅗHAVING
--조치내용 쿼리는 아래와 같다.
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) > 15000000;
--

--QUIZ _ 4 ( 제약조건 )
CREATE TABLE QUIZ4(
    QNO NUMBER PRIMARY KEY,
    QNAME VARCHAR2(10),
    SCORE NUMBER
    );

SELECT * FROM QUIZ4;

INSERT INTO QUIZ4 VALUES(1,'QUIZ_1',30); -- 잘 이행됨
INSERT INTO QUIZ4 VALUES(2,'QUIZ_2',50); -- 잘 이행됨
INSERT INTO QUIZ4 VALUES(1,'QUIZ_3',40); --오류 PRIMARY KEY  중복
INSERT INTO QUIZ4 VALUES(NULL,'QUIZ_1',30); --오류 PRIMARY KEY 에러(NULL)

--QUIZ _ 5 (CASE WHEN)
--SALARY 가 500 이상이면 고급개발자
--            300이상이면 중급개발자
--                이것도 아니면 초급개발자
SELECT EMP_NAME, SALARY,
        CASE WHEN SALARY >= 5000000 THEN '고급 개발자'
                WHEN SALARY >= 3000000 THEN '중급 개발자'
                ELSE '초급 개발자'
                END AS "레벨"
FROM EMPLOYEE;

















