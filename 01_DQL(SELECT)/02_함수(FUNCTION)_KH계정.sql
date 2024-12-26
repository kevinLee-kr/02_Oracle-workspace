--예이~
/*
함수
전달된 컬럼값을 읽어들여서 함수를 실행,ㅡ 실행한 결과를 반환한다. 

- 단일행 함수 : N개의 값을 읽어들여서 N개의 결과값을 리턴한다.(매행 마다 함수 실행 결과 반환한다.) 사원이 5명 있는데 키(HEIGHT) 가 있는데, 키값을 반올림한다면, 데이터가 나오자나, 두개의 값을 반올림 하겠다 하면, 2개의 값이 나오겠찌. 하지만
5개의 값중에 가장큰, 가장 작은, 조건식에 의해서 어떤 값을 도출하고 싶다. 그러면 그룹함수를 쓰면 된다. 
- 그룹 함수 : N개의 값을 읽어들여서 1개의 결과값을 리턴한다. (그룹을 지어 그룹별로 함수 실행 결과 반환)

SELECT 절을 짤때 단일행 함수랑 그룹함수를 함께 사용 못한다. 
왜냐면, 결과 행의 개수가 다르기 때문이다. 

함수식을 기술 할 수 있는 위치가 정해져 있다. SELECT절, WHERE절, ORDER BY 절, GROUP BY잘, HAVING 절.
자 그러면 이제부터, 함수식을 기술하는 방법을 아라보자. 
문자 처리 함수. 에 대해 알아보자 .
LENGTH / LENGTHB : 글자수를 리턴하는 함수, 결과값으로는 숫자(INT)로 나온다. 
[표현식]
LENGTH(컬럼|'문자열값') : 해당 문자열값의 글자수를 반환해준다. 
LENGTHB(컬럼|'문자열값'): 해당 문자열 값의 바이트 수 반환해준다. 

'김', '나', 'ㄱ' 등 한글로 되어있는 문자들은 3BYTE로 구성이 되어있다. 
영문자, 숫자, 특문등 한글 외에 문자들은 1BYTE로 구성되어있다. 
*/

SELECT SYSDATE FROM DUAL; --가상테이블로부터 조회를 하겠다. (DUAL)

SELECT LENGTH('오라클'), LENGTHB('오라클')
FROM DUAL;
--오라클이라고 한다면, 3글자, 라고 하는데
--LEGNTHB 라고 하면, 3, 6, 9BYTE(3글자이기 때문) 로 출력된다. 

SELECT LENGTH('oracle'), lengthb('oracle')
FROM DUAL;
--6글자 이기 때문에 '6'
--각 1글자당 1BYTE이기 때문에 6BYTE

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME), EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;

/*
INSTR
문자열로부터 특정 문자의 시작위치를 찾아서 반환
[표현법]
INSTR(컬럼|'문자열', '찾고자 하는문자', ['찾을위치의 시작값'] <--결과값이 NUMBER타입이다. 
찾을 위치의 시작값
1 : 앞에서부터 찾겠다. 
-1: 뒤에서부터 찾겠다. 
*/
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL; --해석: DUAL테이블에서 저 첫 문자열에서 B를 찾고 싶다. 기본값은 1이기 때문에(앞에서부터 찾는다), A,A,B 즉, 3번쨰 있기 때문에 출력값이 3이 나온다. 
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL; --해석: 찾을 위치 시작점이-1이기 때문에 맨 뒤에서부터 시작한다. B는 앞에서부터 10번쨰 자리에 위치해 있는걸 확인 했으니 10의 값을 출력한다. 
SELECT INSTR('AABAACAABBAA', 'B', -1, 2) FROM DUAL;

--골뱅이, 언더바등이 EMAIL형식에서 어디에 위치해 있는지 찾고 싶다. 
SELECT EMAIL ,INSTR(EMAIL,'_', 1, 1) AS " _위치", INSTR(EMAIL, '@') AS"@위치"
FROM EMPLOYEE;

