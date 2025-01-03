SELECT * FROM TB_CLASS;
SELECT * FROM TB_CLASS_PROFESSOR;
SELECT * FROM TB_DEPARTMENT;
SELECT * FROM TB_GRADE;
SELECT * FROM TB_PROFESSOR;
SELECT * FROM TB_STUDENT;
--1. 춘 기술대학교의 학과 이름과 계열을 표시하시오. 단, 출력 헤더는 "학과 명", "계열" 으로 표시하도록 핚다.

SELECT DEPARTMENT_NAME "학과 명", CATEGORY"계열"
FROM TB_DEPARTMENT;


--2. 학과의 학과 정원을 다음과 같은 형태로 화면에 출력핚다.

SELECT DEPARTMENT_NAME||'과의 정원은 '||CAPACITY||'명 입니다. '
FROM TB_DEPARTMENT;


--3. "국어국문학과" 에 다니는 여학생 중 현재 휴학중인 여학생을 찾아달라는 요청이 들어왔다. 누구인가?
--(국문학과의 '학과코드'는 학과 테이블(TB_DEPARTMENT)을 조회해서 찾아 내도록 하자)


SELECT *
FROM TB_DEPARTMENT
JOIN TB_STUDENT USING(DEPARTMENT_NO)
WHERE SUBSTR(STUDENT_SSN,8,1) IN('2','4')
AND ABSENCE_YN='N';

--4. 도서관에서 대출 도서 장기 연체자 들을 찾아 이름을 게시하고자 핚다. 그 대상자들의 학번이 다음과 같을 때 대상자들을 찾는 적젃핚 SQL 구문을 작성하시오.
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN('A513079','A513090','A513091','A513110','A513119')
ORDER BY STUDENT_NAME DESC;


--5. 입학정원이 20명 이상 30명 이하인 학과들의 학과 이름과 계열을 출력하시오.

SELECT DEPARTMENT_NAME, CATEGORY 
FROM TB_DEPARTMENT
WHERE CAPACITY >=20 AND CAPACITY<=30;


--6. 춘 기술대학교는 총장을 제외하고 모든 교수들이 소속 학과를 가지고 있다.
--그럼 춘 기술대학교 총장의 이름을 알아낼 수 있는 SQL 문장을 작성하시오.
SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;




--7. 혹시 젂산상의 착오로 학과가 지정되어 있지 않은 학생이 있는지 확인하고자 핚다.
--어떠핚 SQL 문장을 사용하면 될 것인지 작성하시오.
SELECT *
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NOT NULL;


--8. 수강신청을 하려고 핚다. 선수과목 여부를 확인해야 하는데, 
--선수과목이 존재하는 과목들은 어떤 과목인지 과목번호를 조회해보시오.
SELECT PREATTENDING_CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;


--9. 춘 대학에는 어떤 계열(CATEGORY)들이 있는지 조회해보시오.
SELECT DISTINCT CATEGORY
FROM TB_DEPARTMENT;


--10. 02학번 전주 거주자들의 모임을 만들려고 핚다.
--휴학핚 사람들은 제외한 재학중인 학생들의 학번, 이름, 주민번호를 출력하는 구문을 작성하시오.

SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN, STUDENT_ADDRESS, ENTRANCE_DATE
FROM TB_STUDENT
WHERE SUBSTR(ENTRANCE_DATE,1,2)=02
AND SUBSTR(STUDENT_ADDRESS,1,2) IN('전주')
AND ABSENCE_YN = 'N';



--1. 영어영문학과(학과코드 002) 학생들의 학번과 이름, 입학 년도를 입학 년도가 빠른 순으로 표시하는 SQL 문장을 작성하시오.
--( 단, 헤더는 "학번", "이름", "입학년도" 가 표시되도록 핚다.)
SELECT STUDENT_NO"학번", STUDENT_NAME" 이름 ", ENTRANCE_DATE"입학년도"
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NO = 002
ORDER BY ENTRANCE_DATE ASC;


