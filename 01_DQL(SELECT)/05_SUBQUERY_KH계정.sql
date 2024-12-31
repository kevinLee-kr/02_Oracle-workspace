--�����
/*
�������� ( SUBQUERY)
- �ϳ��� SQL�� �ȿ� ���Ե� �� �ٸ� SELECT ��
- ���� SQL���� ���� ���� �������� �ϴ� �������̴�. 
*/
--���ö ����� ���� �μ��� ���� ����� ��ȸ�ϰ� �ʹ�. 
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '���ö'; --D9�ΰ� �˾Ƴ´�.

--�μ��ڵ尡 D9�� ����� ��ȸ�غ���
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE='D9';

--���� 2���� �ܰ踦 �ϳ��� ����������!
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE=(
                SELECT DEPT_CODE
                FROM EMPLOYEE
WHERE EMP_NAME = '���ö'
);
--��....��..
--�� ������ ��� �޿����� �� ���� �޿��� �޴� ������� ���, �̸�, ���ޤǵ�, �޿� ��ȸ
--1) �� ������ ��� �޿� ��ȸ
SELECT AVG(SALARY)
FROM EMPLOYEE ;--3047662

--2)�޿��� 2040000�̻��� ����� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 2047330;

--����  �� �ܰ踦 �ϳ��� ���������� �ٲ㺸�� �ʹ�. 
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (   SELECT AVG(SALARY)
                    FROM EMPLOYEE --3047662
);


/*
���������� ����
���������� ������ ������� �� �� �� ���̳Ŀ� ���� �з��ȴ�. 
- ������ �������� : ���������� ��ȸ ������� ������ ������ 1���� ��.(���� �� ��)
- ������ �������� : ���������� ��ȸ ������� ������ �϶� (������ �� ��) -> �������� ���ö 2���� ��. ���ȴ�. 
- ���߿� �������� : ����︮�� ��ȸ ������� �� �� �������� �ø��� ������ �ϋ�(���� ���� ��)
- ���߿� ������ �������� : ����︮�� ��ȸ ���� ���� �� ���� �÷��� ��(����� ������)

���������� ������ ���Ŀ� ���� �������� �տ� �ٴ� �����ڰ� �޶����⿡ � ����������� ����� ������ �˾ƾ� �Ѵ�. 
1. ������ ��������(SINGLE ROW SUBQUERY)
���������� ��ȸ ������� ������ ������ 1���϶�, (���� �� ��)
�Ϲ� �� ������ ��� �����ϴ�. 
=  , !=  , ^=,  >  , <  , <=,   ...


�� ������ ��� 
���� �޿��� �� ���� �޴� ������� �����, �����ڵ�, �޿� ��ȸ�� �غ���. 
*/
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT AVG(SALARY)
                FROM EMPLOYEE);

--����2)�����ݿ��� �޴� ����� ���, �̸�, �޿�, �Խ���
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
--WHERE SALARY = �������� �޿��� �����ݿ�
WHERE SALARY = (SELECT MIN(SALARY)
                FROM EMPLOYEE);

--����3)���ö ����� �޿����� �� ���� �޴� ������� ���, �̸�, �μ��ڵ�, �޿� ��ȸ�ϱ�
SELECT EMP_ID, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME = '���ö');
--JOIN, ����Ŭ �����뱸��,
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND SALARY > (  SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME ='���ö');


--ANSI ����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE SALARY > (SELECT  SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME = '���ö');
                
--4. �μ��� �޿����� ���� ū �μ��� �μ��ڵ�, �޿� �� ��ȸ
--4. ���� �μ��� �޿��� �߿����� ���� ū �� �ϳ��� ��ȸ
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

--4_2) �μ��� �޿��հ谡 1700000�� �� �μ� ��ȸ
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (  SELECT DEPT_CODE,MAX(SARALY)
                        FROM EMPLOYEE
                        GROUP BY DEPT_CODE);

--����� ����� ���� �μ������� ���, �����, ��ȭ��ȣ, �Ի���, �μ���
--��, �������� ����

--����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE,DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND DEPT_CODE = (SELECT DEPT_CODE
                FROM EMPLOYEE
                WHERE EMP_NAME='������')
AND EMP_NAME != '������';

--ANSI ���� ����.  ������ ���� ����
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE,DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_ID = DEPT_CODE)
WHERE DEPT_CODE = (SELECT DEPT_CODE
                FROM EMPLOYEE
                WHERE EMP_NAME='������')
