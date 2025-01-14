SELECT * FROM TB_BOOK;
SELECT * FROM TB_BOOK_AUTHOR;
SELECT * FROM TB_PUBLISHER;
SELECT * FROM TB_WRITER;


--3. 도서명이 25 자 이상인 책 번호와 도 서 명 을 화면에 출력하는 SQL 문을 작성하시오
SELECT BOOK_NO, BOOK_NM
FROM TB_BOOK
WHERE LENGTH(BOOK_NM) >=25;


--4. 휴대폰 번호가 019 로 시작하는 김씨 성을 가진 작가를 이름순으로 정렬했을 때
--가장 먼저 표시되는 작가
--이름과 사무실 전화번호 , 집 전화번호 , 휴대폰 전화번호를 표시하는 SQL 구 문을 작성하시오
SELECT E.*
FROM(
SELECT  WRITER_NM, OFFICE_TELNO, HOME_TELNO, MOBILE_NO
FROM TB_WRITER
WHERE SUBSTR(MOBILE_NO,1,3) = '019'
AND SUBSTR(WRITER_NM,1,1)='김'
ORDER BY WRITER_NM ASC) E
WHERE ROWNUM<=1;




--5. 저작 형태가 옮김 에 해당하는 작가들이 총 몇 명인지 계산하는 SQL 구 문을 작성하시오 결과 헤더는
--작가 명 으로 표시되도록 할 것
--작가 이름을 중복 제거하고 세어버리자. 
SELECT COUNT(DISTINCT WRITTER_NM) AS "작가명"
FROM TB_WRITER
JOIN TB_BOOK_AUTHOR USING(WRITER_NO)
WHERE COMPOSE_TYPE = '옮김';


--6. 300 권 이상 등록된 도서의 저작 형태 및 등록된 도서 수 량을 표시하는 SQL 구 문을 작성하시오 저작
--형태가 등록되지 않은 경우는 제외할 것
SELECT COMPOSE_TYPE, COUNT(*)
FROM TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE IS NOT NULL
GROUP BY COMPOSE_TYPE
HAVING COUNT(*) > = 300;


--7. 가장 최근에 발간된 최신작 이름과 발행일자 , 출판사 이름을 표시하는 SQL 구 문을 작성하시오
SELECT ROWNUM,E.* 
FROM(
    SELECT BOOK_NO, BOOK_NM, ISSUE_DATE, PUBLISHER_NM
    FROM TB_BOOK
    ORDER BY ISSUE_DATE DESC
    )E
WHERE ROWNUM = 1;


--8. 가장 많은 책을 쓴 작가 3 명의 이름과 수 량을 표시하되 , 많이 쓴 순서대로 표시하는 SQL 구 문을 작성하시오
--단 , 동명이인 同名異人 ) 작가는 없다고 가정한다 . 결과 헤더는 작가 이름 ”, 권 수 로 표시 되도록 할 것
SELECT  ROWNUM,E.*
FROM(
    SELECT WRITER_NM, WRITER_NO, COUNT(BOOK_NO)
    FROM TB_WRITER
    JOIN TB_BOOK_AUTHOR USING(WRITER_NO)
    GROUP BY WRITER_NM, WRITER_NO
    ORDER BY COUNT(BOOK_NO) DESC) E
    WHERE ROWNUM <= 3;




--9. 작가 정보 테이블의 모든 등록일자 항목이 누락되어 있는 걸 발견하였다 . 누락된 등록일자 값을 각 작가의
--최초 출판도서의 발행일과 동일한 날짜 로 변경시키는 SQL 구 문을 작성하시오 (COMMIT 처리할 것)
UPDATE TB_WRITER A
SET A.REGIST_DATE = (
        SELECT 최초출판일
        FROM (SELECT WRITER_NO, MIN(ISSUE_DATE) AS "최초출판일"
         FROM TB_BOOK
         JOIN TB_BOOK_AUTHOR USING(BOOK_NO)
         JOIN TB_WRITER USING (WRITER_NO)
         GROUP BY WRITER_NO) B
         WHERE B.WRITER_NO = A.WRITER_NO);

SELECT WRITER_NM, REGIST_DATE 
FROM TB_WRITER
ORDER BY REGIST_DATE ASC;

ROLLBACK;



