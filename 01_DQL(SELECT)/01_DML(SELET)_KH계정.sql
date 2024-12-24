--����°�
/*
    <SELECT>
    �����͸� ��ȸ�� �� ���Ǵ� ����

    >> RESULT SET : SELECT���� ���� ��ȸ�� �����(��, ��ȸ�� ����� ������ �ǹ�)
[ǥ����]
SELET ��ȸ�ϰ��� �ϴ� �÷���1, �÷�2, ...
FROM ���̺��;

�ݵ�� �����ϴ� �÷����� �����! �����ϴ� ���̺�� ����� ���°� ���� ������. 

*/

--EMPLOYEE ���̺��� ��� �÷�(*) ��ȸ.
--SELECT EMP_ID, EMP_NAME, EMP_NUMBER

SELECT *
FROM EMPLOYEE;
--EMPLOYEE ���̺��� ���, �̸�, �޿� ��ȸ.. �÷��� ���� �ܿ��� �Ѵ�. 
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;  --FROM(���� ���� ��ȸ�ϰڴ�.)

--JOB�̶� ���̺��� �����ϴµ�, ��� �÷� ��ȸ�� �غ��ڴ�.  SELECT(��ȸ)
SELECT *
FROM JOB;
------------------�ǽ�����---------------------------
--1. JOB���̺��� ���޸� ��ȸ�غ���
SELECT JOB_NAME
FROM JOB;
--2. DEPARTMENT ���̺��� ��� �÷� ��ȸ�غ���
SELECT *
FROM DEPARTMENT;
--3. DEPARTMENT ���̺��� �μ��ڵ�, �μ���, �� ��Þ �غ���
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;
--4. EMPLOYEE ���̺��� �����, �̸���, ��ȭ��ȣ, �Ի���, �޿� ��ȸ.
SELECT EMP_NAME,EMAIL,PHONE,SALARY
FROM EMPLOYEE;
--�̰��� ��ȸ �ϰ� �ʹ�.
-- �̰�����.   ��� ������ �����ϰ�, ���� �ɵ���!
--�÷��� �ܿ�� �����ϴ� �÷��� - ��ü �̸�? ��ȸ�ϰ���� ���� �̸�? �̴�.
/*
<�÷����� ���� �������>
SELECT �÷��� �ۼ� �κп� ��� ���� ��� ����(�̶�, ��� ����� ��� ��ȸ)

*/
--EMPLOYEE ���̺��� �����, ����� ����(SALARY * 12)��ȸ
SELECT EMP_NAME, SALARY * 12
FROM EMPLOYEE;

--EMPLOYEE ���̺��� �����, �޿�, ���ʽ� ��ȸ
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE;

--EMPLOYEE ���̺��� �����, �޿�, ���ʽ�, ����, ���ʽ����� ����(�޿� + ���ʽ� * �޿�)
SELECT EMP_NAME, SALARY, BONUS, SALARY * 12, ((SALARY + BONUS * SALARY)*12)
FROM EMPLOYEE;
--��� ���� ������, NULL ���� ������ä ����ó�� �� ���, ����� �� ������ NULL�� ����� ��������. 

--EMPLOYEE���� �����, �Ի���
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE;

