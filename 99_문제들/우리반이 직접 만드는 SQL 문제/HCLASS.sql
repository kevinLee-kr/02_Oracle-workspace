COMMENT ON COLUMN TBL_BUY.BUY_IDX IS '구매 넘버';
COMMENT ON COLUMN TBL_BUY.CUSTOMID IS '구매자 아이디';
COMMENT ON COLUMN TBL_BUY.PCODE IS '물건 코드';
COMMENT ON COLUMN TBL_BUY.QUANTITY IS '물건 수량';
COMMENT ON COLUMN TBL_BUY.BUY_DATE IS '구매 일자';

COMMENT ON COLUMN TBL_CUSTOM.CUSTOM_ID IS '고객 아이디';
COMMENT ON COLUMN TBL_CUSTOM.NAME IS '고객 이름';
COMMENT ON COLUMN TBL_CUSTOM.EMAIL IS '고객 이메일';
COMMENT ON COLUMN TBL_CUSTOM.AGE IS '고객 나이';
COMMENT ON COLUMN TBL_CUSTOM.REG_DATE IS '고객 가입일자';

COMMENT ON COLUMN TBL_PRODUCT.PCODE IS '물건 코드';
COMMENT ON COLUMN TBL_PRODUCT.CATEGORY IS '물건 카테고리';
COMMENT ON COLUMN TBL_PRODUCT.PNAME IS '물건 정보';
COMMENT ON COLUMN TBL_PRODUCT.PRICE IS '가격';
------------------------------------------------------------------
/* A조  */
--A-1. 'mina012' 가 구매한 상품 금액 합계(이광원)

	  
SELECT sum(PRICE * QUANTITY)||'원' AS "상품 금액 합계"
FROM TBL_BUY
JOIN TBL_PRODUCT USING(PCODE)
WHERE CUSTOMID = 'mina012';
/*
CJBAB12G 5 14500
APLE5KG 2 66000
JINRMN5 2 6350
-----------------
            217,200원
*/


--A-2. 이름에 '길동'이 들어가는 회원 구매한 상품 구매현황 (권태윤)
-- 데이터 추가 후 실행하세요.
INSERT INTO TBL_CUSTOM 
			VALUES ('dongL','이길동','lee@daum.net',25,sysdate);
INSERT INTO TBL_BUY 
			VALUES (1008,'dongL','DOWON123A',2,sysdate);
COMMIT;
       SELECT PCODE, NAME,BUY_DATE 
       FROM TBL_CUSTOM
       JOIN TBL_BUY ON(CUSTOM_ID = CUSTOMID)
       JOIN TBL_PRODUCT USING(PCODE)
       WHERE NAME LIKE '%길동';
        
            
            
--A-3. `25살`이상 고객님들의 `구매`한 `상품명` 조회하기 (강주찬) => 테이블 3개
       
     SELECT NAME, AGE , PNAME
     FROM TBL_CUSTOM
       JOIN TBL_BUY ON(CUSTOM_ID = CUSTOMID)
       JOIN TBL_PRODUCT USING(PCODE)
    WHERE AGE>=25
    ORDER BY 1;
		

--A-4. 상품명에 '사과' 단어가 포함된 상품을 구매한 고객에 대해 상품별 구매금액의 합을 구하기.(고길현)
-- 데이터 추가 후 실행하세요.
INSERT INTO TBL_PRODUCT
			VALUES ('BUSA211','B2','부사 사과 3kg 박스',25000);
INSERT INTO TBL_BUY  
			VALUES (1009,'hongGD','BUSA211',2,TO_date('2024-01-03','yyyy-mm-dd'));

COMMIT;
SELECT PCODE "제품 코드", PNAME "제품 명", SUM(PRICE)||'원' "합계" 
FROM TBL_PRODUCT
JOIN TBL_BUY USING(PCODE)
WHERE PNAME LIKE '%사과%'
GROUP BY PCODE, PNAME;


