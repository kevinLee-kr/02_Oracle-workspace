--q���� �غ��Ҷ� ���� ���� ����.

--rownum��Ȱ���ؼ� �޿��� ���� ���� 5���� ��ȸ�ϰ� �;���. ����
--�̋� �ۼ��� SQL���� �Ʒ��� ����
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;
--������ �����ϱ�?
--���� : ���� ������ ����, 5���� �̹� ��ȸ�ǰ� , �� �ȿ��� ������ �Ǿ��� ����.
--��ġ�� ���� : 
SELECT * 
FROM EMPLOYEE
ORDER BY SALARY DESC;

SELECT ROWNUM, EMP_NAME,SALARY FROM ( 
            SELECT * 
            FROM EMPLOYEE
            ORDER BY SALARY DESC)
WHERE ROWNUM <=5; --���ϴ� ������� ������� �����͸� FROM���� �ְ�, �� �ȿ��� ���� 5���� ��ȸ�Ѵ�.
---------------------------------
--�μ��� ��ձ޿��� 2270������ �ʰ��ϴ� �μ��鿡 ����(�μ��ڵ�, �μ��� �� �޿���, �μ��� ��ձ޿�, �μ��� �����)��ȸ�غ���.
--�̶� �ۼ��� SQL���� ������ ����
SELECT DEPT_CODE �μ��ڵ�, SUM(SALARY) ���� , FLOOR(AVG(SALARY)) ���, COUNT(*)�ο���
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;
--���� �߻���, ������ �����ΰ�? 
--���� : ���� 1���� ���� �����̴�. ���� �۵� ������ ���� ��ȸ ���� �޶��� ���� ���� �� ���̴�. 
--���� : 2. ����, ���ϴ� ������� ���� ���ǽĹ��� �߸��Ǿ���.
---��ġ���� : 
SELECT DEPT_CODE �μ��ڵ�, SUM(SALARY) ���� , FLOOR(AVG(SALARY)) ���, COUNT(*)�ο���
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) > 2700000
ORDER BY DEPT_CODE;
----------------------------------------------------------------
--������ �޿� ��ȸ�� �� ���޺��� �λ��ؼ� ��ȸ
--J7�� ����� �޿��� 10%�λ�
--J6�� ����� �޿��� 15% �λ�
--J5�� ����� �޿��� 20% �λ�
--�� ���� ����� ���޿��� 5% �λ�.

SELECT EMP_NAME,JOB_CODE , 
    DECODE(JOB_CODE, 'J7',SALARY *1.1,
                     'J6',SALARY *1.15,
                     'J5',SALARY*1.2,
                     SALARY * 1.05 )AS "�λ�� �޿�"
FROM EMPLOYEE;
-------------------
--'25/01/05 '�� ���� ���ڿ��� ������ '2025-01-06'���� ǥ���غ���.
--TO_DATE('���ڿ�',[����]) : DATE
--TO_CHAR(��¥ OR ����,[����]) : CHAR
SELECT TO_CHAR(TO_DATE('25/01/05'),'YYYY-MM-DD')
FROM DUAL;

------'240106'�� ���� ���ڿ��� ������ 2024�� 1�� 16�� ǥ���غ���.���信 ���� �����غ���.
SELECT TO_CHAR(SYSDATE,'DL')
FROM DUAL;

SELECT TO_CHAR(TO_DATE('240106'),'DL')
FROM DUAL;

SELECT TO_CHAR(TO_DATE('240106'),'YYYY"��" FMMM"��" DD"��"') AS ��¥
FROM DUAL;

SELECT TO_CHAR(TO_DATE('240106'),'YYYY"��" FMMM"��" DD"��"') AS ��¥
FROM DUAL;