--2. 춘 기술대학교의 교수 중 이름이 세 글자가 아닌 교수가 핚 명 있다고 핚다.
--그 교수의 이름과 주민번호를 화면에 출력하는 SQL 문장을 작성해 보자.
--(* 이때 올바르게 작성핚 SQL 문장의 결과 값이 예상과 다르게 나올 수 있다. 원인이 무엇일지 생각해볼 것)
SELECT PROFESSOR_NAME"이름", PROFESSOR_SSN"주민번호"
FROM TB_PROFESSOR
WHERE PROFESSOR_NAME LIKE '____%'
OR PROFESSOR_NAME LIKE'__';
--3. 춘 기술대학교의 남자 교수들의 이름과 나이를 출력하는 SQL 문장을 작성하시오.
--단 이때 나이가 적은 사람에서 맋은 사람 순서로 화면에 출력되도록 맊드시오.
--(단, 교수 중 2000년 이후 출생자는 없으며 출력 헤더는 "교수이름", "나이"로 핚다. 나이는 ‘맊’으로 계산핚다.)
SELECT PROFESSOR_NAME"교수이름", FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE('19' || 
                                                    SUBSTR(PROFESSOR_SSN, 1, 6), 'YYYYMMDD')) / 12 ) 나이
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN,8,1)='1'
ORDER BY PROFESSOR_SSN DESC;



--4. 교수들의 이름 중 성을 제외핚 이름맊 출력하는 SQL 문장을 작성하시오. 출력 헤더는 ?이름? 이 찍히도록 핚다.
--(성이 2자인 경우는 교수는 없다고 가정하시오)
SELECT SUBSTR(PROFESSOR_NAME,2,3)"이름"
FROM TB_PROFESSOR;

--5. 춘 기술대학교의 재수생 입학자를 구하려고 핚다. 어떻게 찾아낼 것인가?
--이때, 19살에 입학하면 재수를 하지 않은 것으로 갂주핚다.
SELECT E.*
FROM (
SELECT STUDENT_NAME, STUDENT_SSN, ENTRANCE_DATE, ABSENCE_YN,
SUBSTR(TO_CHAR(ENTRANCE_DATE,'YYYYMMDD'),1,4)-('19'||SUBSTR(STUDENT_SSN, 1, 2))             AS"입학나이"
FROM TB_STUDENT
)E
WHERE 입학나이 > 19
;
--6. 2020년 크리스마스는 무슨 요일인가?
SELECT TO_CHAR(TO_DATE(20201225), 'DAY') 
FROM DUAL; -- 금요일
--7. TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD') 은 각각 몇 년 몇 월 몇 일을 의미핛까?
--또 TO_DATE('99/10/11','RR/MM/DD'), TO_DATE('49/10/11','RR/MM/DD') 은 각각 몇 년 몇 월 몇 일을 의미핛까?
SELECT TO_DATE('99/10/11', 'YY/MM/DD') FROM DUAL; -- 2099년 10월 11일
SELECT TO_DATE('49/10/11', 'YY/MM/DD') FROM DUAL; -- 2049년 10월 11일
SELECT TO_DATE('99/10/11', 'RR/MM/DD') FROM DUAL; -- 1999년 10월 11일
SELECT TO_DATE('49/10/11', 'RR/MM/DD') FROM DUAL; -- 2049년 10월 11일




--8. 춘 기술대학교의 2000년도 이후 입학자들은 학번이 A로 시작하게 되어있다.
--2000년도 이젂 학번을 받은 학생들의 학번과 이름을 보여주는 SQL 문장을 작성하시오.
SELECT STUDENT_NAME, STUDENT_NO, ENTRANCE_DATE
FROM TB_STUDENT
WHERE ENTRANCE_DATE<'2000/01/01'
ORDER BY ENTRANCE_DATE;

--9. 학번이 A517178 인 한아름 학생의 학점 총 평점을 구하는 SQL 문을 작성하시오. 
--단, 이때 출력 화면의 헤더는 "평점" 이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 한 자리까지맊 표시핚다.

SELECT STUDENT_NAME AS"학생 이름", ROUND(AVG(POINT),1) AS"평점"
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
GROUP BY STUDENT_NAME;
--10. 학과별 학생수를 구하여 "학과번호", "학생수(명)" 의 형태로 헤더를 맊들어 결과값이 출력되도록 하시오.
SELECT DEPARTMENT_NO AS"학과번호", CAPACITY AS "학생수(명)"
FROM TB_DEPARTMENT;


