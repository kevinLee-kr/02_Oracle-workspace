
/*
����Ŭ���� �����ϴ� ��ü�鿡 ���ؼ� ���� �ִ�. 
������<SEQUENCE>

�ڵ����� ��ȣ�� �߻������ִ� ������ �ϴ� ��ü
�������� ���������� ������ �� ������Ű�鼭 ��������(�⺻�����δ� 1�� ����)
��EX) ȸ����ȣ, �����ȣ, �Խñ۹�ȣ �� ���� ��ó���� �ȵǴ� �����͵�.


1. ������ ��ü ���� �ϴ� ��
[ǥ����]
CREATE TABLE SEQUENCE ��������

���� Ŀ���� �ϰ� �ʹٸ�? 
[�� ǥ����]
CREATE SEQUENCE ������ ��
[START WITH ���ۼ���]  --> ó������ �߻���ų ���۰� �����ȴ�.(�⺻�� 1)
[INCREAMENT BY ����] -- �󸶳� , � ���� ��ų������ ���� ����(�⺻�� 1)


100 ���� �����ؼ� 200 ���� ���� 301 ���� �Դµ� 302���� �������� ���ڴ�. (��������)
[MAXVALUE ����]   --> �̰� �Ⱦ���, ���Ѵ��ΰ���? �׷��� �ƴѵ�, �ִ밪�� �ʹ� Ŀ�� �� �����������.(�ִ밪 ����)
[MINVALUE ����]  --> �ּҰ� ���� -> �ִ밪�� ��� ù������ �ٽ� ���ƿͼ� �����Ҷ�. �������� �� �� ������ �ٽ� ���ƿË�. 
[CYCLE|NOCYCLE] --> �� ��ȯ ���� ����(NOCYCLE)
[NOCACHE|CACHE ����Ʈ ũ��]  --> ĳ�ø޸� �Ҵ�(�⺻�� CACHE 20)

* ĳ�ø޸� : �ӽð���
        �̸� �߻��� ������ �����ؼ� �����صδ� ����
        �Ź� ȣ�� �ɶ����� ���Ӱ� ��ȣ�� �����Ѵ� ���� �ƴ϶�. 
        ĳ�� �޸� ������ �̸� ������ ������ ������ ������ �ִ�. (�ӵ��� ������)
        ������ ������ �Ǹ� , ĳ�ø޸𸮿� �̸� ������ ��ȣ���� �������. 
        ��ȣ�� �����ϰ� �ο� �ȵ� �� ������ Ȯ���� �� �ؾ��Ѵ�. 
*/
CREATE SEQUENCE SEQ_TEST;
--[����] ���� ������ �����ϰ� �ִ� �������� �������� ������ �Ҷ� �����

SELECT * FROM USER_SEQUENCES;

CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

/*������ ��� �ϴ� ����� ���ؼ� �˾ƺ���.

��������.CURRVAL : ���� �������� �� (���������� ���������� �����  NEXTVAL�� ��)
��������.NEXTVAL : ���������� �������� �������Ѽ� �߻��� ��..
                    ���� ������������ INCREAMENT BY �� ��ŭ ������ ��. 
                    --��������.CURRVAL+INCREMENT BY

*/

SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
--ORA-08002: sequence SEQ_EMPNO.CURRVAL is not yet defined in this session
*Action:   select NEXTVAL from the sequence before selecting CURRVAL

--NEXTVAL�� �� �ѹ��� �������� �ʴ� �̻� CURRVAL �� �� ����
--��? ���������� ���������� ����� NEXT VAL ���� CURRVAL �̱� �����̴�. 

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --300
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- ���������� ������ NEXT ���� ��� (300)

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --305
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --310

SELECT * FROM USER_SEQUENCES

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --������ MAX VALUE���� �ʰ� ���� ������ ���� �߻� (����!)

SELECT SEQ_EMPNO.CURRVAL FROM DUAL; --310;

/*
3. ������ ���� ����
ALTER SEQUENCES ��������
[INCREAMENT BY ����] -- �󸶳� , � ���� ��ų������ ���� ����(�⺻�� 1)
100 ���� �����ؼ� 200 ���� ���� 301 ���� �Դµ� 302���� �������� ���ڴ�. (��������)
[MAXVALUE ����]   --> �̰� �Ⱦ���, ���Ѵ��ΰ���? �׷��� �ƴѵ�, �ִ밪�� �ʹ� Ŀ�� �� �����������.(�ִ밪 ����)
[MINVALUE ����]  --> �ּҰ� ���� -> �ִ밪�� ��� ù������ �ٽ� ���ƿͼ� �����Ҷ�. �������� �� �� ������ �ٽ� ���ƿË�. 
[CYCLE|NOCYCLE] --> �� ��ȯ ���� ����(NOCYCLE)
[NOCACHE|CACHE ����Ʈ ũ��]  --> ĳ�ø޸� �Ҵ�(�⺻�� CACHE 20)

    -- START WITH �� ������ �Ұ��ϴ�. �̹� �����ߴµ� ��ĳ �ٲٴ�? ��� �������� �Ͻ�. 
    
*/


ALTER SEQUENCE SEQ_EMPNO
INCREMENT BY 10
MAXVALUE 400;

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
--310 + 10  == 320


--������ ���� �ϱ�
 DROP SEQUENCE SEQ_EMPNO;
 
-- �����ȣ�� Ȱ���� ������ �����غ���.
CREATE SEQUENCE SEQ_EID
START WITH 400
NOCACHE;

INSERT
    INTO EMPLOYEE
        (
        EMP_ID
        , EMP_NAME
        , EMP_NO
        , JOB_CODE
        , SAL_LEVEL
        , HIRE_DATE
        )
VALUES
        (
        SEQ_EID.NEXTVAL
        , '������'
        , '111111=1111111'
        , 'J7'
        ,'S1'
        , SYSDATE
        );
        SELECT * FROM EMPLOYEE;
INSERT
    INTO EMPLOYEE
        (
        EMP_ID
        , EMP_NAME
        , EMP_NO
        , JOB_CODE
        , SAL_LEVEL
        , HIRE_DATE
        )
VALUES
        (
        SEQ_EID.NEXTVAL
        , '�ݵ��縣'
        , '222222=2222222'
        , 'J2'
        ,'S1'
        , SYSDATE
        );
        
        
        --���ٴ� NEXTVAL�� ������ ���� ���� �ϴ� ��.
    
INSERT
    INTO EMPLOYEE
        (
        EMP_ID
        , EMP_NAME
        , EMP_NO
        , JOB_CODE
        , SAL_LEVEL
        , HIRE_DATE
        )
VALUES
        (
        SEQ_EID.NEXTVAL
        , '������'
        , '111111=1111111'
        , 'J7'
        ,'S1'
        , SYSDATE
        );















