--SQL ������ ��ȭ�����̶���.
/*
    <PL / SQL >
    PROCEDURE LANGUAGE EXTENSION TO SQL
    
    ����Ŭ ��ü�� ����Ǿ� �ִ� ������ ����̴�. 
    SQL ���峻���� ������ ����, ����ó��(IF), �ݺ�ó��(LOOP, FOR, WHILE)���� �����Ͽ� SQL ���� ����
    �ټ���SQL���� �ѹ��� ���� �����ϴ�. (BLOCK ���� ) + ���� ó�� ����
    
    PL / SQL ����
 - [�����] - DECLARE �� ������ �Ѵ�. ������ ����� ���� �� �ʱ�ȭ �ϴ� �κ�
  - �����  - BEGIN���� ������ �Ѵ�. ������ �־����, �ʼ�����. SQL �Ǵ� ���(���ǹ�, �ݺ���) ���� ������ ����ϴ� �κ�
  -[����ó����] - EXCEPTION���� ������ �Ѵ�. ���ܰ� �߻��ϸ� �ذ��ϱ� ���� ������ �̸� ����ص� �� �ִ� �����̴�. 
  
*/

SET SERVEROUTPUT ON;
--�����ϰ� ȭ�鿡 HELLO ORCLE �� ��� �غ��� �� �غ��� �ʹ�. 
BEGIN
--�ڹٷ� ���� ���, System.out.println("Hello World");
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');

END ; 
/
-----------------------------------------
/*
DECLARE �����
���� �� ��� �����ϴ� ���� (����� ���ÿ� �ʱ�ȭ�� ����)��
�Ϲ�Ÿ�Ժ���, ���۷���Ÿ�� ����, ROWŸ�� ����.

1_1 �Ϲ� Ÿ�� ���� ���� �� �ʱ�ȭ
                [ǥ����] ������ [CONSTANT -> ����� ���Ѵ�.] �ڷ��� : = ��;
*/
DECLARE
    EID NUMBER;
    ENAME VARCHAR(20);
    PI CONSTANT NUMBER := 3.14;
BEGIN
--    EID := 800;
--    ENAME := '������';
    
    EID := &��ȣ;
    ENAME := '&�̸�';
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME :'|| ENAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/
------------------------------------------
/*
1_2) ���۷��� Ÿ�� ���� ���� �� �ʱ�ȭ(� ���̺��� � �÷��� ������ Ÿ���� �����ؼ� �� Ÿ������ ����
        [ǥ����] ������ ���̺��. �÷���%TYPE;
        --�����ڰ� ũ�⸦ �����ϴ� ���� �ƴ϶�, ���̺�� �Ǵ� �÷��� ���� ũ�Ⱑ ��������. 
        */
        
        DECLARE
            EID EMPLOYEE.EMP_ID%TYPE; -- EMPLOYEE �� ���� EMP_ID �÷��� �ְ�, �� �÷��� ������ �����Ǿ��.
            ENAME EMPLOYEE.EMP_NAME%TYPE;
            SAL  EMPLOYEE.SALARY%TYPE;
        BEGIN
--            EID := '300';
--            ENAME := 'DLGHTJR';
--            SAL := 3000000;
            
            SELECT EMP_ID, EMP_NAME, SALARY
            INTO EID, ENAME, SAL
            FROM EMPLOYEE
            WHERE EMP_ID = &���;

            
            DBMS_OUTPUT.PUT_LINE('EID: ' || EID);
            DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
            DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
            END;
        /
        
        
--����� 200���� ����� ���, �����, �޿� ��ȸ�ؼ� �� ������ ����.
SELECT EMP_ID, EMP_NAME, SALARY
INTO EID, ENAME, SAL
FROM EMPLOYEE
WHERE EMP_ID = &���;



--------------------------�ǽ�����
/*
���۷���Ÿ�� ������ EID, ENAME, JCODE, SAL, DTITLE �� �����ϰ�
�� �ڷ����� EMPLOYEE, DEPARTMENT ���̺���� �����ϰ� 
����ڰ� �Է��� ����� ����� ���, ����� �����ڵ�, �޿� �μ��� ��ȸ

�� ������ ��� ��� �غ���.
*/

 DECLARE
            EID EMPLOYEE.EMP_ID%TYPE;
            ENAME EMPLOYEE.EMP_NAME%TYPE;
            JCODE EMPLOYEE.JOB_CODE%TYPE;
            SAL  EMPLOYEE.SALARY%TYPE;
            DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
            
        BEGIN
