--

/*
    <VIEW ��>
    
    SELECT (������)(������)�� ������ �� �� �ִ� ��ü
    (���� ���� �� SELECT ���� �����صθ� �� �� SELECT ���� �Ź� �ٽ� ����� �ʿ䰡 ����. )
    
    �ӽ� ���̺� ���� ���� ! (���� �����Ͱ� ����ִ� �� �ƴϴ�. ) (�����ֱ�� �̶�� �����ص� ����. 

    �������� ���̺� : �����Ѵ�.
    ������ ���̺� : ������ -> ��� ������ ���̺��̴�. 
    
    VIEW ���ó 
    
    --�並 ����� ���� ������ ������ �ۼ��غ���.
    --������ �������� ������.
    
    �ѱ����� �ٹ��ϴ� ���, �̸�, �μ���, �޿�, �ٹ������� ��ȸ �غ���.
    */
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING(NATIONAL_CODE)
    WHERE NATIONAL_NAME = '�ѱ�';
    
    -- �ѱ����� �ٹ��ϴ� ���, �̸�, �μ���, �޿�, �ٹ������� ��ȸ �غ���.
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING(NATIONAL_CODE)
    WHERE NATIONAL_NAME = '���þ�';
    
    -- �ѱ����� �ٹ��ϴ� ���, �̸�, �μ���, �޿�, �ٹ������� ��ȸ �غ���.
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING(NATIONAL_CODE)
    WHERE NATIONAL_NAME = '�Ϻ�';
    ------------------------------------------------------------------
    /*
    VIEW ���� ���
    [ǥ����]
    CREATE VIEW ���̸�
    AS (��������);    
    [OR REPLACE]
    �� ������ ������ �ߺ��� �̸��� �䰡 ���ٸ� ~ �並 �����Ͻÿ�.
             ������ �ߺ��� �̸��� �䰡 �ִٸ� ~ �ش�並 ����, �����⸦ �Ͻÿ�.
    */
    CREATE VIEW VW_EMPLOYEE
    AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
        FROM EMPLOYEE
        JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
        JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
        JOIN NATIONAL USING(NATIONAL_CODE);
        --ORA-01031: insufficient privileges
        
        --������ ������ �����ؼ� ���Ѻο�
        GRANT CREATE VIEW TO KH;
        
        --�̰Ŵ� �����ִ� ���̺��� �ƴϴ�. �׷��� �����̶�� �ϴ°ų�, �����̺�� �Ҹ���. 
        SELECT * FROM VM_EMPLOYEE;
        
    --�ѱ� ���þ� �Ϻ��� �ٹ��ϴ� ���. 
    SELECT * 
    FROM VM_EMPLOYEE
    WHERE NATIONAL_NAME = '�ѱ�';
    SELECT * 
    FROM VM_EMPLOYEE
    WHERE NATIONAL_NAME = '���þ�';
    SELECT * 
    FROM VM_EMPLOYEE
    WHERE NATIONAL_NAME = '�Ϻ�';
    
    --����
    SELECT * 
    FROM USER_VIEWS;
    
    --���࿡ �信�ٰ� ��ȸ�ϰ� ���� �� �ϳ� �߰� �ϰ� �ʹ�. 
    
     CREATE OR REPLACE VIEW VW_EMPLOYEE
    AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, BONUS
        FROM EMPLOYEE
        JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
        JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
        JOIN NATIONAL USING(NATIONAL_CODE);
    
    --------------------------------------------------
    --�信 ��Ī�ο� �غ���. 
    /*
    ���������� SELECT ���� �Լ����̳� ���������� ����Ǿ� ���� ��� �ݵ�� ��Ī�� �����ؾ� �ȴ�. 
    */
    --��ü ����� ���, �̸�, ���޸�, ����(��/��), �ٹ���� �� ��ȸ �� �� �ִ� SELECT ���� ��� ���Ǹ� �غ���. 
    --�̋� ���� �̸��� (VM_EMP_JOB)���� ���� �غ���. 
    
    CREATE OR REPLACE VIEW VM_EMP_JOB
    AS SELECT EMP_ID, EMP_NAME, JOB_NAME,
            DECODE(SUBSTR(EMP_NO,8,1),1,'MAN',2,'WOMEN')AS"����(��/��)",
            EXTRACT( YEAR FROM SYSDATE) - EXTRACT( YEAR FROM HIRE_DATE) AS "�ٹ����"
        FROM EMPLOYEE
        JOIN JOB USING(JOB_CODE);
  
  SELECT * FROM VM_EMP_JOB;
  --������ �̷� ���̺��� �ִ� ���� �ƴ϶�, ��~! �̷� ������ �ֱ���~ ��� Ȯ�ο����� ����� �ȴ�. 
    
     CREATE OR REPLACE VIEW VM_EMP_JOB(���, �̸�, ���޸�, ����, �ٹ����)
    AS SELECT EMP_ID, EMP_NAME, JOB_NAME,
            DECODE(SUBSTR(EMP_NO,8,1),1,'MAN',2,'WOMEN'),
            EXTRACT( YEAR FROM SYSDATE) - EXTRACT( YEAR FROM HIRE_DATE)
        FROM EMPLOYEE
        JOIN JOB USING(JOB_CODE);
    --�̷��� ��Ī�� �ο� �ϴ� ����� �ִ�. ��, ��� �÷��� ���ؼ� ��Ī�� �ʼ������� �ο� �ؾ� �Ѵ�. 
    
    --���� ����; ���ϴ�. �ս���. ���̹� �� ���� �����J�⿡. ���ϴ�. 
    SELECT �̸�, ���޸�
    FROM VM_EMP_JOB
    WHERE ���� = '��';
    
    SELECT *
    FROM VM_EMP_JOB
    WHERE �ٹ���� >=20;
    
    
    -----------------
    --�並 ���� �ϰ��� �Ѵٸ�. 
    DROP VIEW VM_EMP_JOB;
    
    --������ �並 �̿��ؼ� DML(INSERT, UPDATE, DELETE)��밡���ϴ�.
    --�並 ���ؼ� �����ϴ��� ���� �����Ͱ� ����ִ� ���̽����̺� �ݿ��ȴ���.
    -- �׷�����, �� �ȵǴ� ��찡 ���Ƽ� �����δ� ���� ������ �ʴ´�. 
    
    CREATE OR REPLACE VIEW VM_JOB
    AS SELECT JOB_CODE, JOB_NAME
        FROM JOB;
        
        SELECT * FROM VM_JOB; --������ ���̺�, �����̴�~ ��� �Ѵ�.(���� �����Ͱ��� ������� ����)
        SELECT * FROM JOB;   -- ���̽� ���̺�, ������~ ��� �Ѵ�. (���� �����Ͱ� ��� �ִ�. )
        
        --VIEW �� ���ؼ� INSERT �� �غ���. 
        INSERT INTO VM_JOB VALUES('J8','����');
    
        --������ �ȴ�. 
        -- UPDATE�� �ǳ�?
        UPDATE VM_JOB
        SET JOB_NAME = '�˹�' --�� �����ϰ� �ʹ�. 
        WHERE JOB_CODE = 'J8';
        --�� �ȴ�. �� ���� �ȴ�.
        --���� ���̺���VIEW �ε��� �� ������ �Ǵ� ���. 
        
        --�並 ���ؼ� DELETE �� �غ���. 
        DELETE FROM VM_JOB
        WHERE JOB_CODE = 'J8';
        --���� ���. ������ ��Ȱ�� �� �Ǵ� ��찡 �ִ�. 
        --������ ������ ����J��, �ȵǴ� ��찡 �ִ�. 
        --� ��찡 �ֳ�?
        ---------------------
        /*
        DML ��ɾ�� ������ �Ұ����� ��찡 ��~ ���� ����. 
        1. �信 ���ǵǾ� ���� ���� �÷��� �����Ϸ��� �ϴ� ���. 
        
        2. �信 ���ǵǾ����� ���� �÷��߿� ���̽����̺� �� NOT NULL ���������� �����Ǿ� �ִ� ���.  - ��� �ǰ� ��� �ȵǴ� ��찡 ����
        3. �������� �Ǵ� �Լ������� ���ǵǾ��ִ� ���. ������ �ȵ�
        4. �׷��Լ��� GROUP BY ���� ���Ե� ���
        5. DISTINCT ������ ���Ե� ���, DML ������ �ȵ� �� �ִ�. 
        6. ������ �̿��ؼ� �������̺��� ������ѳ��� ��� �ȵȴ�. 
        -VIEW �� ��ȸ�Ϸ��� ���� ����̱⿡, DML ���� ���� ����. 
        --�״ϱ�, VIEW 
        */
          CREATE OR REPLACE  VIEW VW_JOB
            AS SELECT JOB_CODE
            FROM JOB;
