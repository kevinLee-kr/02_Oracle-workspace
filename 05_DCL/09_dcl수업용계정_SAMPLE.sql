--��ȿ

CREATE TABLE TEST(
    TEST_ID NUMBER,
    TEST_NAME VARCHAR2(10)
);
--TEST ��� ���̺��� �ѹ� ����������?

--CREATE TABLE �Ҽ� �ִ� ������ ��� ���� �߻�! 
--3.1 CREATE TABLE ���� �޾ƺ���.
--3.2 TABLESAPCE �Ҵ� �ޱ�.

INSERT INTO TEST VALUES(10,'�ȳ�');
SELECT * FROM TEST;
-- CREATE TABLE ������ ������ ���̺��� �ٷ� ���� ����
--------------------------------------------------
--���ڱ� ���⼭ EMPLOYEE ���̺��� ��ȸ �� ���� �;�. 
--���⼭.
--KH ������ �ִ� EMPLOYEE ���̺� ���� �غ���. 
--������ ������ �ȴ�. 
--�ٵ� ���� ���� ��ȸ ������ ����.  �׷��� �ѹ� �غ���.
SELECT * FROM KH.EMPLOYEE;
SELECT * FROM KH.DEPARTMENT;

--4. SELECT ON KH.EMPLOYEE ������ �ʿ��ϴ�. 

--5. INTO KH.DEPARTMENT
INSERT INTO KH.DEPARTMENT
VALUES('D0','ȸ���','L1');

ROLLBACK;
COMMIT;


