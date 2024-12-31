--저장용
/*
서브쿼리 ( SUBQUERY)
- 하나의 SQL문 안에 포함된 또 다른 SELECT 문
- 메인 SQL문을 위해 보조 ㅎ역할을 하는 쿼리문이다. 
*/
--노옹철 사원과 같은 부서에 속한 사원들 조회하고 싶다. 
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철'; --D9인걸 알아냈다.

--부서코드가 D9인 사원들 조회해보기
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE='D9';

--위의 2가지 단계를 하나의 쿼리문으로!
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE=(
                SELECT DEPT_CODE
                FROM EMPLOYEE
WHERE EMP_NAME = '노옹철'
);
--아....오..
--전 직원의 평균 급여보다 더 많은 급여를 받는 사원들의 사번, 이름, 직급ㅗ드, 급여 조회
--1) 전 직원의 평균 급여 조회
SELECT AVG(SALARY)
FROM EMPLOYEE ;--3047662

--2)급여가 2040000이상인 사원들 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 2047330;

--위의  두 단계를 하나의 쿼리문으로 바꿔보고 싶다. 
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (   SELECT AVG(SALARY)
                    FROM EMPLOYEE --3047662
);


/*
서브쿼리의 구분
서브쿼리를 수행한 결과값이 몇 행 몇 열이냐에 따라 분류된다. 
- 단일행 서브쿼리 : 서브쿼리의 조회 결과값의 개수가 오로지 1개일 떄.(한행 한 열)
- 다중행 서브쿼리 : 서브쿼리의 조회 결과값이 여러행 일때 (여러행 한 열) -> 동명이인 노옹철 2명일 때. 사용된다. 
- 다중열 서브쿼리 : 서브뤄리의 조회 결과값이 한 행 이이지만 컬림이 여러개 일떄(한행 여러 열)
- 다중열 다중행 서브쿼리 : 서브뤄리의 조회 값이 여러 행 여러 컬럼일 때(어려행 여러열)

서브쿼리의 종류가 뭐냐에 따라서 버스쿼리 앞에 붙는 연산자가 달라지기에 어떤 어떤서브쿼리를 사용할 것인지 알아야 한다. 
1. 단일행 서브쿼리(SINGLE ROW SUBQUERY)
서브쿼리의 조회 결과값의 개수가 오로지 1개일때, (한행 한 열)
일반 비교 연산자 사용 가능하다. 
=  , !=  , ^=,  >  , <  , <=,   ...


전 직원의 평균 
보다 급여를 더 적게 받는 사원들의 사원명, 직급코드, 급여 조회를 해보자. 
*/
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT AVG(SALARY)
                FROM EMPLOYEE);

--문제2)최저금여를 받는 사원의 사번, 이름, 급여, 입시일
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
--WHERE SALARY = 전직원들 급여중 최저금여
WHERE SALARY = (SELECT MIN(SALARY)
                FROM EMPLOYEE);

--문제3)노옹철 사원의 급여보다 더 많이 받는 사원들의 사번, 이름, 부서코드, 급여 조회하기
SELECT EMP_ID, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME = '노옹철');
--JOIN, 오라클 ㄱ전용구문,
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND SALARY > (  SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME ='노옹철');


--ANSI 구문
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE SALARY > (SELECT  SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME = '노옹철');
                
--4. 부서별 급여합이 가장 큰 부서의 부서코드, 급여 합 조회
--4. 먼저 부서별 급여합 중에서도 가장 큰 값 하나만 조회
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

--4_2) 부서별 급여합계가 1700000원 인 부서 조회
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (  SELECT DEPT_CODE,MAX(SARALY)
                        FROM EMPLOYEE
                        GROUP BY DEPT_CODE);

--전사원 사원과 같은 부서원들의 사번, 사원명, 전화번호, 입사일, 부서명
--단, 전지연은 제외

--오라클 전용 구문
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE,DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND DEPT_CODE = (SELECT DEPT_CODE
                FROM EMPLOYEE
                WHERE EMP_NAME='전지연')
AND EMP_NAME != '전지연';

--ANSI 전용 구문.  단일행 서브 쿼리
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE,DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_ID = DEPT_CODE)
WHERE DEPT_CODE = (SELECT DEPT_CODE
                FROM EMPLOYEE
                WHERE EMP_NAME='전지연')