--        1. �信 ���ǵǾ� ���� ���� �÷��� �����Ϸ��� �ϴ� ���. 
            INSERT INTO VW_JOB(JOB_CODE, JOB_NAME) VALUES('J8','����');
            --ORA-00904: "JOB_NAME": invalid identifier
            UPDATE VW_JOB
            SET JOB_NAME = '����'
            WHERE JOB_CODE ='J7';
            -- ORA-00904: "JOB_NAME": invalid identifier
            
            DELETE FROM VW_JOB
            WHERE JOB_NAME = '���';
            --ORA-00904: "JOB_NAME": invalid identifier
--        2. �信 ���ǵǾ����� ���� �÷��߿� ���̽����̺� �� NOT NULL ���������� �����Ǿ� �ִ� ���.  - ��� �ǰ� ��� �ȵǴ� ��찡 ����
            CREATE OR REPLACE VIEW VW_JOB
            AS SELECT JOB_NAME FROM JOB;
            
            SELECT * FROM VW_JOB;
            SELECT * FROM JOB; --JOB_CODE �� ����������NOT NULL�̴�. 
            
            INSERT INTO VW_JOB VALUES('����');
            --ORA-01400: cannot insert NULL into ("KH"."JOB"."JOB_CODE")
            
            UPDATE VW_JOB
            SET JOB_NAME = '�˹�'
            WHERE JOB_NAME = '���';
            --1 �� ��(��) ������Ʈ�Ǿ����ϴ�.
            
            DELETE FROM VW_JOB
            WHERE JOB_NAME = '���';
            --ORA-02292: integrity constraint (KH.SYS_C007167) violated - child record found
            