--SUBSTR
--문자열에서 특정 문자열을 추출해서 반환(자바에서의 SUBSTRING() 메소드와 매우 유사. 
--SUB(STRING, POSITION, [LENGTH]) <-- 결과값이 CHARACTER 타입
-- -STRING : 문자타입컬럼 또는 '문자열값'
-- - POSITION : 문자열을 추출할 시작위치값
-- - LENGTH : 추출할 문자 개수(생략시 끝까지 의미)
SELECT SUBSTR('SHOWMETHEMONEY' ,7) FROM DUAL; --7번 부터 보여준다. (짤라서 출력해준다.)
SELECT SUBSTR('SHOWMETHEMONEY' , 5, 2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY' , 1, 6) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;

--여자 사원들만 조회해보기
SELECT EMP_NAME
FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO,8,1) = 2 OR SUBSTR(EMP_NO, 8,1)=4;
--주민번호 8번쨰 자리 첫번째 자리가 2 또는 4인 사원들의 이름만 출력을 원할때. 
WHERE SUBSTR(EMP_NO,8,1) IN('2','4');
--같은 결과값을 도출하지만 IN을 사용했다. 

SELECT EMP_NAME
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN (1,3)
--오라클은 형변환이 너무 유연해서 '' 를 쓰지 않았지만, 잘 된다. 위에와 작동 구조가 동일하다. (내부적으로 자동 형변환 됨)
ORDER BY 1; --기본적으로 오름차순이다 오라클은.

--함수 중첩 사용해보기
SELECT EMP_NAME, EMAIL, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL,'@')-1) -- SUBSTR조건식중에 EMAIL에서~ 1첫째에서 골뱅이의 위치를 찾고 1번부터 골뱅이의 위치까지 의 글자수를 알아낸다. 최종적으로는 -1까지 해서 골뱅이전까지 위치를 찾아준다.
FROM EMPLOYEE;--나는 지금 사람들의아이디만 따고 싶다. ,\

/*
LPAD, RPAD
문자열을 조회할 떄 통일감 있게 조죄하고자 할 떄 이용한다. 
[표현법]
LPAD/RPAD(STRING, 최종적으로 반환할 문자의 길이,[덧붙이고자 하는문자])
문자열에 덧붙이고자 하는 문자를 왼쪽 또는 오른쪽에 덧붙여서 최종 N 길이 만큼의 문자열을 반환.
*/
--20만큼의 길이 중 EMAIL컬럼값은 오른쪽으로 정리하고 나머지 부분은 공백으로 채워짐(왼편_)
SELECT EMP_NAME, EMAIL, LPAD(EMAIL, 20) -- 덧붙이고자 하는 문자 생략시 기본값이 공백이 된다. 
FROM EMPLOYEE;

SELECT EMP_NAME, EMAIL, LPAD(EMAIL, 20, '*')
FROM EMPLOYEE;



SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO),8 , 14 ,'%')
FROM EMPLOYEE;


SELECT EMP_NAME, SUBSTR(EMP_NO,1,8)||'*******'
FROM EMPLOYEE;
/*
LTRIM/RTRIM
문재열에서 특정 문자를 제거한 나머지를 반환한다. 
[표현법]
LTRIM/RTRIM(STRING, [제거할 문자들'] -> 생략하면 공백 제거중

문자열의 왼쪽 혹은 오른쪽에서 제거하고자 하는 문자들을 찾아서 제거 후 문자열 반환
*/
SELECT LTRIM('  K  H') FROM DUAL; -- 공백을 찾아서 제거를 하고 공백안에 문자를 만나게 되면 도망갑니다. 그냥 끝남;

SELECT LTRIM('123123KH123','123') FROM DUAL;
SELECT LTRIM('AAAAAaaaCABACCKH', 'A')FROM DUAL; -- 특정 문자를 찾아서 짤르고 출력을 해준다. 