AND EMP_NAME != '전지연';

/*
2. 다중행 서브쿼리(MULTI ROW SUBQUERY)
서브쿼리를 수행한 결과값이 여러 행일떄 (컬럼은 한개!!!!!1)
단일행일떄는 비교 연산자가 왔었는데
다중행일떄는 비교연산자가 올 수 가 없다. 
 -IN 서브 쿼리 : 여러개의 결과값 중에서 한개라도 일치하는 값이 있다면~
 - >  ANY 서브쿼리 : 여러개의 겨로가값 중에서 한개라도 클 경우. ?(여러개의 결과값 중에서 가장 작은 값보다 클경우)
 - < ANY 서브쿼리 : 여러개의 결과값 중에서 "한개라도"작을 경우(여러개의 결과값 중에서 가장 큰 값보다 작을경우)
 
 비교대상이 나오고 >ANY 가 나오고( 값, 값2, 값3) 이 나오면 
 비교대상이 값1 보다 크거나, 
 비교대상이 값2 보다 크거나
 비교대상이 값3 보다 크다! 라는 말이다. 
 
 근데 > ALL 서브쿼리라고 쓰는 경우가 ㅣㅆ고
 < ALL 서브쿼리라고 쓰는 경우가 있는데
 
 > ALL 은 여러개의 "모든 "결과값 보다 클경우에 쓰이고
 < ALL 은 여러개의 모든 겨로가값들 보다 작을 경우 에 사용이 된다. 
 예를 들어 비교대상을 만들었고, 
 이 비교대상보다 > ALL (값1, 값2, 값3)이라고 써져 있다면 
 이 비교대상은 값1, 값2, 값3 보다 보다 보다 커야만 한다~ 라는 뜻이다. 
 
 예제를 통해서 이해를 해보다. 
 
 
 */
-- 1) 유재식 또는 윤은해 사원과 같은 직급인 사원들의 사번, 사원명, 직급코드, 급여 조회해보자. 
--1-1) 유재식 또는 윤은해 사우너이 어떤 직급인지 먼저 조회를 해야한다. - 'J3','J7'이라는 값을 알아냈다. (다중행 서브쿼리라는걸 알아냈다. ) 
SELECT JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME IN('유재식','윤은해');

--1_2) J3, J7인 직급인 사원들 조회하면 되겠네? 
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN('J3','J7');
-- 1-1을 통해서 직급 코드를 알아냈었고, 1-2를 통해서 조회하는 메인 을 얻어냈지, 이것들을 합쳐보자!
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN( 
                    SELECT JOB_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME IN('유재식','윤은해')
                    );
--다중행 서브쿼리에슨 앞서 말했듯, 동등 비교가 아닌, IN을 통해 기술해야만 오류를 피할 수 있다. 
--이유는 여러행으로 조회가 되기 때문이다. 


--우리가 회사에 가면 사원으로 직급이 정해지게 된다. 4년정도 있으면, 대리가 될거고 시간이 지나 과장, 차장, 부장이 될것 이다. 
-- 2) 대리 직급에도 불구하고 과장 직급 급여들 중 최소 급여보다 많이 받는 직원을 조회해보자. 
--사번, 이름, 직급, 급여
--과장들이 먼저 얼마나 받는지 파악을 하고, 대리 급여를 확인 하고 비교해야한다. 

SELECT SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND JOB_NAME = '과장';-- 2200000, 2500000, 3760000 과장 급여를 알아냈다. 

--2-2)직급이 대리이면서 급여값이 위의 목록들 값 중에 하나라도 큰 사원.
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME ='대리'
AND (SALARY > 2200000 OR SALARY > 2500000 OR SALARY > 3760000);

--위의 두 단계를 하나의 쿼리문으로 작성해보자. 
--단일행 서브쿼리로도 가능
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME ='대리'
AND SALARY > ANY (
                    SELECT SALARY
                    FROM EMPLOYEE E, JOB J
                    WHERE E.JOB_CODE = J.JOB_CODE
                    AND JOB_NAME = '과장');

