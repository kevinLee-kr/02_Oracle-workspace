--asdf
/*
 DDL (DATA DEFINITION LANGUAGE) : ������ ���� ���
 ����Ŭ���� �����ϴ� ��ü(OBJECT)�� ���Ӱ� �����, ������ �����ϰ�, ���� ��ü�� �����ϴ� ���.
������ �����ϰ� (ALTER) , ������ü�� ����(DROP) �ϴ� ���. 
��, ���� ������ ���� �ƴ� ���� ��ü�� �����ϴ� ���

�ַ�, DB������, �Ǵ� �����ڰ� ����ϱ⿡
�ִϾ� �����ڰ� ����ϴ� ���� ���� ���� ������, �׷��� �˾Ƶξ ���ܰ� ����. 

������, DDL�� �ٷ�� ��ü���� �˾ƺ���
����Ŭ���� �����ϴ� ��ü(����) : ���̺�(TABLE), ��(VIEW), ������(SEQUENCE), 
                                �ε���(INDEX), ��Ű��(PACKAGE), Ʈ����(TRIGGER), 
                                ���ν���(PROCEDURE), �Լ�(FUNCTION), ���Ǿ�(SYNONYM), �����(USER)
                                
                                
        <CREATE> �� ���� �˾ƺ��� ��� ����ϴ��� �˾ƺ���. 
        CREATE : ��ü�� ������ �����ϴ� �����̴�.
        
        1��, ���̺��� �����ϴ� ����� �˾ƺ���. 
        - ���̺��̶� �����ΰ� ��� ������, ��� �� �� �����Ǿ��ִ� ���� �⺻���� �����ͺ��̽� ��ü�� ���ǵȴ�. 
        ��� �����͵��� ���̺� ����� �Ǿ��ִ�. 
        DBMS ��� �� �ϳ���, �����͸� ������ ǥ ���·� ǥ�� �� ���̴�. 
        
        ���̺��� �����, �����͸� �־��, �� �����̴�. �츮�� ������. 
        
        [ǥ����]
        CREATE TABLE ���̺�� ();  -> ���̺��� ������ �Ǿ���. ������ �÷����� ������ ����. 
        
        CREATE TABLE ���̺��(
            �÷��� �ڷ���(ũ��),
            �÷��� �ڷ���(ũ��),   -> �÷����� ����, �ڷ����� ��� �ϴ±���. ũ�⸦ �����ص� ������ �ʼ����ΰ� �ƴϴ�.
            �÷��� �ڷ���, 
            ...
        );
        
        - �ڷ���, �ڷ����� ũ�� 3������ �����ٰ� ���� �ȴ�. 
        1. CHAR : ���� �ڷ���.(CHAR(����Ʈũ��)) | VARCHAR2(����Ʈũ��)
            - �ݵ�� ũ�� ������ ���־�� �Ѵ�. �ݸ�, ����, ��¥ Ÿ���� ũ�� ������ �� �ʿ䰡 ����. 
            - �ִ� 2000BYTE������ ������ �����ϴ�. �ʱ� ũ�� ������, ������ ������ ������ �����Ƿ�, ������ ���� �ȿ����� ����Ѵ�.  / ���� ����
            - (������ ũ�⺸�� �� ���� ���� ���͵�, �������� ä����, �޸� ������ �� ����. 
            - ������ ���ڼ��� �����͸��� ��� ��� �ַ� ���.
        2. VARCHAR2 : ���� �ڷ���(CHAR2(����Ʈũ��)
            - �ִ� 4000����Ʈ ���� ���� ����.
            - �������̰� �ƴ� ���� �����̴�. 
            - ���� ���� ���� ������ ũ�Ⱑ �޶�����. 
            - �� ������ �����Ͱ� ������ �� ��� ����� �ȴ�. 
        2. ���� �ڷ���. (NUMBER TYPE)
            ����, �Ǽ�,  ����, ��¥ Ÿ���� ũ�� ������ �� �ʿ䰡 ����. 
        3. ��¥ �ڷ���. (DATE)
            ��¥ Ÿ��  ����, ��¥ Ÿ���� ũ�� ������ �� �ʿ䰡 ����. 
*/

-- ȸ���� ���� �����͸� ��� ���� ���̺� MEMBER �����ϱ�.
CREATE TABLE MEMBER(
    MEM_NO NUMBER, 
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    GENDER  CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE
);
--- �̹� �����ϴ� ��ü�� �ֱ⿡ �ٽ� ������ �Ұ����ϴ�.
--- ���� �����ϰ��� �ϴ� �÷��� ��Ÿ�� �߻�������, �ٽ� ����� �ɱ�? �����Ⱑ �ɱ�?
--- �ȵȴ�. �����ϰ� �ٽ� ������ �Ѵ�.

