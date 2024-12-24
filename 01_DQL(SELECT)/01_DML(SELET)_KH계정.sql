--뭐라는겨
/*
    <SELECT>
    데이터를 조회할 때 사용되는 구문

    >> RESULT SET : SELECT문을 통해 조회된 결과물(즉, 조회된 행들의 집합을 의미)
[표현법]
SELET 조회하고자 하는 컬럽ㅁ1, 컬럼2, ...
FROM 테이블명;

반드시 존재하는 컬럼으로 써야함! 존재하는 테이블로 써야함 없는거 쓰면 오류남. 

*/

--EMPLOYEE 테이블의 모든 컬럼(*) 조회.
--SELECT EMP_ID, EMP_NAME, EMP_NUMBER

SELECT *
FROM EMPLOYEE;
--EMPLOYEE 테이블의 사번, 이름, 급여 조회.. 컬럼은 조금 외워야 한다. 
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;  --FROM(어디로 부터 조회하겠다.)

--JOB이란 테이블이 존재하는데, 모든 컬럼 조회를 해보겠다.  SELECT(조회)
SELECT *
FROM JOB;
------------------실습문제---------------------------
--1. JOB테이블의 직급명만 조회해보기
SELECT JOB_NAME
FROM JOB;
--2. DEPARTMENT 테이블의 모든 컬럼 조회해보기
SELECT *
FROM DEPARTMENT;
--3. DEPARTMENT 테이블의 부서코드, 부서명, 만 조횧 해보기
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;
--4. EMPLOYEE 테이블의 사원명, 이메일, 전화번호, 입사일, 급여 조회.
SELECT EMP_NAME,EMAIL,PHONE,SALARY
FROM EMPLOYEE;
--이것을 조회 하고 싶다.
-- 이곳에서.   라는 뜻으로 이해하고, 쓰면 될듯함!
--컬럼을 외우면 유리하다 컬럼은 - 개체 이름? 조회하고싶은 것의 이름? 이다.
/*
<컬럼값을 통한 산술연산>
SELECT 컬럼명 작성 부분에 산술 연산 기술 가능(이때, 산술 연산된 결과 조회)

*/
--EMPLOYEE 테이블의 사원명, 사원의 연봉(SALARY * 12)조회
SELECT EMP_NAME, SALARY * 12
FROM EMPLOYEE;

--EMPLOYEE 테이블의 사원명, 급여, 보너스 조회
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE;

--EMPLOYEE 테이블의 사원명, 급여, 보너스, 연봉, 보너스포함 연봉(급여 + 보너스 * 급여)
SELECT EMP_NAME, SALARY, BONUS, SALARY * 12, ((SALARY + BONUS * SALARY)*12)
FROM EMPLOYEE;
--산술 연산 과정중, NULL 값이 존재한채 연산처리 될 경우, 결과값 은 무조건 NULL로 계산이 마쳐진다. 

--EMPLOYEE에서 사원명, 입사일
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE;