AND EMP_NAME != '������';

/*
2. ������ ��������(MULTI ROW SUBQUERY)
���������� ������ ������� ���� ���ϋ� (�÷��� �Ѱ�!!!!!1)
�������ϋ��� �� �����ڰ� �Ծ��µ�
�������ϋ��� �񱳿����ڰ� �� �� �� ����. 
 -IN ���� ���� : �������� ����� �߿��� �Ѱ��� ��ġ�ϴ� ���� �ִٸ�~
 - >  ANY �������� : �������� �ܷΰ��� �߿��� �Ѱ��� Ŭ ���. ?(�������� ����� �߿��� ���� ���� ������ Ŭ���)
 - < ANY �������� : �������� ����� �߿��� "�Ѱ���"���� ���(�������� ����� �߿��� ���� ū ������ �������)
 
 �񱳴���� ������ >ANY �� ������( ��, ��2, ��3) �� ������ 
 �񱳴���� ��1 ���� ũ�ų�, 
 �񱳴���� ��2 ���� ũ�ų�
 �񱳴���� ��3 ���� ũ��! ��� ���̴�. 
 
 �ٵ� > ALL ����������� ���� ��찡 �Ӥ���
 < ALL ����������� ���� ��찡 �ִµ�
 
 > ALL �� �������� "��� "����� ���� Ŭ��쿡 ���̰�
 < ALL �� �������� ��� �ܷΰ����� ���� ���� ��� �� ����� �ȴ�. 
 ���� ��� �񱳴���� �������, 
 �� �񱳴�󺸴� > ALL (��1, ��2, ��3)�̶�� ���� �ִٸ� 
 �� �񱳴���� ��1, ��2, ��3 ���� ���� ���� Ŀ�߸� �Ѵ�~ ��� ���̴�. 
 
 ������ ���ؼ� ���ظ� �غ���. 
 
 
 */
-- 1) ����� �Ǵ� ������ ����� ���� ������ ������� ���, �����, �����ڵ�, �޿� ��ȸ�غ���. 
--1-1) ����� �Ǵ� ������ ������ � �������� ���� ��ȸ�� �ؾ��Ѵ�. - 'J3','J7'�̶�� ���� �˾Ƴ´�. (������ ����������°� �˾Ƴ´�. ) 
SELECT JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME IN('�����','������');

--1_2) J3, J7�� ������ ����� ��ȸ�ϸ� �ǰڳ�? 
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN('J3','J7');
-- 1-1�� ���ؼ� ���� �ڵ带 �˾Ƴ¾���, 1-2�� ���ؼ� ��ȸ�ϴ� ���� �� ������, �̰͵��� ���ĺ���!
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN( 
                    SELECT JOB_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME IN('�����','������')
                    );
--������ ������������ �ռ� ���ߵ�, ���� �񱳰� �ƴ�, IN�� ���� ����ؾ߸� ������ ���� �� �ִ�. 
--������ ���������� ��ȸ�� �Ǳ� �����̴�. 


--�츮�� ȸ�翡 ���� ������� ������ �������� �ȴ�. 4������ ������, �븮�� �ɰŰ� �ð��� ���� ����, ����, ������ �ɰ� �̴�. 
-- 2) �븮 ���޿��� �ұ��ϰ� ���� ���� �޿��� �� �ּ� �޿����� ���� �޴� ������ ��ȸ�غ���. 
--���, �̸�, ����, �޿�
--������� ���� �󸶳� �޴��� �ľ��� �ϰ�, �븮 �޿��� Ȯ�� �ϰ� ���ؾ��Ѵ�. 

SELECT SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND JOB_NAME = '����';-- 2200000, 2500000, 3760000 ���� �޿��� �˾Ƴ´�. 

--2-2)������ �븮�̸鼭 �޿����� ���� ��ϵ� �� �߿� �ϳ��� ū ���.
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME ='�븮'
AND (SALARY > 2200000 OR SALARY > 2500000 OR SALARY > 3760000);

--���� �� �ܰ踦 �ϳ��� ���������� �ۼ��غ���. 
--������ ���������ε� ����
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME ='�븮'
AND SALARY > ANY (
                    SELECT SALARY
                    FROM EMPLOYEE E, JOB J
                    WHERE E.JOB_CODE = J.JOB_CODE
                    AND JOB_NAME = '����');