SELECT RTRIM('5782KH123','01023122357') FROM DUAL;

/*
TRIM
문자열 앞/뒤/양쪽에 있는 지정한 문자들을 제거한 나머지 문자열 탄환
W

FROM EMPLOYEE;
*/
SELECT TRIM('     K  H  ') FROM DUAL;

SELECT TRIM('Z' FROM 'ZZZZKHZZZZZ') FROM DUAL;  --> KH
SELECT TRIM(LEADING 'Z' FROM 'ZZZZKHZZZ') FROM DUAL; --> KHZZZ, 리딩은 앞을 말한다.LTRIM과 매우 유사하다. 
SELECT TRIM(TRAILING 'Z' FROM 'ZZZZKHZZZ') FROM DUAL; --> ZZZKH,  TRAILING : 뒤 - RTRIM 과 유사하다.
SELECT TRIM (BOTH 'Z' FROM 'ZZZZKHZZZ') FROM DUAL; -->KH

/*
LOWER / UPPER / INITCAP

LOWER, UPPER, INITCAP ( STRING ) CHARACTER 결과값으로 반환된다. 
LOWER : 다 소문자로 변경한 문자열 반환
UPPER : 다 대문자로 변경한 문자열 반화
INITCAP : 앞 글저다마 대문자로 변경한 문자열 반환

*/
SELECT LOWER('WELCOME TO MY WORLAKD!') FROM DUAL;
SELECT UPPER('WELCOME TO MY WORLAKD!') FROM DUAL;
SELECT INITCAP('WELCOME TO MY WORLAKD!') FROM DUAL;

/*
CONCAT
문자열 두개를 전달받아 하나로 합친 후 결과를 반환해준다. 
CONCAT(STRING, STRING)  --> 결과값 CHARACTER 타입으로 반환한다 .
*/
SELECT CONCAT('ABC','초콜릿') FROM DUAL;
select 'abc'||'초콜릿' From DUAL;

--SELECT CONCAT('ABC','초콜릿','맛있따') FROM DUAL; -- 오류발생, 2개만 받을 수 있다. 

select 'abc'||'초콜릿' || '맛있다.' From DUAL;

/*
REPLACE(STRING, STR1 , STR2) --STRING 하나를 주고, STR1을 STR2로 바꾸고 싶다. 결과값은 CHARACTER이고, 
SELECT FRM-NAME, EMAIL
FROM EMPLYEE;

SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'kh.or.kr','gmail.com')
FROM EMPLOYEE;


숫자 처리 함수에 대해서 알아보자. 
 ABSOLUTE 절대값을 구해주는 함수. 
 ABS -> 결과값은 NUMBER 타입
 */
SELECT ABS(10) FROM DUAL;
SELECT ABS(10.577) FROM DUAL;
SELECT ABS(-5) FROM DUAL;

/*
MOD
두 수를 나눈 나머지 값을 반환해주는 함수. 

7숫자. 값을 기본적으로 사용한다. 
*/

SELECT MOD(10,3) FROM DUAL;
SELECT MOD(10.9,3) FROM DUAL;
------------------------------------------------------------------------------------
/*
ROUND
반올림한 결과를 반환
ROUND (NUMBER,[위치])  => 결과값이 NUMBER타입
*/
SELECT ROUND (123.456,1) FROM DUAL;
SELECT ROUND (123.456,-1) FROM DUAL;
SELECT ROUND (123.456,0) FROM DUAL;

/*
CEIL
올림처리 해주는 함수
*/
SELECT CEIL(123.152) FROM  DUAL;
--5이상 아니여도 무조건 그냥 올림, 위치 지정 불가. 

/*
FLLOR
소수점 아래 버림처리 하는 함수

*/
SELECT FLOOR(123.152) FROM DUAL;
SELECT FLOOR(123.952) FROM DUAL;