-- EMPLOYEE에 사원명, 입사일, 근무일수(오늘 날짜에서 - 입사일)
--DATE형식에서도 연산처리 기능이 가능하다. 
-- 오늘날짜 : SYSDATE
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE
FROM EMPLOYEE;
--우리가 날짜에서 날짜를 뺴면 결과값으로 '일'단위가 맞긴 하다. 
-- 하지만, 값이 일정하지 않은 이유, DATE형식은 년/월/일/시/분/초 단위로 정의를 하기 때문.
--만약 지금 이 결과가 마음에 들지 않으면, 함수를 이용해, 소숫점을 버릴 수 있다. 나중에 배워보자.
--
/*
<컬럼명에 별칭 지정해보기>
산술 연산을 하게 되면 컬럼명이 복잡해 진다. 이떄 컬럼명을 별칭 부여해서 깔끔하게 보여준다. 
[표현법]
1. 컬럼명 별칭
2. 컬럼명 AS 별칭
3. 컬럼명 "별칭"
4. 컬럼명 AS "별칭"
AS 붙이든 안붙이든 간에 부여하고자 하는 별칭에 띄어쓰기 OR 특수문자가 포함될 경우 반드시 쌍따옴표("")로 기술해야함
*/
SELECT EMP_NAME 사원명, SALARY AS 급여, SALARY * 12 "연봉(원)", (SALARY + SALARY* BONUS)*12 AS "총 소드(보너스 포함)"
FROM EMPLOYEE;
-------------------------------------------------------
/*리터럴 - 값 그 자체. 
임의로 지정한 문자열(' ')
SELECT 절에 리터럴을 제시하면 마치 테이블 상에 존재하는 데이터 처럼 조회 가능
조회된 RESULT SET의 모든 행에 반복적으로 같이 출력을 보내는 그런.

*/
--EMPLOYEE 테이블의 사번, 사원명, 급여 조회 (리터럴 활용_
SELECT EMP_ID, EMP_NAME, SALARY, '원'
FROM EMPLOYEE;

-- 연결 연산자 : ||  , 여러 컬럼값들을 마치 하나의 컬럼인 것처럼 연결하거나, 컬럼값과 리터럴은 연결할 수 없음. 
--사번, 이름, 급여를 하나의 컬럼으로 조회를 해보자. 
SELECT EMP_ID || EMP_NAME || SALARY 
FROM EMPLOYEE;

--컬럼값이랑 리터럴과을 연결해보기
---XXX의 월급은 000원 입니다. -> 컬럼명 별칭 : 급여정보
SELECT EMP_NAME || '의 월급은' || SALARY ||'입니다'  AS "급여정보"
FROM EMPLOYEE;




--현재 우리 회사에 어떤 직급의 사람들이 존재하는지 궁금하다!
SELECT JOB_CODE
FROM EMPLOYEE; --현재 회사에 23명의 집급의 부서들이 조회된다. 

/*명령어!
DISTINCT
컬럼에 중복된 값들이 있을 때, 한번 씩만 표시하고자 할 때 사용한다. 
*/
--EMPLOYEE 직급코드(중복제거) 조회
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE; --중복제거되서 23행에서 7행으로 요약이되었다. 


--사원들이 어떤 부서에 소속 돼있는지 궁금함
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE; --NULL : 부서배정을 아직 받지 못한 사람

--유의사항 : DISTINCT 는 SELCET 절에 딱 한번만 사용 가능하다.
/*
SELECT DISTINCT JOB_CODE, DISTINCT DEPT_CODE
FROM EMPLOYEE;
*/
SELECT DISTINCT JOB_CODE, DEPT_CODE
FROM EMPLOYEE;

--(JOB_CODE, DEPT_CODE)쌍으로 묶어서 중복 판별
-------------------------------------------------------------------------
/*
WHERE 절
내가 조회를 하고자 하는 테이블. 이 있는데 특정 조건에 만족하는 데이터만을 조회하고자 할 때 사용한다. 
예) 내가 '김씨' 만 조회 하겠다. 내가 '이씨'만을 조회 하고 싶다. 할떄 자주 쓰인다. 
조건식에서는 다양한 연산자를 사요할 수 있음. 
[표현법]
SELECT 컬럼1, 컬럼2
FROM 테이블명;    <-- 이런 식으로 위에서부터 해왔음
WHERE 조건식;    <---- 맨 밑에 이렇게 WHERE 식을 달아준다. 
[비교연산자]
>  ,  <  , >=  , <==        -> 대소비교
=                           -> 동등비교
!= ,  ^= , <>               0> 동등하지 않은지 비교

--EMPLOYEE 에서 부서코드가  'D9'인 사원들만 조회 해보기(이떄, 모든 컬럼 조회)


*/
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE 에서 부서코드가 'D1'인 사원들의 사원명, 급여, 부서코드 만 조회
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

--EMPLOYEE 에서 부서 코드가 'D1'이 아닌 사원들의 사번, 사원명, 부서코드 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
--WHERE DEPY_CODE !='D1';
WHERE DEPT_CODE ^='D1';

--급여가 400만원 이상인 사원들의 사원명, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

--현재  재직중인(ENT_YN 컬럼 값이 'N')인 사원들의 사번, 이름, 입사일
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN ='N';
-----------------------------------------------------------------------
--급여가 300만원 이상이 ㄴ사원들의 사원명, 급여, 입사일, 연봉(보너스미포함) 조회
SELECT EMP_NAME, SALARY , HIRE_DATE, SALARY * 12
FROM EMPLOYEE
WHERE SALARY >=3000000;
-- 연봉이 5000만원ㅇ 이상인 사원들의 사원명, 급여, 연봉, 부서코드
SELECT EMP_NAME AS "사원 명", SALARY AS "급여", SALARY * 12 AS "연봉", DEPT_CODE AS "부서코드"
FROM EMPLOYEE
WHERE SALARY*12 >= 50000000;
--쿼리 실행 순서 풀이해보기.
--FROM - WHERE - SELECT 순서로 코드가 실행이 되다 보니 WHERE 또는 FROM 에서 별칭으로 기술을 하면, 아직 거치지 않은 영역에서 정의된 별칭은 아직 이해를 하지 못해 오류가 나는 것이다. 
-- 조치내용 : 별칭이 아닌 리터럴 값으로 적는다. EX) SALARY * 12 와 같이.