--            EID := '300';
--            ENAME := 'DLGHTJR';
--            JCODE := 3000000;
--            SAL := 6000000;
--            DTITLE := 'ȸ�������';

            SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
            INTO EID, ENAME, JCODE, SAL, DTITLE
            FROM EMPLOYEE
            JOIN DEPARTMENT ON(DEPT_ID = DEPT_CODE)
            WHERE EMP_ID = &���;
            
            DBMS_OUTPUT.PUT_LINE('EID: ' || EID);
            DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
            DBMS_OUTPUT.PUT_LINE('JCODE : ' || JCODE);
            DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
            DBMS_OUTPUT.PUT_LINE('DTITLE : ' || DTITLE);
            END;
        /
-----------------------------------------
--1_3) ROW Ÿ�� ����
--          ���̺��� �� �࿡ ���� ��� �÷����� �Ѳ����� ���� �� �ִ� ����
--          [ǥ����] ������ ���̺��%ROWTYPE;

DECLARE 
    E EMPLOYEE%ROWTYPE;
BEGIN
    SELECT *
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = &���;

--    DBMS_OUTPUT.PUT_LINE(E);
    DBMS_OUTPUT.PUT_LINE('����� : ' ||E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || E.SALARY);
    DBMS_OUTPUT.PUT_LINE('���ʽ� : ' || NVL(E.BONUS,0)); --NVL ����
END;
/
-----------------------------------------
/*
2. BEGIN �����
<���ǹ�>
1) IF ���ǽ� THEN ���೻�� END IF;
--��� �Է� ���� �� �ش� ����� ���, �̸�, �޿�, ���ʽ���(%) ��� �غ���. 
��, ���ʽ��� ���� �ʴ� ����� ���ʽ��� ��� ��'���ʽ�'�� ���޹��� �ʴ� ����Դϴ�. ��� �ϰ� �ʹ�. 
*/
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)
    INTO EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('�����ȣ : ' || EID);
    DBMS_OUTPUT.PUT_LINE('����̸� : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('����޿� : ' || SALARY);
    
    IF BONUS = 0
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�. ');
    END IF ;
    
    DBMS_OUTPUT.PUT_LINE('������ʽ�: ' || BONUS * 100 || '%');

END;
/ 

--2) IF ���ǽ� THEN ���೻�� ELSE ����׿� END IF;
        -- (�ڹ��� IF-ELSE ���� ������ ����ϴ�.)
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)
    INTO EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('�����ȣ : ' || EID);
    DBMS_OUTPUT.PUT_LINE('����̸� : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('����޿� : ' || SALARY);
    
    IF BONUS = 0
        THEN DBMS_OUTPUT.PUT_LINE('�� ����� ���ʽ��� ���� �ʽ��ϴ�. ');
    ELSE
      DBMS_OUTPUT.PUT_LINE('������ʽ�: ' || BONUS * 100 || '%');
    END IF ;
END;
/        
-----------------------------------------------------------
--�ǽ����� ,���ν����� ������.
-- ����.
--���۷���Ÿ�� ����(EID, ENAME, DTITLE, NCODE)
--������ ���̺��� �����̳� .: EMPLOYEE, DEPARTMENT, NATIONAL)

--�Ϲ� Ÿ�� ������ ������ּ��� .  TYPE �� �����ؾ��ϴµ� (TEAM ���ڿ�) -> �̵��� '������', '�ؿ���' �̶�� ����
-- ���� ������. �˾Ƽ� �� ������ֶ� ^^

--����ڰ� �Է��� ����� ����� ���, �̸�, �μ���, �ٹ����� �ڵ带 ��ȸ�� �Ŀ�  EID, ENAME, DTITLE, NCODE �� 
--���� �����϶�. 
--NCODE �� ���� KO �� ��쿡 -> TEAM �� '������'
-- NCODE �� ���� US?EU? (KO�� �ƴѰ��) -> TEAM�� '�ؿ���' �� �־��.

--���, �̸�, �μ�, �Ҽ�(������ �Ǵ� �ؿ��� �̶�� ����� �ǰ�  ���α׷����� �غ���. 

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.NATIONAL_CODE%TYPE;
    TEAM VARCHAR(20);
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EID, ENAME, DTITLE, NCODE
    FROM EMPLOYEE
    JOIN  DEPARTMENT ON(DEPT_ID = DEPT_CODE)
    JOIN  LOCATION ON(LOCATION_ID = LOCAL_CODE)
    WHERE EMP_ID = &���;
    
    IF NCODE = 'KO'
        THEN TEAM := '������';
    ELSE
        TEAM := '�ؿ���';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('����̸� : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�μ��̸� : ' || DTITLE);
    DBMS_OUTPUT.PUT_LINE('�����ڵ� : ' || NCODE);
    DBMS_OUTPUT.PUT_LINE('�Ҽ� �� : ' || TEAM);
END;
/

----------------------------------------------
--3) IF ���ǽ�1 THEN ���೻��1 ELSE ���ǽ�2 THEN ���೻��2 ... END IF;
--������ �Է¹޾� SCORE ������ ������ ��
--90�̻��� 'A' , 80 �� 'B',  70�� �̻��� 'C', 60�� �̻��� 'D', 60�� �̸��� 'F'

