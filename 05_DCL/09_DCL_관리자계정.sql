--
/*
DCL : DATA CONTROL LANGUAGE
������ ���� ���.
�������� �ý��� ���� �Ǵ� ��ü ���ٱ����� �ο� �ϰų� ȸ���ϴ� ����.

�������� �ý��� ���� �Ǵ� ��ü���ٱ����� �ο�(GRANT)�ϰų� ȸ��(REVOKE)GKSMS RNANS.
> �ý��� ������ ����
- DB �� �����ϴ� ����, ��ü���� ������ �� �ִ� ����



> ��ü ���� ������ ����. 
Ư�� ��ü���� ������ �� �ִ� ����
*/

/*
�ý��� ���� �� ����
1. CREATE SESSION : ������ �� �� �ִ� ����
2. CREATE TABLE : ���̺��� ������ �� �ִ� ����
3. CREATE VIEW : �並 ������ �� �ִ� ����
4. CREATE SEQUENCE : �������� ������ �� �ִ� ����. 
... : �Ϻ� Ŀ��Ʈ �ȿ� ���ԵǾ� �ֵ�. 
*/
--1. SAMPLE / SAMPLE ���� ����.
CREATE USER SAMPLE IDENTIFIED BY SAMPLE;
--����: ���� -�׽�Ʈ ����: ORA-01045: user SAMPLE lacks CREATE SESSION privilege; logon denied

--2. ������ ���� CREATE SESSION ������ �ο��غ���. 
GRANT CREATE SESSION TO SAMPLE;

--3.1 ���̺� ���� �� �� �ִ� CRAETE TABLE ���� �ο�
GRANT CREATE TABLE TO SAMPLE;

--3.2 TABLESPACE �Ҵ� ���ֱ�.
--���� ������ Ȯ�� ����� �ϴµ�, ���� �ʾҵ�. 
-- ��� ����? 
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;
---------------------------------------��ȸ.����.
/*
���֤ļ��� �ý��� ������ �ο��ϴ� �� �̾���, 
�̰��� 
    ��ü ���� ���� ����
    Ư�� ��ü�� �����ؼ� ������ �� �ִ� ����. 
    ���� ����               Ư�� ��ü
    SELECT      TABLE, VIEW, SEQUENCE
    INSERT      TABLE, VIEW
    UPDATE      TABLE, VIEW
    DELETE      TABLE, VIEW
    ....
    
    [ǥ����]
    GRANT ���� ���� ON Ư�� ��ü TO ������
    */
    
    GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;
    GRANT SELECT ON KH.DEPARTMENT TO SAMPLE;
    GRANT INSERT ON KH.DEPARTMENT TO SAMPLE;
---------------------------------------------
GRANT CONNECT, RESOURCE TO ������;
/*
<��, ROLE>
- Ư�� ���ѵ��� �ϳ��� �������� ��Ƴ��� ���̴�. 
CONNECT : ������ �� �ִ� ���� CREATE SESSION
RESOURCE : Ư�� ��ü���� ������ �� �ִ� ����. CREATE TABLE, CREATE SEQUENCE, ...
*/
SELECT *
FROM ROLE_SYS_PRIVS
WHERE ROLE IN('CONNECT','RESOURCE')
ORDER BY 1;


