-- 직급코드가 'J3' 가 아닌 사원들의 사번, 사원명, 직급코드, 퇴사여부 조회 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, ENT_YN
FROM EMPLOYEE
WHERE JOB_CODE != 'J3';

--부서코드가 'D9'이면서 급여가 500만원 이상이 ㄴ사원들의 사번, 사원명, 급여, 부서코드 를 조회 해보자. 
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE (DEPT_CODE='D9' AND SALARY >= 5000000);

--부서코드가 'D9'이거나 급여가 300만원 이상인 사원들의 사원명, 부서코드ㅏㅏ, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' OR SALARY >-300000000;

--급여가 350만원 이상이고 600만원 이하를 받는 사원들의 사원명, 급여, 사번, 조회
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
--WHERE 3500000<=SALARY  AND SALARY<=6000000;
WHERE SALARY>=3500000 AND SALARY <= 6000000;
-----------------------------------------------------------------------
/*
< BETWEEN A AND B >
조건식에서 사용되는 구문
몇 이상 몇 이하인 범위에 대한 조건을 제시할 때 사용되는 연산자

[표현법]
WHERE 비교대상컬럼 BETWEEN A(값) AND B(값)
 -> 해당 컬럼의 값이 A이상이고 B이하인 경우
*/
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000 ;
--위의 커리 범위 밖의 사람들 조회하고 싶다면? 350미만 + 600 만원 초과인 사람들
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
--WHERE SALARY < 3500000 AND SALARY > 6000000;
--WHERE NOT SALARY BETWEEN 3500000 AND 6000000;
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;
-- NOT : 논리부정 연산자
--컬럼명 앞이나 또는 BETWEEN 앞에 기입이 가능하다. 

SELECT *
FROM EMPLOYEE
--WHERE HIRE_DATE >= '90/01/01' AND HIRE+DATE <= '01/01/01'; DATE형식은 대소비교 가능
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';
--------------------------------------------------------------------------------------
/*
LIKE
비교하고자 하는 컬럼값이 내가 제시한 특정 패턴에 만족될 경우 조회
[표현법]
WHERE 비교대상컬럼 LIKE '특정패턴'

-특정 패턴 제시시 '%', '_' 를 와일드 카드로 사용할 수 있음. 
-- % : 0글자 이상
비교대상 컬럼 LIKE 문자%    -> 비교대상 컬럼값이 문자로 "시작"되는걸 조회

EMP_NAME LIKE 차%
차은우
차은
차차차
차안에서
차가강
차호호
차핳핳  ->
비교대상 컬럼 LIKE 문자%  -> 비교대상 컬럼값이 문자로 "끝"나는 것을 조회

EMP_NAME LIKE %차     
말차
영차
녹차
유자차
비교대상 컬럼 LIKE %문자% -> 비교대상 컬럼값이 문자앞뒤로 둘러쌓인 경우 - 차가 문자열에 들어간 경우
차차차
차은우
유자차
차자
어기영차

 ' _ ' = 1글자
 비교대상 컬럼 LIKE '_문자'   -> 비교대상 컬럼값에 문자앞에 무조건 한글자가 올 경우 조회
 EMP_NAME LIKE '_은우' -> 자릿수라고 생각하면 되는데, 은우 앞에 딱 한글자만 온 경우TRUE
 차은우
 김은우
 박은우
 남궁은우   -> 오류
비교대상 컬럼 LIKE '문자_'  -> 비교대상 컬럼값에 문자앞에 무조건 한글자가 온 경우 조회
EMP_NAME LIKE'차_'
차남
차녀
차은우
비교대상 컬럼 LIKE '__문자'  -> 비교대상 컬럼값에 문자앞에 무조건 두 글자가 온 경우 조회

비교대상 컬럼 LIKE '_문자_'  -> 비교대상 컬럼값에 문자앞에 무조건 두 글자가 온 경우 조회
EMP_NAME LIKE '_동_'      --> 비교대상 컬럼값에 무자 앞과 뒤에 무조건 한 글자씩 올 경우 조회.
성동일
장동건
동동이
부동   <--- 안됨 

*/

