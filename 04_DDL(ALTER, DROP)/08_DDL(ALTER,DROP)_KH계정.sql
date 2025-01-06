/*
DDL( DATE DEFINITION LANGUAGE) : ������ ���� ���

��ü���� ����(CREATE), ����(ALTER) , ����(DROP) �ϴ� ����.

<ALTER>
��ü�� �����ϴ� ����. 
[ǥ����]
ALTER TABLE ���̺�� �����ҳ���;

*������ ����
1) �÷� �߰� OR ���� OR �����ҋ� ALTER�� ����� �� ����
2) �������� �߰� / ���� --> ������ �ƴϵȴ�. (�ϰ��� �Ѵٸ�, ������ ����� �ؾ��Ѵ�. )
3) �÷��� / �������Ǹ� / ���̺�� ����
*/

--1) �÷� �߰� / ���� / ����
--1-1 ) �÷� �߰� (ADD) : ADD �÷��� �ڷ��� [DEFAULT �⺻�� ��������]
--DEPT_COPY �� CNAME �̶�� �÷��� �߰��غ���. 

SELECT * FROM DEPT_COPY;

ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);
-->���ο� �÷��� ��������� �⺻�����δ� NULL�� ä������. 

ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '�ѱ�';


--1-2) �÷� ���� �غ���~
-->ǥ���� : MODIFY �÷��� �ٲٰ��� �ϴ� �ڷ���
--DEFUALT: MODIFY �÷��� DEFAULT �ٲٰ��� �ϴ� �⺻��

ALTER TABLE DEPT_COPY ������ ����;
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);
ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER; -- ������, �̹� �����Ͱ� ���� �ƴѰ͵��� ����ֱ⿡...
-- �����ϴ� �����Ͱ� ����߸� �ٲ� �� �ִ�. 

ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(10);
--01441. 00000 -  "cannot decrease column length because some value is too big"
--�̹� �÷��� ������ ����ִµ�, �װ͵��� �����ҷ��� ������� ũ�⿡, �ٲ� ���� ����. 


--DEPT_TITLE �÷��� VARCHAR2(50)�� -> DEPT_COPY ���̺�� �ٲپ��
--LOCATION_ID �÷��� VARCHAR2(4) ��
--LNAME �÷��� �⺻���� '����'���� �ٲپ��.

ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(50);
ALTER TABLE DEPT_COPY MODIFY LOCATION_ID VARCHAR2(4);
ALTER TABLE DEPT_COPY MODIFY LNAME DEFAULT '����';

SELECT * FROM DEPT_COPY;
---------------���� ������ �����ϴ�.
ALTER TABLE DEPT_COPY
    MODIFY DEPT_TITLE VARCHAR2(50)
    MODIFY LOCATION_ID VARCHAR(4)
    MODIFY LNAME DEFAULT '����';

--------------------
--1-3)�÷�����( DROP COLNUM ) : DROP COLUMN ���� �ϰ��� �ϴ� �÷���
--������ ���� ���纻 ���̺� ����
CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;

SELECT * 
FROM DEPT_COPY2;
--DEPT_COPY2 �� ���� DEPT_ID  �÷� ��������.
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;
--DROP COLUMN�� �������� �ۼ��� �Ұ����ϴ�. 
ALTER TABLE DEPT_COPY2 DOPR COLUMN LOCATION_ID;

/*
--2) �������� / �߰� / ����
--PRIMARY,      : ADD PRIMARY KEY(�÷���) 
--FOREIGN       : ADD FOREIGN KEY(�÷���) : REFERTENCES������ Ƽ�̺��
--UNIQUE        : ADD UNIQUE(�÷Ÿ�)
--CHECK         : ADD CHECK(�÷��� ���� ����)
--NOT NULL      : MODIFY �÷��� NOT NULL | NULL
�������Ǹ��� �����ϰ��� �Ѵٸ�, [����Ʈ����Ʈ �����Ǹ�) ���� ����
*/

--DEPT_ID �� PRIMARY KEY  �������� �߰� ADD
--DEPT_TITLE �� UNIQUE �������� �߰�.
--LNAME �� NOT NULL �������� �߰� MODIFY

ALTER TABLE DEPT_COPY
    ADD CONSTRAINT DCOPY_PK PRIMARY KEY(DEPT_NO)
    ADD CONSTRAINT DCOPY_UQ UNIQUE(DEPT_TITLE)
    MODIFY LANEM CONSTRAINT DCOPY_NN NOT NUILL;
--�䷱������ �ڴʰ� ���������� �߰� ���� �� �ִ�. 

--2-2) �������� ���� : DROP CONSTAT �������Ǹ�
--NOT NUMM �� ������ �ȵǰ� MODIFY NULL�̰ɷ� ��������� �Ѵ�. 
ALTER TABLE DEPT_������ ����;
ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_PK;

ALTER TABLE DEPT_COPY
    DROPT CONSTRAINT DCOPY)QU
    MODAFY LANME NULL;
    ==���� ���� ALTER ������ �ϰ� �ִ�. 
    3)
--3_1)�÷��� �����غ���.
RENAME COLUMN �⺻�÷��� TO �ٲ� �÷���

���� DEPT_TITLE �� DEPT_NAME 
ALTER TABLE DEPT_COPY ������ ����
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_COPY INTO DEPT_NAME;

--E_2) �������Ǹ� ���� : RENAME CONSTRAINT �������Ǹ� TO �ٲ� ���� ���Ǹ�;
--DEPT_COPY ���̺��� SYS_C007173�� DCOPY_DID_NN�� �ٲٱ�
ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007173 TO DCOPY_DID_NN;

--3-3) ���̺�� ���� : RENAME �⺻ ���̺�� TO �ٲ� ���̺��;
--DEPT_COPY ���̺� �̸��� DEPT_TEST�� �����غ���
ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST;
SELECT * FROM DEPT_TEST;

-----------------------------------------------------------------
/*
2. DROP ��ü�� �����ϴ� ����
[ǥ����]
DROP TABLE �����ϰ��� �ϴ� ���̺��;
*/
--EMP_NEW ����
DROP TABLE EMP_NEW ;

--�θ����̺��� ������ ���, �׽�Ʈ �� ȯ�� �����. 
--1) DEPT_TEST ���̺��� ��ȸ�� ����, DEPT_ID�� �ִ�. 
--�� �÷��� ���� PRIMARY KEY �������� �߰� �غ���.
 ALTER TABLE DEPT_TEST
 ADD CONSTRAINT DTEST_PK PRIMARY KEY (DEPT_ID);

SELECT * FROM DEPT_TEST;
--2) EMPLOYEE_COPY3 �� �÷� �߰� -> �ܷ�Ű ��������
ALTER TABLE EMPLOYEE_COPY3
ADD DEPT_CODE CHAR(3);

ALTER TABLE EMPLOYEE_COPY3 FOREIGN K

ALTER TABLE EMPLOYEE_COPT3
������ ����
ALTER TABLE EMPLOYEE_COPY3 CONSTRAINT ECOPY_FK FOREIGN KEY(DEPT_CODE) REFERENCES DEPT_TEST;

DROP TABLE DEPT_TEST;
--��, �����ǰ� �ִ� �θ����̺��� �������� ����
--���࿡ �θ����̺��� �����ϰ��� �Ѵٸ�, 
--��� 1) �ڽ����̺��� ���� ����, ��, �����ϰ��ִ� �ڽ��� ���� ������, ����
--��� 2)�ڽ����̺��� �ܷ�Ű �������� ���� �� �θ����̺� �����.

--CNS DDLǮ���. 