----------------------------
/*
�÷��� �ּ� �ޱ�(�÷��� ���� ���� ���� ��)(COMMENT)
[ǥ����]
COMMENT ON COLUMN ���̺��, �÷��� IS '�ּ�����';
*/

COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN MEMBER.MEM_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEM_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEM_NAME IS 'ȸ����';
COMMENT ON COLUMN MEMBER.GENDER IS '����(��/��)';
COMMENT ON COLUMN MEMBER.PHONE IS 'ȸ����ȭ��ȣ';
COMMENT ON COLUMN MEMBER.EMAIL IS 'ȸ�� �̸���';
COMMENT ON COLUMN MEMBER.MEM_DATE IS 'ȸ�� ������';

--���̺� ������ �߰���Ű�� ����(DML : INSERT) �̶� �ڼ��ϰ� ���
--INSERT INTO ���̺�� VALUES (��, ��2, ..);

SELECT * FROM MEMBER;
INSERT INTO MEMBER VALUES(1,'user01','pass01','ȫ�浿'); 
-- not enough values

INSERT INTO MEMBER VALUES(1,'user01','pass01','ȫ�浿','��','010-1234-5678','kking@gmail.com','24/12/30'); 
INSERT INTO MEMBER VALUES(2,'user02','pass02','ȫ���','��',null,NULL,SYSDATE); 

INSERT INTO MEMBER VALUES(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
--��ȿ���� ���� �����Ͱ� ���� ����.

---------------------------------------
/*
���� ���� <CONSTRAINT>
- ���ϴ� �����Ͱ��� �����ϱ� ���ؼ� Ư�� �÷��� �����ϴ� ��������

- ���� :
1. NOT NULL
2. UNIQUE
3. CHECK
4. CHECK
5. PRIMARY KEY
6. FOREIGN KEY

NOT NULL ��������- 
�ش� �÷��� �ݵ�� ���� ���� �ؾ߸� �� ���
��, �ش� �÷��� ���������� NULL�� ���ͼ��� �ȵǴ� ���.
���� / ���� �� NULL ���� ������� �ʵ��� �����ϴ� ���ǽ��̴�. 

���� ������ �ο��ϴ� ����� ũ�� 2������ ������. 
1. �÷��������
2. ���̺��� ���.
NOT NULL ���������� ������ �÷� ���� ��� ���ιۿ� �ȵȴ�. 
*/
--�÷����� ��� : �÷��� �ڷ��� ��������
CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL, 
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER  CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);
SELECT * FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL VALUES(1,'user01','pass01','�̺���','��',null,null);
INSERT INTO MEM_NOTNULL VALUES(2,'user02',null,'���̵𰡰�','��',null,'holywhat@gamil.com');
--�ǵ��ߴ���� ������ ����. (NOT NULL �������ǿ� ����Ǿ� ���� �߻�!!)
INSERT INTO MEM_NOTNULL VALUES(2,'user01','pass01','����ȯ','��',null,'holywhat@null.com');
--�����Ͱ� �̹� �����Ͽ� ���̵� �ߺ��� �Ǿ��µ�, �� �߰��� �ǰ� �ֵ�.
------------------------
/*
unique��������
.�ش� �÷��� �ߺ��� ���� ������ �� �� ���.
�÷����� �ߺ����� ���� �ϴ� ���� ����
���� / ������ ������ �ִ� ������ ���� �ߺ����� ���� ��� ���� �߻�.
*/

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL, 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, --�÷� ���� ���.
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER  CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);
SELECT * FROM MEM_UNIQUE;
DROP TABLE MEM_UNIQUE;

--���̺� ���� ��� : ��� �÷��� �� ���� �� �� �������� ����Ѵ�. 
--�������Ǹ�(�÷���)

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL, 
    MEM_ID VARCHAR2(20) NOT NULL, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER  CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    UNIQUE(MEM_ID) --> ���̺� �������. ���� UNIQUE ������ �ɰ� ������ , MEM_ID�� �ɰ� �ʹ�. 
);

INSERT INTO MEM_UNIQUE VALUES(1,'user01','pass01','����Ŀ',null,null,null);
INSERT INTO MEM_UNIQUE VALUES(2,'user01','pass02','���콺',null,null,null);
--ORA-00001: unique constraint (DDL.SYS_C007100) violated
/*
�������� �ο��� �������� �� ���� �����ִ� ���
���� �츮�� 2���� ������� ��ü���� �����ϰ� �ִ�. 

�÷� ���� ���
CREATE TABLE ���̺��(
�÷��� �ڷ��� [CONSTRAINT �������Ǹ�] ��������, 
�÷��� �ڷ��� 
);

���̺� ���� ���
CREATE TABLE ���̺��(
�÷��� �ڷ���, 
�÷��� �ڷ���, 
[CONSTRAINT �������Ǹ�] ��������(�÷���)
);
*/
select * from MEM_UNIQUE;

 --> ���̺� ���� ���. 


CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL, 
    MEM_ID VARCHAR2(20) NOT NULL, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER  CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    CONSTRAINT MEMID_UQ UNIQUE(MEM_ID) --> ���̺� �������. ���� UNIQUE ������ �ɰ� ������ , MEM_ID�� �ɰ� �ʹ�. 
);

INSERT INTO MEM_UNIQUE VALUES(1,'user01','pass01','����Ŀ',null,null,null);
INSERT INTO MEM_UNIQUE VALUES(2,'user01','pass02','���콺',null,null,null);
--ORA-00001: unique constraint (DDL.MEMID_UQ) violated
INSERT INTO MEM_UNIQUE VALUES(2,'user02','pass02','����',null,null,null);
INSERT INTO MEM_UNIQUE VALUES(3,'user03','pass03','�Ǳ۷�','��',null,null);

SELECT * FROM MEM_UNIQUE;
/*
CHECK(���ǽ� ��������
�ش� �÷��� ���� �� �ִ� ���� ���� ������ �����ص� �� ����.
�ش� ���ǿ� �����ϴ� �����Ͱ��� ��� �� ����. 
*/
CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL, 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER  CHAR(3) CHECK(GENDER IN('��','��')), --�÷� ���� ���
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    
    --CHECK(GENDER IN('��','��')) --���̺� ���� ���
);
SELECT * FROM MEM_CHECK;
INSERT INTO MEM_CHECK VALUES(1,'user01','pass01','�����','��',null,null);
INSERT INTO MEM_CHECK VALUES(2,'user02','pass02','��õ��',null,null,null);
--ORA-02290: check constraint (DDL.SYS_C007110) violated
-- ����, GENDER ���������� ������ ���� ��������, ����� ���� �ؾ� �Ѵ�. 
-- CHECK �������ǿ� �����ϴ� ���� �־�� ��. 
--NOT NULL�� �ƴ� �̻�, NULL ���� ��� �� �� �ִ�. 

INSERT INTO MEM_CHECK VALUES(2,'user03','pass03','�̰���',null,null,null);
--�� �������� ��������, ȸ����ȣ�� �ߺ��� �Ǿ������� �ұ��ϰ� , �����ͱ���� �ʹ� �� �ǰ��ִ�. 

--------
/*
�̶� ����ϴ� ���� 
PRIMARY KEY
���̺��� �� ����� �ĺ��ϱ� ���� ���� �÷��� �ο��ϴ� �������� (�������� ����)

EX)ȸ����ȣ, �й�, �����ȣ(EMP_ID), �μ��ڵ�(DEPT_ID), �����ڵ�(JOB_CODE), �ֹ���ȣ, �����ȣ, 
����� ��ȣ
PRIMARY KEY �������Ϥ��� �ο��ϸ� �� �÷��� �ڵ����� NOT NULL + UNIQUE ���������� ������.

���ǻ��� : �� ���̺�� ������, �Ѱ��� ���� �����ϴ�. 
*/

CREATE TABLE MEM_PRI(
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY, --�÷� ���� ���. 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER  CHAR(3) CHECK(GENDER IN('��','��')), 
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    --CONSTRAINT MEMNO_PK PRIMARY KEY(MEM_NO) --���̺� ���� ���. 
);
SELECT * FROM MEM_PRI;
INSERT INTO MEM_PRI VALUES(1,'user01','pass01','�����','��','12-12-12',null);
INSERT INTO MEM_PRI VALUES(2,'user02','pass02','�ڸ��� ����',null,null,null);
--ORA-00001: unique constraint (DDL.MEMNO_PK) violated
--�⺻Ű�� NULL�� �������� �ҋ�(NOT NULL �������ǿ� ����ȴ�. )

CREATE TABLE MEM_PRI2(
    MEM_NO NUMBER ,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER  CHAR(3) CHECK(GENDER IN('��','��')), 
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    PRIMARY KEY(MEM_NO,MEM_ID) --��� PRIMARY KEY �������� �ο� (����Ű)
);
SELECT * FROM MEM_PRI2;
INSERT INTO MEM_PRI2 VALUES(1,'user01','pass01','�����','��','12-12-12',null);
--1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO MEM_PRI2 VALUES(1,'user02','pass02','�����','��','12-12-12',null);
--1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO MEM_PRI2 VALUES(NULL,'user02','pass02','�����','��','12-12-12',null);
--ORA-01400: cannot insert NULL into ("DDL"."MEM_PRI2"."MEM_NO")
--PRIMARY KEY �� �����ִ� �� �÷����� ���� NULL �� ������� �ʴ´�.