-- 사원들 중에 성이 전씨인 사웓늘의 사원명, 급여, 입사일 조회
SELECT EMP_NAME, SALARY , HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';  --전하, 전형돈, 전지현 등 글자 갯수를 특정할 수 없을때는 '_'(언더바) 보다는 %(퍼센트) 를 넣으면 좋다.  

--이름중에 하가 포함된 사원들의 사원명, 주민번호, 전화번호 조회
SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%'; -- 김하림, 정준하, 하하  와 같이 문장열에 하 가 포함된 것들을 전부 조회한다. 

--DLFMADML RKDNSEP RMFWKRK GKDLS TKDNJSEMFAKS WHGHL TKDNJSAUD, WJSGHKQJSGH
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_하_';   <--- 3글자에 한해서 가운데에 '하' 인 문장열을 조회하기.

--전화번호의 3번쨰 자리가 1인 사원들의 사번, 사원명, 전번, 이메일 조회해보기
--와일드 카드 : '_'(언더바)(1글자) , '%'(퍼센트)(0글자)

SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '__0%';   <--- 와일드 카드가 사용된 예) XX0 으로 시작하고 뒤에 숫자가 나열된 정보를 가진 ID, NAME, PHONE, MAIL을 조회하고싶다~ 라는 뜻

-- ** 특이케이스
--이메일 중 _(언더바)를 기준으로 앞글자가 3글자인 사원들의 사번, 이름, 이메일 조회
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___%';  <--- 원하고 있는 결과 도출 불가능. <-- 언더바가 4개, 퍼센트가 하나이기 때문에 4글자 이상의 문장열 전부 조회;로 해석이 된다.
--와일드 카드로 사용이 되고있는 언더바와 문장열의 기준으로 하고 싶은 언더바가 동일하기 때문에 조회가 불가능하다. 
-- 어떤게 와딜드 카드고 어떤게 데이터 값인지 구분해야됨
--데이터 값으로 취급하고자 하는 값 앞에 나만의 와일드 카드를 제시하고, 나만의 와일드 카드를 ESCAPE OPTION 으로 등록 해야한다. 

-- '___$문자%' ESCAPE'$'  <-- 나만의 와일드카드를 $로 정의 했고, 이 와일드 카드 뒤의 문자는 기준점이다. 
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '__$_%' ESCAPE '$'; -- 데이터 값으로 취급하고자 하는 값 닾에 나만의 와일드 카드를 제시하고 

--위의 사원들이 아닌 그외의 사원들 조회
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EAMIL NOT LIE '___$_%' ESCAPE'$'
-----------------------------------------------------------------------------------------------------------
--1. EMPLOYEE에서 이름이'연'으로 끝나는 사원들의 사원명 , 입사일 조회 해보기
SELECT EMP_NAME, SALARY , HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '연%';
--2. EMPLOYEE 에서 전화번호 처음 3자리가 010이 아닌 사원들의 사원명, 전화번호 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';
--3. EMPLOYEE에서 이름에 '하'가 포함 되어 있고 급여가 240만원 이상인 사원들의 사원명 , 급여 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%' AND SALARY >= 2400000;
--4. DEPARTMENT 에서 해외영업부인 부서들의 부서코드, 부서명 조회
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE'해외영업%';

/*
    <IS NULL / IS NOT NULL >
*/
--보너스를 받지 않는 사원 (BONUS 의 값에 NULL) 들의 사번, 이름, 급여, 보너스 조회하기
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
--WHERE BONUS = NULL; 오라클에서는 = NULL 이라는 구문이 활용되지 못한다. 
--WHERE BONUS IS NULL; 라고 기술을 해야 정상적으로 조회가 된다. 
WHERE BONUS IS NOT NULL; --이라고 하면, NULL이 아닌 경우를 조회한다. not은 컬럼명 또는 is 뒤에서 사용 가능하다.

--사수가 없는 사원(MANAGER_ID)들의 사원명, 사수사번, 부서코드 조회
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE;
WHERE MANAGER_ID IS NULL;

--부서배치를 아직 받지 못했지만, 보너스는 받는 사원들의 이름, 보너스, 부서코드 조회
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE;
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

