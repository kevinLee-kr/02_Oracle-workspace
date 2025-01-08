COMMENT ON COLUMN TBL_BUY.BUY_IDX IS '���� �ѹ�';
COMMENT ON COLUMN TBL_BUY.CUSTOMID IS '������ ���̵�';
COMMENT ON COLUMN TBL_BUY.PCODE IS '���� �ڵ�';
COMMENT ON COLUMN TBL_BUY.QUANTITY IS '���� ����';
COMMENT ON COLUMN TBL_BUY.BUY_DATE IS '���� ����';

COMMENT ON COLUMN TBL_CUSTOM.CUSTOM_ID IS '�� ���̵�';
COMMENT ON COLUMN TBL_CUSTOM.NAME IS '�� �̸�';
COMMENT ON COLUMN TBL_CUSTOM.EMAIL IS '�� �̸���';
COMMENT ON COLUMN TBL_CUSTOM.AGE IS '�� ����';
COMMENT ON COLUMN TBL_CUSTOM.REG_DATE IS '�� ��������';

COMMENT ON COLUMN TBL_PRODUCT.PCODE IS '���� �ڵ�';
COMMENT ON COLUMN TBL_PRODUCT.CATEGORY IS '���� ī�װ�';
COMMENT ON COLUMN TBL_PRODUCT.PNAME IS '���� ����';
COMMENT ON COLUMN TBL_PRODUCT.PRICE IS '����';
------------------------------------------------------------------
/* A��  */
--A-1. 'mina012' �� ������ ��ǰ �ݾ� �հ�(�̱���)

	  
SELECT sum(PRICE * QUANTITY)||'��' AS "��ǰ �ݾ� �հ�"
FROM TBL_BUY
JOIN TBL_PRODUCT USING(PCODE)
WHERE CUSTOMID = 'mina012';
/*
CJBAB12G 5 14500
APLE5KG 2 66000
JINRMN5 2 6350
-----------------
            217,200��
*/


--A-2. �̸��� '�浿'�� ���� ȸ�� ������ ��ǰ ������Ȳ (������)
-- ������ �߰� �� �����ϼ���.
INSERT INTO TBL_CUSTOM 
			VALUES ('dongL','�̱浿','lee@daum.net',25,sysdate);
INSERT INTO TBL_BUY 
			VALUES (1008,'dongL','DOWON123A',2,sysdate);
COMMIT;
       SELECT PCODE, NAME,BUY_DATE 
       FROM TBL_CUSTOM
       JOIN TBL_BUY ON(CUSTOM_ID = CUSTOMID)
       JOIN TBL_PRODUCT USING(PCODE)
       WHERE NAME LIKE '%�浿';
        
            
            
--A-3. `25��`�̻� ���Ե��� `����`�� `��ǰ��` ��ȸ�ϱ� (������) => ���̺� 3��
       
     SELECT NAME, AGE , PNAME
     FROM TBL_CUSTOM
       JOIN TBL_BUY ON(CUSTOM_ID = CUSTOMID)
       JOIN TBL_PRODUCT USING(PCODE)
    WHERE AGE>=25
    ORDER BY 1;
		

--A-4. ��ǰ�� '���' �ܾ ���Ե� ��ǰ�� ������ ���� ���� ��ǰ�� ���űݾ��� ���� ���ϱ�.(�����)
-- ������ �߰� �� �����ϼ���.
INSERT INTO TBL_PRODUCT
			VALUES ('BUSA211','B2','�λ� ��� 3kg �ڽ�',25000);
INSERT INTO TBL_BUY  
			VALUES (1009,'hongGD','BUSA211',2,TO_date('2024-01-03','yyyy-mm-dd'));

COMMIT;
SELECT PCODE "��ǰ �ڵ�", PNAME "��ǰ ��", SUM(PRICE)||'��' "�հ�" 
FROM TBL_PRODUCT
JOIN TBL_BUY USING(PCODE)
WHERE PNAME LIKE '%���%'
GROUP BY PCODE, PNAME;