-- EMPLOYEE�� �����, �Ի���, �ٹ��ϼ�(���� ��¥���� - �Ի���)
--DATE���Ŀ����� ����ó�� ����� �����ϴ�. 
-- ���ó�¥ : SYSDATE
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE
FROM EMPLOYEE;
--�츮�� ��¥���� ��¥�� ���� ��������� '��'������ �±� �ϴ�. 
-- ������, ���� �������� ���� ����, DATE������ ��/��/��/��/��/�� ������ ���Ǹ� �ϱ� ����.
--���� ���� �� ����� ������ ���� ������, �Լ��� �̿���, �Ҽ����� ���� �� �ִ�. ���߿� �������.
--
/*
<�÷��� ��Ī �����غ���>
��� ������ �ϰ� �Ǹ� �÷����� ������ ����. �̋� �÷����� ��Ī �ο��ؼ� ����ϰ� �����ش�. 
[ǥ����]
1. �÷��� ��Ī
2. �÷��� AS ��Ī
3. �÷��� "��Ī"
4. �÷��� AS "��Ī"
AS ���̵� �Ⱥ��̵� ���� �ο��ϰ��� �ϴ� ��Ī�� ���� OR Ư�����ڰ� ���Ե� ��� �ݵ�� �ֵ���ǥ("")�� ����ؾ���
*/
SELECT EMP_NAME �����, SALARY AS �޿�, SALARY * 12 "����(��)", (SALARY + SALARY* BONUS)*12 AS "�� �ҵ�(���ʽ� ����)"
FROM EMPLOYEE;
-------------------------------------------------------
/*���ͷ� - �� �� ��ü. 
���Ƿ� ������ ���ڿ�(' ')
SELECT ���� ���ͷ��� �����ϸ� ��ġ ���̺� �� �����ϴ� ������ ó�� ��ȸ ����
��ȸ�� RESULT SET�� ��� �࿡ �ݺ������� ���� ����� ������ �׷�.

*/
--EMPLOYEE ���̺��� ���, �����, �޿� ��ȸ (���ͷ� Ȱ��_
SELECT EMP_ID, EMP_NAME, SALARY, '��'
FROM EMPLOYEE;

-- ���� ������ : ||  , ���� �÷������� ��ġ �ϳ��� �÷��� ��ó�� �����ϰų�, �÷����� ���ͷ��� ������ �� ����. 
--���, �̸�, �޿��� �ϳ��� �÷����� ��ȸ�� �غ���. 
SELECT EMP_ID || EMP_NAME || SALARY 
FROM EMPLOYEE;

--�÷����̶� ���ͷ����� �����غ���
---XXX�� ������ 000�� �Դϴ�. -> �÷��� ��Ī : �޿�����
SELECT EMP_NAME || '�� ������' || SALARY ||'�Դϴ�'  AS "�޿�����"
FROM EMPLOYEE;




--���� �츮 ȸ�翡 � ������ ������� �����ϴ��� �ñ��ϴ�!
SELECT JOB_CODE
FROM EMPLOYEE; --���� ȸ�翡 23���� ������ �μ����� ��ȸ�ȴ�. 

/*��ɾ�!
DISTINCT
�÷��� �ߺ��� ������ ���� ��, �ѹ� ���� ǥ���ϰ��� �� �� ����Ѵ�. 
*/
--EMPLOYEE �����ڵ�(�ߺ�����) ��ȸ
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE; --�ߺ����ŵǼ� 23�࿡�� 7������ ����̵Ǿ���. 


--������� � �μ��� �Ҽ� ���ִ��� �ñ���
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE; --NULL : �μ������� ���� ���� ���� ���

--���ǻ��� : DISTINCT �� SELCET ���� �� �ѹ��� ��� �����ϴ�.
/*
SELECT DISTINCT JOB_CODE, DISTINCT DEPT_CODE
FROM EMPLOYEE;
*/
SELECT DISTINCT JOB_CODE, DEPT_CODE
FROM EMPLOYEE;

--(JOB_CODE, DEPT_CODE)������ ��� �ߺ� �Ǻ�
-------------------------------------------------------------------------
/*
WHERE ��
���� ��ȸ�� �ϰ��� �ϴ� ���̺�. �� �ִµ� Ư�� ���ǿ� �����ϴ� �����͸��� ��ȸ�ϰ��� �� �� ����Ѵ�. 
��) ���� '�达' �� ��ȸ �ϰڴ�. ���� '�̾�'���� ��ȸ �ϰ� �ʹ�. �ҋ� ���� ���δ�. 
���ǽĿ����� �پ��� �����ڸ� ����� �� ����. 
[ǥ����]
SELECT �÷�1, �÷�2
FROM ���̺��;    <-- �̷� ������ ���������� �ؿ���
WHERE ���ǽ�;    <---- �� �ؿ� �̷��� WHERE ���� �޾��ش�. 
[�񱳿�����]
>  ,  <  , >=  , <==        -> ��Һ�
=                           -> �����
!= ,  ^= , <>               0> �������� ������ ��

--EMPLOYEE ���� �μ��ڵ尡  'D9'�� ����鸸 ��ȸ �غ���(�̋�, ��� �÷� ��ȸ)


*/
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE ���� �μ��ڵ尡 'D1'�� ������� �����, �޿�, �μ��ڵ� �� ��ȸ
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

--EMPLOYEE ���� �μ� �ڵ尡 'D1'�� �ƴ� ������� ���, �����, �μ��ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
--WHERE DEPY_CODE !='D1';
WHERE DEPT_CODE ^='D1';

--�޿��� 400���� �̻��� ������� �����, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

--����  ��������(ENT_YN �÷� ���� 'N')�� ������� ���, �̸�, �Ի���
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN ='N';
-----------------------------------------------------------------------
--�޿��� 300���� �̻��� ��������� �����, �޿�, �Ի���, ����(���ʽ�������) ��ȸ
SELECT EMP_NAME, SALARY , HIRE_DATE, SALARY * 12
FROM EMPLOYEE
WHERE SALARY >=3000000;
-- ������ 5000������ �̻��� ������� �����, �޿�, ����, �μ��ڵ�
SELECT EMP_NAME AS "��� ��", SALARY AS "�޿�", SALARY * 12 AS "����", DEPT_CODE AS "�μ��ڵ�"
FROM EMPLOYEE
WHERE SALARY*12 >= 50000000;
--���� ���� ���� Ǯ���غ���.
--FROM - WHERE - SELECT ������ �ڵ尡 ������ �Ǵ� ���� WHERE �Ǵ� FROM ���� ��Ī���� ����� �ϸ�, ���� ��ġ�� ���� �������� ���ǵ� ��Ī�� ���� ���ظ� ���� ���� ������ ���� ���̴�. 
-- ��ġ���� : ��Ī�� �ƴ� ���ͷ� ������ ���´�. EX) SALARY * 12 �� ����.