--3) ���� ���޿��� �ұ��ϰ� ���������λ������ ��� �޿����ٵ� �� ���� �޴� ������� ���, �����, ���޸�, �޿�
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME='����'
AND SALARY > ALL(SELECT SALARY
                FROM EMPLOYEE
                JOIN JOB USING(JOB_CODE)
                WHERE JOB_NAME = '����'  );



--------------------------------------------------------
/*
���߿� ��������
��� ��ü�� �� ��������, ������ �÷����� �������� ��찡 �ִ�. 
*/
--1) ����������� ���� �μ��ڵ�, ���� �����ڵ忡 �ش��ϴ� ����� ��ȸ�ϰ� �ʹ�. (�����,�μ��ڵ�, �����ڵ�, �Ի���)
-->>������ ���������ε� �������ϴ�!

SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '������') 
AND JOB_CODE = (SELECT JOB_CODE
                FROM EMPLOYEE
                WHERE JOB_CODE = '������');

SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE
                                FROM EMPLOYEE
                                WHERE EMP_NAME='������');  -- ���� ��� �߿�, ������ ����� �� ������, �ٸ��� ���� �ȳ����ų�, �ٸ� ���� �ٿ´�. 
                                


-- �ڳ��� ����� ���� �����ڵ�, ���� ����� ������ �ִ� ������� �纯, ����� �����ڵ� , ��� ��ȣ ��ȸ

SELECT EMP_ID ,EMP_NAME, JOB_CODE,  MANAGER_ID
FROM EMPLOYEE 
WHERE (JOB_CODE, MANAGER_ID) = (SELECT JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE EMP_NAME = '�ڳ���');

--�� ���ݱ��� ���������� 3���� ���Ұ�, ������ ���������� ������ڲٳ�
/*
4. ������ ���߿� ��������
�������� ��ȸ ������� ������ �������� ���. 

�̷��Ŵ� ���� ��� �̷�����

*/
-- 1) �� ���޺�  (~ �� ~ �� �ϸ� ������ GROUP BY �� ��� �Ѵٴ� �Ŵ�. )
--1) �� ���޺� �ּұ޿��� �޴� ��� ��ȸ(���, �����, �����ڵ�, �޿�)
-->> �� ���޺� �ּ� �޿� ��ȸ�� ���� �ؾ���.

SELECT JOB_CODE , MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

/*
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J2' AND SALARY = 3700000
    OR JOB_CODE='J7' AND SALARY = 1380000
    ...; �� �� �� �ִ�. ������ �̷��� �Ǹ� ���� �����Ͱ� �鸸�� �Ǹ�, ȿ���� ���� �ʴ�. 
*/

--���������� Ȱ���غ���!
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE,SALARY) IN ( SELECT JOB_CODE , MIN(SALARY)
                                FROM EMPLOYEE
                                GROUP BY JOB_CODE);
--2) �� �μ��� �ְ�޿��� �޴� ������� ���, �����, �μ��ڵ�, �޿�

SELECT SALARY
FROM EMPLOYEE
GROUP BY SALARY; 

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE, SALARY) IN (SELECT DEPT_CODE, MAX(SALARY)
                                FROM EMPLOYEE
                                GROUP BY DEPT_CODE); 
