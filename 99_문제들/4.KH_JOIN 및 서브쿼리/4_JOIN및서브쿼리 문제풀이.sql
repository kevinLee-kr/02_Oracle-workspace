--1. 70��� ��(1970~1979) �� �����̸鼭 ������ ����� �̸��� �ֹι�ȣ, �μ� ��, ���� ��ȸ
SELECT EMP_NAME AS "�̸�", EMP_NO AS "�ֹι�ȣ", DEPT_TITLE AS "�μ� ��", JOB_NAME AS "������ȸ"
FROM EMPLOYEE E
JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
JOIN JOB USING(JOB_CODE)
WHERE SUBSTR(EMP_NO,1,2) BETWEEN 70 AND 79
AND SUBSTR(EMP_NO,8,1) =2
AND EMP_NAME LIKE '��%';

--2. ���� �� ���� ������ ��� �ڵ�, ��� ��, ����, �μ� ��, ���� �� ��ȸ
--2��

--3. �̸��� �������� ���� ����� ��� �ڵ�, ��� ��, ���� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J USING(JOB_CODE)
WHERE EMP_NAME LIKE '_��_';
--4. �μ��ڵ尡 D5�̰ų� D6�� ����� ��� ��, ���� ��, �μ� �ڵ�, �μ� �� ��ȸ
SELECT EMP_NAME, JOB_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
JOIN JOB USING (JOB_CODE)
WHERE DEPT_CODE IN('D5','D6');

--5. ���ʽ��� �޴� ����� ��� ��, �μ� ��, ���� �� ��ȸ
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
WHERE BONUS IS NOT NULL;

--6. ��� ��, ���� ��, �μ� ��, ���� �� ��ȸ
SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
JOIN LOCATION ON(LOCATION_ID=LOCAL_CODE)
JOIN JOB USING(JOB_CODE);



--7. �ѱ��̳� �Ϻ����� �ٹ� ���� ����� ��� ��, �μ� ��, ���� ��, ���� �� ��ȸ
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
JOIN LOCATION ON(LOCATION_ID=LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE);

--8. �� ����� ���� �μ����� ���ϴ� ����� �̸� ��ȸ
SELECT  M.EMP_NAME , E.DEPT_CODE, E.EMP_NAME
FROM EMPLOYEE E, EMPLOYEE M
WHERE  E.DEPT_CODE = M.DEPT_CODE
AND E.EMP_NAME != M.EMP_NAME;

--9. ���ʽ��� ���� ���� �ڵ尡 J4�̰ų� J7�� ����� �̸�, ���� ��, �޿� ��ȸ(NVL �̿�)
SELECT EMP_NAME, JOB_NAME, NVL(BONUS,SALARY)
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_CODE IN('J4','J7');
--10. ���ʽ� ������ ������ ���� 5���� ���, �̸�, �μ� ��, ����, �Ի���, ���� ��ȸ
--10�� ����
--11. �μ� �� �޿� �հ谡 ��ü �޿� �� ���� 20%���� ���� �μ��� �μ� ��, �μ� �� �޿� �հ� ��ȸ
--11-1. JOIN�� HAVING ���
--11-2. �ζ��� �� ��� --����
--11-2�� ����

--12. �μ� ��� �μ� �� �޿� �հ� ��ȸ
SELECT * FROM EMPLOYEE;   
SELECT * FROM DEPARTMENT; 
SELECT * FROM LOCATION;     
SELECT * FROM JOB;                             
SELECT * FROM NATIONAL;  

SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_ID = DEPT_CODE)
GROUP BY DEPT_TITLE;
