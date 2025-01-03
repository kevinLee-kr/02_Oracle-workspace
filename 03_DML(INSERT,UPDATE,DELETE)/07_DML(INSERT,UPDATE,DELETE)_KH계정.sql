--DD

/*
DQL (QUERY ������ ���� ���) : SELELCT 

DML  MANIPULATION ������ ���۾�� : INSERT, UPDATE, DELETE
DDL  ERFINITION ������ ���� ���) : CREATE , ALTER, DROP
DCL  CONTROL ������ ������ : GRANT , REVOKE

TCL  TRANSACTION Ʈ������ ���� ��� : COMMIT, ROLLBACK
 
 DML DATA MANIPULATION LAGUAGE 
 ������ ���� ���
 
 ���̺� ���� ���� (INSERT ) �ϰų�, ����(UPDATE)�ϰų�, ���� (DELETE)�ϴ� ����
 
 1. INSERT
 ���̺� ���ο� ���� �߰��ϴ� ����
 [ǥ����]
 1. INSERT INTO [TABLE ��] VALUES(��1, ��2, ��3 ... )
 ���̺� ��� �÷��� ���� ���� ���� �����ؼ� ���� INSERT �ϰ��� �ҋ� ����Ѵ�. 
 
 ���̺� �ȿ� �� ���� ���� �־��ً� ����Ѵ�. 
 �÷� ������ ���Ѽ� VALUES �� ���� �����ؾ���. 
 --> ���̺� ������ �����ϴ� Ÿ�Կ� ���� ���� �־�� �Ѵ�.
 
  */
  INSERT INTO EMPLOYEE
  VALUES(900,'������','900101-1111111','CHA_00@KH.CO.COM','01012345678','D1','J7','S3',400000,'0.2',200,SYSDATE,NULL,DEFAULT);
  
  
  SELECT * FROM EMPLOYEE;
--  2. �μ�Ʈ �ϴ� �ٸ� ����� �ִ�. 
--   2) INSERT INTO ���̺��(�÷���, �÷���, �÷���) VALUES (��1, ��2, ��3 ... );
--  ������ : ù��° INSERT ����� ��� �÷��� ���� ���ø� �ؾ� �ߴ�.(NULL �� ������ , NULL �̶�� �����鼭����.)
--   ������, �� ���� �����, ���̺��(�÷���) �̶�� ���� �÷��� �� ��ŭ, ���� �ִ� ����̴�. 
--  
--   �׷��� �� �� ������ �߰��Ǳ� ������ ������ �ȵ� �÷��� �⺻������ NULL�� ����. 
--   NOT NULL ���� ������ �ɷ��ִ� �÷��� �ݵ�� �����ؼ� ���� �� �����ؾߵȴ�. 
--   ��, DEFAULT ���� �ִ� ���� NULL�� �ƴ� DDFAULT ���� ����. 
  
  INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL, HIRE_DATE)
  VALUES(901, '������', '990202-1111111', 'J1', 'S2',SYSDATE);
  SELECT * FROM EMPLOYEE;
  --��ȸ�� ����� ����, �������� ���� ����, ����Ʈ ���� ���ִ�. ����Ʈ������ ���� ���� NULL�� ����. 
  
   
  INSERT 
    INTO EMPLOYEE
         (
            EMP_ID
            , EMP_NAME
            , EMP_NO
            , JOB_CODE
            , SAL_LEVE
            , HIRE_DATE)
  VALUES(
            901
            , '������'
            , '990202-1111111'
            , 'J1'
            , 'S2'
            ,SYSDATE); 
  ---------------------------------------
  --INSERT �� ��° ���
  --3. INSERT INTO ���̺��(��������);
  --��VALUES �� �� ���� ����ϴ°� ��ſ�
 -- ���������� ��ȸ�� ������� �뤊�� INSERT ���� ! (������ INSERT �����ϴ�.)
  
  
  CREATE TABLE EMP_01(
  EMP_ID NUMBER,
  EMP_NAME VARCHAR2(20),
  DEPT_TITLE VARCHAR2(20)
  );
  
  SELECT * FROM EMP_01;
  
  --��ü ������� ���, �̸�, �μ��� ��ȸ
  SELECT EMP_ID, EMP_NAME, DEPT_TITLE
  FROM EMPLOYEE
  LEFT JOIN DEPARTMENT ON(DEPT_CODE =  DEPT_ID);
  
  
  INSERT INTO EMP_01 (
                        SELECT EMP_ID, EMP_NAME, DEPT_TITLE
                         FROM EMPLOYEE
                         LEFT JOIN DEPARTMENT ON(DEPT_CODE =  DEPT_ID)  
  );
  
  SELECT * FROM EMP_01;
  ----------------------------------------------------------------
  --4. INSERT ALL
  --�׽�Ʈ �� ���̺� �����
  --���� �賢��.
  
  
  
  CREATE TABLE EMP_DEPT
  AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
    FROM EMPLOYEE
    WHERE 1 = 0;
  
  CREATE TABLE EMP_MANAGER
  AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
    FROM EMPLOYEE
    WHERE 1 = 0;
  
  SELECT * FROM EMP_MANAGER;
  --�μ��ڵ尡 D1 �� ������� ���, �̸�, �μ��ڵ�, �Ի���, ������, ��ȸ
  SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
  FROM EMPLOYEE
  WHERE DEPT_CODE = 'D1';
  
  /*
  ǥ���� ]
  INSERT ALL
  INTO ���̺�� 1 VALUES (�÷��� �÷��� �÷��� ...)
  INTO ���̺�� 1 VALUES (�÷��� �÷��� �÷��� ...)
  INTO ���̺�� 1 VALUES (�÷��� �÷��� �÷��� ...)
    ��������
    
    
    
    �̷������� INSERT ALL�� ����ϴµ�, �ѹ��� INSERT�� �� �� �ִ�. 
  */
  INSERT ALL
  INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
  INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
   SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
  FROM EMPLOYEE
  WHERE DEPT_CODE = 'D1';
    SELECT * FROM EMP_MANAGER;
    
    
    
    -- 2000�⵵ ������ �Ի��� �Ի��ڵ鿡 ���� ������ ���� ���̺��� �ϳ� ������. 
    --1. ���̺� ������ �貸�� ���� ������.
    CREATE TABLE EMP_OLD
    AS SELECT EMP_ID, EMP_NAME, HIRE_DATE , SALARY
        FROM EMPLOYEE
        WHERE 1 = 0;
        
    CREATE TABLE EMP_NEW
    AS SELECT EMP_ID, EMP_NAME, HIRE_DATE , SALARY
        FROM EMPLOYEE
        WHERE 1 = 0;
