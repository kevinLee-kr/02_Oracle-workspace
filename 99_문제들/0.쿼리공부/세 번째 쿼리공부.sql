--���� �尡��

--QUIZ 1 (DCL)����


--CREATE USER TEST IDENTIFIED BY 12344;����
--USER TEST(��)�� ���� �Ǿ����ϴ�. 
-- ���� ������ �ϰ� ���ӽ� �����߻� 

--�� ������ �������? �ذ����� �����ÿ�. 

--������ : ���� ������ �߰�, ���� ������ �ο����� �ʾұ� ����.

--GRANT CONNECT , RESOURCE TO TEST �� ������? <--�������� ���� �ٸ� ���� ������ �̷��� ������
--GRANT CREATE SESSION TO TEST;
-- CREATE SESSION ���� �� �� �ִ� ����. �̰� ó��. �����Ҽ� �ִ� ���� �����~ ��� �� ���̵� �ְ� �� ���� �ִ�. 

--QUIZ2(JOIN ����)
CREATE TABLE TB_JOB(
    JOBCODE NUMBER PRIMARY KEY, 
    JOBNAME VARCHAR2(10) NOT NULL   
);
--�ϳ� �� ���̺��� �ʿ��Ѱ� ����.  � ���̺��� ����ųĸ�
CREATE TABLE TB_EMP(
    EMPNO NUMBER PRIMARY KEY,
    EMPNAME VARCHAR2(10) NOT NULL,
    JOBNO NUMBER REFERENCES TB_JOB(JOBCODE)
);


--���� �� ���̺��� �ִٴ� �����Ͽ� 
--�� ���̺� �� �����ؼ� EMPNO, EMPNAME, JOBNO, JOBNAME�÷� �� ��ȸ �ϰ� �ʹ�. 
--�̋� ������ SQL���� �̷���.  ������ ����, ��ġ�� �����ֶ�.  ��� ���� �� �ִ�. 

SELECT EMPNO, EMPNAME, JOBNO, JOBNAME
FROM TB_EMP
JOIN TB_JOB USING(JOBNO);
--ORA-00904: "TB_JOB"."JOBNO": invalid identifier
--������. JOBNO��� �÷��� TB_EMP���� ����������, TB_JOB���� �������� �ʱ� ������ USING ������ ������ ����.
--��ġ����:USING�� �ƴ� ON���� ����ؼ� ��Ȱ�ϰ� JOIN�� �ִ� ���� �ٶ��� �ϴ�.
--��ġ�� ���� �ڵ�� �Ʒ��� ����.
SELECT EMPNO, EMPNAME, JOBNO, JOBNAME
FROM TB_EMP
JOIN TB_JOB ON(JOBNO = JOBCODE);



--���̺��� �����ҋ� ������ Ÿ���� �������� �����Ѵ�. 
--(CHAR, VARCHAR2() �� �������� �����϶�. )
--����Ŭ ��ü ��������
--Ŀ�� �ѹ� ����? 
--QUIZ_3 ( WHERE OR HAVING ? )
--�Ʒ��� SQL������ �μ��� ���� �հ谡 1500������ �ʰ��ϴ� �μ��� ��ȸ�� ���̴�. 
--����� �ùٸ��� �ʴ�. ������ �����̰�, ���븦 ���϶�. 
--������ �����¾Ʒ��� ����. 
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE SUM(SALARY) >= 15000000
GROUP BY DEPT_CODE;

--�����ؾ� �� �� : GROUP BY �� �ҋ��� WHERE ���� �ȵȴ�.   (x)
--�̰��� �ƴϴ�. ���� ������  SUM(sALARY)�� �ƴ� �׳� SALARY ��� ������ �� ����� ���� ������ ������ �ȳ���.
--�ùٸ��� ǥ���ϰ� ������, 
--GROUP �Լ���(SUM) �� ����ϰ� ������, WHERE �� �ƴ� HAVING�� ������� �ߴ�.
--GROUP �� ���� ������ �����ҋ��� WHERE ���� ���°� �ƴϴ�. -> ��HAVING
--��ġ���� ������ �Ʒ��� ����.
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) > 15000000;
--

--QUIZ _ 4 ( �������� )
CREATE TABLE QUIZ4(
    QNO NUMBER PRIMARY KEY,
    QNAME VARCHAR2(10),
    SCORE NUMBER
    );

SELECT * FROM QUIZ4;

INSERT INTO QUIZ4 VALUES(1,'QUIZ_1',30); -- �� �����
INSERT INTO QUIZ4 VALUES(2,'QUIZ_2',50); -- �� �����
INSERT INTO QUIZ4 VALUES(1,'QUIZ_3',40); --���� PRIMARY KEY  �ߺ�
INSERT INTO QUIZ4 VALUES(NULL,'QUIZ_1',30); --���� PRIMARY KEY ����(NULL)

--QUIZ _ 5 (CASE WHEN)
--SALARY �� 500 �̻��̸� ��ް�����
--            300�̻��̸� �߱ް�����
--                �̰͵� �ƴϸ� �ʱް�����
SELECT EMP_NAME, SALARY,
        CASE WHEN SALARY >= 5000000 THEN '��� ������'
                WHEN SALARY >= 3000000 THEN '�߱� ������'
                ELSE '�ʱ� ������'
                END AS "����"
FROM EMPLOYEE;

















