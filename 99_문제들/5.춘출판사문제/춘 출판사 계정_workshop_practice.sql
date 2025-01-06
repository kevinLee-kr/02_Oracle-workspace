SELECT * FROM TB_BOOK;
SELECT * FROM TB_BOOK_AUTHOR;
SELECT * FROM TB_PUBLISHER;
SELECT * FROM TB_WRITER;


--3. �������� 25 �� �̻��� å ��ȣ�� �� �� �� �� ȭ�鿡 ����ϴ� SQL ���� �ۼ��Ͻÿ�
SELECT BOOK_NO, BOOK_NM
FROM TB_BOOK
WHERE LENGTH(BOOK_NM) >=25;


--4. �޴��� ��ȣ�� 019 �� �����ϴ� �达 ���� ���� �۰��� �̸������� �������� ��
--���� ���� ǥ�õǴ� �۰�
--�̸��� �繫�� ��ȭ��ȣ , �� ��ȭ��ȣ , �޴��� ��ȭ��ȣ�� ǥ���ϴ� SQL �� ���� �ۼ��Ͻÿ�
SELECT E.*
FROM(
SELECT  WRITER_NM, OFFICE_TELNO, HOME_TELNO, MOBILE_NO
FROM TB_WRITER
WHERE SUBSTR(MOBILE_NO,1,3) = '019'
AND SUBSTR(WRITER_NM,1,1)='��'
ORDER BY WRITER_NM ASC) E
WHERE ROWNUM<=1;




--5. ���� ���°� �ű� �� �ش��ϴ� �۰����� �� �� ������ ����ϴ� SQL �� ���� �ۼ��Ͻÿ� ��� �����
--�۰� �� ���� ǥ�õǵ��� �� ��



--6. 300 �� �̻� ��ϵ� ������ ���� ���� �� ��ϵ� ���� �� ���� ǥ���ϴ� SQL �� ���� �ۼ��Ͻÿ� ����
--���°� ��ϵ��� ���� ���� ������ ��




--7. ���� �ֱٿ� �߰��� �ֽ��� �̸��� �������� , ���ǻ� �̸��� ǥ���ϴ� SQL �� ���� �ۼ��Ͻÿ�
SELECT ROWNUM,E.* 
FROM(
    SELECT BOOK_NO, BOOK_NM, ISSUE_DATE, PUBLISHER_NM
    FROM TB_BOOK
    ORDER BY ISSUE_DATE DESC
    )E
WHERE ROWNUM = 1;


--8. ���� ���� å�� �� �۰� 3 ���� �̸��� �� ���� ǥ���ϵ� , ���� �� ������� ǥ���ϴ� SQL �� ���� �ۼ��Ͻÿ�
--�� , �������� ��٣��� ) �۰��� ���ٰ� �����Ѵ� . ��� ����� �۰� �̸� ��, �� �� �� ǥ�� �ǵ��� �� ��
SELECT  ROWNUM,E.*
FROM(
    SELECT WRITER_NM, WRITER_NO, COUNT(BOOK_NO)
    FROM TB_WRITER
    JOIN TB_BOOK_AUTHOR USING(WRITER_NO)
    GROUP BY WRITER_NM, WRITER_NO
    ORDER BY COUNT(BOOK_NO) DESC) E
    WHERE ROWNUM <= 3;




--9. �۰� ���� ���̺��� ��� ������� �׸��� �����Ǿ� �ִ� �� �߰��Ͽ��� . ������ ������� ���� �� �۰���
--���� ���ǵ����� �����ϰ� ������ ��¥ �� �����Ű�� SQL �� ���� �ۼ��Ͻÿ� (COMMIT ó���� ��)