--        3. �������� �Ǵ� �Լ������� ���ǵǾ��ִ� ���. ������ �ȵ�
            CREATE OR REPLACE VIEW VW_EMP_SALARY
            AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12 AS "����" FROM EMPLOYEE;
            
            SELECT * FROM VW_EMP_SALARY;       --�� ���̺�
            SELECT * FROM EMPLOYEE;         --���̽� ���̺�
            
            INSERT INTO VW_EMP_SALARY VALUES(400,'������',3000000,3600000);
            --ORA-01733:virtual column not allowed here
            --EMPLOYEE �� �����̶�� �÷��� ���� ����. 
            
            UPDATE VW_EMP_SAL
            SET ���� = 8000000
            WHERE WMP_ID = 200; -- ����
            
            UPDATE VW_EMP_SALARY
            SET SALARY = 7000000
            WHERE EMP_ID = 200; -- ����
            
            DELETE FROM VM_EMP_SALARY
            WHERE ���� = 72000000; --���� �Ȱ� �ƴ�����, Ʈ�����ǿ� �ӹ��� �������̴�. 
--        4. �׷��Լ��� GROUP BY ���� ���Ե� ���
            CREATE OR REPLACE VIEW VW_GROUPDEPT
            AS SELECT DEPT_CODE, SUM(SALARY) "�հ�", FLOOR(AVG(SALARY)) "���"
            FROM EMPLOYEE
            GROUP BY DEPT_CODE;
            
            SELECT * FROM VW_GROUPDEPT;
            
            INSERT INTO VW_GROUPDEPT VALUES('D3',8000000,4000000); --����
            --ORA-01733: virtual column not allowed here
            --���̽� �������� ���� EMPLOYEE�� ���� �� ���� ������ �������̹Ƿ�, INSERT�� �ȵȴ�. 

            UPDATE VW_GROUPDEPT
            SET �հ� = 8000000
            WHERE DEPT_CODE = 'D1';
            
            DELETE FROM VW_GROUPDEPT
            WHERE �հ� = 5210000;
            
--        5. DISTINCT ������ ���Ե� ���, DML ������ �ȵ� �� �ִ�. 
            CREATE OR REPLACE VIEW VW_DT_JOB
            AS SELECT DISTINCT JOB_CODE FROM EMPLOYEE;
            
            SELECT * FROM VW_DT_JOB;
            SELECT * FROM EMPLOYEE;
            
            INSERT INTO VW_DT_JOB VALUES('J8');


            UPDATE VW_DT_JOB
            SET JOB_CODE = 'J8'
            WHERE JOB_CODE = 'J7';
            
            DELETE VW_DT_JOB
            WHERE JOB_CODE = 'J4';