--A-5. 총 구매합산 금액이 100000~200000 값인 고객 ID를 조회하시오.(김태완)
        SELECT CUSTOMID, SUM(QUANTITY * PRICE )
        FROM TBL_BUY
        JOIN TBL_PRODUCT USING(PCODE)
        GROUP BY CUSTOMID
        HAVING SUM(QUANTITY * PRICE ) BETWEEN 100000 AND 200000;

/*  B조 */
--B-1. 20대 나이 고객의 구매 상품 코드와 나이를 나이순으로 정렬 조회 (이대환)

    SELECT PCODE, AGE, NAME
    FROM TBL_CUSTOM
    JOIN TBL_BUY ON(CUSTOM_ID = CUSTOMID)
    WHERE AGE BETWEEN 20 AND 29;


--B-2. 나이가 가장 많은 고객이 상품을 구매한 횟수를 조회하세요.-서브쿼리 사용하기 (김승한)
SELECT *
FROM(
    SELECT NAME, AGE , COUNT(*)
    FROM TBL_CUSTOM
    JOIN TBL_BUY ON (CUSTOM_ID = CUSTOMID)
    GROUP BY NAME, AGE
    ORDER BY AGE DESC)
WHERE ROWNUM=1;
    

--B-3. 2023년 하반기 구매금액을 고객ID별로 조회하시오. 금액이 높은 순서부터 조회하세요. (노희영)
SELECT CUSTOMID , PRICE
FROM TBL_BUY
JOIN TBL_PRODUCT USING(PCODE)
WHERE TO_CHAR(BUY_DATE,'YY') = 23
AND TO_CHAR(BUY_DATE,'MM')>=6
ORDER BY PRICE DESC;


--B-4. 2024년에 구매횟수가 1회 이상인 고객id, 고객이름, 나이,이메일을 조회하세요.(이재훈)
SELECT CUSTOMID, NAME
FROM TBL_BUY
JOIN TBL_CUSTOM ON( CUSTOMID= CUSTOM_ID)
WHERE TO_CHAR(BUY_DATE,'YY')=24
GROUP BY CUSTOMID, NAME;



--B-5. 고객별-상품별 구매금액을 조회하세요. 정렬도 고객ID,상품코드 오름차순으로 정렬하세요.(이예진)
SELECT * FROM TBL_BUY;
SELECT * FROM TBL_CUSTOM;
SELECT * FROM TBL_PRODUCT;

SELECT CUSTOMID, PCODE, QUANTITY, PRICE
FROM TBL_BUY
JOIN TBL_CUSTOM ON(CUSTOMID = CUSTOM_ID)
JOIN TBL_PRODUCT USING(PCODE)
ORDER BY CUSTOMID, PCODE ASC;




/* C조 */
--C-1. 가격 1만원 이상의 상품에 대해 각각 고객들이 구매한 평균 개수를 출력하시오.상품코드 순서로 정렬 (임현범)
SELECT CUSTOMID , ROUND(AVG(QUANTITY),2) AS "AVG사용 평균개수"
                , ROUND(SUM(QUANTITY)/COUNT(QUANTITY),2)AS"나눗셈사용/평균개수"
FROM TBL_PRODUCT 
JOIN TBL_BUY USING(PCODE)
WHERE PRICE >= 10000
GROUP BY CUSTOMID;
--C-2. 진라면을 구매한 고객의 이름, 구매수량, 구매날짜를 조회하자. (출제자 : 전예진)
SELECT NAME, QUANTITY, BUY_DATE
FROM TBL_CUSTOM
JOIN TBL_BUY ON(CUSTOM_ID = CUSTOMID)
JOIN TBL_PRODUCT USING(PCODE)
WHERE PNAME LIKE '%진라면%';

--C-4. 2023년에 팔린 상품의 이름과 코드, 총 판매액 그리고 총 판매개수를 상품코드 순서로 정렬하여 조회하시오. (정제원)


SELECT PNAME, PCODE, SUM(PRICE), COUNT(PRICE)
FROM TBL_BUY 
JOIN TBL_PRODUCT USING(PCODE)
WHERE TO_CHAR(BUY_DATE,'YY')=23
GROUP BY PNAME, PCODE
ORDER BY PCODE ASC;