--A-5. �� �����ջ� �ݾ��� 100000~200000 ���� �� ID�� ��ȸ�Ͻÿ�.(���¿�)
        SELECT CUSTOMID, SUM(QUANTITY * PRICE )
        FROM TBL_BUY
        JOIN TBL_PRODUCT USING(PCODE)
        GROUP BY CUSTOMID
        HAVING SUM(QUANTITY * PRICE ) BETWEEN 100000 AND 200000;

/*  B�� */
--B-1. 20�� ���� ���� ���� ��ǰ �ڵ�� ���̸� ���̼����� ���� ��ȸ (�̴�ȯ)

    SELECT PCODE, AGE, NAME
    FROM TBL_CUSTOM
    JOIN TBL_BUY ON(CUSTOM_ID = CUSTOMID)
    WHERE AGE BETWEEN 20 AND 29;


--B-2. ���̰� ���� ���� ���� ��ǰ�� ������ Ƚ���� ��ȸ�ϼ���.-�������� ����ϱ� (�����)
SELECT *
FROM(
    SELECT NAME, AGE , COUNT(*)
    FROM TBL_CUSTOM
    JOIN TBL_BUY ON (CUSTOM_ID = CUSTOMID)
    GROUP BY NAME, AGE
    ORDER BY AGE DESC)
WHERE ROWNUM=1;
    

--B-3. 2023�� �Ϲݱ� ���űݾ��� ��ID���� ��ȸ�Ͻÿ�. �ݾ��� ���� �������� ��ȸ�ϼ���. (����)
SELECT CUSTOMID , PRICE
FROM TBL_BUY
JOIN TBL_PRODUCT USING(PCODE)
WHERE TO_CHAR(BUY_DATE,'YY') = 23
AND TO_CHAR(BUY_DATE,'MM')>=6
ORDER BY PRICE DESC;


--B-4. 2024�⿡ ����Ƚ���� 1ȸ �̻��� ��id, ���̸�, ����,�̸����� ��ȸ�ϼ���.(������)
SELECT CUSTOMID, NAME
FROM TBL_BUY
JOIN TBL_CUSTOM ON( CUSTOMID= CUSTOM_ID)
WHERE TO_CHAR(BUY_DATE,'YY')=24
GROUP BY CUSTOMID, NAME;



--B-5. ����-��ǰ�� ���űݾ��� ��ȸ�ϼ���. ���ĵ� ��ID,��ǰ�ڵ� ������������ �����ϼ���.(�̿���)
SELECT * FROM TBL_BUY;
SELECT * FROM TBL_CUSTOM;
SELECT * FROM TBL_PRODUCT;

SELECT CUSTOMID, PCODE, QUANTITY, PRICE
FROM TBL_BUY
JOIN TBL_CUSTOM ON(CUSTOMID = CUSTOM_ID)
JOIN TBL_PRODUCT USING(PCODE)
ORDER BY CUSTOMID, PCODE ASC;




/* C�� */
--C-1. ���� 1���� �̻��� ��ǰ�� ���� ���� ������ ������ ��� ������ ����Ͻÿ�.��ǰ�ڵ� ������ ���� (������)
SELECT CUSTOMID , ROUND(AVG(QUANTITY),2) AS "AVG��� ��հ���"
                , ROUND(SUM(QUANTITY)/COUNT(QUANTITY),2)AS"���������/��հ���"
FROM TBL_PRODUCT 
JOIN TBL_BUY USING(PCODE)
WHERE PRICE >= 10000
GROUP BY CUSTOMID;
--C-2. ������� ������ ���� �̸�, ���ż���, ���ų�¥�� ��ȸ����. (������ : ������)
SELECT NAME, QUANTITY, BUY_DATE
FROM TBL_CUSTOM
JOIN TBL_BUY ON(CUSTOM_ID = CUSTOMID)
JOIN TBL_PRODUCT USING(PCODE)
WHERE PNAME LIKE '%�����%';

--C-4. 2023�⿡ �ȸ� ��ǰ�� �̸��� �ڵ�, �� �Ǹž� �׸��� �� �ǸŰ����� ��ǰ�ڵ� ������ �����Ͽ� ��ȸ�Ͻÿ�. (������)


