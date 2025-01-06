/*
<JOIN>
두 개 이상의 테이블에서 데이터를 조회하고자 할 때 사용되는 구문.
조회 결과ㅏ는 하나의 결과물(RESULT SET)로 나옵니다.

관계형 데이터 베이스 -> 최소합의 데이터로 각각의 테이블에 데이터를 담고 있음. 
중복을 최소화 하기 위해 최대한 쪼개서 관리함. 
EX) DEPT_CODE = J7, D5, A6
왜 총무부, 관리부, 영업부 로 직접적으로 사용하지 않고, 이렇게 J7 등 으로 표현을 하고 있을까>  
블라블라
결과적으로 J7, D4등 의 값을 답고 있는 테이블에서 코드만 수정해줌으로써, 효율적으로 모든 정보를 업데이트 해줄 수 있기 때문. 
-> 관계형 데이터베이스에서SQL문을 이용한 테이블간의"관계"를 맺는 방법
(무작정 다 조회를 해오는게 아니라 각 테이블간의 연결고리로써의 데이터를 매칭 시켜서 조회해야함.
JOIN은 크게 "오라클 전용구문"과 "ANSI구문" (ANSI==미국국립표준협회) -> 아스키코드 만드는 단체
JOIN
1. 오라클 전용구문 - 
2. ANSI 구문  - 

JOIN 전용 구문 들에 대해서 알아보자. 

오라클 전용 구문                           ANSI 구문
--=====================================================
등가 조인                |                  내부조인(INNER JOIN)
(EQUAL JOIN)            |                   자연조인(NATUAL JOIN)
--------------------------------------------------------------------
포괄 조인               |                   왼쪽 외부 조인(LEFT OUTER JOIN)
(LEFT JOIN)             |                   오른쪽 외부 조인(RIGHT OUTER JOIN)
(RIGHT JOIN)            |                   전체 외부 조인(FULL OUTER JOIN)
-------------------------------------------------------------------------
자체조인(SELF JOIN)     |                     
비등가 조인(NON EQUAL JOIN)|
------------------------------------------------------------------------------
*/
--전체 사원들의 사번, 사원명, 부서코드, 부서명 조회하고자 할떄
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

--전체 사원들의 사번, 사원명, 직급토드, 직급명 조회하고자 할떄
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE;

SELECT JOB_CODE, JOB_NAME
FROM JOB;

/*
구하고자 값이 담겨있는 공통적인 컬럼을 찾았다. 
1. 등가조인(EQUAL JOIN)/ 내부 조인(INNER JOIN)
연결시키는 컬럼의 값이 일치하는 행들만 조인되서 조회(== 일치하는 값이 없는 행은 조회에서 제외)

-->오라클 전용 구문
FROM 절에 조회하고자 하는 테이블들을 나열한다. 
그다음으로, WHERE 절에 가보면 , 매칭시킬 컬럼(연결고리, 공통적인 값을 갖고 있는 컬럼_에 대한 조건을 제시한다. 


*/
--1. 연결할 두 컬럼명이 다른경우 예) DEPT_CODE, DEPT_ID , 두 컬럼 명이 다르지만, 둘다 D1,2,3,4,등 같은 값을 갖고 있다. 사번, 부서콛, 부서명을 같이 조회해보자.

SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID ;
--2. 연결할 두 컬럼명이 같은 경우(employee : job+CODE, JOB:JOB_CODE)
-- 사번, 사원명, 직급코드, 직급명
SELECT EMP_ID,EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE,JOB
WHERE JOB_CODE=JOB;
--AMBIGUOUSLY 는 모호하다 라는 뜻이다. JOB_CODE가 두 테이블에 있는데 어느 테이블에 있는걸 쓸려는거냐?? 라는 거다. 

