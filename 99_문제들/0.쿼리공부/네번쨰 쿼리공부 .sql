--dd

SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE;
----------------------

SELECT DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
GROUP BY DEPT_CODE , JOB_CODE, SALARY; --<-- 오류, 그룹절 구조 오류. 
-- 원인을 적고 : JOB_CODE, SALARY 컬럼이 GROUP BY로 ㅂ묶여있지 않고, GROUP BY 사용시 그룹함수와 함꼐 써야 하는데 그러지 않았따..
-- 조치사항을 적어보시오. : SELECT 목록이 GROUP BY 와 일치하지 않으므로 수정이 필요함. 
SELECT DEPT_CODE , SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;
----------------------------------------------------------------
--문제2
SELECT DEPT_CODE, JOB_CODE, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE; --그룹BY 라고 1개의 조건만 걸수 있는건 아니다. , 이렇게 2개 이상 사용할 수 있다. 그룹으로 묶은것은 반드시 SELECT 절에 나와야 한다. 
---------------------------------------------------------------
-- 이상 마지막 DB 문제로 GROUPBY 가  예상이 되고 있지만, 열심히 공부 해보자. !








