--11. 지도 교수를 배정받지 못한 학생의 수는 몇 명 정도 되는 알아내는 SQL 문을 작성하시오.

SELECT COUNT(NVL(COACH_PROFESSOR_NO,1)) AS"지도교수 없는 학생"
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

--12. 학번이 A112113인 김고운 학생의 년도 별 평점을 구하는 SQL 문을 작성하시오.
--단, 이때 출력 화면의 헤더는 "년도", "년도 별 평점" 이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 핚 자리까지맊 표시한다.
SELECT TO_DATE('20'||TERM_NO,'YYYYMMDD') AS"년도", POINT AS "년도 별 평점"
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
WHERE STUDENT_NO = 'A112113';



--13. 학과 별 휴학생 수를 파악하고자 핚다. 학과 번호와 휴학생 수를 표시하는 SQL 문장을 작성하시오.
SELECT DEPARTMENT_NO, COUNT(DECODE(ABSENCE_YN,'Y',1))
FROM (  SELECT *
        FROM TB_STUDENT
        WHERE ABSENCE_YN IN('Y','N'))
        JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO ASC;




--14. 춘 대학교에 다니는 동명이인(同名異人) 학생들의 이름을 찾고자 핚다. 어떤 SQL 문장을 사용하면 가능하겠는가?
SELECT A.STUDENT_NAME AS "동일이름" , COUNT(A.STUDENT_NAME) AS "동명인 수"
FROM TB_STUDENT A, TB_STUDENT B
WHERE A.STUDENT_NAME = B.STUDENT_NAME
AND A.STUDENT_NO != B.STUDENT_NO
GROUP BY A.STUDENT_NAME
ORDER BY A.STUDENT_NAME ASC;
--15. 학번이 A112113 인 김고운 학생의 년도, 학기 별 평점과 년도 별 누적 평점 , 총 평점을 구하는 SQL 문을 작성하시오.
--(단, 평점은 소수점 1자리까지맊 반올림하여 표시한다.)


SELECT SUBSTR(TERM_NO,1,4) AS "년도", SUBSTR(TERM_NO,5,2)   , POINT 
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO) 
WHERE STUDENT_NO = 'A112113';


--1. 학생이름과 주소지를 표시하시오. 단, 출력 헤더는 "학생 이름", "주소지"로 하고, 정렬은 이름으로 오름차순 표시하도록 핚다.
SELECT STUDENT_NAME"학생이름", STUDENT_ADDRESS"주소지"
FROM TB_STUDENT
ORDER BY STUDENT_NAME ASC;


--2. 휴학중인 학생들의 이름과 주민번호를 나이가 적은 순서로 화면에 출력하시오.

SELECT STUDENT_NAME, STUDENT_NO, STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY STUDENT_SSN DESC;


--3. 주소지가 강원도나 경기도인 학생들 중 1900년대 학번을 가진 학생들의 이름과 학번, 주소를 이름의 오름차순으로 화면에 출력하시오. 
--단, 출력헤더에는 "학생이름","학번", "거주지 주소" 가 출력되도록 핚다. 
 SELECT STUDENT_NAME AS " 학생이름 ", STUDENT_NO " 학번 ",STUDENT_ADDRESS AS " 거주지 주소 ", ENTRANCE_DATE
 FROM TB_STUDENT
 WHERE SUBSTR(STUDENT_ADDRESS,1,3) IN ('강원도','경기도')
 AND TO_NUMBER(TO_CHAR(ENTRANCE_DATE,'YYYY'))<2000;
 


--4. 현재 법학과 교수 중 가장 나이가 맋은 사람부터 이름을 확인핛 수 있는 SQL 문장을 작성하시오. (법학과의 '학과코드'는 학과 테이블(TB_DEPARTMENT)을 조회해서 찾아 내도록 하자)

SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_DEPARTMENT
JOIN TB_PROFESSOR USING(DEPARTMENT_NO)
ORDER BY PROFESSOR_SSN ASC;