--        6. ������ �̿��ؼ� �������̺��� ������ѳ��� ��� �ȵȴ�. 
--        -VIEW �� ��ȸ�Ϸ��� ���� ����̱⿡, DML ���� ���� ����. 

            CREATE OR REPLACE VIEW BVW_JOINEMP
            AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE
            FROM EMPLOYEE
            JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
            
            SELECT * FROM BVW_JOINEMP;
            
            INSERT INTO BVW_JOINEMP VALUES(300,'�����','�ѹ���');
            
            UPDATE BVW_JOINEMP
            SET EMP_NAME = '������'
            WHERE EMP_ID = 200;
            
            UPDATE BVW_JOINEMP
            SET DEPT_TITLE = 'ȸ���'
            WHERE EMP_ID = 200;
            
            
            DELETE FROM BVW_JOINEMP
            WHERE EMP_ID = 200;
    
    
            ROLLBACK;
    
    
    -----------------------------------
    /*
    VIEW �ɼ�
    [�� ǥ����]
    CREATE OR REPLACE [FORCE|"NOFORCE"] VIEW �� �̸�
    AS ��������. 
    
    [WITH CHECK OPTION]
    [WITH READ ONLY]        --VIEW ���� DML����� �۵��ϴ°� ������ Ʋ��� ���. ��, ������ ��ȸ�� ����
    
    1) OR REPALCE : ������ ������ �䰡 ���� ��� ���Ž�Ű��, 
                                    ���� ��� ������ ������Ų��.
    2) FORCE | NOFORCE
    > FORCE : ���������� ����� ���̺��� �������� �ʾƵ� �䰡 �����ǰ� �Ѵ�. 
    > NOFORCE : ���������� ����� ���̺��� �����ϴ� ���̺��̿��� �䰡 �����ǰ� �ϴ� ���.
    --FORCE �Ǵ� NOFORCE�� �����ϰ� �Ǹ� �⺻���� NOFORCE �� ������ �ȴ�. 
    3) WITH CHECK OPTION : DML�� ���������� ����� ���ǿ� ������ �����θ� DML�����ϵ��� �ϴ� ���.
    4) WITH READ ONLY : VIEW �� ���ؼ� ��ȸ�� �����ϰ� ����� ���, DML ����� ������ Ʋ���.
    */
    

   -- NOFORCE : ���������� ����� ���̺��� �����ϴ¤� ���̺��̿��߸� �䰡 �����ǰ� �ϴ� �ɼ�;
    
    CREATE OR REPLACE FORCE VIEW VW_EMP
    AS SELECT TCODE, TNAME, TCONTENT
    FROM TT;
    --���: ������ ������ �Բ� �䰡 �����Ǿ����ϴ�.
    
    SELECT * FROM VW_EMP; --��ȸ�� �ȵ�
    
    CREATE TABLE TT(
        TCODE NUMBER,
        TNAME VARCHAR2(20),
        TCONTENT VARCHAR2(30)
    );
    
    --3) WITH CHECK OPTION : ���������� ����� ���ǿ� �������� �ʴ� ������ ������ ���� �߻�.
    -- WITH CHECK OPTION �Ⱦ��� ������� �ִ�. �ѹ� �غ���. 
    CREATE OR REPLACE VIEW VW_EMP
    AS SELECT * 
        FROM EMPLOYEE
        WHERE SALARY >= 3000000;
        
    SELECT *
    FROM VW_EMP; --8�� ��ȸ��
    --200�� ����� �޿��� 200�������� ����(���������� ���ǿ� ���յ��� �ʴ� ������ ���� ���� �õ�.)
    UPDATE 
    SET SALARY = 3000000
    WHERE EMP_ID = 200;
    ROLLBACK;
    
    CREATE OR REPLACE VIEW VW_EMP
    AS SELECT * 
        FROM EMPLOYEE
        WHERE SALARY >= 3000000
    WITH CHECK OPTION;

SELECT * FROM VW_EMP;    
    
    UPDATE VW_EMP
    SET SALARY = 3000000
    WHERE EMP_ID = 200; -- ����
    --���������� ����� ���ǿ� ���յ��� �ʱ� ������ ������ �Ұ��ϴ�.
    -- ���������� ����� ���ǿ� ���յǱ� ������ ������ �����ϴ�. 
    ROLLBACK;
    SELECT * FROM EMPLOYEE;
    
    
    /*
    
    4) WITH READ ONLY : �信 ���ؼ� ��ȸ�� ���� (DML�� ���� ��� ����)
    
    */
    CREATE OR REPLACE VIEW VW_EMP
    AS SELECT EMP_ID, EMP_NAME, BONUS
        FROM EMPLOYEE
        WHERE BONUS IS NOT NULL
    WITH READ ONLY; 
    
    SELECT * FROM VW_EMP;
    
    DELETE FROM VW_EMP
    WHERE EMP_ID = 200;
    --ORA-42399: cannot perform a DML operation on a read-only view
    
    SELECT * FROM EMPLOYEE;
    SELECT *
    FROM(
        SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
        FROM EMPLOYEE));
        
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    