-- �����ڵ尡 'J3' �� �ƴ� ������� ���, �����, �����ڵ�, ��翩�� ��ȸ 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, ENT_YN
FROM EMPLOYEE
WHERE JOB_CODE != 'J3';

--�μ��ڵ尡 'D9'�̸鼭 �޿��� 500���� �̻��� ��������� ���, �����, �޿�, �μ��ڵ� �� ��ȸ �غ���. 
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE (DEPT_CODE='D9' AND SALARY >= 5000000);

--�μ��ڵ尡 'D9'�̰ų� �޿��� 300���� �̻��� ������� �����, �μ��ڵ夿��, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' OR SALARY >-300000000;

--�޿��� 350���� �̻��̰� 600���� ���ϸ� �޴� ������� �����, �޿�, ���, ��ȸ
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
--WHERE 3500000<=SALARY  AND SALARY<=6000000;
WHERE SALARY>=3500000 AND SALARY <= 6000000;
-----------------------------------------------------------------------
/*
< BETWEEN A AND B >
���ǽĿ��� ���Ǵ� ����
�� �̻� �� ������ ������ ���� ������ ������ �� ���Ǵ� ������

[ǥ����]
WHERE �񱳴���÷� BETWEEN A(��) AND B(��)
 -> �ش� �÷��� ���� A�̻��̰� B������ ���
*/
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000 ;
--���� Ŀ�� ���� ���� ����� ��ȸ�ϰ� �ʹٸ�? 350�̸� + 600 ���� �ʰ��� �����
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
--WHERE SALARY < 3500000 AND SALARY > 6000000;
--WHERE NOT SALARY BETWEEN 3500000 AND 6000000;
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;
-- NOT : ������ ������
--�÷��� ���̳� �Ǵ� BETWEEN �տ� ������ �����ϴ�. 