--5. 2004년2학기에 'C3118100' 과목을 수강한 학생들의 학점을 조회하려고 핚다. 학점이 높은 학생부터 표시하고, 학점이 같으면 학번이 낮은 학생부터 표시하는 구문을 작성해보시오.

SELECT STUDENT_NAME, POINT
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
WHERE TERM_NO = '200402'
AND CLASS_NO ='C3118100'
ORDER BY POINT DESC, STUDENT_NO;


--6. 학생 번호, 학생 이름, 학과 이름을 학생 이름으로 오름차순 정렬하여 출력하는 SQL 문을 작성하시오.


SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
ORDER BY STUDENT_NAME ASC;


--7. 춘 기술대학교의 과목 이름과 과목의 학과 이름을 출력하는 SQL 문장을 작성하시오.


SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO);



--8. 과목별 교수 이름을 찾으려고 핚다. 과목 이름과 교수 이름을 출력하는 SQL 문을 작성하시오.


SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS
JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
JOIN TB_PROFESSOR USING(PROFESSOR_NO);




--9. 8번의 결과 중 ‘인문사회’ 계열에 속핚 과목의 교수 이름을 찾으려고 핚다. 이에 해당하는 과목 이름과 교수 이름을 출력하는 SQL 문을 작성하시오.SELECT * FROM TB_CLASS;
SELECT PROFESSOR_NAME, DEPARTMENT_NAME
FROM TB_PROFESSOR
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE CATEGORY ='인문사회';



--10. ‘음악학과’ 학생들의 평점을 구하려고 핚다.
--음악학과 학생들의 "학번", "학생 이름", "젂체 평점"을 출력하는 SQL 문장을 작성하시오.
--(단, 평점은 소수점 1자리까지맊 반올림하여 표시핚다.)

SELECT STUDENT_NO AS "학번", STUDENT_NAME AS "학생이름" ,  ROUND(AVG(POINT),1) AS "전체 평점"
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME='음악학과'
GROUP BY STUDENT_NO, STUDENT_NAME;

--11. 학번이 A313047인 학생이 학교에 나오고 있지 않다. 지도 교수에게 내용을 전달하기 위한 학과 이름, 학생 이름과 지도 교수 이름이 필요하다.
--이때 사용한 SQL 문을 작성하시오. 단, 출력헤더는 ?학과이름?, ?학생이름?, ?지도교수이름?으로 출력되도록 한다.
SELECT DEPARTMENT_NAME AS "학과 이름", STUDENT_NAME AS "학생이름", PROFESSOR_NAME AS "지도 교슈", COACH_PROFESSOR_NO
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
JOIN TB_PROFESSOR ON(COACH_PROFESSOR_NO = PROFESSOR_NO)
WHERE COACH_PROFESSOR_NO = 'P034' AND STUDENT_NO='A313047';

--12. 2007년도에 '인간관계록' 과목을 수강한 학생을 찾아 학생이름과 수강학기를 표시하는 SQL
--문장을 작성하시오.
SELECT * 
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
WHERE CLASS_NO = 'C2604100'
AND SUBSTR(TERM_NO,1,4)=2007;
--13. 예체능 계열 과목 중 과목 담당교수를 한 명도 배정받지 못한 과목을 찾아
--그 과목 이름과 학과 이름을 출력하는 SQL 문장을 작성하시오.
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
LEFT JOIN TB_CLASS_PROFESSOR USING(CLASS_NO) 
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NO IN ('056','057','058','059','060','061','062','063')
AND PROFESSOR_NO IS NULL
ORDER BY DEPARTMENT_NAME ASC;



--14. 춘 기술대학교 서반아어학과 학생들의 지도교수를 게시하고자 한다. 학생이름과 지도교수 이름을 찾고 
--만일 지도 교수가 없는 학생일 경우 "지도교수 미지정?으로 표시하도록 하는 SQL 문을 작성하시오.
--단, 출력헤더는 ?학생이름?, ?지도교수?로 표시하며 고학번 학생이 먼저 표시되도록 한다.

SELECT STUDENT_NAME AS "학생 이름", NVL(COACH_PROFESSOR_NO,'지도교수 미지정') AS "지도교수 넘버", ENTRANCE_DATE
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '서반아어학과'
ORDER BY ENTRANCE_DATE ASC;



