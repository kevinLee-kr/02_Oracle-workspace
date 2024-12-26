--1.EMP 테이블에서 COMM 의 값이 NULL 이 아닌 정보 조회
SELECT *
FROM  EMP
WHERE COMM IS NOT NULL;
--2.EMP 테이블에서 커미션을 받지 못하는 직원 조회
SELECT *
FROM EMP
WHERE COMM IS NULL;

--3.EMP 테이블에서 관리자가 없는 직원 정보 조회
SELECT *
FROM EMP
WHERE MGR IS NULL;

--4.EMP 테이블에서 급여를 많이 받는 직원 순으로 조회
SELECT *
FROM EMP
ORDER BY SAL DESC;
--5.EMP 테이블에서 급여가 같을 경우 커미션을 내림차순 정렬 조회
SELECT *
FROM EMP
ORDER BY SAL DESC, COMM ASC;
--6. EMP테이블에서 사원번호 , 사원명 직급 , 입사일 조회 단 입사일을 오름차순 정렬 처리
SELECT EMPNO, ENAME, HIREDATE
FROM EMP
ORDER BY HIREDATE DESC;
--7. EMP테이블 에서 사원번호 , 사원명 조회 사원번호 기준 내림차순 정렬
SELECT EMPNO, ENAME
FROM EMP
ORDER BY EMPNO ASC;
--8.EMP 테이블에서 사번 , 입사일 , 사원명 , 급여 조회
--부서번호가 빠른 순으로 , 같은 부서번호일 때는 최근 입사일 순으로 처리
SELECT EMPNO, HIREDATE, ENAME, SAL, DEPTNO
FROM EMP
ORDER BY DEPTNO DESC, HIREDATE ASC;
--9.오늘 날짜에 대한 정 보 조회
SELECT SYSDATE
FROM DUAL;
--10.EMP 테이블에서 사번 , 사원명 , 급여 조회(단 , 급여는 100 단위까지의 값만 출력 처리 하고 급여 기준 내림차순 정렬
SELECT EMPNO, ENAME, ROUND(SAL,-2)AS"급여"
FROM EMP
ORDER BY SAL ASC;
--11. EMP테이블 에서 사원번호가 홀수인 사원들을 조회
SELECT *
FROM EMP
WHERE MOD(EMPNO,2)=1;
--12. EMP테이블 에서 사원명 , 입사일 조회 단 , 입사일은 년도와 월을 분리 추출해서 출력
SELECT ENAME, HIREDATE,
EXTRACT(YEAR FROM HIREDATE)||'년'AS"입사년도",
EXTRACT(MONTH FROM HIREDATE)||'월'AS"입사월"
FROM EMP;
--13. EMP테이블 에서 9 월에 입사한 직원의 정보 조회
SELECT *
FROM EMP
WHERE EXTRACT(MONTH FROM HIREDATE) = 9;
--14. EMP테이블에서 81 년도에 입사한 직원 조회
SELECT *
FROM EMP
WHERE EXTRACT(YEAR FROM HIREDATE) = '1981';
--15. EMP테이블 에서 이름이 'E' 로 끝나는 직원 조회
SELECT *
FROM EMP
WHERE ENAME LIKE'%E';
--16. EMP테이블 에서 이름의 세 번째 글자가 'R' 인 직원의 정보 조회
--16 1. LIKE 사용
SELECT *
FROM EMP
WHERE ENAME LIKE '__R%';
--16 2. SUBSTR() 함수 사용
SELECT *
FROM EMP
WHERE SUBSTR(ENAME,3,1) IN('R');
--17.EMP 테이블에서 사번 , 사원명 , 입사일 , 입사일로부터 40 년 되는 날짜 조회
SELECT EMPNO, ENAME, HIREDATE, ADD_MONTHS(HIREDATE,40*12)AS"정년퇴임"
FROM EMP;
--18.EMP 테이블에서 입사일로부터 38 년 이상 근무한 직원의 정보 조회
SELECT *
FROM EMP
WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIREDATE)>=38;
--19.오늘 날짜에서 년도만 추출
SELECT TO_CHAR(SYSDATE,'YYYY')AS"년도"
FROM DUAL;