-- ������ ��, WHERE (DEPT_CODE, SALARY) IN (SELECT DEPT_CODE, MAX(SALARY)
--���� WHERE ���̶� IN ������ �񱳰����� ���� �ؾ� �Ѵ�. 

-------------------------------------------------------
/*
�ζ��� ��(INLINE-VIEW)

���������� ������ ����� ��ġ ���̺�ó�� ��밡���� ��.
*/
--������� ���, �̸�, ���ʽ� ���� ����(��Ī �ο�:����), �μ��ڵ� ��ȸ
--��, ���ʽ� ���� ������ 3000���� �̻��� ����鸸 ��ȸ.

SELECT EMP_ID, EMP_NAME, (SALARY + SALARY * NVL(BONUS,0))*12 AS "����", DEPT_CODE
FROM EMPLOYEE
WHERE (SALARY + SALARY * NVL(BONUS,0))*12 > = 30000000; --WHERE ���� �ٷ� ��Ī ��� �Ұ��ϴ�. 

SELECT EMP_ID, EMP_NAME, (SALARY + SALARY * NVL(BONUS,0))*12 AS "����", DEPT_CODE
FROM EMPLOYEE;
-- �̰� ��ġ �����ϴ� ���̺��ΰ� ó�� ����� �� ����!! �װ��� �ٷ� �ζ��κ� ~ 
---�ζ��� ��~
SELECT *
FROM (SELECT EMP_ID, EMP_NAME, (SALARY + SALARY * NVL(BONUS,0))*12 AS "����", DEPT_CODE
FROM EMPLOYEE)
WHERE ���� > = 30000000;

--�ζ��� �� ���ϴ� �� ��ȸ�غ���
SELECT EMP_NAME, DEPT_CODE, ����
FROM (SELECT EMP_ID, EMP_NAME, (SALARY + SALARY * NVL(BONUS,0))*12 AS "����", DEPT_CODE
FROM EMPLOYEE)
WHERE ���� > = 30000000;
--����ϴ� ���� �ִ�. 
--N�м�(���� ��� �����ְ� ������)
--TOP-N �м��� �Ҷ� ������ �ζ��κ並 ����Ѵ�. 
--�� ���� �� �޿��� ���� ���� ���� 5�� ��ȸ�ϱ� . 
--����Ŭ���� �������ִ� ���� �÷� : ROWNUM.
--��ȸ�� ������� 1���� ������ �ο����ִ� �÷�. 
--������� ������ ����� �� �Ǿ��, ���� �̻��ϴ�. 
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;
-- FROM 0> SELECT ROWNUM (�̶� ������ �ο��� �Ǵµ� ������ �ϱ⵵���� �̹� ������ �ο��ȴ�. )
-- �̷��� ¥�� �Ǹ� �������� ��ȸ�� ���� �ʽ��ϴ�.
--������ �Ǳ⵵ ���� 5���� �߷����� ���� ���ĵȴ�. 

--ORDER BY ���� �� ����� ����� ������ ROWNUM �ο� �� 5���߷�����.
SELECT
FROM (������ �̹� �� ������);


SELECT ROWNUM, E.*
FROM(SELECT EMP_NAME, SALARY, DEPT_CODE
            FROM EMPLOYEE
             ORDER BY SALARY DESC) E
WHERE ROWNUM<=5;

--���������� FROM �� �ȿ� ����� �Ǹ� , �ζ��� �� ��� �Ѵ�. 



----------------------------------------------------------
--���� �ֱٿ� �Ի��� ��� 5�� ��ȸ.(�����, �޿�, �Ի���)
--�� ����� �Ի��� ��¥ ��ȸ
SELECT ROWNUM,EMP_NAME, HIRE_DATE
FROM EMPLOYEE
ORDER BY HIRE_DATE DESC;

SELECT E.*
FROM (SELECT ROWNUM,EMP_NAME, HIRE_DATE
                    FROM EMPLOYEE
                    ORDER BY HIRE_DATE DESC) E
WHERE ROWNUM <=5;
--�� �μ��� ��ձ޿��� ���� 3���Ǻμ��� ��ȸ.


SELECT ROWNUM, E.*
FROM (SELECT DEPT_CODE, TRUNC(AVG(SALARY),1)
        FROM EMPLOYEE
        GROUP BY DEPT_CODE
        ORDER BY AVG(SALARY)DESC) E
WHERE ROWNUM<=3;

----------------------------������ �ű�� �Լ�--------------------------
/*

window FUNCTION - SQLD �ܰ� ����
1. RANK() OVER(���ı���)    
 - ������ ���� ������ ����� ������ �ο��� ��ŭ �ǳʶٰ� �������
    EX)���� 1���� 2���̸� �� ���� ������ 3��. (1�� 1�� 3�� 3�� 5�� 6�� 6�� 8��.)
2. DENSE_RANK() OVER(���ı���)
    EX)���� 1���� 2���̰� �� ���� ������ 2��. (1�� 1�� 2�� 3�� 3�� 4�� 4�� 5��.)
        ������ ������ �־, �� ���� ����� 1�� ������Ŵ.
�� �Լ��� ������ SELECT �������� ��밡�� �ϴ�. 
*/
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) AS "����"
FROM EMPLOYEE;
--RANK() OVER(���ı���)       --���� 19�� 2�� �� ���� ������ 21 -> ������ ������ ��ȸ�� ����� ����.

SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) AS "����"
FROM EMPLOYEE;
--DENSE_RANK() OVER(���ı���) --���� 19�� 2�� �� ���� ������ 20��.

SELECT *
FROM(   SELECT EMP_NAME, SALARY, 
        DENSE_RANK() OVER(ORDER BY SALARY DESC) AS "����"
        FROM EMPLOYEE)
WHERE ���� <=5; 