--15. 휴학생이 아닌 학생 중 평점이 4.0 이상인 학생을 찾아 그 학생의 학번, 이름, 학과 이름, 평점을 출력하는 SQL 문을 작성하시오.
SELECT STUDENT_NAME, AVG(POINT)
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
HAVING AVG(POINT) >4.0
GROUP BY STUDENT_NAME;





--16. 환경조경학과 전공과목들의 과목 별 평점을 파악할 수 있는 SQL 문을 작성하시오.
SELECT CLASS_NO,CLASS_NAME, AVG(POINT)
FROM TB_CLASS
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
JOIN TB_GRADE USING(CLASS_NO)
WHERE DEPARTMENT_NAME = '환경조경학과'
GROUP BY CLASS_NO,CLASS_NAME;

--17. 춘 기술대학교에 다니고 있는 최경희 학생과 같은 과 학생들의 이름과 주소를 출력하는 SQL 문을 작성하시오.
SELECT STUDENT_NAME AS " 학생 이름" , STUDENT_ADDRESS AS " 주소 지"
FROM TB_STUDENT
WHERE DEPARTMENT_NO = (
                    SELECT DEPARTMENT_NO
                    FROM TB_STUDENT
                    WHERE STUDENT_NAME = '최경희'
                    );



--18. 국어국문학과에서 총 평점이 가장 높은 학생의 이름과 학번을 표시하는 SQL문을 작성하시오.
SELECT * 
FROM (
    SELECT STUDENT_NAME AS "학생 이름", STUDENT_NO AS "학생번호", ROUND(AVG(POINT),2)
    FROM TB_STUDENT
    JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
    JOIN TB_GRADE USING(STUDENT_NO)
    WHERE DEPARTMENT_NAME='국어국문학과'
    GROUP BY STUDENT_NAME, STUDENT_NO
    ORDER BY AVG(POINT)DESC
    )
    WHERE ROWNUM = 1; 




--19. 춘 기술대학교의 "환경조경학과"가 속한 같은 계열 학과들의 학과 별 전공과목 평점을 파악하기 위한 적절핚 SQL 문을 찾아내시오.
--단, 출력헤더는 "계열 학과명", "전공평점"으로 표시되도록 하고, 평점은 소수점 한 자리까지만 반올림하여 표시되도록 핚다.
SELECT DEPARTMENT_NAME AS "계열 학과명", ROUND(AVG(POINT),1) AS "전공평점"
FROM TB_DEPARTMENT
JOIN TB_CLASS USING(DEPARTMENT_NO)
JOIN TB_GRADE USING(CLASS_NO)
WHERE CATEGORY = '자연과학'
GROUP BY DEPARTMENT_NAME
ORDER BY DEPARTMENT_NAME;
--1. 계열 정보를 저장핛 카테고리 테이블을 맊들려고 핚다. 다음과 같은 테이블을 작성하시오.
CREATE TABLE TB_CATEGORY(
    NAME VARCHAR2(10),
    USE_YN CHAR(1) DEFAULT 'Y'
    );
--2. 과목 구분을 저장할 테이블을 만들려고 핚다. 다음과 같은 테이블을 작성하시오.
CREATE TABLE TB_CLASS_TYPE(
NO VARCHAR2(5) PRIMARY KEY,
NAME VARCHAR(10)
);
--3. TB_CATAGORY 테이블의 NAME 컬럼에 PRIMARY KEY를 생성하시오. (KEY 이름을 생성하지 않아도 무방함.
--만일 KEY 이를 지정하고자 핚다면 이름은 본인이 알아서 적당한 이름을 사용핚다.)
DROP TABLE TB_CATEGORY;
CREATE TABLE TB_CATEGORY(
    NAME VARCHAR2(10) PRIMARY KEY,
    USE_YN CHAR(1) DEFAULT 'Y'
    );
SELECT * FROM TB_CATEGORY;

