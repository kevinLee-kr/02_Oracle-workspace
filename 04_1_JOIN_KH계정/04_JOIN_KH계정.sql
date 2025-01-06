/*
<JOIN>
�� �� �̻��� ���̺��� �����͸� ��ȸ�ϰ��� �� �� ���Ǵ� ����.
��ȸ ������� �ϳ��� �����(RESULT SET)�� ���ɴϴ�.

������ ������ ���̽� -> �ּ����� �����ͷ� ������ ���̺� �����͸� ��� ����. 
�ߺ��� �ּ�ȭ �ϱ� ���� �ִ��� �ɰ��� ������. 
EX) DEPT_CODE = J7, D5, A6
�� �ѹ���, ������, ������ �� ���������� ������� �ʰ�, �̷��� J7 �� ���� ǥ���� �ϰ� ������>  
�����
��������� J7, D4�� �� ���� ��� �ִ� ���̺��� �ڵ常 �����������ν�, ȿ�������� ��� ������ ������Ʈ ���� �� �ֱ� ����. 
-> ������ �����ͺ��̽�����SQL���� �̿��� ���̺���"����"�� �δ� ���
(������ �� ��ȸ�� �ؿ��°� �ƴ϶� �� ���̺��� ������ν��� �����͸� ��Ī ���Ѽ� ��ȸ�ؾ���.
JOIN�� ũ�� "����Ŭ ���뱸��"�� "ANSI����" (ANSI==�̱�����ǥ����ȸ) -> �ƽ�Ű�ڵ� ����� ��ü
JOIN
1. ����Ŭ ���뱸�� - 
2. ANSI ����  - 

JOIN ���� ���� �鿡 ���ؼ� �˾ƺ���. 

����Ŭ ���� ����                           ANSI ����
--=====================================================
� ����                |                  ��������(INNER JOIN)
(EQUAL JOIN)            |                   �ڿ�����(NATUAL JOIN)
--------------------------------------------------------------------
���� ����               |                   ���� �ܺ� ����(LEFT OUTER JOIN)
(LEFT JOIN)             |                   ������ �ܺ� ����(RIGHT OUTER JOIN)
(RIGHT JOIN)            |                   ��ü �ܺ� ����(FULL OUTER JOIN)
-------------------------------------------------------------------------
��ü����(SELF JOIN)     |                     
�� ����(NON EQUAL JOIN)|
------------------------------------------------------------------------------
*/
--��ü ������� ���, �����, �μ��ڵ�, �μ��� ��ȸ�ϰ��� �ҋ�
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

--��ü ������� ���, �����, �������, ���޸� ��ȸ�ϰ��� �ҋ�
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE;

SELECT JOB_CODE, JOB_NAME
FROM JOB;

/*
���ϰ��� ���� ����ִ� �������� �÷��� ã�Ҵ�. 
1. �����(EQUAL JOIN)/ ���� ����(INNER JOIN)
�����Ű�� �÷��� ���� ��ġ�ϴ� ��鸸 ���εǼ� ��ȸ(== ��ġ�ϴ� ���� ���� ���� ��ȸ���� ����)

-->����Ŭ ���� ����
FROM ���� ��ȸ�ϰ��� �ϴ� ���̺���� �����Ѵ�. 
�״�������, WHERE ���� ������ , ��Ī��ų �÷�(�����, �������� ���� ���� �ִ� �÷�_�� ���� ������ �����Ѵ�. 


*/
--1. ������ �� �÷����� �ٸ���� ��) DEPT_CODE, DEPT_ID , �� �÷� ���� �ٸ�����, �Ѵ� D1,2,3,4,�� ���� ���� ���� �ִ�. ���, �μ���, �μ����� ���� ��ȸ�غ���.

SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID ;
--2. ������ �� �÷����� ���� ���(employee : job+CODE, JOB:JOB_CODE)
-- ���, �����, �����ڵ�, ���޸�
SELECT EMP_ID,EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE,JOB
WHERE JOB_CODE=JOB;
--AMBIGUOUSLY �� ��ȣ�ϴ� ��� ���̴�. JOB_CODE�� �� ���̺� �ִµ� ��� ���̺� �ִ°� �����°ų�?? ��� �Ŵ�. 

--�ذ��� : ���̺���� �̿��ϴ� ��� ( ��ȸ�ϰ����ϴ� ���̺��.)
SELECT EMP_ID,EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE,JOB
WHERE EMPLOYEE.JOB_CODE=JOB.JOB_CODE;
--�ذ��� : ���̺� ��Ī�� �ο��ؼ� �ذ��ϴ� ���.
SELECT EMP_ID,EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E,JOB J
WHERE E.JOB_CODE=J.JOB_CODE;
-----------------------------------------------------------
/* ANSI ����
FROM���� ������ �Ǵ� ���̺��� �ϳ��� ����� ��
JOIN���� ���� ��ȸ�ϰ��� �ϴ� ���̺� ��� + ��Ī ��ų �÷��� ���� ���ǵ� ����ؾ��Ѵ�. 
JOIN USING, JOIN ON. ����� �÷����� �����ų� �ٸ��ų�. 

������ �� �÷����� �ٸ� ���(EMPLOYEE:DEPT_CODE, DEPARTMENT : DEPT_ID)
������ JOIN ON �������θ� ����;
���, ����� ��Ŀ���� �μ��� /*
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE=DETEID);

2. ������ �� �÷����� ���� ���. (EMPLOYEE:JOB_CODE, J=JAB_ì��
JOIN ON, JOIN USING ������ ��밡��
TKQJS, TKDNJSAUD , WLRRMQZHEM, WLRRMQAUD WHGHLGOQHWK.
SELECT EMP-ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB ON(JOB_CODE = JOB_CODE);  --������
 
 �ذ���,1) ���̺�� �Ǵ� ���� �̿��ؼ� ���
 SELECT EMP_10, EMP
 
 
 --�ذ���2) JOIN USING ������ ����ϴ� ���( �� �÷��� ��ġ�ҋ��� ��밡��)
 SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
 FROM EMPLOYEE
 JOIN JOB USING(JOB_CODE);
 --�������--
 --�ڿ����� �� �ѹ� �غ���. (NATUAL JOIN)
 �� ���̺� ���� ������ �÷��� �� �Ѱ��� ������ ���. 
 SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
 FROM EMPLOYEE
 NATURAL JOIN JOB;
--������ �븮�� ����� �̸�, ���޸�, �޿� ��ȸ �غ��� �ʹ�. 
*/
-> ����Ŭ ���� �������� �� �� �غ���?
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND JOB_NAME='�븮';

-> ANSI �������� �� �� �غ���?
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮';
-------------------------------------�ǽ����� Ǯ���--------------------
--1. �μ��� �λ�������� ������� ���, �̸�, ���ʽ� ��ȸ
--����Ŭ ���뱸������ Ǯ��
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID AND DEPT_TITLE ='�λ������';

--ANSI ���뱸������ Ǯ��. 
 SELECT EMP_ID, EMP_NAME, BONUS
 FROM EMPLOYEE
 JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
 WHERE DEPT_TITLE ='�λ������';
 
 --JOIN�� �ϱ� ���ؼ��� �� ���̺� ���� �������� ��������, �������� �÷��� �̸��� ������, Ȯ���� ���� �ؾ��Ѵ�. 
 
--2. DEPARTMENT �� LOCATION�� �����ؼ� ��ü�μ��� �μ��ڵ�, �μ���, �����ڵ�, ������ ��ȸ�غ���
--����Ŭ ���뱸������ Ǯ��
SELECT * FROM DEPARTMENT; --LOCATION_ID

SELECT * FROM LOCATION; --LOCAL_CODE
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT, LOCATION
WHERE LOCATION_ID = LOCAL_CODE;
--ANSI ���뱸������ Ǯ��. 

SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

3. ���ʽ��� �޴� ������� ���, �����, ���ʽ�, �μ��� ��ȸ
SELECT * FROM DEPARTMENT; --LOCATION_ID
SELECT * FROM LOCATION; --LOCAL_CODE

--����Ŭ ���뱸������ Ǯ��
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND BONUS IS NOT NULL;

--ANSI ���뱸������ Ǯ��. 
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE BONUS IS NOT NULL;

4. �μ��� �ѹ��ΰ� �ƴ� ������� ����� , �޿� , �μ��� ��ȸ.
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
--����Ŭ ���뱸������ Ǯ��
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE=DEPT_ID
AND DEPT_TITLE !='�ѹ���';
--ANSI ���뱸������ Ǯ��. 

SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE !='�ѹ���';
--�������� DEPT_CODE �� NULL�ΰ��� ������ ���� ���� ��������� 18���� ������ ��ȸ�ǰ� ����. DEPARTMENT �� NULL�� ���� ���� ����.

/*
���� ����, �ܺ� ����.
--���� ���� �غ���.
--�����, �μ���, �޿�, ���� �� ��ȸ�غ���.
*/--�̰�� �μ���ġ�� ���� ���� ����(NULL)������� ��ȸ�� ���� �ʴ´�. 
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
--�μ��� ������ ����� ���� �μ����� ��쵵 ��ȸ�� ���� �ʴ´�. 
--���ñ⼭ �˼� �ִ°� � ������ �ٽ��� , �ʵ� ���� ���� �־�� �۵��� �ȴٴ� ���̴�. 
/*
���� ����
�� ���̺��� JOIN�� ��ġ���� �ʴ� �൵ ���Խ��Ѽ� ��ȸ �����ϴ�. 
��, LEFT/FIGHT�� �ݵ�� �����ؾߵȴ�. (������ �Ǵ� ���̺� �����Ѵ�. )
������� �ϴٺ��� ���� �����Ǵ� ��찡 �־ ���������� �ϴ°��̴�. 

1. LEFT [OUTER JOIN] : �� ���̺� �� ������ ����� ���̺� �������� JOIN.
*/
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
--//�÷����� �ٸ��Ƿ� ON���� �־��� ���̴�. 
--���ʿ� �ִ� ���̺� �������� ��� ������ ��ȸ�Ѵ�. LEFT [OUTER] JOIN
--�μ���ġ�� ���� �ʾҴ� 2���� ��� ������ ��ȸ�� �ȴ�. ���ο� 23�� ��. 

--> ����Ŭ ���� ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE=DEPT_ID(+);        
--�������� ����� �ϴ� ���̺��� �ݴ��� �÷� �ڿ� (+)�� ���̱�.��� �ߴ� ���� ���� �־�� �ϴ°Ű� 
--OUTER �� ���� �ϳ��� ���̺��� �������� ���� ��ȸ �ϴ� ��.

--2. RIGHT [OUTER] JOIN : �� ���̺��� ������ ����� ���̺��� �������� JOIN
--> ����Ŭ ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+)=DEPT_ID; 
--> ANSI JOIN
SELECT EMP_NAME, DEPT_TITLE SALARY, SALARY*12
FROM EMPLOYEE
RIGHT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

--3. FULL[OUTER] JOIN : �� ���̺��� ���� ��� ���� ��ȸ�� �� ����(��, ����Ŭ ���� �������δ� �ȵ�) (������, ANSI �������� ������ �ȴ�. )
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE
FULL JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);  
--LEFT , RIGHT ��ģ�� �̶�� �����ϸ� ����, �ߺ��Ǵ� ���� ���� �÷��� ��ȸ�ϴ� ����̾��� LEFT , RIGHT ����
--�׷��� �𸣰ڰ�, ��� NULL������ ���� �����ؼ� ��ȸ�� �� �ְ� ���ִ� ���� FULL ����̴�. 


/*
3. �� ���� (NON EQUAL JOIN) -> �߿����� ����. ���� �Ⱦ��̱� ����
��Ī ��ų �÷��� ���� ���� �ۼ��� '=(��ȣ)'�� ������� �ʴ� ���ι�
ANSI�������δ� JOIN ON�� ��� �����ϴ�. 
*/
-----------------------------------------------------
/*
4. SELF JOIN (��ü ����) -> �߿���
���� ���̺��� �ѹ� �� ���� �ϴ� ���.
--���� ���� ������ �����ν�, ������ �ִ� ������ ���� ��ȸ �� �� �̾��� ���.
--��ü ����� ���, �����, ����μ��ڵ� ,����� ���, �����, ����μ��ڵ�

--��ü ����� ��� ��, �����, ��� �μ��ڵ� -> EMPLOYEE E
            ����� ���, �����, ����μ��ڵ� -> EMPLOUU M
*/
---����Ŭ ���� ����
SELECT * FROM EMPLOYEE;
SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE,
 M.EMP_ID, M.EMP_NAME , M.DEPT_CODE
 FROM EMPLOYEE E, EMPLOYEE M
 WHERE E.MANAGER_ID=M.EMP_ID;
--> ANSI JOIN
SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE,
 M.EMP_ID, M.EMP_NAME , M.DEPT_CODE
 FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON(E.MANAGER_ID=M.EMP_ID);


--����� ���� ����� ������ �ϰ� ������ , LEFT ������ �ϸ� �ȴ�. 
-----------------------------------------------------------self join ���� ���� ��---------
/*
���� ���� 
N�� �̻��� ���̺��� ������ JOIN �Ҷ� ����Ѵ�. 
*/
--���, �����, �μ���, ���޸�, ��ȸ.
SELECT * FROM EMPLOYEE; -- DEPT_CODE, JOB_CODE
SELECT * FROM DEPARTMENT; --DEPT_ID
SELECT * FROM JOB;      --JOB_CODE

-->����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE DEPT_CODE = DEPT_ID
AND E.JOB_CODE = J.JOB_CODE;


-->ANSI ���� ����. 
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(DEPT_CODE = DEPT_ID)
JOIN JOB USING (JOB_CODE);
------------------------------------------------���� JOIN �� ��ǥ���� ��

--���, �����, �μ���, ������
--(EMPLOYEE)(DEPARTMENT) (LOCATION)
SELECT * FROM EMPLOYEE; --DEPT_CODE
SELECT * FROM DEPARTMENT; --DEPT_ID, LOCATION_ID
SELECT * FROM LOCATION;     --LOCAL_CODE

--����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
FROM EMPLOYEE, DEPARTMENT, LOCATION
WHERE DEPT_CODE = DEPT_ID
AND LOCATION_ID = LOCAL_CODE;

--ANSI ���� ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON( LOCAL_CODE = LOCATION_ID);
------------------------------------------------------���� JOIN�� ��ǥ���� ��2

--1. ���, �����, �μ���., ������. , ������, 
SELECT * FROM EMPLOYEE;   --DEPT_CODE 
SELECT * FROM DEPARTMENT; -- DEPT_ID,LOCATION_ID 
SELECT * FROM LOCATION;   -- LOCAL_CODE

--����Ŭ ���� ����
SELECT EMP_ID AS "���", EMP_NAME AS "�����", DEPT_TITLE AS "�μ���", LOCAL_NAME AS "������", NATIONAL_CODE AS "������"
FROM EMPLOYEE, DEPARTMENT, LOCATION
WHERE DEPT_CODE = DEPT_ID
AND LOCATION_ID = LOCAL_CODE;

--ANSI ����. 
SELECT EMP_ID AS "���", EMP_NAME AS "�����", DEPT_TITLE AS "�μ���", LOCAL_NAME AS "������", NATIONAL_CODE AS "������"
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);


--2. ���, �����, �μ���, ���޸�, ������, ������, �ش� �޿� ��޿��� ���� �� �ִ� �ִ� �ݾ� ��ȸ.
SELECT * FROM EMPLOYEE;   --DEPT_CODE               JOB_CODE                    SAL_LEVEL
SELECT * FROM DEPARTMENT; -- DEPT_ID,   LOCATION_ID 
SELECT * FROM LOCATION;   --            LOCAL_CODE              NATIONAL_CODE
SELECT * FROM JOB;        --                        JOB_CODE
SELECT * FROM SAL_GRADE;  --                                                    SAL_LEVEL.
SELECT * FROM NATIONAL;   --                                    NATIONAL_CODE
--����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, N.NATIONAL_CODE, MAX_SAL
FROM EMPLOYEE E, DEPARTMENT, LOCATION L, JOB J, SAL_GRADE S, NATIONAL N
WHERE DEPT_CODE = DEPT_ID
AND LOCATION_ID = LOCAL_CODE
AND E.JOB_CODE = J.JOB_CODE
AND E.SAL_LEVEL = S.SAL_LEVEL
AND L.NATIONAL_CODE = N.NATIONAL_CODE;
--ANSI ����. 
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_CODE, MAX_SAL
FROM EMPLOYEE E
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
JOIN JOB USING(JOB_CODE)
JOIN SAL_GRADE USING(SAL_LEVEL)
JOIN NATIONAL USING(NATIONAL_CODE);





