SELECT *
FROM EMPLOYEE
--WHERE HIRE_DATE >= '90/01/01' AND HIRE+DATE <= '01/01/01'; DATE������ ��Һ� ����
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';
--------------------------------------------------------------------------------------
/*
LIKE
���ϰ��� �ϴ� �÷����� ���� ������ Ư�� ���Ͽ� ������ ��� ��ȸ
[ǥ����]
WHERE �񱳴���÷� LIKE 'Ư������'

-Ư�� ���� ���ý� '%', '_' �� ���ϵ� ī��� ����� �� ����. 
-- % : 0���� �̻�
�񱳴�� �÷� LIKE ����%    -> �񱳴�� �÷����� ���ڷ� "����"�Ǵ°� ��ȸ

EMP_NAME LIKE ��%
������
����
������
���ȿ���
������
��ȣȣ
���K�K  ->
�񱳴�� �÷� LIKE ����%  -> �񱳴�� �÷����� ���ڷ� "��"���� ���� ��ȸ

EMP_NAME LIKE %��     
����
����
����
������
�񱳴�� �÷� LIKE %����% -> �񱳴�� �÷����� ���ھյڷ� �ѷ����� ��� - ���� ���ڿ��� �� ���
������
������
������
����
��⿵��

 ' _ ' = 1����
 �񱳴�� �÷� LIKE '_����'   -> �񱳴�� �÷����� ���ھտ� ������ �ѱ��ڰ� �� ��� ��ȸ
 EMP_NAME LIKE '_����' -> �ڸ������ �����ϸ� �Ǵµ�, ���� �տ� �� �ѱ��ڸ� �� ���TRUE
 ������
 ������
 ������
 ��������   -> ����
�񱳴�� �÷� LIKE '����_'  -> �񱳴�� �÷����� ���ھտ� ������ �ѱ��ڰ� �� ��� ��ȸ
EMP_NAME LIKE'��_'
����
����
������
�񱳴�� �÷� LIKE '__����'  -> �񱳴�� �÷����� ���ھտ� ������ �� ���ڰ� �� ��� ��ȸ

�񱳴�� �÷� LIKE '_����_'  -> �񱳴�� �÷����� ���ھտ� ������ �� ���ڰ� �� ��� ��ȸ
EMP_NAME LIKE '_��_'      --> �񱳴�� �÷����� ���� �հ� �ڿ� ������ �� ���ھ� �� ��� ��ȸ.
������
�嵿��
������
�ε�   <--- �ȵ� 

*/

-- ����� �߿� ���� ������ ��d���� �����, �޿�, �Ի��� ��ȸ
SELECT EMP_NAME, SALARY , HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';  --����, ������, ������ �� ���� ������ Ư���� �� �������� '_'(�����) ���ٴ� %(�ۼ�Ʈ) �� ������ ����.  

--�̸��߿� �ϰ� ���Ե� ������� �����, �ֹι�ȣ, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%'; -- ���ϸ�, ������, ����  �� ���� ���忭�� �� �� ���Ե� �͵��� ���� ��ȸ�Ѵ�. 

--DLFMADML RKDNSEP RMFWKRK GKDLS TKDNJSEMFAKS WHGHL TKDNJSAUD, WJSGHKQJSGH
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_��_';   <--- 3���ڿ� ���ؼ� ����� '��' �� ���忭�� ��ȸ�ϱ�.

--��ȭ��ȣ�� 3���� �ڸ��� 1�� ������� ���, �����, ����, �̸��� ��ȸ�غ���
--���ϵ� ī�� : '_'(�����)(1����) , '%'(�ۼ�Ʈ)(0����)

SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '__0%';   <--- ���ϵ� ī�尡 ���� ��) XX0 ���� �����ϰ� �ڿ� ���ڰ� ������ ������ ���� ID, NAME, PHONE, MAIL�� ��ȸ�ϰ�ʹ�~ ��� ��

-- ** Ư�����̽�
--�̸��� �� _(�����)�� �������� �ձ��ڰ� 3������ ������� ���, �̸�, �̸��� ��ȸ
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___%';  <--- ���ϰ� �ִ� ��� ���� �Ұ���. <-- ����ٰ� 4��, �ۼ�Ʈ�� �ϳ��̱� ������ 4���� �̻��� ���忭 ���� ��ȸ;�� �ؼ��� �ȴ�.
--���ϵ� ī��� ����� �ǰ��ִ� ����ٿ� ���忭�� �������� �ϰ� ���� ����ٰ� �����ϱ� ������ ��ȸ�� �Ұ����ϴ�. 
-- ��� �͵��� ī��� ��� ������ ������ �����ؾߵ�
--������ ������ ����ϰ��� �ϴ� �� �տ� ������ ���ϵ� ī�带 �����ϰ�, ������ ���ϵ� ī�带 ESCAPE OPTION ���� ��� �ؾ��Ѵ�. 

-- '___$����%' ESCAPE'$'  <-- ������ ���ϵ�ī�带 $�� ���� �߰�, �� ���ϵ� ī�� ���� ���ڴ� �������̴�. 
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '__$_%' ESCAPE '$'; -- ������ ������ ����ϰ��� �ϴ� �� ���� ������ ���ϵ� ī�带 �����ϰ� 

--���� ������� �ƴ� �׿��� ����� ��ȸ
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EAMIL NOT LIE '___$_%' ESCAPE'$'
-----------------------------------------------------------------------------------------------------------
--1. EMPLOYEE���� �̸���'��'���� ������ ������� ����� , �Ի��� ��ȸ �غ���
SELECT EMP_NAME, SALARY , HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';
--2. EMPLOYEE ���� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ������� �����, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';
--3. EMPLOYEE���� �̸��� '��'�� ���� �Ǿ� �ְ� �޿��� 240���� �̻��� ������� ����� , �޿� ��ȸ
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%' AND SALARY >= 2400000;
--4. DEPARTMENT ���� �ؿܿ������� �μ����� �μ��ڵ�, �μ��� ��ȸ
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE'�ؿܿ���%';

/*
    <IS NULL / IS NOT NULL >
*/
--���ʽ��� ���� �ʴ� ��� (BONUS �� ���� NULL) ���� ���, �̸�, �޿�, ���ʽ� ��ȸ�ϱ�
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
--WHERE BONUS = NULL; ����Ŭ������ = NULL �̶�� ������ Ȱ����� ���Ѵ�. 
--WHERE BONUS IS NULL; ��� ����� �ؾ� ���������� ��ȸ�� �ȴ�. 
WHERE BONUS IS NOT NULL; --�̶�� �ϸ�, NULL�� �ƴ� ��츦 ��ȸ�Ѵ�. not�� �÷��� �Ǵ� is �ڿ��� ��� �����ϴ�.

--����� ���� ���(MANAGER_ID)���� �����, ������, �μ��ڵ� ��ȸ
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE;
WHERE MANAGER_ID IS NULL;

--�μ���ġ�� ���� ���� ��������, ���ʽ��� �޴� ������� �̸�, ���ʽ�, �μ��ڵ� ��ȸ
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE;
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

--������ �߿��� IN �̶� �δ� �ְ� �ִ�. 
/*
  < IN >
    �񱳴�� �÷����� ���� ������ ����߿� ��ġ�ϴ� ���� �ִ���
    
    [ǥ����]
    WHERE �񱳴���÷� IN('��1','��2','��3', ...)

*/
--�μ��ڵ尡 D6�̰ų� D8�̰ų� D5�� �μ������� �̸�, �μ��ڵ�, �޿� ��ȸ�غ���
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
--WHERE DEPT_CODE='D6' OR DEPT_CODE='D8' OR DEPT_CODE = 'D5';
WHERE DEPT_CODE IN('D6','D8','D5');


