--dd

SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE;
----------------------

SELECT DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
GROUP BY DEPT_CODE , JOB_CODE, SALARY; --<-- ����, �׷��� ���� ����. 
-- ������ ���� : JOB_CODE, SALARY �÷��� GROUP BY�� ���������� �ʰ�, GROUP BY ���� �׷��Լ��� �Բ� ��� �ϴµ� �׷��� �ʾҵ�..
-- ��ġ������ ����ÿ�. : SELECT ����� GROUP BY �� ��ġ���� �����Ƿ� ������ �ʿ���. 
SELECT DEPT_CODE , SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;
----------------------------------------------------------------
--����2
SELECT DEPT_CODE, JOB_CODE, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE; --�׷�BY ��� 1���� ���Ǹ� �ɼ� �ִ°� �ƴϴ�. , �̷��� 2�� �̻� ����� �� �ִ�. �׷����� �������� �ݵ�� SELECT ���� ���;� �Ѵ�. 
---------------------------------------------------------------
-- �̻� ������ DB ������ GROUPBY ��  ������ �ǰ� ������, ������ ���� �غ���. !








