--10. ���� �������� ���� ���̺��� ������ �������� ���� ���� ���� �ϰ� �ִ� . �����δ� �������� ���� �����Ϸ�
--�� �Ѵ� . ���õ� ���뿡 �°� ��TB_BOOK_ TRANSLATOR�� ���̺��� �����ϴ� SQL ������ �ۼ��Ͻÿ� .
--(Primary Key ���� ���� �̸��� ��PK_BOOK_ �� �ϰ� , Reference ���� ���� �̸���
--��FK_BOOK_TRANSLATOR_01 ����, ��FK_BOOK_TRANSLATOR_ �� �� ��


CREATE TABLE TB_BOOK_TRANSLATOR(
BOOK_NO VARCHAR2(10) ,
WRITER_NO VARCHAR2(10),
TRANS_LANG VARCHAR2(60),
CONSTRAINT PK_BOOK_TRANSLATOR PRIMARY KEY (BOOK_NO),
CONSTRAINT FK_BOOK_TRANSLATOR_01 FOREIGN KEY (BOOK_NO) REFERENCES TB_BOOK (BOOK_NO),
CONSTRAINT FK_BOOK_TRANSLATOR_02 FOREIGN KEY (WRITER_NO) REFERENCES TB_WRITER(WRITER_NO)
);
COMMENT ON COLUMN TB_BOOK_TRANSLATOR.BOOK_NO IS '������ȣ';
COMMENT ON COLUMN TB_BOOK_TRANSLATOR.WRITER_NO IS '�۰���ȣ';
COMMENT ON COLUMN TB_BOOK_TRANSLATOR.TRANS_LANG IS '�������';

DROP TABLE TB_BOOK_TRANSLATOR;
SELECT * FROM TB_BOOK_TRANSLATOR;




--11. ���� ���� ���� (compose_ �� �ű� ', ���� ', �� ', ���� �� �ش��ϴ� �����ʹ�
--���� ���� ���� ���̺��� ���� ���� ���� ���̺� (TB_BOOK_TRANSLATOR �� �ű� �� SQL
--������ �ۼ��Ͻÿ� . �� , ��TRANS_LANG�� �÷��� NULL ���·� �ε��� �Ѵ� . �̵��� �����ʹ� ��
--�̻� TB_BOOK_AUTHOR ���̺� ���� ���� �ʵ��� ������ ��
INSERT INTO TB_BOOK_TRANSLATOR(BOOK_NO,WRITER_NO)
            (SELECT BOOK_NO, WRITER_NO
                FROM TB_BOOK_AUTHOR
                WHERE COMPOSE_TYPE IN('�ű�','����','��','����'));
DELETE
    FROM TB_BOOK_AUTHOR
    WHERE COMPOSE_TYPE IN('�ű�','����','��','����');
    
   COMMIT;
SELECT *FROM TB_BOOK_TRANSLATOR;
--12. 2007 �⵵�� ���ǵ� ������ �̸� �� ������ ���� �� ǥ���ϴ� SQL �� ���� �ۼ��Ͻÿ�

SELECT BOOK_NM, WRITER_NM, ISSUE_DATE
FROM TB_BOOK_TRANSLATOR
JOIN TB_BOOK USING(BOOK_NO)
JOIN TB_WRITER USING(WRITER_NO)
WHERE SUBSTR( TO_CHAR(ISSUE_DATE,'YYYYMMDD'),1,4) = '2007';
--13. 12 �� ����� Ȱ���Ͽ� ��� ���������� �������� ������ �� ������ �ϴ� �� �� �����ϴ� SQL
--�� ���� �ۼ��Ͻÿ� . �� �̸��� VW_BOOK_TRANSLATOR �� �ϰ� ������ , �� ���� , ��������
--ǥ�õǵ��� �� ��
--14. ���ο� ���ǻ� �� ���ǻ� �� �ŷ� ����� �ΰ� �Ǿ��� . ���õ� ���� ������ �Է��ϴ� SQL
--�� ���� �ۼ��Ͻÿ� ..(COMMIT ó���� ��
SELECT * FROM TB_BOOK;
SELECT * FROM TB_BOOK_AUTHOR;
SELECT * FROM TB_PUBLISHER;
SELECT * FROM TB_WRITER;
SELECT * FROM TB_BOOK_TRANSLATOR;

INSERT INTO TB_PUBLISHER VALUES('�� ���ǻ�','02-6710-3737-',DEFAULT);
SELECT * FROM TB_PUBLISHER;


--15. �������� ��٣��� ) �۰��� �̸��� ã������ �Ѵ� . �̸��� �������� ���ڸ� ǥ���ϴ� SQL �� ����
--�ۼ��Ͻÿ�

SELECT WRITER_NM, COUNT(*)
FROM TB_WRITER
GROUP BY WRITER_NM
HAVING COUNT(*) >1;


--16. ������ ���� ���� �� ���� ���� (compose_ �� ������ �����͵��� ���� �ʰ� �����Ѵ� . �ش� �÷���
--NULL �� ��� ���� ���� �����ϴ� SQL �� ���� �ۼ��Ͻÿ� ..(COMMIT ó���� ��



--17. �������� �۰� ������ �����Ϸ��� �Ѵ� . �繫���� �����̰� , �繫�� ��ȭ ��ȣ ������ 3 �ڸ��� �۰���
--�̸��� �繫�� ��ȭ ��ȣ�� ǥ���ϴ� SQL �� ���� �ۼ��Ͻÿ�
SELECT * 
FROM TB_WRITER
WHERE OFFICE_TELNO LIKE '02_________';

--18. 2006 �� 1 �� �������� ��ϵ� �� 31 �� �̻� �� �۰� �̸��� �̸������� ǥ���ϴ� SQL �� ���� �ۼ��Ͻÿ�
SELECT WRITER_NM, WRITER_NO
FROM TB_WRITER
JOIN TB_BOOK_AUTHOR USING(WRITER_NO)
JOIN TB_BOOK USING(BOOK_NO)
WHERE SUBSTR(TO_CHAR(ISSUE_DATE,'YYYYMMDD'),1,4)<=1975
GROUP BY WRITER_NM, WRITER_NO
ORDER BY WRITER_NM ASC;






--19. ���� ��� �ٽñ� �α⸦ ��� �ִ� Ȳ�ݰ��� ' ���ǻ縦 ���� ��ȹ���� ������ �Ѵ� . Ȳ�ݰ��� '
--���ǻ翡�� ������ ���� �� ��� �� ���� 10 �� �̸��� ������� ���� , �����¸� ǥ���ϴ� SQL �� ����
--�ۼ��Ͻÿ� . 
--��� �� ���� 5 �� �̸��� ������ �߰��ֹ��ʿ� �� , �������� �ҷ����� �� ǥ�� �ϰ� ,
--������ �� ���� �� , ������ ������ ǥ�� �� ���� �Ѵ� .
SELECT E.BOOK_NM, E.PRICE,
DECODE(E.STOCK_QTY,0,'�߰��ֹ��ʿ�',
                    1,'�߰��ֹ��ʿ�',
                    2,'�߰��ֹ��ʿ�',
                    3,'�߰��ֹ��ʿ�',
                    4,'�߰��ֹ��ʿ�',
                    5,'�ҷ�����',
                    6,'�ҷ�����',
                    7,'�ҷ�����',
                    8,'�ҷ�����',
                    9,'�ҷ�����')
FROM(   SELECT BOOK_NM, PRICE, STOCK_QTY
        FROM TB_BOOK
        WHERE PUBLISHER_NM = 'Ȳ�ݰ���'
AND STOCK_QTY<10)E;
--20. ��ŸƮ�� ���� �۰��� ���ڸ� ǥ���ϴ� SQL �� ���� �ۼ��Ͻÿ� ��� �����
--������ ���� ���� �� ǥ���� ��
SELECT BOOK_NM, WRITER_NO
FROM TB_BOOK_AUTHOR
JOIN TB_BOOK USING(BOOK_NO)
WHERE BOOK_NO = 1991081002;
    
SELECT WRITER_NM
FROM TB_WRITER
WHERE WRITER_NO = 286;

    

--
--21.���� �������� ���� �����Ϸκ��� �� 30���� ����Ǿ���, 
--��� ������ 90�� �̻��� ������ ���� ������, ������, ��������, 
--20% ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͽ���. 
--(��� ����� "������","������","����(Org)","����(New)"�� ǥ���� ��.
--��� ������ ���� ��, ���� ������ ������, ������ ��
--���� ǥ���� ��. 
SELECT * FROM TB_BOOK;
SELECT * FROM TB_BOOK_AUTHOR;
SELECT * FROM TB_PUBLISHER;
SELECT * FROM TB_WRITER;
SELECT * FROM TB_BOOK_TRANSLATOR;


SELECT BOOK_NO, BOOK_NM AS "������", STOCK_QTY AS "������", PRICE AS "����(Org)", PRICE*0.8 AS"���ϰ���", ISSUE_DATE
FROM TB_BOOK
WHERE STOCK_QTY>=90
AND SYSDATE >= ADD_MONTHS(ISSUE_DATE, 360) -- BETWEEN(ISSUE_DATE ,SYSDATE) >= 360
ORDER BY STOCK_QTY DESC, ���ϰ��� DESC, BOOK_NM ASC;



--��MONTH BETWEEN(DA1, ED2) : �� ��¥ ������ ���� �� => ���������� DATE1 -(����) DATE2 �� ������ 30,31�� ���� �� ���̴�. 
--������� NUMBER Ÿ��
-- EMPLOYEE, ���� �����, �Ի���, �ٹ� ������







