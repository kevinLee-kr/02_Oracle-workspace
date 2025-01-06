SELECT * FROM TB_CLASS;
SELECT * FROM TB_CLASS_PROFESSOR;
SELECT * FROM TB_DEPARTMENT;
SELECT * FROM TB_GRADE;
SELECT * FROM TB_PROFESSOR;
SELECT * FROM TB_STUDENT;
--1. �� ������б��� �а� �̸��� �迭�� ǥ���Ͻÿ�. ��, ��� ����� "�а� ��", "�迭" ���� ǥ���ϵ��� ����.

SELECT DEPARTMENT_NAME "�а� ��", CATEGORY"�迭"
FROM TB_DEPARTMENT;


--2. �а��� �а� ������ ������ ���� ���·� ȭ�鿡 �������.

SELECT DEPARTMENT_NAME||'���� ������ '||CAPACITY||'�� �Դϴ�. '
FROM TB_DEPARTMENT;


--3. "������а�" �� �ٴϴ� ���л� �� ���� �������� ���л��� ã�ƴ޶�� ��û�� ���Դ�. �����ΰ�?
--(�����а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ� ã�� ������ ����)


SELECT *
FROM TB_DEPARTMENT
JOIN TB_STUDENT USING(DEPARTMENT_NO)
WHERE SUBSTR(STUDENT_SSN,8,1) IN('2','4')
AND ABSENCE_YN='N';

--4. ���������� ���� ���� ��� ��ü�� ���� ã�� �̸��� �Խ��ϰ��� ����. �� ����ڵ��� �й��� ������ ���� �� ����ڵ��� ã�� ������ SQL ������ �ۼ��Ͻÿ�.
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN('A513079','A513090','A513091','A513110','A513119')
ORDER BY STUDENT_NAME DESC;


--5. ���������� 20�� �̻� 30�� ������ �а����� �а� �̸��� �迭�� ����Ͻÿ�.

SELECT DEPARTMENT_NAME, CATEGORY 
FROM TB_DEPARTMENT
WHERE CAPACITY >=20 AND CAPACITY<=30;


--6. �� ������б��� ������ �����ϰ� ��� �������� �Ҽ� �а��� ������ �ִ�.
--�׷� �� ������б� ������ �̸��� �˾Ƴ� �� �ִ� SQL ������ �ۼ��Ͻÿ�.
SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;




--7. Ȥ�� ������� ������ �а��� �����Ǿ� ���� ���� �л��� �ִ��� Ȯ���ϰ��� ����.
--��� SQL ������ ����ϸ� �� ������ �ۼ��Ͻÿ�.
SELECT *
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NOT NULL;


--8. ������û�� �Ϸ��� ����. �������� ���θ� Ȯ���ؾ� �ϴµ�, 
--���������� �����ϴ� ������� � �������� �����ȣ�� ��ȸ�غ��ÿ�.
SELECT PREATTENDING_CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;


--9. �� ���п��� � �迭(CATEGORY)���� �ִ��� ��ȸ�غ��ÿ�.
SELECT DISTINCT CATEGORY
FROM TB_DEPARTMENT;


--10. 02�й� ���� �����ڵ��� ������ ������� ����.
--������ ������� ������ �������� �л����� �й�, �̸�, �ֹι�ȣ�� ����ϴ� ������ �ۼ��Ͻÿ�.

SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN, STUDENT_ADDRESS, ENTRANCE_DATE
FROM TB_STUDENT
WHERE SUBSTR(ENTRANCE_DATE,1,2)=02
AND SUBSTR(STUDENT_ADDRESS,1,2) IN('����')
AND ABSENCE_YN = 'N';



--1. ������а�(�а��ڵ� 002) �л����� �й��� �̸�, ���� �⵵�� ���� �⵵�� ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
--( ��, ����� "�й�", "�̸�", "���г⵵" �� ǥ�õǵ��� ����.)
SELECT STUDENT_NO"�й�", STUDENT_NAME" �̸� ", ENTRANCE_DATE"���г⵵"
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NO = 002
ORDER BY ENTRANCE_DATE ASC;


--2. �� ������б��� ���� �� �̸��� �� ���ڰ� �ƴ� ������ �� �� �ִٰ� ����.
--�� ������ �̸��� �ֹι�ȣ�� ȭ�鿡 ����ϴ� SQL ������ �ۼ��� ����.
--(* �̶� �ùٸ��� �ۼ��� SQL ������ ��� ���� ����� �ٸ��� ���� �� �ִ�. ������ �������� �����غ� ��)
SELECT PROFESSOR_NAME"�̸�", PROFESSOR_SSN"�ֹι�ȣ"
FROM TB_PROFESSOR
WHERE PROFESSOR_NAME LIKE '____%'
OR PROFESSOR_NAME LIKE'__';
--3. �� ������б��� ���� �������� �̸��� ���̸� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
--�� �̶� ���̰� ���� ������� ���� ��� ������ ȭ�鿡 ��µǵ��� ����ÿ�.
--(��, ���� �� 2000�� ���� ����ڴ� ������ ��� ����� "�����̸�", "����"�� ����. ���̴� ���������� �������.)
SELECT PROFESSOR_NAME"�����̸�", FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE('19' || 
                                                    SUBSTR(PROFESSOR_SSN, 1, 6), 'YYYYMMDD')) / 12 ) ����
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN,8,1)='1'
ORDER BY PROFESSOR_SSN DESC;



--4. �������� �̸� �� ���� ������ �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�. ��� ����� ?�̸�? �� �������� ����.
--(���� 2���� ���� ������ ���ٰ� �����Ͻÿ�)
SELECT SUBSTR(PROFESSOR_NAME,2,3)"�̸�"
FROM TB_PROFESSOR;

--5. �� ������б��� ����� �����ڸ� ���Ϸ��� ����. ��� ã�Ƴ� ���ΰ�?
--�̶�, 19�쿡 �����ϸ� ����� ���� ���� ������ �A������.
SELECT E.*
FROM (
SELECT STUDENT_NAME, STUDENT_SSN, ENTRANCE_DATE, ABSENCE_YN,
SUBSTR(TO_CHAR(ENTRANCE_DATE,'YYYYMMDD'),1,4)-('19'||SUBSTR(STUDENT_SSN, 1, 2))             AS"���г���"
FROM TB_STUDENT
)E
WHERE ���г��� > 19
;
--6. 2020�� ũ���������� ���� �����ΰ�?
SELECT TO_CHAR(TO_DATE(20201225), 'DAY') 
FROM DUAL; -- �ݿ���
--7. TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD') �� ���� �� �� �� �� �� ���� �ǹ�����?
--�� TO_DATE('99/10/11','RR/MM/DD'), TO_DATE('49/10/11','RR/MM/DD') �� ���� �� �� �� �� �� ���� �ǹ�����?
SELECT TO_DATE('99/10/11', 'YY/MM/DD') FROM DUAL; -- 2099�� 10�� 11��
SELECT TO_DATE('49/10/11', 'YY/MM/DD') FROM DUAL; -- 2049�� 10�� 11��
SELECT TO_DATE('99/10/11', 'RR/MM/DD') FROM DUAL; -- 1999�� 10�� 11��
SELECT TO_DATE('49/10/11', 'RR/MM/DD') FROM DUAL; -- 2049�� 10�� 11��




--8. �� ������б��� 2000�⵵ ���� �����ڵ��� �й��� A�� �����ϰ� �Ǿ��ִ�.
--2000�⵵ �̠� �й��� ���� �л����� �й��� �̸��� �����ִ� SQL ������ �ۼ��Ͻÿ�.
SELECT STUDENT_NAME, STUDENT_NO, ENTRANCE_DATE
FROM TB_STUDENT
WHERE ENTRANCE_DATE<'2000/01/01'
ORDER BY ENTRANCE_DATE;

--9. �й��� A517178 �� �ѾƸ� �л��� ���� �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. 
--��, �̶� ��� ȭ���� ����� "����" �̶�� ������ �ϰ�, ������ �ݿø��Ͽ� �Ҽ��� ���� �� �ڸ������� ǥ������.

SELECT STUDENT_NAME AS"�л� �̸�", ROUND(AVG(POINT),1) AS"����"
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
GROUP BY STUDENT_NAME;
--10. �а��� �л����� ���Ͽ� "�а���ȣ", "�л���(��)" �� ���·� ����� ����� ������� ��µǵ��� �Ͻÿ�.
SELECT DEPARTMENT_NO AS"�а���ȣ", CAPACITY AS "�л���(��)"
FROM TB_DEPARTMENT;


--11. ���� ������ �������� ���� �л��� ���� �� �� ���� �Ǵ� �˾Ƴ��� SQL ���� �ۼ��Ͻÿ�.

SELECT COUNT(NVL(COACH_PROFESSOR_NO,1)) AS"�������� ���� �л�"
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

--12. �й��� A112113�� ���� �л��� �⵵ �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�.
--��, �̶� ��� ȭ���� ����� "�⵵", "�⵵ �� ����" �̶�� ������ �ϰ�, ������ �ݿø��Ͽ� �Ҽ��� ���� �� �ڸ������� ǥ���Ѵ�.
SELECT TO_DATE('20'||TERM_NO,'YYYYMMDD') AS"�⵵", POINT AS "�⵵ �� ����"
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
WHERE STUDENT_NO = 'A112113';



--13. �а� �� ���л� ���� �ľ��ϰ��� ����. �а� ��ȣ�� ���л� ���� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT DEPARTMENT_NO, COUNT(DECODE(ABSENCE_YN,'Y',1))
FROM (  SELECT *
        FROM TB_STUDENT
        WHERE ABSENCE_YN IN('Y','N'))
        JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO ASC;




--14. �� ���б��� �ٴϴ� ��������(��٣���) �л����� �̸��� ã���� ����. � SQL ������ ����ϸ� �����ϰڴ°�?
SELECT A.STUDENT_NAME AS "�����̸�" , COUNT(A.STUDENT_NAME) AS "������ ��"
FROM TB_STUDENT A, TB_STUDENT B
WHERE A.STUDENT_NAME = B.STUDENT_NAME
AND A.STUDENT_NO != B.STUDENT_NO
GROUP BY A.STUDENT_NAME
ORDER BY A.STUDENT_NAME ASC;
--15. �й��� A112113 �� ���� �л��� �⵵, �б� �� ������ �⵵ �� ���� ���� , �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�.
--(��, ������ �Ҽ��� 1�ڸ������� �ݿø��Ͽ� ǥ���Ѵ�.)


SELECT SUBSTR(TERM_NO,1,4) AS "�⵵", SUBSTR(TERM_NO,5,2)   , POINT 
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO) 
WHERE STUDENT_NO = 'A112113';


--1. �л��̸��� �ּ����� ǥ���Ͻÿ�. ��, ��� ����� "�л� �̸�", "�ּ���"�� �ϰ�, ������ �̸����� �������� ǥ���ϵ��� ����.
SELECT STUDENT_NAME"�л��̸�", STUDENT_ADDRESS"�ּ���"
FROM TB_STUDENT
ORDER BY STUDENT_NAME ASC;


--2. �������� �л����� �̸��� �ֹι�ȣ�� ���̰� ���� ������ ȭ�鿡 ����Ͻÿ�.

SELECT STUDENT_NAME, STUDENT_NO, STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY STUDENT_SSN DESC;


--3. �ּ����� �������� ��⵵�� �л��� �� 1900��� �й��� ���� �л����� �̸��� �й�, �ּҸ� �̸��� ������������ ȭ�鿡 ����Ͻÿ�. 
--��, ���������� "�л��̸�","�й�", "������ �ּ�" �� ��µǵ��� ����. 
 SELECT STUDENT_NAME AS " �л��̸� ", STUDENT_NO " �й� ",STUDENT_ADDRESS AS " ������ �ּ� ", ENTRANCE_DATE
 FROM TB_STUDENT
 WHERE SUBSTR(STUDENT_ADDRESS,1,3) IN ('������','��⵵')
 AND TO_NUMBER(TO_CHAR(ENTRANCE_DATE,'YYYY'))<2000;
 


--4. ���� ���а� ���� �� ���� ���̰� ���� ������� �̸��� Ȯ���� �� �ִ� SQL ������ �ۼ��Ͻÿ�. (���а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ� ã�� ������ ����)

SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_DEPARTMENT
JOIN TB_PROFESSOR USING(DEPARTMENT_NO)
ORDER BY PROFESSOR_SSN ASC;



--5. 2004��2�б⿡ 'C3118100' ������ ������ �л����� ������ ��ȸ�Ϸ��� ����. ������ ���� �л����� ǥ���ϰ�, ������ ������ �й��� ���� �л����� ǥ���ϴ� ������ �ۼ��غ��ÿ�.

SELECT STUDENT_NAME, POINT
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
WHERE TERM_NO = '200402'
AND CLASS_NO ='C3118100'
ORDER BY POINT DESC, STUDENT_NO;


--6. �л� ��ȣ, �л� �̸�, �а� �̸��� �л� �̸����� �������� �����Ͽ� ����ϴ� SQL ���� �ۼ��Ͻÿ�.


SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
ORDER BY STUDENT_NAME ASC;


--7. �� ������б��� ���� �̸��� ������ �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.


SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO);



--8. ���� ���� �̸��� ã������ ����. ���� �̸��� ���� �̸��� ����ϴ� SQL ���� �ۼ��Ͻÿ�.


SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS
JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
JOIN TB_PROFESSOR USING(PROFESSOR_NO);




--9. 8���� ��� �� ���ι���ȸ�� �迭�� ���� ������ ���� �̸��� ã������ ����. �̿� �ش��ϴ� ���� �̸��� ���� �̸��� ����ϴ� SQL ���� �ۼ��Ͻÿ�.SELECT * FROM TB_CLASS;
SELECT PROFESSOR_NAME, DEPARTMENT_NAME
FROM TB_PROFESSOR
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE CATEGORY ='�ι���ȸ';



--10. �������а��� �л����� ������ ���Ϸ��� ����.
--�����а� �л����� "�й�", "�л� �̸�", "��ü ����"�� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
--(��, ������ �Ҽ��� 1�ڸ������� �ݿø��Ͽ� ǥ������.)

SELECT STUDENT_NO AS "�й�", STUDENT_NAME AS "�л��̸�" ,  ROUND(AVG(POINT),1) AS "��ü ����"
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME='�����а�'
GROUP BY STUDENT_NO, STUDENT_NAME;

--11. �й��� A313047�� �л��� �б��� ������ ���� �ʴ�. ���� �������� ������ �����ϱ� ���� �а� �̸�, �л� �̸��� ���� ���� �̸��� �ʿ��ϴ�.
--�̶� ����� SQL ���� �ۼ��Ͻÿ�. ��, �������� ?�а��̸�?, ?�л��̸�?, ?���������̸�?���� ��µǵ��� �Ѵ�.
SELECT DEPARTMENT_NAME AS "�а� �̸�", STUDENT_NAME AS "�л��̸�", PROFESSOR_NAME AS "���� ����", COACH_PROFESSOR_NO
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
JOIN TB_PROFESSOR ON(COACH_PROFESSOR_NO = PROFESSOR_NO)
WHERE COACH_PROFESSOR_NO = 'P034' AND STUDENT_NO='A313047';

--12. 2007�⵵�� '�ΰ������' ������ ������ �л��� ã�� �л��̸��� �����б⸦ ǥ���ϴ� SQL
--������ �ۼ��Ͻÿ�.
SELECT * 
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
WHERE CLASS_NO = 'C2604100'
AND SUBSTR(TERM_NO,1,4)=2007;
--13. ��ü�� �迭 ���� �� ���� ��米���� �� �� �������� ���� ������ ã��
--�� ���� �̸��� �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
LEFT JOIN TB_CLASS_PROFESSOR USING(CLASS_NO) 
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NO IN ('056','057','058','059','060','061','062','063')
AND PROFESSOR_NO IS NULL
ORDER BY DEPARTMENT_NAME ASC;



--14. �� ������б� ���ݾƾ��а� �л����� ���������� �Խ��ϰ��� �Ѵ�. �л��̸��� �������� �̸��� ã�� 
--���� ���� ������ ���� �л��� ��� "�������� ������?���� ǥ���ϵ��� �ϴ� SQL ���� �ۼ��Ͻÿ�.
--��, �������� ?�л��̸�?, ?��������?�� ǥ���ϸ� ���й� �л��� ���� ǥ�õǵ��� �Ѵ�.

SELECT STUDENT_NAME AS "�л� �̸�", NVL(COACH_PROFESSOR_NO,'�������� ������') AS "�������� �ѹ�", ENTRANCE_DATE
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '���ݾƾ��а�'
ORDER BY ENTRANCE_DATE ASC;



--15. ���л��� �ƴ� �л� �� ������ 4.0 �̻��� �л��� ã�� �� �л��� �й�, �̸�, �а� �̸�, ������ ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT STUDENT_NAME, AVG(POINT)
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
HAVING AVG(POINT) >4.0
GROUP BY STUDENT_NAME;





--16. ȯ�������а� ����������� ���� �� ������ �ľ��� �� �ִ� SQL ���� �ۼ��Ͻÿ�.
SELECT CLASS_NO,CLASS_NAME, AVG(POINT)
FROM TB_CLASS
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
JOIN TB_GRADE USING(CLASS_NO)
WHERE DEPARTMENT_NAME = 'ȯ�������а�'
GROUP BY CLASS_NO,CLASS_NAME;

--17. �� ������б��� �ٴϰ� �ִ� �ְ��� �л��� ���� �� �л����� �̸��� �ּҸ� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT STUDENT_NAME AS " �л� �̸�" , STUDENT_ADDRESS AS " �ּ� ��"
FROM TB_STUDENT
WHERE DEPARTMENT_NO = (
                    SELECT DEPARTMENT_NO
                    FROM TB_STUDENT
                    WHERE STUDENT_NAME = '�ְ���'
                    );



--18. ������а����� �� ������ ���� ���� �л��� �̸��� �й��� ǥ���ϴ� SQL���� �ۼ��Ͻÿ�.
SELECT * 
FROM (
    SELECT STUDENT_NAME AS "�л� �̸�", STUDENT_NO AS "�л���ȣ", ROUND(AVG(POINT),2)
    FROM TB_STUDENT
    JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
    JOIN TB_GRADE USING(STUDENT_NO)
    WHERE DEPARTMENT_NAME='������а�'
    GROUP BY STUDENT_NAME, STUDENT_NO
    ORDER BY AVG(POINT)DESC
    )
    WHERE ROWNUM = 1; 




--19. �� ������б��� "ȯ�������а�"�� ���� ���� �迭 �а����� �а� �� �������� ������ �ľ��ϱ� ���� ������ SQL ���� ã�Ƴ��ÿ�.
--��, �������� "�迭 �а���", "��������"���� ǥ�õǵ��� �ϰ�, ������ �Ҽ��� �� �ڸ������� �ݿø��Ͽ� ǥ�õǵ��� ����.
SELECT DEPARTMENT_NAME AS "�迭 �а���", ROUND(AVG(POINT),1) AS "��������"
FROM TB_DEPARTMENT
JOIN TB_CLASS USING(DEPARTMENT_NO)
JOIN TB_GRADE USING(CLASS_NO)
WHERE CATEGORY = '�ڿ�����'
GROUP BY DEPARTMENT_NAME
ORDER BY DEPARTMENT_NAME;
--1. �迭 ������ ������ ī�װ� ���̺��� ������� ����. ������ ���� ���̺��� �ۼ��Ͻÿ�.
CREATE TABLE TB_CATEGORY(
    NAME VARCHAR2(10),
    USE_YN CHAR(1) DEFAULT 'Y'
    );
--2. ���� ������ ������ ���̺��� ������� ����. ������ ���� ���̺��� �ۼ��Ͻÿ�.
CREATE TABLE TB_CLASS_TYPE(
NO VARCHAR2(5) PRIMARY KEY,
NAME VARCHAR(10)
);
--3. TB_CATAGORY ���̺��� NAME �÷��� PRIMARY KEY�� �����Ͻÿ�. (KEY �̸��� �������� �ʾƵ� ������.
--���� KEY �̸� �����ϰ��� ���ٸ� �̸��� ������ �˾Ƽ� ������ �̸��� �������.)
DROP TABLE TB_CATEGORY;
CREATE TABLE TB_CATEGORY(
    NAME VARCHAR2(10) PRIMARY KEY,
    USE_YN CHAR(1) DEFAULT 'Y'
    );
SELECT * FROM TB_CATEGORY;

--4. TB_CLASS_TYPE ���̺��� NAME �÷��� NULL ���� ���� �ʵ��� �Ӽ��� �����Ͻÿ�
DROP TABLE TB_CLASS_TYPE;
CREATE TABLE TB_CLASS_TYPE(
NO VARCHAR2(5) PRIMARY KEY,
NAME VARCHAR(10) NOT NULL
);
--5. �� ���̺��� �÷� ���� NO�� ���� ���� Ÿ���� �����ϸ鼭 ũ��� 10 ����,
--�÷����� NAME �� ���� ���������� ���� Ÿ���� �����ϸ鼭 ũ�� 20 ���� �����Ͻÿ�.

ALTER TABLE TB_CLASS_TYPE MODIFY NO VARCHAR2(10);
ALTER TABLE TB_CLASS_TYPE MODIFY NAME VARCHAR2(20);
ALTER TABLE TB_CATEGORY MODIFY NAME VARCHAR2(20);

--6. �� ���̺��� NO �÷��� NAME �÷��� �̸���
--�� �� TB_ �� ������ '���̺� �̸�''�� �տ� ���� ���·� �����Ѵ�.
--(ex. CATEGORY_NAME)
ALTER TABLE TB_CLASS_TYPE RENAME COLUMN NO TO CLASS_TYPE_NO;
ALTER TABLE TB_CLASS_TYPE RENAME COLUMN NAME TO CLASS_TYPE_NAME;
ALTER TABLE TB_CATEGORY RENAME COLUMN USE_YN TO CATEGORY_USE_YN;
ALTER TABLE TB_CATEGORY RENAME COLUMN NAME TO CATEGORY_NAME;


--7. TB_CATAGORY ���̺�� TB_CLASS_TYPE ���̺��� PRIMARY KEY �̸��� ������ ���� �����Ͻÿ�.
--Primary Key�� �̸��� PK_ + �÷��̸����� �����Ͻÿ�. (ex. PK_CATEGORY_NAME )
ALTER TABLE TB_CATEGORY RENAME CONSTRAINT SYS_C007264 TO PK_CATEGORY_NAME;
ALTER TABLE TB_CLASS_TYPE RENAME CONSTRAINT SYS_C007266 TO PK_CLASS_TYPE_NAME;


--8. ������ ����INSERT ���� ��������.
INSERT INTO TB_CATEGORY VALUES ('����','Y');
INSERT INTO TB_CATEGORY VALUES ('�ڿ�����','Y');
INSERT INTO TB_CATEGORY VALUES ('����','Y');
INSERT INTO TB_CATEGORY VALUES ('��ü��','Y');
INSERT INTO TB_CATEGORY VALUES ('�ι���ȸ','Y');
COMMIT;

--9.TB_DEPARTMENT�� CATEGORY �÷��� TB_CATEGORY ���̺��� CATEGORY_NAME �÷��� �θ� ������
--�����ϵ��� FOREIGN KEY�� �����Ͻÿ�.
--�� �� KEY �̸��� FK_���̺��̸�_�÷��̸����� ��������.
--(ex. FK_DEPARTMENT_CATEGORY )

ALTER TABLE TB_DEPARTMENT ADD FOREIGN KEY(CATEGORY) REFERENCES TB_CATEGORY;

SELECT * FROM TB_DEPARTMENT;
SELECT * FROM TB_CATEGORY;
SELECT * FROM TB_CLASS_TYPE;

--10. �� ������б� �л����� �������� ���ԵǾ� �ִ� �л��Ϲ����� VIEW�� ������� ����.
--�Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�.

--11. �� ������б��� 1�⿡ �� ���� �а����� �л��� ���������� ���� ����� ��������.
--�̸� ���� ����� �л��̸�, �а��̸�, ��米���̸� ���� �����Ǿ� �ִ� VIEW �� ����ÿ�.
--�̶� ���� ������ ���� �л��� ���� �� ������ ����Ͻÿ�
--(��, �� VIEW �� �ܼ� SELECT ���� �� ��� �а����� ���ĵǾ� ȭ�鿡 �������� ����ÿ�.)
--12. ��� �а��� �а��� �л� ���� Ȯ���� �� �ֵ��� ������ VIEW �� �ۼ��� ����.
--13. ������ ������ �л��Ϲ����� View�� ���ؼ� �й��� A213046�� �л��� �̸��� ���� �̸����� �����ϴ� SQL ���� �ۼ��Ͻÿ�.
--14. 13�������� ���� VIEW�� ���ؼ� �����Ͱ� ����� �� �ִ� ��Ȳ�� �������� VIEW�� ��� �����ؾ� �ϴ��� �ۼ��Ͻÿ�.

--15. �� ������б��� �ų� ������û ��A�� �Ǹ� Ư�� �α� ����鿡 ���� ��û�� ���� ������ �ǰ� �ִ�.
--2005~2009���� �������� �����ο��� ���� ���Ҵ� 3 ������ ã�� ������ �ۼ��غ��ÿ�.

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
       
       
        

        
        
        
        