--10. 현재 도서저자 정보 테이블은 저서와 번역서를 구분 없이 관리 하고 있다 . 앞으로는 번역서는 따로 관리하려
--고 한다 . 제시된 내용에 맞게 “TB_BOOK_ TRANSLATOR” 테이블을 생성하는 SQL 구문을 작성하시오 .
--(Primary Key 제약 조건 이름은 “PK_BOOK_ 로 하고 , Reference 제약 조건 이름은
--“FK_BOOK_TRANSLATOR_01 ””, “FK_BOOK_TRANSLATOR_ 로 할 것


CREATE TABLE TB_BOOK_TRANSLATOR(
BOOK_NO VARCHAR2(10) ,
WRITER_NO VARCHAR2(10),
TRANS_LANG VARCHAR2(60),
CONSTRAINT PK_BOOK_TRANSLATOR PRIMARY KEY (BOOK_NO),
CONSTRAINT FK_BOOK_TRANSLATOR_01 FOREIGN KEY (BOOK_NO) REFERENCES TB_BOOK (BOOK_NO),
CONSTRAINT FK_BOOK_TRANSLATOR_02 FOREIGN KEY (WRITER_NO) REFERENCES TB_WRITER(WRITER_NO)
);
COMMENT ON COLUMN TB_BOOK_TRANSLATOR.BOOK_NO IS '도서번호';
COMMENT ON COLUMN TB_BOOK_TRANSLATOR.WRITER_NO IS '작가번호';
COMMENT ON COLUMN TB_BOOK_TRANSLATOR.TRANS_LANG IS '번역언어';

DROP TABLE TB_BOOK_TRANSLATOR;
SELECT * FROM TB_BOOK_TRANSLATOR;




--11. 도서 저작 형태 (compose_ 가 옮김 ', 역주 ', 편역 ', 공역 에 해당하는 데이터는
--도서 저자 정보 테이블에서 도서 역자 정보 테이블 (TB_BOOK_TRANSLATOR 로 옮기 는 SQL
--구문을 작성하시오 . 단 , “TRANS_LANG” 컬럼은 NULL 상태로 두도록 한다 . 이동된 데이터는 더
--이상 TB_BOOK_AUTHOR 테이블에 남아 있지 않도록 삭제할 것
INSERT INTO TB_BOOK_TRANSLATOR(BOOK_NO,WRITER_NO)
            (SELECT BOOK_NO, WRITER_NO
                FROM TB_BOOK_AUTHOR
                WHERE COMPOSE_TYPE IN('옮김','역주','편역','공역'));
DELETE
    FROM TB_BOOK_AUTHOR
    WHERE COMPOSE_TYPE IN('옮김','역주','편역','공역');
    
   COMMIT;
SELECT *FROM TB_BOOK_TRANSLATOR;
--12. 2007 년도에 출판된 번역서 이름 과 번역자 역자 를 표시하는 SQL 구 문을 작성하시오

SELECT BOOK_NM, WRITER_NM, ISSUE_DATE
FROM TB_BOOK_TRANSLATOR
JOIN TB_BOOK USING(BOOK_NO)
JOIN TB_WRITER USING(WRITER_NO)
WHERE SUBSTR( TO_CHAR(ISSUE_DATE,'YYYYMMDD'),1,4) = '2007';
--13. 12 번 결과를 활용하여 대상 번역서들의 출판일을 변경할 수 없도록 하는 뷰 를 생성하는 SQL
--구 문을 작성하시오 . 뷰 이름은 VW_BOOK_TRANSLATOR 로 하고 도서명 , 번 역자 , 출판일이
--표시되도록 할 것
GRANT CREATE VIEW TO WORKSHOP;

CREATE OR REPLACE VIEW VW_BOOK_TRANSLATOR
AS SELECT BOOK_NM, WRITER_NM, ISSUE_DATE
    FROM (
    SELECT BOOK_NM, WRITER_NM, ISSUE_DATE
    FROM TB_BOOK_TRANSLATOR
    JOIN TB_BOOK USING(BOOK_NO)
    JOIN TB_WRITER USING(WRITER_NO)
    WHERE SUBSTR( TO_CHAR(ISSUE_DATE,'YYYYMMDD'),1,4) = '2007')
    WITH READ ONLY;
--14. 새로운 출판사 춘 출판사 와 거래 계약을 맺게 되었다 . 제시된 다음 정보를 입력하는 SQL
--구 문을 작성하시오 ..(COMMIT 처리할 것


INSERT INTO TB_PUBLISHER VALUES('춘 출판사','02-6710-3737-',DEFAULT);
SELECT * FROM TB_PUBLISHER;


--15. 동명이인 同名異人 ) 작가의 이름을 찾으려고 한다 . 이름과 동명이인 숫자를 표시하는 SQL 구 문을
--작성하시오

SELECT WRITER_NM, COUNT(*)
FROM TB_WRITER
GROUP BY WRITER_NM
HAVING COUNT(*) >1;


--16. 도서의 저자 정보 중 저작 형태 (compose_ 가 누락된 데이터들이 적지 않게 존재한다 . 해당 컬럼이
--NULL 인 경우 지음 으로 변경하는 SQL 구 문을 작성하시오 ..(COMMIT 처리할 것)
SELECT * FROM TB_BOOK_AUTHOR;

UPDATE TB_BOOK_AUTHOR
SET COMPOSE_TYPE = '지음'
WHERE COMPOSE_TYPE IS NULL;

SELECT COMPOSE_TYPE
FROM TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE IS NULL;

COMMIT;

--17. 서울지역 작가 모임을 개최하려고 한다 . 사무실이 서울이고 , 사무실 전화 번호 국번이 3 자리인 작가의
--이름과 사무실 전화 번호를 표시하는 SQL 구 문을 작성하시오
SELECT * 
FROM TB_WRITER
WHERE OFFICE_TELNO LIKE '02_________';

--18. 2006 년 1 월 기준으로 등록된 지 31 년 이상 된 작가 이름을 이름순으로 표시하는 SQL 구 문을 작성하시오
SELECT WRITER_NM, WRITER_NO
FROM TB_WRITER
JOIN TB_BOOK_AUTHOR USING(WRITER_NO)
JOIN TB_BOOK USING(BOOK_NO)
WHERE SUBSTR(TO_CHAR(ISSUE_DATE,'YYYYMMDD'),1,4)<=1975
GROUP BY WRITER_NM, WRITER_NO
ORDER BY WRITER_NM ASC;






--19. 요즘 들어 다시금 인기를 얻고 있는 황금가지 ' 출판사를 위한 기획전을 열려고 한다 . 황금가지 '
--출판사에서 발행한 도서 중 재고 수 량이 10 권 미만인 도서명과 가격 , 재고상태를 표시하는 SQL 구 문을
--작성하시오 . 
--재고 수 량이 5 권 미만인 도서는 추가주문필요 로 , 나머지는 소량보유 로 표시 하고 ,
--재고수량 이 많은 순 , 도서명 순으로 표시 되 도록 한다 .
SELECT E.BOOK_NM, E.PRICE,
DECODE(E.STOCK_QTY,0,'추가주문필요',
                    1,'추가주문필요',
                    2,'추가주문필요',
                    3,'추가주문필요',
                    4,'추가주문필요',
                    5,'소량보유',
                    6,'소량보유',
                    7,'소량보유',
                    8,'소량보유',
                    9,'소량보유')
FROM(   SELECT BOOK_NM, PRICE, STOCK_QTY
        FROM TB_BOOK
        WHERE PUBLISHER_NM = '황금가지'
AND STOCK_QTY<10)E;
--20. 아타트롤 도서 작가와 역자를 표시하는 SQL 구 문을 작성하시오 결과 헤더는
--도서명 저자 역자 로 표시할 것








--고트홀트 에프라임 레씽(GOTTHOLD EPHRAIM LESSING)
   
SELECT B.BOOK_NM, W.WRITER_NM, 
FROM TB_BOOK B
JOIN TB_BOOK_AUTHOR A ON (A.BOOK_NO = B.BOOK_NO)
JOIN TB_WRITER W USING (WRITER_NO)
WHERE BOOK_NM = '아타트롤'
AND TB_BOOK_AUTHOR = (SELECT * 
                        FROM  TB_BOOK_TRANSLATOR
                        WHERE WRITER_NO = 647);


--
--21.현재 기준으로 최초 발행일로부터 만 30년이 경과되었고, 
--재고 수량이 90권 이상인 도서에 대해 도서명, 재고수량, 원래가격, 
--20% 인하 가격을 표기하는 SQL 구문을 작성하여라. 
--(결과 헤더는 "도서명","재고수량","가격(Org)","가격(New)"로 표시할 것.
--재고 수량이 많은 순, 할인 가격이 높은순, 도서명 순
--으로 표시할 것. 
SELECT BOOK_NO, BOOK_NM AS "도서명", STOCK_QTY AS "재고수량", PRICE AS "가격(Org)", PRICE*0.8 AS"인하가격", ISSUE_DATE
FROM TB_BOOK
WHERE STOCK_QTY>=90
AND SYSDATE >= ADD_MONTHS(ISSUE_DATE, 360) -- BETWEEN(ISSUE_DATE ,SYSDATE) >= 360
ORDER BY STOCK_QTY DESC, 인하가격 DESC, BOOK_NM ASC;



--ㅡMONTH BETWEEN(DA1, ED2) : 두 날짜 사이의 개월 수 => 내부적으로 DATE1 -(빼기) DATE2 후 나누기 30,31이 진행 될 것이다. 
--결과값은 NUMBER 타입
-- EMPLOYEE, 에서 사원명, 입사일, 근무 개원수