--4. TB_CLASS_TYPE 테이블의 NAME 컬럼에 NULL 값이 들어가지 않도록 속성을 변경하시오
DROP TABLE TB_CLASS_TYPE;
CREATE TABLE TB_CLASS_TYPE(
NO VARCHAR2(5) PRIMARY KEY,
NAME VARCHAR(10) NOT NULL
);
--5. 두 테이블에서 컬럼 명이 NO인 것은 기존 타입을 유지하면서 크기는 10 으로,
--컬럼명이 NAME 인 것은 마찬가지로 기존 타입을 유지하면서 크기 20 으로 변경하시오.

ALTER TABLE TB_CLASS_TYPE MODIFY NO VARCHAR2(10);
ALTER TABLE TB_CLASS_TYPE MODIFY NAME VARCHAR2(20);
ALTER TABLE TB_CATEGORY MODIFY NAME VARCHAR2(20);

--6. 두 테이블의 NO 컬럼과 NAME 컬럼의 이름을
--각 각 TB_ 를 제외한 테이블 이름이 앞에 붙은 형태로 변경한다.
--(ex. CATEGORY_NAME)

--7. TB_CATAGORY 테이블과 TB_CLASS_TYPE 테이블의 PRIMARY KEY 이름을 다음과 같이 변경하시오.
--Primary Key의 이름은 PK_ + 컬럼이름으로 지정하시오. (ex. PK_CATEGORY_NAME )



--8. 다음과 같은INSERT 문을 수행핚다.
INSERT INTO TB_CATEGORY VALUES ('공학','Y');
INSERT INTO TB_CATEGORY VALUES ('자연과학','Y');
INSERT INTO TB_CATEGORY VALUES ('의학','Y');
INSERT INTO TB_CATEGORY VALUES ('예체능','Y');
INSERT INTO TB_CATEGORY VALUES ('인문사회','Y');
COMMIT;

--9.TB_DEPARTMENT의 CATEGORY 컬럼이 TB_CATEGORY 테이블의 CATEGORY_NAME 컬럼을 부모 값으로
--참조하도록 FOREIGN KEY를 지정하시오.
--이 때 KEY 이름은 FK_테이블이름_컬럼이름으로 지정핚다.
--(ex. FK_DEPARTMENT_CATEGORY )
ALTER TABLE TB_DEPARTMENT ADD FOREIGN KEY(CATEGORY) REFERENCES TB_CATEGORY;


--10. 춘 기술대학교 학생들의 정보만이 포함되어 있는 학생일반정보 VIEW를 맊들고자 핚다. 아래 내용을 참고하여 적젃핚 SQL 문을 작성하시오.
--11. 춘 기술대학교는 1년에 두 번씩 학과별로 학생과 지도교수가 지도 면담을 진행핚다.
--이를 위해 사용핛 학생이름, 학과이름, 담당교수이름 으로 구성되어 있는 VIEW 를 맊드시오.
--이때 지도 교수가 없는 학생이 있을 수 있음을 고려하시오
--(단, 이 VIEW 는 단순 SELECT 맊을 핛 경우 학과별로 정렬되어 화면에 보여지게 맊드시오.)
--12. 모든 학과의 학과별 학생 수를 확인핛 수 있도록 적젃핚 VIEW 를 작성해 보자.
--13. 위에서 생성핚 학생일반정보 View를 통해서 학번이 A213046인 학생의 이름을 본인 이름으로 변경하는 SQL 문을 작성하시오.
--14. 13번에서와 같이 VIEW를 통해서 데이터가 변경될 수 있는 상황을 막으려면 VIEW를 어떻게 생성해야 하는지 작성하시오.

--15. 춘 기술대학교는 매년 수강신청 기갂맊 되면 특정 인기 과목들에 수강 신청이 몰려 문제가 되고 있다.
--2005~2009년을 기준으로 수강인원이 가장 많았던 3 과목을 찾는 구문을 작성해보시오.

SELECT  E.*
FROM (
       SELECT CL.CLASS_NO, CL.CLASS_NAME, COUNT(*)
       FROM TB_CLASS CL
        JOIN TB_GRADE GR ON(CL.CLASS_NO = GR.CLASS_NO)
       WHERE SUBSTR(TERM_NO,1,4) IN (2007,2008,2009)
       GROUP BY CL.CLASS_NO,CL.CLASS_NAME
       ORDER BY COUNT(*) DESC
       ) E
       WHERE ROWNUM <=3;
       
       
        

        
        
        
        

--1. 과목유형 테이블(TB_CLASS_TYPE)에 아래와 같은 데이터를 입력하시오.
INSERT INTO TB_CLASS_TYPE(NO,NAME) VALUES(01,'전공필수');
INSERT INTO TB_CLASS_TYPE(NO,NAME) VALUES(02,'전공선택');
INSERT INTO TB_CLASS_TYPE(NO,NAME) VALUES(03,'교양필수');
INSERT INTO TB_CLASS_TYPE(NO,NAME) VALUES(04,'교양선택');
INSERT INTO TB_CLASS_TYPE(NO,NAME) VALUES(05,'논문지도');
--2. 춘 기술대학교 학생들의 정보가 포함되어 있는 학생일반정보 테이블을 만들고자 한다.
--아래 내용을 참고하여 적절한 SQL 문을 작성하시오. (서브쿼리를 이용하시오)

CREATE TABLE TB_GENERAL_STUDENT ( 
        STUDENT_NO VARCHAR2(10),
        STUDENT_NAME VARCHAR2(40),
        STUDENT_ADDRESS VARCHAR(200)
        );
SELECT * FROM TB_GENERAL_STUDENT;

INSERT INTO TB_GENERAL_STUDENT(STUDENT_NO,STUDENT_NAME,STUDENT_ADDRESS)
(SELECT STUDENT_NO,STUDENT_NAME, STUDENT_ADDRESS
 FROM TB_STUDENT   );

--3. 국어국문학과 학생들의 정보맊이 포함되어 있는 학과정보 테이블을 맊들고자 핚다.
--아래 내용을 참고하여 적젃핚 SQL 문을 작성하시오. (힌트 : 방법은 다양함, 소신껏 작성하시오)
CREATE TABLE TB_STUDENT_KOR(
    STUDENT_NO VARCHAR2(10) ,
    STUDENT_NAME VARCHAR2(20),
    BIRTH_DAY VARCHAR(20),
    PROFESSOR_NAME VARCHAR2(10)
    );
    DROP TABLE TB_STUDENT_KOR;
    SELECT * FROM TB_STUDENT_KOR;
    
    INSERT INTO
    TB_STUDENT_KOR( STUDENT_NO, STUDENT_NAME, BIRTH_DAY, PROFESSOR_NAME)
    (SELECT
            STUDENT_NO
            , STUDENT_NAME
            , TO_CHAR(TO_DATE(SUBSTR(STUDENT_SSN,1,6),'RRMMDD'), 'YYYY')
            , PROFESSOR_NAME
            FROM TB_STUDENT S
            LEFT JOIN TB_PROFESSOR P ON (S.COACH_PROFESSOR_NO = P.PROFESSOR_NO)
            JOIN TB_DEPARTMENT D ON (S.DEPARTMENT_NO = D.DEPARTMENT_NO)
            WHERE D.DEPARTMENT_NAME = '국어국문학과'
            );



--4. 현 학과들의 정원을 10% 증가시키게 되었다. 이에 사용핛 SQL 문을 작성하시오.
--(단, 반올림을 사용하여 소수점 자릿수는 생기지 않도록 핚다)


--5. 학번 A413042인 박건우 학생의 주소가 "서울시 종로구 숭인동 181-21 "로 변경되었다고 핚다.
--주소지를 정정하기 위해 사용핛 SQL 문을 작성하시오.


--6. 주민등록번호 보호법에 따라 학생정보 테이블에서 주민번호 뒷자리를 저장하지 않기로 결정하였다.
--이 내용을 반영핛 적젃핚 SQL 문장을 작성하시오.
--(예. 830530-2124663 ==> 830530 )



--7. 의학과 김명훈 학생은 2005년 1학기에 자신이 수강핚 '피부생리학' 점수가
--잘못되었다는 것을 발견하고는 정정을 요청하였다.
--담당 교수의 확인 받은 결과 해당 과목의 학점을 3.5로 변경키로 결정되었다.
--적젃핚 SQL 문을 작성하시오.




--8. 성적 테이블(TB_GRADE) 에서 휴학생들의 성적항목을 제거하시오.





