--1. �������� ���̺�(TB_CLASS_TYPE)�� �Ʒ��� ���� �����͸� �Է��Ͻÿ�.
INSERT INTO TB_CLASS_TYPE(NO,NAME) VALUES(01,'�����ʼ�');
INSERT INTO TB_CLASS_TYPE(NO,NAME) VALUES(02,'��������');
INSERT INTO TB_CLASS_TYPE(NO,NAME) VALUES(03,'�����ʼ�');
INSERT INTO TB_CLASS_TYPE(NO,NAME) VALUES(04,'���缱��');
INSERT INTO TB_CLASS_TYPE(NO,NAME) VALUES(05,'������');
--2. �� ������б� �л����� ������ ���ԵǾ� �ִ� �л��Ϲ����� ���̺��� ������� �Ѵ�.
--�Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�. (���������� �̿��Ͻÿ�)

CREATE TABLE TB_GENERAL_STUDENT ( 
        STUDENT_NO VARCHAR2(10),
        STUDENT_NAME VARCHAR2(40),
        STUDENT_ADDRESS VARCHAR(200)
        );
SELECT * FROM TB_GENERAL_STUDENT;

INSERT INTO TB_GENERAL_STUDENT(STUDENT_NO,STUDENT_NAME,STUDENT_ADDRESS)
(SELECT STUDENT_NO,STUDENT_NAME, STUDENT_ADDRESS
 FROM TB_STUDENT   );

--3. ������а� �л����� �������� ���ԵǾ� �ִ� �а����� ���̺��� ������� ����.
--�Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�. (��Ʈ : ����� �پ���, �ҽŲ� �ۼ��Ͻÿ�)
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
            WHERE D.DEPARTMENT_NAME = '������а�'
            );



--4. �� �а����� ������ 10% ������Ű�� �Ǿ���. �̿� ����� SQL ���� �ۼ��Ͻÿ�.
--(��, �ݿø��� ����Ͽ� �Ҽ��� �ڸ����� ������ �ʵ��� ����)

SELECT DEPARTMENT_NAME, DECODE(OPEN_YN,'Y',ROUND(CAPACITY * 1.1),1)
FROM TB_DEPARTMENT;



--5. �й� A413042�� �ڰǿ� �л��� �ּҰ� "����� ���α� ���ε� 181-21 "�� ����Ǿ��ٰ� ����.
--�ּ����� �����ϱ� ���� ����� SQL ���� �ۼ��Ͻÿ�.
UPDATE TB_STUDENT
SET STUDENT_ADDRESS = '����� ���α� ���ε� 181-21'
WHERE STUDENT_NO = 'A413042' ;

SELECT STUDENT_NO , STUDENT_NAME , STUDENT_ADDRESS
FROM TB_STUDENT
WHERE STUDENT_NO = 'A413042';



--6. �ֹε�Ϲ�ȣ ��ȣ���� ���� �л����� ���̺��� �ֹι�ȣ ���ڸ��� �������� �ʱ�� �����Ͽ���.
--�� ������ �ݿ��� ������ SQL ������ �ۼ��Ͻÿ�.
--(��. 830530-2124663 ==> 830530 )
SELECT * FROM TB_STUDENT;

UPDATE TB_STUDENT
SET STUDENT_SSN = SUBSTR(STUDENT_SSN,1,6);

--7. ���а� ����� �л��� 2005�� 1�б⿡ �ڽ��� ������ '�Ǻλ�����' ������
--�߸��Ǿ��ٴ� ���� �߰��ϰ�� ������ ��û�Ͽ���.
--��� ������ Ȯ�� ���� ��� �ش� ������ ������ 3.5�� ����Ű�� �����Ǿ���.
--������ SQL ���� �ۼ��Ͻÿ�.
UPDATE TB_GRADE SET POINT = 3.5 WHERE STUDENT_NO =  'A331101' AND TERM_NO = 200501;

SELECT POINT
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
WHERE STUDENT_NO = 'A331101'
AND TERM_NO = 200501;
--8. ���� ���̺�(TB_GRADE) ���� ���л����� �����׸��� �����Ͻÿ�.

DELETE FROM (
        SELECT STUDENT_NO, STUDENT_NAME, ABSENCE_YN
        FROM TB_STUDENT
        JOIN TB_GRADE USING(STUDENT_NO))
WHERE ABSENCE_YN = 'Y';
 












