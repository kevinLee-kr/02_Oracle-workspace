
1. GROUP BY ��
�׷� ������ ������ �� �ִ� ���̴�. 
�������� ������ �ϳ��� �׷����� ��� ó���� �������� ���ȴ�.

SELECT SUM(SALARY)
FROM EMPLOEE; 
-> ��ü ����� �ϳ��� �׷����� ��� ������ ���� ���. 
-> �׷� �Լ�. 

-- �� �μ��� �� �޿���
--���̵� **��, **�� �ϸ�, �׷��Լ��� ���� �ȴ�. 

SELECT DEPT_CODE ,SUM(SALARY) 
FROM EMPLOYEE
GROUP BY DEPT_CODE  ;
--�ؼ� : DEPT_CODE �׷캰�� ���� ���� ���̴�~ ��� ���Ľ�

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

--�� �μ��� �����
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

�ܿ��� �Ұ�. ����� �׷��Լ��̰�, � ���� �����Լ����� �˾ƾ� �ϴµ�, GROUP BY ���� ����. 
SELECT DEPT_CODE, COUNT(*), SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;
ORDER BY DEPT_CODE;

--�����ڵ庰�� �� �ο���, �޿���
SELECT  JOB_CODE
FROM EMPLOYEE
GROUP BY JOB_CODE;

--�� ���޺� �� �����, ���ʽ��� �޴� �����, �޿���, ��ձ޿�, ��������, �ִ�޿�, 
SELECT DEPT_CODE, COUNT(*)AS"�� �����", COUNT(BONUS) AS "���ʽ��� �޴� �����",
        SUM(SALARY) AS"�޿���", FLOOR(AVG(SALARY))AS "��ձ޿�",
        MIN(SALARY) AS"�����޿�", MAX(SALARY)AS"�ִ�޿�"
FROM EMPLOYEE
GROUP DEPT_CODE;
ORDER BY 1;


-- GROUP BYU ���� �Լ��� ��� ����!
SELECT DECODE(SUBSTR(EMP_NO,8,1),1,'����',2,'����')AS "����", COUNT(*)
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1);

--GROUP BY ���� ���� �÷� ��� �����ϴ�. 
SELECT DEPT_CODE, JOB_CODE, COUNT(*), SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE;

/*
HAVING ��
�׷쿡 ���� ������ ������ ���� ������ ����ϴ� ����. (�ַ� �׷��Լ����� ������ ������ ������ �� ����Ѵ�. )

*/
--�� �μ��� ��� �޿� ��ȸ
SELECT DEPT_CODE AS"�μ�", AVG(SALARY)AS"��ձ޿� ��ȸ"
FROM EMPLOYEE
GROUP BY DEPT_CODE;

--�μ����� ��� �޿��� 300���� �̻��� �μ��鸸 ��ȸ. 
SELECT DEPT_CODE 
FROM EMPLOYEE
WHERE AVG(SALARY) >=30000000  -- WHERE ������ ���������� �׷��Լ��� ����ϸ� �ȵȴ�. ������ ������ �߻��Ѵ�. 
GROUP BY DEPT_CODE;

--��� HAVING ���� ����ϸ� �ȴ�. 
SELECT DEPT_CODE 
FROM EMPLOYEE
HAVING AVG(SALARY) >=3000000  --WHERE ��� HAVING �� ����ߴ�. ��ġ�� GROUP BY ���� ���� �ֵ���, �Ʒ� �ֵ��� �������. 
GROUP BY DEPT_CODE;

--�μ��� ���ʽ��� �޴� ����� ���� �μ����� ��ȸ
SELECT DEPT_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS)=0;
----------------------------------------------------------------------------------------------------------------------------
/*
SELECT�� ���� ����. 
5. SELECT * |��ȸ�ϰ��� �ϴ� �÷� | ����� | �Լ���
1. FROM ��ȸ�ϰ��� �ϴ� ���̺��
2. WHERE ���ǽ� (�����ڵ� ������ ���)
3. GROUP BY �׷������ ���� �÷� | �Լ���
4. HAVING ���ǽ� (�׷��Լ��� ������ ����Ѵ�.
6. ORDER BY �÷��� 
*/
-------------------------
/*
�����Լ�
�׷캰 ����� ������� �߰����踦 ��� ���ִ��Լ�. 
ROLL UP -> GORUP BY���� ����ϴ� �Լ�. 
*/
--���޺��� �޿����� ����ʹ�. 
SELECT JOB_CODE , SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE);
--ROLLUP. 7���� JOB_CODE�� ���� ���´�. �׸��� ������ 8������ NULL�� JOB_CODE�� ������, ��� SUM���� ���� �� �ؿ� �������ش�. 
--ROLLUP �� �Ѱ��� ���� ���µ�
--���� �ΰ��� ���� ���ٸ�, ���ǹ��� �޸��Ŵ�. 
--�ΰ��� ���� �ش��ϴ� ������ ���� ���ϰ� �� �ؿ� ��� �ϰ� �� ��? �̴�. 
-------------------------------------------------------------------
/*
���� ������ SET OPERATION
�������� �������� ������ �ϳ��� ���������� ����� ������. 
- UNION         : OR (������):������ �� ������ ������� ���� �� �ߺ��Ǵ� ���� �ѹ��� ����������. 
- INTERSECT     : AND(������):�������� ������ ������� �ߺ��� ���. 
- UNION ALL     : ������+������ (�ߺ��Ǵ� ���κ��� �� �� ǥ���� �� ����.)
- MINUS         : ���� ��������� ���� ������� �A ������(������)

�������� : �� ��������SELECT ���� �ۼ��� �ִ� �÷� ������ ������ ���� �ؾ� �Ѵ�. 
����, �÷� ���� �Ӹ� �ƴ϶�, �� �÷� �ڸ����� ������ Ÿ������ ����ؾ���. (����, Ÿ��, ����) ���� �߿���.  
*/
--1. UNION
--�μ��ڵ尡  D5�� ��� �Ǵ� �޿��� 300���� �ʰ��� ����� ��ȸ�ϰ�ʹ�. ���, �̸� �μ��ڵ� �޿�
SELECT   EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5';

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >3000000;

SELECT   EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5'
UNION 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >3000000;---------------------------------������ ���ǵ��� �ϳ��� ������Ű�� ������ ��������, �ߺ����� �ϳ��� ���´�. 


SELECT   EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5' OR SALARY>3000000; --UNION

--2.INTERSECT(������)
--�μ��ڵ尡 D5�̸鼭 �޿������� 300���� �ʰ��� ��� ��ȸ.
SELECT   EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5'
INTERSECT 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >3000000;----------------------------------������ ���ǵ��� �Ѵ� ���� ��Ű�� ������ ���´�. 

SELECT   EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5' AND SALARY>3000000; --UNION

--ORDERBY ���� ���̰��� �Ѵٸ� �������� ����ؾߵ�.
--------------------------------------------------------------------------------------------------
--3. UNION ALL : �������� ���� ��� ������ �� �� �ϴ� ������(�ߺ��� �� ����)
SELECT   EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >3000000;
------------------------------------------------------------
--4. MINUS : ���� SELECT������� ���� SELECT ����� �� ������(������)
--�μ��ڵ尡 D5�� ����� �� �޿��� 300���� �ʰ��� ������� �����ؼ� ��ȸ
SELECT   EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >3000000;

SELECT   EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5' AND SALARY <=3000000; --UNION