--���� �ڵ尡 J7�̰ų� J2�� ����� �� �޿��� 200���� �̻��� ������Ǹ�� �÷� ��ȸ.
SELECT *
FROM EMPLOYEE
WHERE JOB_CODE= 'J7' OR JOB_CODE = 'J2' AND SALARY >=2000000;
-----------------------------------------------------------------------------
--1. ����� ���� ��ó��ġ�� ���� ���� �����(�����, ������, �μ��ڵ�) ��ȸ
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;
--2. ����(���ʽ�������)�� 3000���� �̻��̰�, ���ʽ��� ���� �ʴ� ���������ȸ(���, �����, �޿� ����)
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE SALARY*12>=30000000 AND BONUS IS NULL;
--3. �Ի����� 95/01.01 �̻��̰�, �μ�ä�� ����������� ������� (���, �����, �Ի���, �μ��ڵ�)��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL AND HIRE_DATE>= '95.01.01';
--4. �޿��� 200���� �̻� 500���� �̰�, �Ի����� '01/01/01' �̻��̰� ���ʽ��� ���� ���� ������� ��� ����� �޿��� �Ի��� ���ʽ� )��ȸ
SELECT EMP_ID, EMP_NAME, SALARY , HIRE_DATE, BONUS 
FROM EMPLOYEE
WHRER SALARY BETWEEN 2000000 AND 5000000 AND HIRE_DATE > '01.01.01' AND BONUS IS NULL;
--5. ���ʽ� ���� ������ NULL�� �ƴϰ� �̸���  �� �� ���ԵǾ� �ִ� ������� ��� ����� �޿� ���ʽ� ��ȸ ��Ī�ο���
SELECT EMP_ID, EMP_SAME, SALARY, (BONUS + BONUS * SALARY)*12
FROM EMPLOYEE
WHERE BONUS IS NOT NULL AND EMP_NAME '%��%' AND;
 --
 --
 /*
 ORDER BY ��
���� �������ٿ� �ۼ� �Ӹ� �ƴ϶� ������� ���� �������� ����
[ǥ����]
SELECT��ȸ�ϰ��� �ϴ� �÷� ��, �����, ��Ī
FROM��ȸ�ϰ��� �ϴ� ���̺��
WHERE���ǽ�
ORDER BY �����ϰ� ���� �÷�, ��Ī ��� ����, �÷� ���� [ASC|DES] [NULLS FIRST] [NULLS LAST]
-ASC : �������� ���� (������ �⺻��)- (�Ƚᵵ �⺻������ ORACLE�� ���������̴�. )
-DESC: �������� ����
-NULLS FIRST : �����ϰ��� �ϴ� �÷� ���� NULL�� �ִ� ��� �ش� �����͸� �� �� ��ġ.
-NULLS LAST : �����ϰ��� �ϴ� �÷� ���� NULL�� ���� ��� �ش� �����͸� �� �� ��ġ.
 */


SELECT *
FROM EMPLOYEE
--ORDER BY BONUS;  -- ���� ORDER BY �� �ƹ����ľ �����ϰ� ���� ������, ���������� �⺻���� �Ǿ��ִ�. 
--ORDER BY BONUS ASC ; -- ���� ASC�� �����µ� �⺻������ NULLS LAST�� �⺻������ �Ǿ��ִ�. 
--ORDER BY BONUS DESC; -- ���� DESC�� �����µ�,�⺻������ NULLS FIRST �� �⺻������ �Ǿ��ִ�. 
ORDER BY BONUS DESC, SALARY ASC; --���� ���� ������ ���� ����(ù ���� ������ �÷����� ������ ��� �ι��� ���� �÷� ������ ���� �Ѵ�.)

-- �� ����� �����, ���� ��ȸ�ϰ� �ʹ�. (�̋� ������ �������� ������ȸ)
SELECT EMP_NAME, SALARY*12 AS "����"
FROM EMPLOYEE
--ORDER BY ���� DESC; --��Ī ����� �����ϴ�. 
ORDER BY 2 DESC; -- �÷� ���� ��� ����. (SELECT ���� 2���� �־��� �÷� ȣ��)
