--연산자 중에서 IN 이라 부는 애가 있다. 
/*
  < IN >
    비교대상 컬럼값이 내가 제시한 목록중에 일치하는 값이 있는지
    
    [표현법]
    WHERE 비교대상컬럼 IN('값1','값2','값3', ...)

*/
--부서코드가 D6이거나 D8이거나 D5인 부서원들의 이름, 부서코드, 급여 조회해보기
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
--WHERE DEPT_CODE='D6' OR DEPT_CODE='D8' OR DEPT_CODE = 'D5';
WHERE DEPT_CODE IN('D6','D8','D5');


--직급 코드가 J7이거나 J2인 사원들 중 급여가 200만원 이상인 사원들의모든 컬럼 조회.
SELECT *
FROM EMPLOYEE
WHERE JOB_CODE= 'J7' OR JOB_CODE = 'J2' AND SALARY >=2000000;
-----------------------------------------------------------------------------
--1. 사수가 없고 부처배치도 받지 않은 사원들(사원명, 사수사번, 부서코드) 조회
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;
--2. 연볻(보너스미포함)이 3000만원 이상이고, 보너스를 받지 않는 사원들의조회(사번, 사원명, 급여 보스)
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE SALARY*12>=30000000 AND BONUS IS NULL;
--3. 입사일이 95/01.01 이상이고, 부서채비를 받은사원들의 사원들의 (사번, 사원명, 입사일, 부서코드)조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL AND HIRE_DATE>= '95.01.01';
--4. 급여가 200만원 이상 500만원 이고, 입사일이 '01/01/01' 이상이고 보너스를 받지 않은 사원들의 사번 사원명 급여ㅛ 입사일 보너스 )조회
SELECT EMP_ID, EMP_NAME, SALARY , HIRE_DATE, BONUS 
FROM EMPLOYEE
WHRER SALARY BETWEEN 2000000 AND 5000000 AND HIRE_DATE > '01.01.01' AND BONUS IS NULL;
--5. 보너스 포함 연봉이 NULL이 아니고 이름에  하 가 포함되어 있는 사원들의 사번 사원명 급여 보너스 조회 별칭부여ㅣ
SELECT EMP_ID, EMP_SAME, SALARY, (BONUS + BONUS * SALARY)*12
FROM EMPLOYEE
WHERE BONUS IS NOT NULL AND EMP_NAME '%하%' AND;
 --
 --
 /*
 ORDER BY 절
가장 마지막줄에 작성 뿐만 아니라 실행순서 또한 마지막에 실행
[표현법]
SELECT조회하고자 하는 컬럼 명, 연산식, 별칭
FROM조회하고자 하는 테이블명
WHERE조건식
ORDER BY 정렬하고 싶은 컬럼, 별칭 사용 가능, 컬럼 순번 [ASC|DES] [NULLS FIRST] [NULLS LAST]
-ASC : 오름차순 정렬 (생략시 기본값)- (안써도 기본적으로 ORACLE은 오름차순이다. )
-DESC: 내림차순 정렬
-NULLS FIRST : 정렬하고자 하는 컬럼 값에 NULL이 있는 경우 해당 데이터를 맨 앞 배치.
-NULLS LAST : 정렬하고자 하는 컬럼 값에 NULL이 있을 경우 해당 데이터를 맨 뒤 배치.
 */


SELECT *
FROM EMPLOYEE
--ORDER BY BONUS;  -- 현재 ORDER BY 에 아무수식어도 정의하고 있지 않은데, 오름차순이 기본으로 되어있다. 
--ORDER BY BONUS ASC ; -- 현재 ASC가 기술됬는데 기본적으로 NULLS LAST가 기본값으로 되어있다. 
--ORDER BY BONUS DESC; -- 현재 DESC가 기술됬는데,기본적으로 NULLS FIRST 가 기본값으로 되어있다. 
ORDER BY BONUS DESC, SALARY ASC; --정렬 기준 여러개 제시 가능(첫 번쨰 기준의 컬럼값이 동일할 경우 두번쨰 기준 컬럼 가지고 정렬 한다.)

-- 전 사원의 사원명, 연봉 조회하고 싶다. (이떄 연봉별 내림차순 정렬조회)
SELECT EMP_NAME, SALARY*12 AS "연봉"
FROM EMPLOYEE
--ORDER BY 연봉 DESC; --별칭 사용이 가능하다. 
ORDER BY 2 DESC; -- 컬럼 순번 사용 가능. (SELECT 에서 2번쨰 있었던 컬럼 호출)
