--해결방법 : 테이블명을 이용하는 방법 ( 조회하고자하는 테이블명.)
SELECT EMP_ID,EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE,JOB
WHERE EMPLOYEE.JOB_CODE=JOB.JOB_CODE;
--해결방법 : 테이블에 별칭을 부여해서 해결하는 방법.
SELECT EMP_ID,EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E,JOB J
WHERE E.JOB_CODE=J.JOB_CODE;
-----------------------------------------------------------
/* ANSI 구문
FROM절에 기준이 되는 테이블을 하나만 기술한 후
JOIN절에 같이 조회하고자 하는 테이블 기술 + 매칭 시킬 컬럼에 대한 조건도 기술해야한다. 
JOIN USING, JOIN ON. 명령할 컬럼명이 같은거냐 다른거냐. 

연결할 두 컬럼명이 다른 경우(EMPLOYEE:DEPT_CODE, DEPARTMENT : DEPT_ID)
오로지 JOIN ON 구문으로만 가능;
사번, 사원명 수커보드 부서명 /*
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE=DETEID);

2. 연결할 두 컬럼며이 같은 경우. (EMPLOYEE:JOB_CODE, J=JAB_챙ㄷ
JOIN ON, JOIN USING 구문도 사용가능
TKQJS, TKDNJSAUD , WLRRMQZHEM, WLRRMQAUD WHGHLGOQHWK.
SELECT EMP-ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB ON(JOB_CODE = JOB_CODE);  --오류남
 
 해결방법,1) 테이블명 또는 별깇 이용해서 방법
 SELECT EMP_10, EMP
 
 
 --해결방법2) JOIN USING 구분을 사용하는 방법( 두 컬럼명 일치할떄만 사용가능)
 SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
 FROM EMPLOYEE
 JOIN JOB USING(JOB_CODE);
 --참고사항--
 --자연조인 을 한번 해보자. (NATUAL JOIN)
 각 테이블 마다 동일한 컬럼이 딱 한개만 존재할 경우. 
 SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
 FROM EMPLOYEE
 NATURAL JOIN JOB;
--직급이 대리인 사원의 이름, 직급명, 급여 조회 해보고 싶다. 
*/
-> 오라클 전용 구문으로 한 번 해볼까?
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND JOB_NAME='대리';

-> ANSI 구문으로 한 번 해볼까?
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리';
-------------------------------------실습문제 풀어보자--------------------
--1. 부서가 인사관리부인 사원들의 사번, 이름, 보너스 조회
--오라클 전용구문으로 풀기
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID AND DEPT_TITLE ='인사관리부';

--ANSI 전용구문으로 풀기. 
 SELECT EMP_ID, EMP_NAME, BONUS
 FROM EMPLOYEE
 JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
 WHERE DEPT_TITLE ='인사관리부';
 
 --JOIN을 하기 위해서는 두 테이블 간에 공통점이 무엇인지, 공통적인 컬럼의 이름이 같은지, 확인을 먼저 해야한다. 
 
--2. DEPARTMENT 와 LOCATION을 참고해서 전체부서의 부서코드, 부서명, 지역코드, 지역명 조회해보기
--오라클 전용구문으로 풀기
SELECT * FROM DEPARTMENT; --LOCATION_ID

SELECT * FROM LOCATION; --LOCAL_CODE
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT, LOCATION
WHERE LOCATION_ID = LOCAL_CODE;
--ANSI 전용구문으로 풀기. 

SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

3. 보너스를 받는 사원들의 사번, 사원명, 보너스, 부서명 조회
SELECT * FROM DEPARTMENT; --LOCATION_ID
SELECT * FROM LOCATION; --LOCAL_CODE

--오라클 전용구문으로 풀기
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND BONUS IS NOT NULL;

--ANSI 전용구문으로 풀기. 
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE BONUS IS NOT NULL;

4. 부서가 총무부가 아닌 사원들의 사원명 , 급여 , 부서명 조회.
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
--오라클 전용구문으로 풀기
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE=DEPT_ID
AND DEPT_TITLE !='총무부';
--ANSI 전용구문으로 풀기. 

SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE !='총무부';
--지금현재 DEPT_CODE 가 NULL인것은 나오고 있지 않은 결과적으로 18명의 정보만 조회되고 있음. DEPARTMENT 에 NULL인 값이 없기 때문.