/*
TRUNC(절삭하다)
위치 지정해서 버림처리 해주는 함수 . 
TRUNC(NUMBER,[위치])
*/
SELECT TRUNC(123.456) FROM DUAL; -- 위치 지정 하지 않으면 소수점 이 기본값이다. 
SELECT TRUNC(123.456, 1) FROM DUAL;  -- 소숫점 아래 첫째자리 까지 표기하고 싶다.
SELECT TRUNC(123.456, -1) FROM DUAL; -- 해당 위치 뒤로 버려버린다. 
--<오늘날짜 처리 함수>
-- SYSDATE : 시스템 날짜 및 시간 반환( 현재 날짜 및 시간)
SELECT SYSDATE FROM DUAL; --클릭해면 현재 시간 도 확인가능

--ㅡMONTH BETWEEN(DA1, ED2) : 두 날짜 사이의 개월 수 => 내부적으로 DATE1 -(빼기) DATE2 후 나누기 30,31이 진행 될 것이다. 
--결과값은 NUMBER 타입
-- EMPLOYEE, 에서 사원명, 입사일, 근무 개원수

SELECT EMP_NAME, HIRE_DATE, FLOOR(SYSDATE - HIRE_DATE) ||'일' AS "근무일수", 
CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) ||'개월' AS "근무개월수"
FROM EMPLOYEE;

/*
ADD_MONTHS(DATE, NUMBER) : 특정날짜에 해당 숫자만큼의 개월수를 더해서 날짜로 리턴한다. 
결과값 : DATE타입
*/
SELECT ADD_MONTHS(SYSDATE, 6) FROM DUAL; --6개월 뒤의 나이를 구할 수 잇다. 

--EMPOYERR 사원명, 입사일, 입사 후 6개월이 된 날짜 조회
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE,6) AS "수습만료일"
FROM EMPLOYEE;

/*
NEXT_DAY(DATE, 요일(문자|숫자)) : 특정날짜 이후에 가장 가까운 해당 요일의 날짜를 반환해주는 함수
-- 결과값은 DATE타입

*/
SELECT SYSDATE, NEXT_DAY(SYSDATE,'월요일')FROM DUAL;-- 오늘 기준 12월 26일 (목요일) 인데 가장 가깝게 다가오는 월요일은 12월 30일이다. (결과값)
SELECT STSDATE, NEXTDAY(SYSDATE, '월') FROM DUAL;
--1. 일요일, 월요일.. 토요일. 
SELECT SYSDATE, NEXT_DAY(SYSDATE, 6) FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRIDAY') FROM DUAL;-- 현재 언어가 ,KOREAN 이기 때문에 요류가 발생한다. 

--언어 변경
SELECT * FROM NLS_SESSION_PARAMETERS;

ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
ALTER SESSION SET NLS_LANGUAGE = KOREAN; --확인후 이걸로 꼭 바꾸기.!

/*
ALST_DAY(DATE) : 해당 월의 마지막 날짜를 구해서 반환한다. 
결과값은 DATE타입이다. 
*/
SELECT LAST_DAY(SYSDATE) FROM DUAL;

--EMPLOYEE에서 사원명, 입사일, 입사한달의 마지막 날짜, 입사한 달에 근무한 일수를 구해보자
SELECT EMP_NAME,HIRE_DATE , LAST_DAY(HIRE_DATE) AS "입사달의 마지막날", LAST_DAY(HIRE_DATE)-HIRE_DATE AS "첫달 근무일수"
FROM EMPLOYEE;

