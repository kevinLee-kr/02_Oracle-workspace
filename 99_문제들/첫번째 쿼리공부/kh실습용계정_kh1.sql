
--------------------------DB 시험 준비용 -----------------------
--1. 보너스를 받지 않지만 부서배치는 된 사원 조회 해보기.
SELECT * 
FROM EMPLOYEE
WHERE BONUS = NULL AND DEPT_CODE !=NULL;
--짠다고 짯는데 결론적으로 결과값이 안나온다. 왜일까?
-- 원인을 구하고 조치한 내용을 기술하라. 
--문제점 : NULL값을 비교할떄는 단순한 일반 비교연산자를 사용할 수가 없다. 
--해결방법: IS NULL / IS NOT NULL 연산자를 이용해서 비교해야만 한다. 

--조치내용
SELECT * 
FROM EMPLOYEE
WHERE BONUS IS NULL AND DEPT_CODE IS NOT NULL;
--결과를 확인해보면, 13명의 정보들이 정상적으로 출력되는것을 확인 할 수 있다. 

--2. 검색하고자 하는 내용
--JOB_CODE J7 이거나 J6이면서 SALARY 값이 200만원ㅇ 이상이고
--BONUS 가 있으며, 성별은 여성이며, 이메일 주소 언더바 ('_') 앞에 3글자만 있는 사원의 
--사원명, 주민번호, 사원번호, 부서번호, 급여, 보너스를 조회하라. 
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE (JOB_CODE ='J7' OR JOB_CODE = '6')
AND SALARY >=2000000
AND BONUS IS NOT NULL
AND SUBSTR(EMP_NO,8,1) = '2'
AND EMAIL LIKE '__$_%';
--문제점1) OR 연산자와 AND 연산자가 나열되어 있을 경우AND연산자 먼저 수행됨. 문제에서 요구한 내용으로 OR 연산이 먼저 수행이 되어야 하마. 
--문제점2) 급여 값에 대한 비교가 잘못되어있음. > 이 아닌 >=으로 비교핻야된다. 
--문제점3) 보너스가 있는 이라는 조건에 IS NULL 이 아닌 IS NOT NULL 로 비교를 해야 했었다. 
--문제점4) 여사원에대한 조건문이 누락되어있음. 
--문제전5) 이메일에 대한 비교시 네번쨰 자리에있는 _를 데이터 값으로 취급해버렸다.  이것을 위해 새 와일드 카드를 제시해야하고, 또한 ESCAPE OPTION 으로 등록까지 해야합니다. 
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
--조치내용1)
WHERE (JOB_CODE ='J7' OR JOB_CODE = '6')
--조치내용1)
AND SALARY >=2000000
--조치내용1)
AND BONUS IS NOT NULL
--조치내용1)
AND SUBSTR(EMP_NO,8,1) = '2'
--조치내용1)
AND EMAIL LIKE '___$_%' ESCAPE '$';

------------------------------문제 3----------------------
--[계정생성구만 ] CREATE USER 계정명 IDENTIFIED BY 비밀번호;

--계정명 : SCOTT, 비밀번호 : TIGER 계정을 생성하고 싶ㅍ다. 
--이때, 일반 사용자 계정인 KH 계정에 접속해서 CREATE USER SCOTT; 로 실행하니 문제발생.

--문제점1) 사용자 계정 생성시, 일반 사용자 계정인 KH 에서 실행 하는 것이 아닌, 관리자 계정에서 생성이 가능하다. 
--문제점2) SQL문이 잘못되었다.  비밀번호를 입력하지 않았음. 

--조치내용1) 관리자 계정에서 생성을 해야한다. 먼저, 관리자 계정에 접속 해보겠다. 
--조치내용2) CREATE USER SCOTT IDENTIFIED BY TIGER 라고 입력 해야한다. 

--위의 SQL(CREATE)만 실행 후 접속을 만들어서 접속 하려고 했더니 실패 하였다. 
--뿐만 아니라 해당 계정에 테이블 생성 같은 것도 되지 않음 왜그럴까?

--위의 조치내용을 따라 했더니 접속 실패함!
-- 뿐만 아니라 해당 계정에 테이블 생성같은ㄱ 서들이 되지 않음 왜일까.

--문제점1)사용자 계정 생성 후 최소한의 권한 부여가 안된다. 
--조치내용1) GRANT, ASDFASDFSFAF 명령어를 선언하나. 




































