/*
포괄 조인, 외부 조인.
--월급 지급 해보기.
--사원명, 부서명, 급여, 연봉 을 조회해보자.
*/--이경우 부서배치가 아직 되지 않은(NULL)사원들은 조회가 되지 않는다. 
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
--부서에 배정된 사원이 없는 부서같은 경우도 조회가 되지 않는다. 
--여ㅓ기서 알수 있는건 등가 조인의 핵심은 , 너도 나도 값이 있어야 작동이 된다는 것이다. 
/*
포괄 조인
두 테이블간의 JOIN시 일치하지 않는 행도 포함시켜서 조회 가능하다. 
단, LEFT/FIGHT를 반드시 지정해야된다. (기준이 되는 테이블 지정한다. )
등가조인을 하다보면 값이 누락되는 경우가 있어서 포괄조인을 하는것이다. 

1. LEFT [OUTER JOIN] : 두 테이블 주 오인편에 기술된 테이블 기준으로 JOIN.
*/
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
--//컬럼명이 다르므로 ON절을 넣었던 것이다. 
--왼쪽에 있는 테이블 기준으로 모든 정보가 조회한다. LEFT [OUTER] JOIN
--부서배치를 받지 않았던 2명의 사원 정보도 조회가 된다. 총인원 23명 됨. 

--> 오라클 전용 구문
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE=DEPT_ID(+);        
--기준으로 삼고자 하는 테이블의 반대편 컬럼 뒤에 (+)를 붙이기.등가는 중다 값을 갖고 있어야 하는거고 
--OUTER 는 둘중 하나의 테이블을 기준으로 전부 조회 하는 것.

--2. RIGHT [OUTER] JOIN : 두 테이블중 오른편에 기술된 테이블을 기준으로 JOIN
--> 오라클 전용
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+)=DEPT_ID; 
--> ANSI JOIN
SELECT EMP_NAME, DEPT_TITLE SALARY, SALARY*12
FROM EMPLOYEE
RIGHT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

--3. FULL[OUTER] JOIN : 두 테이블이 가진 모든 행을 조회할 수 있음(단, 오라클 전용 구문으로는 안됨) (무조건, ANSI 문에서만 실행이 된다. )
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE
FULL JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);  
--LEFT , RIGHT 합친것 이라고 생각하면 편함, 중복되는 값을 가진 컬럼만 조회하는 기능이었던 LEFT , RIGHT 에서
--그런건 모르겠고, 모든 NULL값까지 전부 포함해서 조회할 수 있게 해주는 것이 FULL 기능이다. 


/*
3. 비등가 조인 (NON EQUAL JOIN) -> 중요하지 않음. 자주 안쓰이기 때문
매칭 시킬 컬럼에 대한 조건 작성시 '=(등호)'를 사용하지 않는 조인문
ANSI구문으로는 JOIN ON만 사용 가능하다. 
*/
-----------------------------------------------------
/*
4. SELF JOIN (자체 조인) -> 중요함
같은 테이블을 한번 더 조인 하는 경우.
--나와 내가 조인을 함으로써, 가지고 있는 값끼리 엮어 조회 할 수 이쓴ㄴ 기능.
--전체 사원의 사번, 사원명, 사원부서코드 ,사수의 사번, 사수명, 사수부서코드

--전체 사원의 사번 ㅅ, 사원명, 사원 부서코드 -> EMPLOYEE E
            사수의 사번, 사수명, 사수부서코드 -> EMPLOUU M
*/
---오라클 전용 구문
SELECT * FROM EMPLOYEE;
SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE,
 M.EMP_ID, M.EMP_NAME , M.DEPT_CODE
 FROM EMPLOYEE E, EMPLOYEE M
 WHERE E.MANAGER_ID=M.EMP_ID;
--> ANSI JOIN
SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE,
 M.EMP_ID, M.EMP_NAME , M.DEPT_CODE
 FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON(E.MANAGER_ID=M.EMP_ID);