--3) 과장 직급에도 불구하고 차장직급인사원들의 모든 급여보다도 더 많이 받는 사원들의 사번, 사원명, 직급명, 급여
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME='과장'
AND SALARY > ALL(SELECT SALARY
                FROM EMPLOYEE
                JOIN JOB USING(JOB_CODE)
                WHERE JOB_NAME = '차장'  );



--------------------------------------------------------
/*
다중열 서브쿼리
결과 자체는 한 행이지만, 나열된 컬럼수가 여러개일 경우가 있다. 
*/
--1) 하이유사원과 같은 부서코드, 같은 직급코드에 해당하는 사원들 조회하고 싶다. (사원명,부서코드, 직급코드, 입사일)
-->>단일행 서브쿼리로도 가능은하다!

SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '하이유') 
AND JOB_CODE = (SELECT JOB_CODE
                FROM EMPLOYEE
                WHERE JOB_CODE = '하이유');

SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE
                                FROM EMPLOYEE
                                WHERE EMP_NAME='하이유');  -- 순서 대박 중요, 개수도 맞춰야 함 무조건, 다르면 값이 안나오거나, 다른 값이 다온다. 
                                


-- 박나라 사원과 같은 직급코드, 샅은 사수를 가지고 있는 사원들의 사변, 사원명 직급코드 , 사수 번호 조회

SELECT EMP_ID ,EMP_NAME, JOB_CODE,  MANAGER_ID
FROM EMPLOYEE 
WHERE (JOB_CODE, MANAGER_ID) = (SELECT JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE EMP_NAME = '박나라');

--자 지금까지 서브쿼리를 3개를 보았고, 마지막 서브쿼리를 배워보자꾸나
/*
4. 다중행 다중열 서브쿼리
서브쿼리 조회 결과값이 여러행 여러열일 경우. 

이런거는 예를 들면 이런거지

*/
-- 1) 각 직급별  (~ 별 ~ 별 하면 무조건 GROUP BY 를 써야 한다는 거다. )
--1) 각 직급별 최소급여를 받는 사원 조회(사번, 사원명, 직급코드, 급여)
-->> 각 직급별 최소 급여 조회를 먼저 해야지.

SELECT JOB_CODE , MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

/*
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J2' AND SALARY = 3700000
    OR JOB_CODE='J7' AND SALARY = 1380000
    ...; 로 할 수 있다. 하지만 이렇게 되면 만약 데이터가 백만개 되면, 효율이 좋지 않다. 
*/

--서브쿼리를 활용해보자!
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE,SALARY) IN ( SELECT JOB_CODE , MIN(SALARY)
                                FROM EMPLOYEE
                                GROUP BY JOB_CODE);
--2) 각 부서별 최고급여를 받는 사원들의 사번, 사원명, 부서코드, 급여

SELECT SALARY
FROM EMPLOYEE
GROUP BY SALARY; 

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE, SALARY) IN (SELECT DEPT_CODE, MAX(SALARY)
                                FROM EMPLOYEE
                                GROUP BY DEPT_CODE); 