--C-5. 'twice'와 'hongGD'는 한집에 살고 있습니다. 이들이 구매한 상품,수량,가격을 조회하세요.
--가격이 높은순서부터 정렬 (장성우)


SELECT NAME, PNAME, QUANTITY, PRICE
FROM TBL_BUY
JOIN TBL_CUSTOM ON(CUSTOM_ID = CUSTOMID)
JOIN TBL_PRODUCT USING(PCODE)
WHERE CUSTOMID ='twice' OR CUSTOMID = 'hongGD';



/* D조 */
--D-1. 진라면을 가장 많이 구매한 회원을 구매금액이 높은 순으로 회원아이디와 총 진라면 구매금액을 보여주세요.(조하연)
-- 							ㄴ 서브쿼리 없이 조인만 사용

SELECT CUSTOMID, PRICE*QUANTITY
FROM TBL_BUY
JOIN TBL_PRODUCT USING(PCODE)
WHERE PCODE ='JINRMN5'
ORDER BY QUANTITY DESC;

 
--D-2. 판매 갯수가 가장 많은 순서로 상품 을 정렬하고 총 팔린 금액을 출력하시오.(한진만)
-- 	   판매 개수가 같으면 상품 코드 순서로 정렬합니다.			ㄴ 동등 조인으로 조회


SELECT  PNAME ,PRICE , PRICE * QUANTITY AS"총 팔린 금액"
FROM TBL_BUY
JOIN TBL_PRODUCT USING(PCODE)
ORDER BY QUANTITY DESC , PCODE ASC;
--D-3. 진라면을 구매한 고객들의 평균 나이를 제품코드(PCODE)와 함께출력해 주세요.(황병훈)
SELECT AVG(AGE), PCODE
FROM TBL_PRODUCT
JOIN TBL_BUY USING(PCODE)
JOIN TBL_CUSTOM ON(CUSTOMID = CUSTOM_ID)
WHERE PCODE = 'JINRMN5'
GROUP BY PCODE;

--D-4. 30세 미만 회원별 구매금액을 구하고 회원으로 그룹바이해서
--구매금액 합계가 큰 순으로 정렬(조지수)
-- 						ㄴ 3개의 테이블 조인
SELECT CUSTOMID, SUM(PRICE*QUANTITY)
FROM TBL_BUY
JOIN TBL_PRODUCT USING(PCODE)
JOIN TBL_CUSTOM ON(CUSTOM_ID=CUSTOMID)
WHERE AGE<30
GROUP BY CUSTOMID
ORDER BY SUM(PRICE*QUANTITY) DESC;


SELECT * FROM TBL_BUY;
SELECT * FROM TBL_CUSTOM;
SELECT * FROM TBL_PRODUCT;

--B2와 같은 카테고리로 설정되어있는 물품명을 조회하고,
--어느 고객님께 판매가 되었는지 조회하시오.
SELECT NAME, CATEGORY, PNAME
FROM TBL_PRODUCT
JOIN TBL_BUY USING(PCODE)
JOIN TBL_CUSTOM ON(CUSTOM_ID=CUSTOMID)
WHERE CATEGORY = 'B2';

--햇반 12개입와 같은 카테고리로 묶여있는 제품을 구매한 고객의 이름, 나이를 출력하시오.
SELECT NAME, AGE
FROM TBL_PRODUCT
JOIN TBL_BUY USING(PCODE)
JOIN TBL_CUSTOM ON(CUSTOM_ID = CUSTOMID)
WHERE CATEGORY = 'B1';
--이나나와 같은 날짜에 가입한 회원의 이름과 EMAIL을 조회하라. '이나나'라는 이름을 사용해서 조회하도록 하라.
SELECT NAME, EMAIL
FROM TBL_CUSTOM
WHERE REG_DATE >= (SELECT REG_DATE
                    FROM TBL_CUSTOM
                    WHERE NAME = '이나나');