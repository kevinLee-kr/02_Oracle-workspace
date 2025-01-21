--q시험 준비할때 보기 위한 문서.

--rownum을활용해서 급여가 가장 높은 5명을 조회하고 싶었음. 실패
--이떄 작성된 SQL문은 아래와 같음
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;
--원인이 무엇일까?
--원인 : 쿼리 순서에 의해, 5명이 이미 조회되고 , 그 안에서 정렬이 되었기 떄문.
--조치한 내용 : 
SELECT * 
FROM EMPLOYEE
ORDER BY SALARY DESC;

SELECT ROWNUM, EMP_NAME,SALARY FROM ( 
            SELECT * 
            FROM EMPLOYEE
            ORDER BY SALARY DESC)
WHERE ROWNUM <=5; --원하는 결과값을 얻기위한 데이터를 FROM으로 넣고, 그 안에서 상위 5명을 조회한다.
---------------------------------
--부서별 평균급여가 2270만원을 초과하는 부서들에 대해(부서코드, 부서별 총 급여합, 부서별 평균급여, 부서별 사원수)조회해보자.
--이때 작성된 SQL문이 다음과 같음
SELECT DEPT_CODE 부서코드, SUM(SALARY) 총합 , FLOOR(AVG(SALARY)) 평균, COUNT(*)인원수
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;
--오류 발생함, 원인이 무엇인가? 
--원인 : 문제 1번과 같은 이유이다. 쿼리 작동 순서에 따라 조회 값이 달라진 것이 문제 인 것이다. 
--원인 : 2. 또한, 원하는 결과값에 대한 조건식문이 잘못되었따.
---조치내용 : 
SELECT DEPT_CODE 부서코드, SUM(SALARY) 총합 , FLOOR(AVG(SALARY)) 평균, COUNT(*)인원수
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) > 2700000
ORDER BY DEPT_CODE;
----------------------------------------------------------------
--직원의 급여 조회시 각 직급별로 인상해서 조회
--J7인 사원은 급여를 10%인상
--J6인 사원은 급여를 15% 인상
--J5인 사원은 급여를 20% 인상
--그 외의 사원으 ㄴ급여를 5% 인상.

SELECT EMP_NAME,JOB_CODE , 
    DECODE(JOB_CODE, 'J7',SALARY *1.1,
                     'J6',SALARY *1.15,
                     'J5',SALARY*1.2,
                     SALARY * 1.05 )AS "인상된 급여"
FROM EMPLOYEE;
-------------------
--'25/01/05 '와 같은 문자열을 가지고 '2025-01-06'으로 표현해보기.
--TO_DATE('문자열',[포멧]) : DATE
--TO_CHAR(날짜 OR 숫자,[포멧]) : CHAR
SELECT TO_CHAR(TO_DATE('25/01/05'),'YYYY-MM-DD')
FROM DUAL;

------'240106'와 같은 문자열을 가지고 2024년 1월 16일 표현해보기.포멧에 대해 공부해보기.
SELECT TO_CHAR(SYSDATE,'DL')
FROM DUAL;

SELECT TO_CHAR(TO_DATE('240106'),'DL')
FROM DUAL;

SELECT TO_CHAR(TO_DATE('240106'),'YYYY"년" FMMM"월" DD"일"') AS 날짜
FROM DUAL;

SELECT TO_CHAR(TO_DATE('240106'),'YYYY"년" FMMM"월" DD"일"') AS 날짜
FROM DUAL;