/*  
    INSERT ALL
    WHEN ����1 THEN
        INTO ���̺��1 VALUES(�÷���, �÷���, ...)
    WHEN ���� 2 THEN
        INTO ���̺��1 VALUES(�÷���, �÷���, ...)
   ��������
   */
   
   INSERT ALL
   WHEN HIRE_DATE <'2000/01/01' THEN
        INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
    WHEN HIRE_DATE>= '2000/01/01' THEN
        INTO EMP_NEW VALUES(EMP_ID,EMP_NAME, HIRE_DATE, SALARY)
    SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE;
    
    SELECT * FROM EMP_OLD;
    SELECT * FROM EMP_NEW;
  
  
  --------------------�μ�Ʈ �� INSERT �� INSERT END----------------------
  /*
  UPDATE
  ���̺� ����� �Ǿ��ִ� ������ �����͸� �����ϴ� ����.
  
  [ǥ����]
  UPDATE ���̺��
  SET �ٲٰ� ���� �÷��� = �ٲ� ��, 
        �ٲٰ� ���� �÷��� = �ٲ� ��,
        ...
        -> �������� �÷��� ���� ���� ����
    WHERE          -> WHERE �� �����ϸ� ��� ����� ������ ���� SET���� ���� ����Ǳ� ������ ������ WHERE �� ����.
    
  */
  --���纻 ���̺� ���� �� �۾� �غ���. 
  CREATE TABLE DEPT_COPY
  AS SELECT * FROM DEPARTMENT;

  SELECT * FROM DEPT_COPY;
  --'D9'�μ��� �μ����� ������ȹ������ �����ش޶�.
  UPDATE DAPT_COPY
  SET DEPT_TITLE = '������ȹ��';
 
  UPDATE DEPT_COPY
  SET DEPT_TITLE = '������ȹ��'
  WHERE DEPT_ID='D9';
  
 
    CREATE TABLE EMP_SALARY
    AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
    FROM EMPLOYEE;
    --���� �غ���. 
    --���ö ����� �޿��� 1�鸸������ ����. ������ ��� �ϰ� ����. 
    --�� ��������, ������ �޿��� 7�鸸������ ����, ���ʽ��� 0.3 -> 0.2 �� ����
    --��ü����� �޿��� ������ �޿��� 10���� �λ��� �ݾ�(������*1.1)
    --WHERE ���� �ĺ�Ű. ����Ű�� ��������. 
    UPDATE EMP_SALARY
    SET SALARY = 1000000
    WHERE EMP_ID = 202;
    SELECT * FROM EMP_SALARY;
    
    SELECT EMP_ID, EMP_NAME, SALARY
    FROM EMP_SALARY
    WHERE EMP_NAME = '������';
    
    UPDATE EMP_SALARY
    SET SALARY = 7000000, BONUS = 0.2
    WHERE EMP_ID = 200;
    SELECT EMP_NAME ,SALARY 
    FROM EMP_SALARY;
    
    UPDATE EMP_SALARY
    SET SALARY = SALARY * 1.1;
    
  --  UPDATE �� ���������� ��밡��
  /*
        UPDATE ���̺��
        SET �÷��� = (��������)
        WHERE  ����;
        
        �ڸ�� ����� �޿��� ���ʽ����� ���缮 ����� �޿��� ���ʽ� ������ �����϶�. 
        */
        SELECT * FROM EMP_SALARY
        WHERE EMP_NAME = '����'; -- 1518000
        
        --�Ʒ��� �ڵ�� ���� �� ���������̴�. 
        UPDATE EMP_SALARY
        SET SALARY = (SELECT SALARY FROM EMP_SALARY WHERE EMP_NAME='�����'),
            BONUS = (SELECT BONUS FROM EMP_SALARY WHERE EMP_NAME='�����')
        WHERE EMP_ID = 214;
        --�Ʒ��� �ڵ�� ���߿� ���������̴�.
        UPDATE EMP_SALARY
        SET(sALARY, BONUS) = (SELECT SALARY, BONUS FROM EMP_SALARY WHERE EMP_NAME = '�����')
        WHERE EMP_ID = 214;
    
        --ASIA �������� �ٹ��ϴ� ������� ���ʽ� ���� 0.3���� ����
        --ASIA �������� �ٹ��ϴ� ����� ��ȸ
        
        SELECT * 
        FROM EMP_SALARY
        JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
        JOIN LOCATION ON( LOCATION_ID = LOCAL_CODE)
        WHERE LOCAL_NAME LIKE 'ASIA%';
        
        SELECT * FROM DEPARTMENT;
        
        UPDATE EMP_SALARY
        SET BONUS = 0.3
        WHERE EMP_ID IN (SELECT EMP_ID
                        FROM EMP_SALARY
                        JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
                        JOIN LOCATION ON( LOCATION_ID = LOCAL_CODE)
                        WHERE LOCAL_NAME LIKE 'ASIA%');
        --UPDATE �Ҷ� ���������� ����� �� �ִ� ���� �� �˰� ������ �ɰͰ���.
        
        ----UPDATE
        --��� 200���� ����� �̸��� NULL�� ����
        
        UPDATE EMPLOYEE
        SET EMP_NAME = NULL
        WHERE EMP_ID = 200;
        --ORA-01407: cannot update ("KH"."EMPLOYEE"."EMP_NAME") to NULL
        --EMPLOYEE ���̺� EMP_NAME �÷��� NULL�� �������� �ϴµ�, ������ ���� NOT NULL �̱⿡ �浹 �Ǿ� ������
        --����� �������� �� ���������� ����Ű�� ���α׷����� ��������. 
        
        --���ö ����� �����ڵ带 J9�� �����غ���.
        UPDATE EMPLOYEE
        SET JOB_CODE = 'J9'
        WHERE EMP_NAME = '���ö';
        --ORA-02291: integrity constraint (KH.SYS_C007167) violated - parent key not found
        --FOREIGN KEY �������� ����...�Ǿ���. 
        
        -------------------------------
        /*
        DELETE
        ���̺� ��ϵ� �����͸� �����ϴ� ���� (�� �� ������ ������)
       
       [ǥ����]
       DELETE FROM ���̺��
       [WHERE ����] --> WHERE �� ���� ���� ������ ��ü ���� �� �� ������ �ȴ�.       
        */
        
        DELETE FROM EMPLOYEE;
        
        ROLLBACK; -- ������ Ŀ�� �������� ���ư���.
        DELETE FROM EMPLOYEE
        WHERE EMP_NAME = '������';
        
        DELETE FROM EMPLOYEE
        WHERE EMP_NAME = '������';
        
        COMMIT;
        
        SELECT * FROM EMPLOYEE;
        
        --DEPARTMENT ���̺��� DEPT_ID�� D1�� �μ��� ���� �غ���. 
        DELETE FROM DEPARTMENT
        WHERE DEPT_ID = 'D1';
        --ORA-02292: integrity constraint (KH.SYS_C007166) violated - child record found
        --Ȥ�� ��ﳪ��, --> �ؼ�) �� �̰� ���� ���� �ֳ��ϸ�, �ش� ���̺��� �ڽĵ��� �� ���� ����ϰ� �־�. 
        
        --D1�� ���� ������ ���� �ڽĵ����Ͱ� �ֱ� ������ ������ �ȵ�.
        
        DELETE FROM DEPARTMENT
        WHERE DEPT_ID = 'D3';
        -->�ݴ�� D3�� ��쿡 ������ ���� �ڽ� �����Ͱ� ���� ������ ������ �����ϴ�. 
        ROLLBACK; --> ���� KH �� ��� �����ڷ�� ��� �ϱ⶧���� ROLLBACK ���༭ ����ȭ ��Ű��. 
        
        --TRUNCATE : ���̺��� ��ü ���� ������ �� ����ϴ� �����̴�. DELETE ���� ���� �ӵ��� �ξ� ������. 
        -- ������ ���� ���� �Ұ��ϴ�, �׳� �ϴ� ������Ų�ٰ� ���� �ȴ�. 
        --ROLLBACK �� �Ұ��ϴ�. ������ ������ �����ϸ� ���ϴ�. ������ ����
        --[ǥ����] TRUNCATE TABLE ���̺��;

        TRUNCATE TABLE EMP_SALARY;