SELECT PNAME, PCODE, SUM(PRICE), COUNT(PRICE)
FROM TBL_BUY 
JOIN TBL_PRODUCT USING(PCODE)
WHERE TO_CHAR(BUY_DATE,'YY')=23
GROUP BY PNAME, PCODE
ORDER BY PCODE ASC;




--C-5. 'twice'�� 'hongGD'�� ������ ��� �ֽ��ϴ�. �̵��� ������ ��ǰ,����,������ ��ȸ�ϼ���.
--������ ������������ ���� (�强��)


SELECT NAME, PNAME, QUANTITY, PRICE
FROM TBL_BUY
JOIN TBL_CUSTOM ON(CUSTOM_ID = CUSTOMID)
JOIN TBL_PRODUCT USING(PCODE)
WHERE CUSTOMID ='twice' OR CUSTOMID = 'hongGD';



/* D�� */
--D-1. ������� ���� ���� ������ ȸ���� ���űݾ��� ���� ������ ȸ�����̵�� �� ����� ���űݾ��� �����ּ���.(���Ͽ�)
-- 							�� �������� ���� ���θ� ���

SELECT CUSTOMID, PRICE*QUANTITY
FROM TBL_BUY
JOIN TBL_PRODUCT USING(PCODE)
WHERE PCODE ='JINRMN5'
ORDER BY QUANTITY DESC;

 
--D-2. �Ǹ� ������ ���� ���� ������ ��ǰ �� �����ϰ� �� �ȸ� �ݾ��� ����Ͻÿ�.(������)
-- 	   �Ǹ� ������ ������ ��ǰ �ڵ� ������ �����մϴ�.			�� ���� �������� ��ȸ


SELECT  PNAME ,PRICE , PRICE * QUANTITY AS"�� �ȸ� �ݾ�"
FROM TBL_BUY
JOIN TBL_PRODUCT USING(PCODE)
ORDER BY QUANTITY DESC , PCODE ASC;
--D-3. ������� ������ ������ ��� ���̸� ��ǰ�ڵ�(PCODE)�� �Բ������ �ּ���.(Ȳ����)
SELECT AVG(AGE), PCODE
FROM TBL_PRODUCT
JOIN TBL_BUY USING(PCODE)
JOIN TBL_CUSTOM ON(CUSTOMID = CUSTOM_ID)
WHERE PCODE = 'JINRMN5'
GROUP BY PCODE;

--D-4. 30�� �̸� ȸ���� ���űݾ��� ���ϰ� ȸ������ �׷�����ؼ�
--���űݾ� �հ谡 ū ������ ����(������)
-- 						�� 3���� ���̺� ����
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

--B2�� ���� ī�װ��� �����Ǿ��ִ� ��ǰ���� ��ȸ�ϰ�,
--��� ���Բ� �ǸŰ� �Ǿ����� ��ȸ�Ͻÿ�.
SELECT NAME, CATEGORY, PNAME
FROM TBL_PRODUCT
JOIN TBL_BUY USING(PCODE)
JOIN TBL_CUSTOM ON(CUSTOM_ID=CUSTOMID)
WHERE CATEGORY = 'B2';

--�޹� 12���Կ� ���� ī�װ��� �����ִ� ��ǰ�� ������ ���� �̸�, ���̸� ����Ͻÿ�.
SELECT NAME, AGE
FROM TBL_PRODUCT
JOIN TBL_BUY USING(PCODE)
JOIN TBL_CUSTOM ON(CUSTOM_ID = CUSTOMID)
WHERE CATEGORY = 'B1';
--�̳����� ���� ��¥�� ������ ȸ���� �̸��� EMAIL�� ��ȸ�϶�. '�̳���'��� �̸��� ����ؼ� ��ȸ�ϵ��� �϶�.
SELECT NAME, EMAIL
FROM TBL_CUSTOM
WHERE REG_DATE >= (SELECT REG_DATE
                    FROM TBL_CUSTOM
                    WHERE NAME = '�̳���');