--GRADE ��� ������ ������ �غ���. (A,B,C,D,F,)
--���������
--����� ������ XX���̰�, ������ X���� �Դϴ�. �� ���� ����.


DECLARE
    SCORE NUMBER;
    GRADE VARCHAR2(1);
BEGIN
    SCORE := &����;
    
    IF SCORE >= 90 THEN GRADE := 'A';
    ELSIF SCORE >= 80 THEN GRADE := 'B';
    ELSIF SCORE >= 70 THEN GRADE := 'C';
    ELSIF SCORE >= 60 THEN GRADE := 'D';
    ELSE GRADE := 'F';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('����� ������ '|| SCORE ||'���̰�,������ '||GRADE||'���� �Դϴ�.');
END;
/

--------------------------�ǽ�����---------------
--���ν��� �����
--���� 2�� (���۷���Ÿ�� ���� : SAL, �Ϲ� Ÿ�� ���� : GRADE -> �ʱ�, �߱�, ���

--�Է��� ����� ����� �޿��� 500���� �̻��̸� GRADE -> ���
--                            300���� �̻��̸� GREADE -> �߱�
--                            300���� �̸��̸� GRADE -> �ʱ�
--                            
--        �ش� �ϻ���� �޿� ����� XX�Դϴ�.

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENM EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    GRADE VARCHAR(10);
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EID, ENM, SAL
    FROM EMPLOYEE
    WHERE EMP_ID = &���;

    IF  SAL >=5000000 THEN GRADE := '���';
    ELSIF SAL >=3000000 THEN GRADE := '�߱�';
    ELSE GRADE := '�ʱ�';
    END IF ;

    DBMS_OUTPUT.PUT_LINE('�ش� ����� �޿������ ' || GRADE || '�Դϴ�. ');

END;
/
------------------------------------------------------------
--4) CASE �񱳴����  WHEN ������� ��1 THEN �����1 WHEN  ������Ұ�2 THEN THEN �����2 .... END;

DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DNAME VARCHAR2(30);
    --> �μ��� ���� ����
    
BEGIN
    SELECT *
    INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DNAME := CASE EMP.DEPT_CODE
                        WHEN 'D1' THEN '�λ���'
                        WHEN 'D2' THEN 'ȸ����'
                        WHEN 'D3' THEN '��������'
                        WHEN 'D4' THEN '����������'
                        WHEN 'D9' THEN '�ѹ���'
                        ELSE '�ؿܿ�����'
            END;
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_NAME || '��(��) ' || DNAME|| '�Դϴ�.');
END;
/
-----------------------------------------------------------
--����� ������ ���ϴ� PL/SQL �� �ۼ� �غ���.

-- ���ʽ��� �ִ� ����� ���ʽ��� �����ؼ� ����ض�.
--���ʽ��� ������ ���ʽ������� �������� ���
--���ʽ��� ������ ���ʽ������ؼ� ������� �ϸ� �Ǵµ�
-- ������ ����� �ش� �����
--�޿�, �̸�, L999,999,999
--(8000000 ������ )

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, BONUS
    INTO EID, ENAME, SAL, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('�����ȣ : ' || EID);
    DBMS_OUTPUT.PUT_LINE('����̸� : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || SAL);
    DBMS_OUTPUT.PUT_LINE('���ʽ� : ' || BONUS);
    
    IF BONUS IS NULL THEN  DBMS_OUTPUT.PUT_LINE('���� : ' || TO_CHAR(SAL *12,'L99,999,999'));
    ELSE DBMS_OUTPUT.PUT_LINE('���� : ' || TO_CHAR((SAL + (SAL * BONUS)) * 12,'L99,999,999'));
    END IF;
    
    
END;
/

IF EMP.BONUS IS NULL
    THEN SALARY := EMP.SALARY * 12;
ELSE SALARY := (EMP.SALARY + (EMP.SALARY * EMP.BONUS))*12;
END IF;

DBMS_OUTPUT.PUT_LINE(EMP.SALARY || ' ' || EMP.EMP_NAME || TO_CHAR(SALARY,'L999,999,999'));