/*
EXTRACT: 특정 날짜로부터 년도, 월, 일 값을 추출해서 반환하는 함수.
EXTRACT(YEAR FROM DATE) : 년도만 추출해준다. 
EXTRACT(MONTH FROM DATE): 월만 추출해준다. 
EXTRACT(DAY FROM DATE) : 일만 추출해 준다. 
-> 결과의 값은 NUMBER타입 입니다. 
*/
--사원명, 입사년도, 입사월, 입사일 조회해 보자. 
SELECT EMP_NAME, 
EXTRACT(YEAR FROM HIRE_DATE) AS "입사년도",
EXTRACT(MONTH FROM HIRE_DATE) AS "입사월",
EXTRACT(DAY FROM HIRE_DATE) AS "입사일"
FROM EMPLOYEE
ORDER BY "입사년도","입사월","입사일";
------------------------------------------------------------
/*
형변환
TO_CHAR : 숫자타입 또는 날짜타입의 값들을 문자 타입으로 변환시켜주는 함수이다. 

TO_CHAR(숫자 혹은 날짜, [포멧])   결과값은 CHAR타입이다. 
*/
-- 숫자 타입을 갖고 있는데 문자 타입으로 바꾸고 싶어졌다. 
SELECT TO_CHAR(1234) FROM DUAL;
--원래는 1234 였고, 출력도 1234로 보이는데, 무엇이 바껴졌냐? (INT)1234 -> (STRING)1234가 된거다. 

SELECT TO_CHAR(1234,'99999') FROM DUAL;  --5칸짜리 공간을 확보하고 우측 정렬 한 것이다. 
SELECT TO_CHAR(1234,'00000') FROM DUAL;
SELECT TO_CHAR(1234,'L99999') FROM DUAL; --현재 시스템에 설정된 국가의 화페단위를 나타낸다. 
SELECT TO_CHAR(1234,'$99999') FROM DUAL; -- $가 표시가 된다. 
SELECT TO_CHAR(1234,'L99,999') FROM DUAL;
SELECT EMP_NAME, SALARY
FROM EMPLOYEE;

SELECT EMP_NAME, TO_CHAR(SALARY, 'L999,999,999')
FROM EMPLOYEE;

--위에는 숫자타입을 문자타입으로 바꾸는 과정이었다. 
--날짜 타입을 문자타입으로 바꾸어 보자
SELECT SYSDATE FROM DUAL; --기본
SELECT TO_CHAR(SYSDATE) FROM DUAL; -- 결과값이 같게 나왔지만(24/12/26), 클릭해서 속성값을 보면 달력이 보이는 것이 아닌, 문자가 나온다. 즉, 형변환이 된 것이다. 
--포맷에 대해 알아보자.
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL; --오후 12:23:43 (12시간 형식)
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL; --12:23:43 (24시간 형식)
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY') FROM DUAL; --2024-12-26 목요일 목
SELECT TO_CHAR(SYSDATE, 'MON,YYYY') FROM DUAL; --12월,2024

SELECT EMP_NAME, HIRE_DATE, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD')
FROM EMPLOYEE;


--년도와 관련된 포멧
SELECT TO_CHAR(SYSDATE,'YYYY'),
TO_CHAR(SYSDATE,'YY'),
TO_CHAR(SYSDATE, 'RRRR'),
TO_CHAR(SYSDATE,'RR'),
TO_CHAR(SYSDATE,'YEAR')
FROM DUAL;

--월과 관련된 포맷
SELECT TO_CHAR(SYSDATE,'MM'),
TO_CHAR(SYSDATE,'MON'),
TO_CHAR(SYSDATE, 'MONTH'),
TO_CHAR(SYSDATE,'RM')
FROM DUAL;

--일과 관련된 포맷
SELECT TO_CHAR(SYSDATE,'DDD') ,--올해기준으로 오늘이 며칠째인지.
        TO_CHAR(SYSDATE,'DD'), -- 월 기준으로 오늘이 며칠인지
        TO_CHAR(SYSDATE,'D')  -- 주 기준으로 오늘이 몇일쨰 요일을 맞고 있는지, 
FROM DUAL;

--요일에 대한 포맷
SELECT TO_CHAR(SYSDATE, 'DAY'), -- 목요일
TO_CHAR(SYSDATE,'DY')           -- 목
FROM DUAL;