-- 주의할 점, WHERE (DEPT_CODE, SALARY) IN (SELECT DEPT_CODE, MAX(SALARY)
--에서 WHERE 문이랑 IN 문에서 비교값들이 동일 해야 한다. 

-------------------------------------------------------
/*
인라인 뷰(INLINE-VIEW)

서브쿼리를 수행한 결과를 마치 테이블처럼 사용가능한 것.
*/
--사원들의 사번, 이름, 보너스 포함 연봉(별칭 부여:연봉), 부서코드 조회
--단, 보너스 포함 연봉이 3000만원 이상이 사원들만 조회.

SELECT EMP_ID, EMP_NAME, (SALARY + SALARY * NVL(BONUS,0))*12 AS "연봉", DEPT_CODE
FROM EMPLOYEE
WHERE (SALARY + SALARY * NVL(BONUS,0))*12 > = 30000000; --WHERE 절에 바로 별칭 사용 불가하다. 

SELECT EMP_ID, EMP_NAME, (SALARY + SALARY * NVL(BONUS,0))*12 AS "연봉", DEPT_CODE
FROM EMPLOYEE;
-- 이걸 마치 존재하는 테이블인것 처럼 사용할 수 있음!! 그것이 바로 인라인뷰 ~ 
---인라인 뷰~
SELECT *
FROM (SELECT EMP_ID, EMP_NAME, (SALARY + SALARY * NVL(BONUS,0))*12 AS "연봉", DEPT_CODE
FROM EMPLOYEE)
WHERE 연봉 > = 30000000;

--인라인 뷰 원하는 값 조회해보기
SELECT EMP_NAME, DEPT_CODE, 연봉
FROM (SELECT EMP_ID, EMP_NAME, (SALARY + SALARY * NVL(BONUS,0))*12 AS "연봉", DEPT_CODE
FROM EMPLOYEE)
WHERE 연봉 > = 30000000;
--사용하는 예가 있다. 
--N분석(상위 몇개만 보여주고 싶을떄)
--TOP-N 분석을 할때 무조건 인라인뷰를 사용한다. 
--전 직원 중 급여가 가장 높은 상위 5명만 조회하기 . 
--오라클에서 제공해주는 가상 컬럼 : ROWNUM.
--조회된 순서대로 1부터 순번을 부여해주는 컬럼. 
--실행순서 떄문에 방식을 잘 되었어도, 값이 이상하다. 
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;
-- FROM 0> SELECT ROWNUM (이때 순번이 부여가 되는데 정렬을 하기도전에 이미 순번이 부여된다. )
-- 이렇게 짜게 되면 정상적인 조회가 되지 않습니다.
--정렬이 되기도 전에 5명이 추려지고 나서 정렬된다. 

--ORDER BY 절이 다 수행된 결과를 가지고 ROWNUM 부여 후 5명추려야함.
SELECT
FROM (정렬이 이미 된 데이터);


SELECT ROWNUM, E.*
FROM(SELECT EMP_NAME, SALARY, DEPT_CODE
            FROM EMPLOYEE
             ORDER BY SALARY DESC) E
WHERE ROWNUM<=5;

--서브쿼리가 FROM 절 안에 기술이 되면 , 인라인 뷰 라고 한다. 



----------------------------------------------------------
--가장 최근에 입사한 사원 5명 조회.(사원명, 급여, 입사일)
--각 사원의 입사한 날짜 조회
SELECT ROWNUM,EMP_NAME, HIRE_DATE
FROM EMPLOYEE
ORDER BY HIRE_DATE DESC;

SELECT E.*
FROM (SELECT ROWNUM,EMP_NAME, HIRE_DATE
                    FROM EMPLOYEE
                    ORDER BY HIRE_DATE DESC) E
WHERE ROWNUM <=5;
--각 부서별 평균급여가 높은 3개의부서만 조회.


SELECT ROWNUM, E.*
FROM (SELECT DEPT_CODE, TRUNC(AVG(SALARY),1)
        FROM EMPLOYEE
        GROUP BY DEPT_CODE
        ORDER BY AVG(SALARY)DESC) E
WHERE ROWNUM<=3;

----------------------------순위를 매기는 함수--------------------------
/*

window FUNCTION - SQLD 단골 문제
1. RANK() OVER(정렬기준)    
 - 동일한 순위 이후의 등수를 동일한 인원수 만큼 건너뛰고 순위계산
    EX)공동 1위가 2명이면 그 다음 순위는 3등. (1등 1등 3등 3등 5등 6등 6등 8등.)
2. DENSE_RANK() OVER(정렬기준)
    EX)공동 1위가 2명이고 그 다음 순위는 2등. (1등 1등 2등 3등 3등 4등 4등 5등.)
        동일한 순위가 있어도, 그 다음 등수를 1씩 증가시킴.
두 함수는 무조건 SELECT 절에서만 사용가능 하다. 
*/
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) AS "순위"
FROM EMPLOYEE;
--RANK() OVER(정렬기준)       --공동 19위 2명 그 뒤의 순위는 21 -> 마지막 순위랑 조회된 행수가 같음.

SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) AS "순위"
FROM EMPLOYEE;
--DENSE_RANK() OVER(정렬기준) --공동 19위 2명 그 뒤의 순위는 20위.

SELECT *
FROM(   SELECT EMP_NAME, SALARY, 
        DENSE_RANK() OVER(ORDER BY SALARY DESC) AS "순위"
        FROM EMPLOYEE)
WHERE 순위 <=5; 











