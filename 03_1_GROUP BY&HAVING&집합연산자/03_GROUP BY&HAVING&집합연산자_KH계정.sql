
1. GROUP BY 절
그룹 기준을 제시할 수 있는 절이다. 
여러개의 값들을 하나의 그룹으로 묶어서 처리할 목적으로 사용된다.

SELECT SUM(SALARY)
FROM EMPLOEE; 
-> 전체 사원을 하나의 그룹으로 묶어서 총합을 구한 결과. 
-> 그룹 함수. 

-- 각 부서별 총 급여함
--보이듯 **별, **별 하면, 그룹함수를 쓰면 된다. 

SELECT DEPT_CODE ,SUM(SALARY) 
FROM EMPLOYEE
GROUP BY DEPT_CODE  ;
--해석 : DEPT_CODE 그룹별로 값을 구할 것이다~ 라는 스탠스

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

--각 부서별 사원수
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

외워야 할것. 어떤것이 그룹함수이고, 어떤 것이 단일함수인지 알아야 하는데, GROUP BY 절에 폼은. 
SELECT DEPT_CODE, COUNT(*), SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;
ORDER BY DEPT_CODE;

--직급코드별로 총 인원수, 급여합
SELECT  JOB_CODE
FROM EMPLOYEE
GROUP BY JOB_CODE;

--각 직급별 총 사원수, 보너스를 받는 사원수, 급여합, 평균급여, 최저습여, 최대급여, 
SELECT DEPT_CODE, COUNT(*)AS"총 사원수", COUNT(BONUS) AS "보너스를 받는 사원수",
        SUM(SALARY) AS"급여합", FLOOR(AVG(SALARY))AS "평균급여",
        MIN(SALARY) AS"최저급여", MAX(SALARY)AS"최대급여"
FROM EMPLOYEE
GROUP DEPT_CODE;
ORDER BY 1;


-- GROUP BYU 절에 함수식 기술 가능!
SELECT DECODE(SUBSTR(EMP_NO,8,1),1,'남자',2,'여자')AS "젠더", COUNT(*)
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1);

--GROUP BY 절에 여러 컬럼 기술 가능하다. 
SELECT DEPT_CODE, JOB_CODE, COUNT(*), SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE;

/*
HAVING 절
그룹에 대한 조건을 제시할 일이 있을때 사용하는 구문. (주로 그룹함수식을 가지고 조건을 제시할 떄 사용한다. )

*/
--각 부서별 평균 급여 조회
SELECT DEPT_CODE AS"부서", AVG(SALARY)AS"평균급여 조회"
FROM EMPLOYEE
GROUP BY DEPT_CODE;

--부서ㅏ별 평균 급여가 300만원 이상인 부서들만 조회. 
SELECT DEPT_CODE 
FROM EMPLOYEE
WHERE AVG(SALARY) >=30000000  -- WHERE 절에는 절대적으로 그룹함수를 기술하면 안된다. 무조건 오류가 발생한다. 
GROUP BY DEPT_CODE;

--대신 HAVING 문을 사용하면 된다. 
SELECT DEPT_CODE 
FROM EMPLOYEE
HAVING AVG(SALARY) >=3000000  --WHERE 대신 HAVING 을 사용했다. 위치는 GROUP BY 보다 위에 있든지, 아래 있든지 상관없다. 
GROUP BY DEPT_CODE;

--부서별 보너스를 받는 사원이 없는 부서만을 조회
SELECT DEPT_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS)=0;
----------------------------------------------------------------------------------------------------------------------------
/*
SELECT문 실행 순서. 
5. SELECT * |조회하고자 하는 컬럼 | 산술식 | 함수식
1. FROM 조회하고자 하는 테이블명
2. WHERE 조건식 (연산자들 가지고 기술)
3. GROUP BY 그룹기준을 삼을 컬럼 | 함수식
4. HAVING 조건식 (그룹함수를 가지고 기술한다.
6. ORDER BY 컬럼명 
*/
-------------------------
/*
집계함수
그룹별 산출된 결과값에 중간집계를 계산 해주는함수. 
ROLL UP -> GORUP BY절에 기술하는 함수. 
*/
--직급별로 급여합을 보고싶다. 
SELECT JOB_CODE , SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE);
--ROLLUP. 7가지 JOB_CODE의 합이 나온다. 그리고 마지막 8번쨰에 NULL이 JOB_CODE에 들어가지만, 모든 SUM값의 합을 맨 밑에 정의해준다. 
--ROLLUP 에 한가지 값이 들어갔는데
--만일 두가지 값이 들어갓다면, 조건문이 달린거다. 
--두가지 값에 해당하는 값들의 합을 구하고 맨 밑에 기술 하게 될 것? 이다. 
-------------------------------------------------------------------
/*
집합 연산자 SET OPERATION
여러개의 쿼리문을 가지고 하나의 쿼릴문으로 만드는 연사자. 
- UNION         : OR (합집합):두쿼리 문 수행항 결과값을 더한 후 중복되는 값은 한번만 더해지도록. 
- INTERSECT     : AND(교집합):두쿼리문 수행한 결과값에 중복된 결과. 
- UNION ALL     : 합집합+교집합 (중복되는 ㄱ부분이 두 번 표현될 수 잇음.)
- MINUS         : 선행 결과값에서 후행 결과값을 뺸 나머지(차집합)

주의할점 : 각 쿼리문의SELECT 절에 작성돼 있는 컬럼 개수는 무조건 동일 해야 한다. 
또한, 컬럼 갯수 뿐만 아니라, 각 컬럼 자리마다 동일한 타입으로 기술해야함. (순서, 타입, 갯수) 전부 중요함.  
*/
--1. UNION
--부서코드가  D5인 사원 또는 급여가 300만원 초과인 사원들 조회하고싶다. 사번, 이름 부서코드 급여
SELECT   EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5';

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >3000000;

SELECT   EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5'
UNION 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >3000000;---------------------------------각각의 조건들을 하나라도 충족시키는 값들이 나오지만, 중복값은 하나만 나온다. 


SELECT   EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5' OR SALARY>3000000; --UNION

--2.INTERSECT(교집합)
--부서코드가 D5이면서 급여까지도 300만원 초과인 사원 조회.
SELECT   EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5'
INTERSECT 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >3000000;----------------------------------각각의 조건들중 둘다 충족 시키는 값들이 나온다. 

SELECT   EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5' AND SALARY>3000000; --UNION

--ORDERBY 절을 붙이고자 한다면 마지막에 기술해야됨.
--------------------------------------------------------------------------------------------------
--3. UNION ALL : 여러개의 쿼리 결과 무조건 다 더 하는 연산자(중복값 이 나옴)
SELECT   EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >3000000;
------------------------------------------------------------
--4. MINUS : 선행 SELECT결과에서 후행 SELECT 결과를 뺀 나머지(차집합)
--부서코드가 D5인 사원들 중 급여가 300만원 초과한 사원들은 제외해서 조회
SELECT   EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >3000000;

SELECT   EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5' AND SALARY <=3000000; --UNION