/*
TO_DATE : 숫자타입 또뭄 문자타입 데이터를 날짜 타입으로 변환해주는 함수
TO_DATE(숫자 OR 문자, [포맷]),결과값으로는 DATE타입이 나온다. 
*/
SELECT TO_DATE(20100101) FROM DUAL;   --> 10/01/01
SELECT TO_DATE(100101) FROM DUAL;  --> 잘 나옴.
SELECT TO_DATE(070101) FROM DUAL; --> 에러, 첫글자가 0인 경우는 문자타입으로 변경하고 수행해야 한다. 
SELECT TO_DATE('070101') FROM DUAL;

SELECT TO_DATE('041030 143000') FROM DUAL; --에러 발생.,
SELECT TO_DATE('041030 143000','YYMMDD HH24MISS') FROM DUAL;

SELECT TO_DATE('140630', 'YYMMDD') FROM DUAL; -- 24년도
SELECT TO_dATE('980630', 'YYMMDD') FROM DUAL; -- 2098년으로 인식됨. 
SELECT TO_dATE('140630', 'RRMMDD') FROM DUAL;
SELECT TO_dATE('980630', 'RRMMDD') FROM DUAL;   -- 98년도
--해당 두자리 년도 값이  50미만일 경우 현재 세기 반영, 50일 경우  이상일 영우 이전 세기 반영

--TO_DATE 사용처
--호텔스 컴바인. 화면에서 무조건 문자입으로 넘어갈떄. 
--현재까지 함수에 대해서 하고 있는데 단일 함수에 대한것들을 하고 있다. 

/*
TO_NUMBER : 문자 타입의 데이터를 숫자타입으로 변환시켜주는 함수. 
[표현법]
TO_NUMBER(문자, [포맷])  <-- 결과값은 NUMBER타입으로 나온다. 
*/
SELECT TO_NUMBER('01023122357') FROM DUAL;
--0은 빠지고 숫자타입으로 저장됨, 맨앞에 0이 있으면 자동으로 생략된다. 
SELECT '1' + '55000' FROM DUAL;   --자바에서는 '문장+문장'으로 그냥 이어지기만 했는데, 오라클에서는 결과값에서 보이다시피 자동 형변환으로 인해 잘 더해진것을 볼 수 있다. 
SELECT '1,100,000' + '55,000' FROM DUAL; --오류남. 문장 일떄, 숫자만 있어야 더해질수 있다. 