--사수가 없는 사람도 나오게 하고 싶으면 , LEFT 조인을 하면 된다. 
-----------------------------------------------------------self join 셀프 조인 끝---------
/*
다중 조인 
N개 이상의 테이블을 가지고 JOIN 할때 사용한다. 
*/
--사번, 사원명, 부서명, 직급명, 조회.
SELECT * FROM EMPLOYEE; -- DEPT_CODE, JOB_CODE
SELECT * FROM DEPARTMENT; --DEPT_ID
SELECT * FROM JOB;      --JOB_CODE

-->오라클 전용 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE DEPT_CODE = DEPT_ID
AND E.JOB_CODE = J.JOB_CODE;


-->ANSI 전용 구문. 
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(DEPT_CODE = DEPT_ID)
JOIN JOB USING (JOB_CODE);
------------------------------------------------다중 JOIN 의 대표적인 예

--사번, 사원명, 부서명, 지역명
--(EMPLOYEE)(DEPARTMENT) (LOCATION)
SELECT * FROM EMPLOYEE; --DEPT_CODE
SELECT * FROM DEPARTMENT; --DEPT_ID, LOCATION_ID
SELECT * FROM LOCATION;     --LOCAL_CODE

--오라클 전용 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
FROM EMPLOYEE, DEPARTMENT, LOCATION
WHERE DEPT_CODE = DEPT_ID
AND LOCATION_ID = LOCAL_CODE;

--ANSI 전용 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON( LOCAL_CODE = LOCATION_ID);
------------------------------------------------------다중 JOIN의 대표적인 예2

--1. 사번, 사원명, 부서명., 지역명. , 국가명, 
SELECT * FROM EMPLOYEE;   --DEPT_CODE 
SELECT * FROM DEPARTMENT; -- DEPT_ID,LOCATION_ID 
SELECT * FROM LOCATION;   -- LOCAL_CODE

--오라클 전용 구문
SELECT EMP_ID AS "사번", EMP_NAME AS "사원명", DEPT_TITLE AS "부서명", LOCAL_NAME AS "지역명", NATIONAL_CODE AS "국가명"
FROM EMPLOYEE, DEPARTMENT, LOCATION
WHERE DEPT_CODE = DEPT_ID
AND LOCATION_ID = LOCAL_CODE;

--ANSI 구문. 
SELECT EMP_ID AS "사번", EMP_NAME AS "사원명", DEPT_TITLE AS "부서명", LOCAL_NAME AS "지역명", NATIONAL_CODE AS "국가명"
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);


--2. 사번, 사원명, 부서명, 직급명, 지역명, 국가명, 해당 급여 등급에서 받을 수 있는 최대 금액 조회.
SELECT * FROM EMPLOYEE;   --DEPT_CODE               JOB_CODE                    SAL_LEVEL
SELECT * FROM DEPARTMENT; -- DEPT_ID,   LOCATION_ID 
SELECT * FROM LOCATION;   --            LOCAL_CODE              NATIONAL_CODE
SELECT * FROM JOB;        --                        JOB_CODE
SELECT * FROM SAL_GRADE;  --                                                    SAL_LEVEL.
SELECT * FROM NATIONAL;   --                                    NATIONAL_CODE
--오라클 전용 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, N.NATIONAL_CODE, MAX_SAL
FROM EMPLOYEE E, DEPARTMENT, LOCATION L, JOB J, SAL_GRADE S, NATIONAL N
WHERE DEPT_CODE = DEPT_ID
AND LOCATION_ID = LOCAL_CODE
AND E.JOB_CODE = J.JOB_CODE
AND E.SAL_LEVEL = S.SAL_LEVEL
AND L.NATIONAL_CODE = N.NATIONAL_CODE;
--ANSI 구문. 
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_CODE, MAX_SAL
FROM EMPLOYEE E
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
JOIN JOB USING(JOB_CODE)
JOIN SAL_GRADE USING(SAL_LEVEL)
JOIN NATIONAL USING(NATIONAL_CODE);





