--����Ű ��� ����)
--(���ϱ�, ���ƿ�, ����)
--���ϱ� : �� ��ǰ�� ������ �ѹ��� ���� �� ����
-- � ȸ���� � ��ǰ�� ���ϴ����� ���� �����͸� �����ϴ� ���̺�.
*/

CREATE TABLE TB_LIKE(
    MEM_NO NUMBER, 
    PRODUCT_NAME VARCHAR2(30),
    LIKE_DATE DATE,
    PRIMARY KEY(MEM_NO,PRODUCT_NAME)
    );
    
    SELECT * FROM TB_LIKE;
    
    INSERT INTO TB_LIKE VALUES(1,'�׵𺣾�',SYSDATE);
    INSERT INTO TB_LIKE VALUES(1,'�׵𷹾�',SYSDATE);
    INSERT INTO TB_LIKE VALUES(2,'�׵𺣾�',SYSDATE);
    INSERT INTO TB_LIKE VALUES(1,'�׵𺣾�',SYSDATE);
    
    ----------------------------------------------------------
    --ȸ����޿� ���� �����͸� ���� ���� �ϴ� ���̺�
    CREATE TABLE MEM_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
    );
    
    SELECT * FROM MEM_GRADE;
    
    INSERT INTO MEM_GRADE VALUES(10,'�Ϲ�ȸ��');
    INSERT INTO MEM_GRADE VALUES(20,'���ȸ��');
    INSERT INTO MEM_GRADE VALUES(30,'Ư��ȸ��');
    
    CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY, 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER  CHAR(3) CHECK(GENDER IN('��','��')), 
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER     --ȸ�� ��޹�ȣ ���� ������ �غ����� ������.
);
    SELECT * FROM MEM;
    INSERT INTO MEM VALUES(1,'user01','pass01','�ظ� ����','��',null,null,null);
    INSERT INTO MEM VALUES(2,'user02','pass02','ī�þ߽�',null,null,null,10);
    INSERT INTO MEM VALUES(3,'user03','pass03','���',null,null,null,99);
--���� ��ȿ�� ȸ���� ����� �ƴѿ��� �ұ��ϰ� ����(insert_)�� �� �ǰ� �ִ�. �̷��� �ȵȴ�. 
--������ ȸ���� �ƴϸ�(99��) ���Ե��� �ʰ� ���ƾ� �Ѵ�. 

/*
FOREIGN KEY(�ܷ�Ű) ���� ����
�ٸ� ���̺� �����ϴ� ���� ���;� �ϴ� Ư�� �÷��� �ο��ϴ� ��������.
--> �ٸ� ���̺��� �����Ѵ�. 
--> �ַ� FOREIGN KEY ���� ���ǿ� ���� ���̺� ���� ���谡 �����ȴ�. 

1. �÷� ���� ���. 
 �÷��� �ڷ��� [CONSTRAINT �������Ǹ�]REFERENCES ������ ���̺�� (������ �÷���)
 
2. ���̺� ���� ���. 
 [CONSTRAINT �������Ǹ�]FOREIGN KEY(�÷���) REFERENCES ������ ���̺��(������ �÷���)
 -> ������ �÷��� ������ ������ ���̺���PRIMARY KEY �� ������ �÷����� ��Ī

*/
DROP TABLE MEM;

   CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY, 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER  CHAR(3) CHECK(GENDER IN('��','��')), 
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER  REFERENCES MEM_GRADE(GRADE_CODE)  
--    GRADE_ID NUMBER  REFERENCES MEM_GRADE �̷��� (GRADE_CODE) �� ���� ������ , �����̸Ӹ�Ű�� �ڵ� ���� ��. / �÷� ���� ����̴�. 
--     FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) --> TABLE LEVEL ���. 
);

SELECT * FROM MEM;
    INSERT INTO MEM VALUES(1,'user01','pass01','�ظ� ����','��',null,null,null);
    INSERT INTO MEM VALUES(2,'user02','pass02','ī�þ߽�',null,null,null,10);
    INSERT INTO MEM VALUES(3,'user03','pass03','���',null,null,null,99);
-- ORA-02291: integrity constraint (DDL.SYS_C007139) violated - parent key not found
--PARENT KEY �� ã�� �� ���ٴ� ���� �߻�.
    INSERT INTO MEM VALUES(4,'user04','pass04','Ŭ����',null,null,null,30);




