--SELECT TO_NUMBER('100,000,000', '999,999,999') + TO_NUMBER('55,000','99'999') FROM DUAL;

/*
NULL 처리 함수.
NVL(컬럼, 해당 컬럼값이 NULL일 경우 반환할 값) */
SELECT EMP_NAME, BONUS, NVL(BONUS,0)
FROM EMPLOYEE;

--전 사원의 이름, 보너스 포함 연봉을 조회 해 보자. (NULL처리 함수 응용)
SELECT EMP_NAME, BONUS, (SALARY + SALARY * BONUS)*12, (SALARY + SALARY * NVL(BONUS,0))*12
FROM EMPLOYEE;

SELECT EMP_NAME, DEPT_CODE, NVL(DEPT_CODE,'부서없음')
FROM EMPLOYEE;

--NVL2(컬럼, 반환값1, 반환값2)
--컬럼값이 존재할 경우 반환값1 반환
--컬럼값이 존재하지 않을 경우 반환값2 반환.
SELECT EMP_NAME, BONUS, NVL2(BONUS, 0.7, 0.1)
FROM EMPLOYEE;


SELECT EMP_NAME, DEPT_CODE, NVL2(DEPT_CODE, '부서있음', '부서없음') AS "부서 존재 여부"
FROM EMPLOYEE;


-- NULLIF(비교대상1, 배교대상2)
-- 두개의 값이 일치하면 NULL반환
-- 두개의 값이 일치하지 않으면 비교대상 1반환
SELECT NULLIF('123', '123') FROM DUAL;
--=============================================================================================
/*
선택함수 시작.
DECODE (비교하고자 하는 대상(컬럼 OR 산술연산 OR 함수식) , 비교값1, 결과값1)
*/
--사번, 사원명, 주민번호, 주민번호 뒷자리의 첫 글자.
SELECT EMP_ID, EMP_NAME, EMP_NO, SUBSTR(EMP_NO,8,1),
DECODE (SUBSTR(EMP_NO,8,1),'1',' 남사원 ','2',' 여사원 ') AS "성별"
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, EMP_NO, SUBSTR(EMP_NO,8,1),
DECODE (SUBSTR(EMP_NO,8,1),'1',' 남사원 ') AS "성별"
FROM EMPLOYEE;

--직원의 급여를 조회해서 각 직급멸로 인상해서 조회해보세요.
--직급이 J7인사람은 급여를 10% 인상한 급여로 보이게 해주세요
--K6인 사원은 급여를 15% 인상한 것으로 보이게 해주세요
-- J5 인사원은 급여를 20%인상한 것 처럼 보이게 해주세요


--사원명, 직급코드, 기존급여, 인상된 급여. 
SELECT EMP_NAME AS"사원명", JOB_CODE AS "직급 코드", SALARY AS "기존 급여",
DECODE(JOB_CODE,'J7',SALARY+SALARY*0.1,
                'J6',SALARY+SALARY*0.15,
                'J5',SALARY+SALARY*0.2,
                    SALARY * 1.05) AS "인상된 급여"
FROM EMPLOYEE
ORDER BY JOB_CODE;


/*
CASE WHEN THEN
CASE WHEN 조건식1 THEN 결과값 1
     WHEN 조건식2 THEN 결과값 2
     ...
     ELSE 결과값99
     END
*/

SELECT EMP_NAME, SALARY,
CASE WHEN SALARY>=5000000 THEN '고급개발자'
     WHEN SALARY>=3000000 THEN '중급개발자'
     ELSE '초급개발자'
     END AS "레벨"
FROM EMPLOYEE;


----------------------------------------------------<그룹 함수>-------------------------------------
/*1. SUM(숫자타입컬럼):해당 컬럼값들의 총 합계를 구해서 반환해주는 함수
--EMPLOYEE 테이블의 전 사원의 총 급여합
SELECT SUM(SALARY)   
FROM EMPLYEE; -- 전체 사원이 하나의 그룹으로 묶였다. 
*/
--남자 사원들의 총 급여합
SELECT SUM(SALARY) AS "총급여의 합"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1)IN('1','3'); --남자 사원들의 총 급여

--부서코드가 D5인 사원들의총 연봉합. 
SELECT SUM(SALARY*12) AS "D5사원 연봉합"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';


--2. AVG(숫자타입) : 해당 컬럼값들의 평균값을 구해서 반환
-- 전체 사원의 평균 급여 조회
SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;

--3. MIN(여러타입) : 
SELECT MIN(EMP_NAME), MIN(SALARY), MIN(HIRE_DATE)
FROM EMPLOYEE;

--4. MAX(여러타입) : 여러 값들 중에 가장 큰 값 구해서 반환
SELECT MAX(EMP_NAME), MAX(SALARY), MAX(HIRE_DATE)
FROM EMPLOYEE;

--5. COOUNT( * OR 컬럼 OR DISTINCT) :조회된 행 개수 세서 반환
--   COUNT(*):조회된 결과의 모든 행 개수 세서 반환
--   COUNT(컬럼) : 제시한 해당 컬럼의값이NULL이 아닌것만 행 개수 세서 반환
--   COUNT(DISTINCT 컬럼)

--전체 사원 수 
SELECT COUNT(*)
FROM EMPLOYEE;

--여자 사원 수
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN('2','4');

SELECT COUNT(BONUS)
FROM EMPLOYEE; -- 결과값 : 9, 해당 열에 NULL값이 아닌 경우만 카운팅을 하고 출력함. 

--부서배치를 받은 사원 수

SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;

--현재 사원들이 분포되어 있는 부서의 수
SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;






