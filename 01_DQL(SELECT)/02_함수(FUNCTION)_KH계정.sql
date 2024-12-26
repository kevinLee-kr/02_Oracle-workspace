--����~
/*
�Լ�
���޵� �÷����� �о�鿩�� �Լ��� ����,�� ������ ����� ��ȯ�Ѵ�. 

- ������ �Լ� : N���� ���� �о�鿩�� N���� ������� �����Ѵ�.(���� ���� �Լ� ���� ��� ��ȯ�Ѵ�.) ����� 5�� �ִµ� Ű(HEIGHT) �� �ִµ�, Ű���� �ݿø��Ѵٸ�, �����Ͱ� �����ڳ�, �ΰ��� ���� �ݿø� �ϰڴ� �ϸ�, 2���� ���� ��������. ������
5���� ���߿� ����ū, ���� ����, ���ǽĿ� ���ؼ� � ���� �����ϰ� �ʹ�. �׷��� �׷��Լ��� ���� �ȴ�. 
- �׷� �Լ� : N���� ���� �о�鿩�� 1���� ������� �����Ѵ�. (�׷��� ���� �׷캰�� �Լ� ���� ��� ��ȯ)

SELECT ���� ©�� ������ �Լ��� �׷��Լ��� �Բ� ��� ���Ѵ�. 
�ֳĸ�, ��� ���� ������ �ٸ��� �����̴�. 

�Լ����� ��� �� �� �ִ� ��ġ�� ������ �ִ�. SELECT��, WHERE��, ORDER BY ��, GROUP BY��, HAVING ��.
�� �׷��� ��������, �Լ����� ����ϴ� ����� �ƶ���. 
���� ó�� �Լ�. �� ���� �˾ƺ��� .
LENGTH / LENGTHB : ���ڼ��� �����ϴ� �Լ�, ��������δ� ����(INT)�� ���´�. 
[ǥ����]
LENGTH(�÷�|'���ڿ���') : �ش� ���ڿ����� ���ڼ��� ��ȯ���ش�. 
LENGTHB(�÷�|'���ڿ���'): �ش� ���ڿ� ���� ����Ʈ �� ��ȯ���ش�. 

'��', '��', '��' �� �ѱ۷� �Ǿ��ִ� ���ڵ��� 3BYTE�� ������ �Ǿ��ִ�. 
������, ����, Ư���� �ѱ� �ܿ� ���ڵ��� 1BYTE�� �����Ǿ��ִ�. 
*/

SELECT SYSDATE FROM DUAL; --�������̺�κ��� ��ȸ�� �ϰڴ�. (DUAL)

SELECT LENGTH('����Ŭ'), LENGTHB('����Ŭ')
FROM DUAL;
--����Ŭ�̶�� �Ѵٸ�, 3����, ��� �ϴµ�
--LEGNTHB ��� �ϸ�, 3, 6, 9BYTE(3�����̱� ����) �� ��µȴ�. 

SELECT LENGTH('oracle'), lengthb('oracle')
FROM DUAL;
--6���� �̱� ������ '6'
--�� 1���ڴ� 1BYTE�̱� ������ 6BYTE

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME), EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;

/*
INSTR
���ڿ��κ��� Ư�� ������ ������ġ�� ã�Ƽ� ��ȯ
[ǥ����]
INSTR(�÷�|'���ڿ�', 'ã���� �ϴ¹���', ['ã����ġ�� ���۰�'] <--������� NUMBERŸ���̴�. 
ã�� ��ġ�� ���۰�
1 : �տ������� ã�ڴ�. 
-1: �ڿ������� ã�ڴ�. 
*/
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL; --�ؼ�: DUAL���̺��� �� ù ���ڿ����� B�� ã�� �ʹ�. �⺻���� 1�̱� ������(�տ������� ã�´�), A,A,B ��, 3���� �ֱ� ������ ��°��� 3�� ���´�. 
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL; --�ؼ�: ã�� ��ġ ��������-1�̱� ������ �� �ڿ������� �����Ѵ�. B�� �տ������� 10���� �ڸ��� ��ġ�� �ִ°� Ȯ�� ������ 10�� ���� ����Ѵ�. 
SELECT INSTR('AABAACAABBAA', 'B', -1, 2) FROM DUAL;

--�����, ����ٵ��� EMAIL���Ŀ��� ��� ��ġ�� �ִ��� ã�� �ʹ�. 
SELECT EMAIL ,INSTR(EMAIL,'_', 1, 1) AS " _��ġ", INSTR(EMAIL, '@') AS"@��ġ"
FROM EMPLOYEE;

--SUBSTR
--���ڿ����� Ư�� ���ڿ��� �����ؼ� ��ȯ(�ڹٿ����� SUBSTRING() �޼ҵ�� �ſ� ����. 
--SUB(STRING, POSITION, [LENGTH]) <-- ������� CHARACTER Ÿ��
-- -STRING : ����Ÿ���÷� �Ǵ� '���ڿ���'
-- - POSITION : ���ڿ��� ������ ������ġ��
-- - LENGTH : ������ ���� ����(������ ������ �ǹ�)
SELECT SUBSTR('SHOWMETHEMONEY' ,7) FROM DUAL; --7�� ���� �����ش�. (©�� ������ش�.)
SELECT SUBSTR('SHOWMETHEMONEY' , 5, 2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY' , 1, 6) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;

--���� ����鸸 ��ȸ�غ���
SELECT EMP_NAME
FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO,8,1) = 2 OR SUBSTR(EMP_NO, 8,1)=4;
--�ֹι�ȣ 8���� �ڸ� ù��° �ڸ��� 2 �Ǵ� 4�� ������� �̸��� ����� ���Ҷ�. 
WHERE SUBSTR(EMP_NO,8,1) IN('2','4');
--���� ������� ���������� IN�� ����ߴ�. 

SELECT EMP_NAME
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN (1,3)
--����Ŭ�� ����ȯ�� �ʹ� �����ؼ� '' �� ���� �ʾ�����, �� �ȴ�. ������ �۵� ������ �����ϴ�. (���������� �ڵ� ����ȯ ��)
ORDER BY 1; --�⺻������ ���������̴� ����Ŭ��.

--�Լ� ��ø ����غ���
SELECT EMP_NAME, EMAIL, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL,'@')-1) -- SUBSTR���ǽ��߿� EMAIL����~ 1ù°���� ������� ��ġ�� ã�� 1������ ������� ��ġ���� �� ���ڼ��� �˾Ƴ���. ���������δ� -1���� �ؼ� ����������� ��ġ�� ã���ش�.
FROM EMPLOYEE;--���� ���� ������Ǿ��̵� ���� �ʹ�. ,\

/*
LPAD, RPAD
���ڿ��� ��ȸ�� �� ���ϰ� �ְ� �����ϰ��� �� �� �̿��Ѵ�. 
[ǥ����]
LPAD/RPAD(STRING, ���������� ��ȯ�� ������ ����,[�����̰��� �ϴ¹���])
���ڿ��� �����̰��� �ϴ� ���ڸ� ���� �Ǵ� �����ʿ� ���ٿ��� ���� N ���� ��ŭ�� ���ڿ��� ��ȯ.
*/
--20��ŭ�� ���� �� EMAIL�÷����� ���������� �����ϰ� ������ �κ��� �������� ä����(����_)
SELECT EMP_NAME, EMAIL, LPAD(EMAIL, 20) -- �����̰��� �ϴ� ���� ������ �⺻���� ������ �ȴ�. 
FROM EMPLOYEE;

SELECT EMP_NAME, EMAIL, LPAD(EMAIL, 20, '*')
FROM EMPLOYEE;



SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO),8 , 14 ,'%')
FROM EMPLOYEE;


SELECT EMP_NAME, SUBSTR(EMP_NO,1,8)||'*******'
FROM EMPLOYEE;
/*
LTRIM/RTRIM
���翭���� Ư�� ���ڸ� ������ �������� ��ȯ�Ѵ�. 
[ǥ����]
LTRIM/RTRIM(STRING, [������ ���ڵ�'] -> �����ϸ� ���� ������

���ڿ��� ���� Ȥ�� �����ʿ��� �����ϰ��� �ϴ� ���ڵ��� ã�Ƽ� ���� �� ���ڿ� ��ȯ
*/
SELECT LTRIM('  K  H') FROM DUAL; -- ������ ã�Ƽ� ���Ÿ� �ϰ� ����ȿ� ���ڸ� ������ �Ǹ� �������ϴ�. �׳� ����;

SELECT LTRIM('123123KH123','123') FROM DUAL;
SELECT LTRIM('AAAAAaaaCABACCKH', 'A')FROM DUAL; -- Ư�� ���ڸ� ã�Ƽ� ©���� ����� ���ش�. 

SELECT RTRIM('5782KH123','01023122357') FROM DUAL;

/*
TRIM
���ڿ� ��/��/���ʿ� �ִ� ������ ���ڵ��� ������ ������ ���ڿ� źȯ
W

FROM EMPLOYEE;
*/
SELECT TRIM('     K  H  ') FROM DUAL;

SELECT TRIM('Z' FROM 'ZZZZKHZZZZZ') FROM DUAL;  --> KH
SELECT TRIM(LEADING 'Z' FROM 'ZZZZKHZZZ') FROM DUAL; --> KHZZZ, ������ ���� ���Ѵ�.LTRIM�� �ſ� �����ϴ�. 
SELECT TRIM(TRAILING 'Z' FROM 'ZZZZKHZZZ') FROM DUAL; --> ZZZKH,  TRAILING : �� - RTRIM �� �����ϴ�.
SELECT TRIM (BOTH 'Z' FROM 'ZZZZKHZZZ') FROM DUAL; -->KH

/*
LOWER / UPPER / INITCAP

LOWER, UPPER, INITCAP ( STRING ) CHARACTER ��������� ��ȯ�ȴ�. 
LOWER : �� �ҹ��ڷ� ������ ���ڿ� ��ȯ
UPPER : �� �빮�ڷ� ������ ���ڿ� ��ȭ
INITCAP : �� �����ٸ� �빮�ڷ� ������ ���ڿ� ��ȯ

*/
SELECT LOWER('WELCOME TO MY WORLAKD!') FROM DUAL;
SELECT UPPER('WELCOME TO MY WORLAKD!') FROM DUAL;
SELECT INITCAP('WELCOME TO MY WORLAKD!') FROM DUAL;

/*
CONCAT
���ڿ� �ΰ��� ���޹޾� �ϳ��� ��ģ �� ����� ��ȯ���ش�. 
CONCAT(STRING, STRING)  --> ����� CHARACTER Ÿ������ ��ȯ�Ѵ� .
*/
SELECT CONCAT('ABC','���ݸ�') FROM DUAL;
select 'abc'||'���ݸ�' From DUAL;

--SELECT CONCAT('ABC','���ݸ�','���ֵ�') FROM DUAL; -- �����߻�, 2���� ���� �� �ִ�. 

select 'abc'||'���ݸ�' || '���ִ�.' From DUAL;

/*
REPLACE(STRING, STR1 , STR2) --STRING �ϳ��� �ְ�, STR1�� STR2�� �ٲٰ� �ʹ�. ������� CHARACTER�̰�, 
SELECT FRM-NAME, EMAIL
FROM EMPLYEE;

SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'kh.or.kr','gmail.com')
FROM EMPLOYEE;


���� ó�� �Լ��� ���ؼ� �˾ƺ���. 
 ABSOLUTE ���밪�� �����ִ� �Լ�. 
 ABS -> ������� NUMBER Ÿ��
 */
SELECT ABS(10) FROM DUAL;
SELECT ABS(10.577) FROM DUAL;
SELECT ABS(-5) FROM DUAL;

/*
MOD
�� ���� ���� ������ ���� ��ȯ���ִ� �Լ�. 

7����. ���� �⺻������ ����Ѵ�. 
*/

SELECT MOD(10,3) FROM DUAL;
SELECT MOD(10.9,3) FROM DUAL;
------------------------------------------------------------------------------------
/*
ROUND
�ݿø��� ����� ��ȯ
ROUND (NUMBER,[��ġ])  => ������� NUMBERŸ��
*/
SELECT ROUND (123.456,1) FROM DUAL;
SELECT ROUND (123.456,-1) FROM DUAL;
SELECT ROUND (123.456,0) FROM DUAL;

/*
CEIL
�ø�ó�� ���ִ� �Լ�
*/
SELECT CEIL(123.152) FROM  DUAL;
--5�̻� �ƴϿ��� ������ �׳� �ø�, ��ġ ���� �Ұ�. 

/*
FLLOR
�Ҽ��� �Ʒ� ����ó�� �ϴ� �Լ�

*/
SELECT FLOOR(123.152) FROM DUAL;
SELECT FLOOR(123.952) FROM DUAL;

/*
TRUNC(�����ϴ�)
��ġ �����ؼ� ����ó�� ���ִ� �Լ� . 
TRUNC(NUMBER,[��ġ])
*/
SELECT TRUNC(123.456) FROM DUAL; -- ��ġ ���� ���� ������ �Ҽ��� �� �⺻���̴�. 
SELECT TRUNC(123.456, 1) FROM DUAL;  -- �Ҽ��� �Ʒ� ù°�ڸ� ���� ǥ���ϰ� �ʹ�.
SELECT TRUNC(123.456, -1) FROM DUAL; -- �ش� ��ġ �ڷ� ����������. 
--<���ó�¥ ó�� �Լ�>
-- SYSDATE : �ý��� ��¥ �� �ð� ��ȯ( ���� ��¥ �� �ð�)
SELECT SYSDATE FROM DUAL; --Ŭ���ظ� ���� �ð� �� Ȯ�ΰ���

--��MONTH BETWEEN(DA1, ED2) : �� ��¥ ������ ���� �� => ���������� DATE1 -(����) DATE2 �� ������ 30,31�� ���� �� ���̴�. 
--������� NUMBER Ÿ��
-- EMPLOYEE, ���� �����, �Ի���, �ٹ� ������

SELECT EMP_NAME, HIRE_DATE, FLOOR(SYSDATE - HIRE_DATE) ||'��' AS "�ٹ��ϼ�", 
CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) ||'����' AS "�ٹ�������"
FROM EMPLOYEE;

/*
ADD_MONTHS(DATE, NUMBER) : Ư����¥�� �ش� ���ڸ�ŭ�� �������� ���ؼ� ��¥�� �����Ѵ�. 
����� : DATEŸ��
*/
SELECT ADD_MONTHS(SYSDATE, 6) FROM DUAL; --6���� ���� ���̸� ���� �� �մ�. 

--EMPOYERR �����, �Ի���, �Ի� �� 6������ �� ��¥ ��ȸ
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE,6) AS "����������"
FROM EMPLOYEE;

/*
NEXT_DAY(DATE, ����(����|����)) : Ư����¥ ���Ŀ� ���� ����� �ش� ������ ��¥�� ��ȯ���ִ� �Լ�
-- ������� DATEŸ��

*/
SELECT SYSDATE, NEXT_DAY(SYSDATE,'������')FROM DUAL;-- ���� ���� 12�� 26�� (�����) �ε� ���� ������ �ٰ����� �������� 12�� 30���̴�. (�����)
SELECT STSDATE, NEXTDAY(SYSDATE, '��') FROM DUAL;
--1. �Ͽ���, ������.. �����. 
SELECT SYSDATE, NEXT_DAY(SYSDATE, 6) FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRIDAY') FROM DUAL;-- ���� �� ,KOREAN �̱� ������ ����� �߻��Ѵ�. 

--��� ����
SELECT * FROM NLS_SESSION_PARAMETERS;

ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
ALTER SESSION SET NLS_LANGUAGE = KOREAN; --Ȯ���� �̰ɷ� �� �ٲٱ�.!

/*
ALST_DAY(DATE) : �ش� ���� ������ ��¥�� ���ؼ� ��ȯ�Ѵ�. 
������� DATEŸ���̴�. 
*/
SELECT LAST_DAY(SYSDATE) FROM DUAL;

--EMPLOYEE���� �����, �Ի���, �Ի��Ѵ��� ������ ��¥, �Ի��� �޿� �ٹ��� �ϼ��� ���غ���
SELECT EMP_NAME,HIRE_DATE , LAST_DAY(HIRE_DATE) AS "�Ի���� ��������", LAST_DAY(HIRE_DATE)-HIRE_DATE AS "ù�� �ٹ��ϼ�"
FROM EMPLOYEE;

/*
EXTRACT: Ư�� ��¥�κ��� �⵵, ��, �� ���� �����ؼ� ��ȯ�ϴ� �Լ�.
EXTRACT(YEAR FROM DATE) : �⵵�� �������ش�. 
EXTRACT(MONTH FROM DATE): ���� �������ش�. 
EXTRACT(DAY FROM DATE) : �ϸ� ������ �ش�. 
-> ����� ���� NUMBERŸ�� �Դϴ�. 
*/
--�����, �Ի�⵵, �Ի��, �Ի��� ��ȸ�� ����. 
SELECT EMP_NAME, 
EXTRACT(YEAR FROM HIRE_DATE) AS "�Ի�⵵",
EXTRACT(MONTH FROM HIRE_DATE) AS "�Ի��",
EXTRACT(DAY FROM HIRE_DATE) AS "�Ի���"
FROM EMPLOYEE
ORDER BY "�Ի�⵵","�Ի��","�Ի���";
------------------------------------------------------------
/*
����ȯ
TO_CHAR : ����Ÿ�� �Ǵ� ��¥Ÿ���� ������ ���� Ÿ������ ��ȯ�����ִ� �Լ��̴�. 

TO_CHAR(���� Ȥ�� ��¥, [����])   ������� CHARŸ���̴�. 
*/
-- ���� Ÿ���� ���� �ִµ� ���� Ÿ������ �ٲٰ� �;�����. 
SELECT TO_CHAR(1234) FROM DUAL;
--������ 1234 ����, ��µ� 1234�� ���̴µ�, ������ �ٲ�����? (INT)1234 -> (STRING)1234�� �ȰŴ�. 

SELECT TO_CHAR(1234,'99999') FROM DUAL;  --5ĭ¥�� ������ Ȯ���ϰ� ���� ���� �� ���̴�. 
SELECT TO_CHAR(1234,'00000') FROM DUAL;
SELECT TO_CHAR(1234,'L99999') FROM DUAL; --���� �ý��ۿ� ������ ������ ȭ������� ��Ÿ����. 
SELECT TO_CHAR(1234,'$99999') FROM DUAL; -- $�� ǥ�ð� �ȴ�. 
SELECT TO_CHAR(1234,'L99,999') FROM DUAL;
SELECT EMP_NAME, SALARY
FROM EMPLOYEE;

SELECT EMP_NAME, TO_CHAR(SALARY, 'L999,999,999')
FROM EMPLOYEE;

--������ ����Ÿ���� ����Ÿ������ �ٲٴ� �����̾���. 
--��¥ Ÿ���� ����Ÿ������ �ٲپ� ����
SELECT SYSDATE FROM DUAL; --�⺻
SELECT TO_CHAR(SYSDATE) FROM DUAL; -- ������� ���� ��������(24/12/26), Ŭ���ؼ� �Ӽ����� ���� �޷��� ���̴� ���� �ƴ�, ���ڰ� ���´�. ��, ����ȯ�� �� ���̴�. 
--���˿� ���� �˾ƺ���.
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL; --���� 12:23:43 (12�ð� ����)
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL; --12:23:43 (24�ð� ����)
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY') FROM DUAL; --2024-12-26 ����� ��
SELECT TO_CHAR(SYSDATE, 'MON,YYYY') FROM DUAL; --12��,2024

SELECT EMP_NAME, HIRE_DATE, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD')
FROM EMPLOYEE;


--�⵵�� ���õ� ����
SELECT TO_CHAR(SYSDATE,'YYYY'),
TO_CHAR(SYSDATE,'YY'),
TO_CHAR(SYSDATE, 'RRRR'),
TO_CHAR(SYSDATE,'RR'),
TO_CHAR(SYSDATE,'YEAR')
FROM DUAL;

--���� ���õ� ����
SELECT TO_CHAR(SYSDATE,'MM'),
TO_CHAR(SYSDATE,'MON'),
TO_CHAR(SYSDATE, 'MONTH'),
TO_CHAR(SYSDATE,'RM')
FROM DUAL;

--�ϰ� ���õ� ����
SELECT TO_CHAR(SYSDATE,'DDD') ,--���ر������� ������ ��ĥ°����.
        TO_CHAR(SYSDATE,'DD'), -- �� �������� ������ ��ĥ����
        TO_CHAR(SYSDATE,'D')  -- �� �������� ������ ���Ϥ� ������ �°� �ִ���, 
FROM DUAL;

--���Ͽ� ���� ����
SELECT TO_CHAR(SYSDATE, 'DAY'), -- �����
TO_CHAR(SYSDATE,'DY')           -- ��
FROM DUAL;

/*
TO_DATE : ����Ÿ�� �ǹ� ����Ÿ�� �����͸� ��¥ Ÿ������ ��ȯ���ִ� �Լ�
TO_DATE(���� OR ����, [����]),��������δ� DATEŸ���� ���´�. 
*/
SELECT TO_DATE(20100101) FROM DUAL;   --> 10/01/01
SELECT TO_DATE(100101) FROM DUAL;  --> �� ����.
SELECT TO_DATE(070101) FROM DUAL; --> ����, ù���ڰ� 0�� ���� ����Ÿ������ �����ϰ� �����ؾ� �Ѵ�. 
SELECT TO_DATE('070101') FROM DUAL;

SELECT TO_DATE('041030 143000') FROM DUAL; --���� �߻�.,
SELECT TO_DATE('041030 143000','YYMMDD HH24MISS') FROM DUAL;

SELECT TO_DATE('140630', 'YYMMDD') FROM DUAL; -- 24�⵵
SELECT TO_dATE('980630', 'YYMMDD') FROM DUAL; -- 2098������ �νĵ�. 
SELECT TO_dATE('140630', 'RRMMDD') FROM DUAL;
SELECT TO_dATE('980630', 'RRMMDD') FROM DUAL;   -- 98�⵵
--�ش� ���ڸ� �⵵ ����  50�̸��� ��� ���� ���� �ݿ�, 50�� ���  �̻��� ���� ���� ���� �ݿ�

--TO_DATE ���ó
--ȣ�ڽ� �Ĺ���. ȭ�鿡�� ������ ���������� �Ѿ��. 
--������� �Լ��� ���ؼ� �ϰ� �ִµ� ���� �Լ��� ���Ѱ͵��� �ϰ� �ִ�. 

/*
TO_NUMBER : ���� Ÿ���� �����͸� ����Ÿ������ ��ȯ�����ִ� �Լ�. 
[ǥ����]
TO_NUMBER(����, [����])  <-- ������� NUMBERŸ������ ���´�. 
*/
SELECT TO_NUMBER('01023122357') FROM DUAL;
--0�� ������ ����Ÿ������ �����, �Ǿտ� 0�� ������ �ڵ����� �����ȴ�. 
SELECT '1' + '55000' FROM DUAL;   --�ڹٿ����� '����+����'���� �׳� �̾����⸸ �ߴµ�, ����Ŭ������ ��������� ���̴ٽ��� �ڵ� ����ȯ���� ���� �� ���������� �� �� �ִ�. 
SELECT '1,100,000' + '55,000' FROM DUAL; --������. ���� �ϋ�, ���ڸ� �־�� �������� �ִ�. 

--SELECT TO_NUMBER('100,000,000', '999,999,999') + TO_NUMBER('55,000','99'999') FROM DUAL;

/*
NULL ó�� �Լ�.
NVL(�÷�, �ش� �÷����� NULL�� ��� ��ȯ�� ��) */
SELECT EMP_NAME, BONUS, NVL(BONUS,0)
FROM EMPLOYEE;

--�� ����� �̸�, ���ʽ� ���� ������ ��ȸ �� ����. (NULLó�� �Լ� ����)
SELECT EMP_NAME, BONUS, (SALARY + SALARY * BONUS)*12, (SALARY + SALARY * NVL(BONUS,0))*12
FROM EMPLOYEE;

SELECT EMP_NAME, DEPT_CODE, NVL(DEPT_CODE,'�μ�����')
FROM EMPLOYEE;

--NVL2(�÷�, ��ȯ��1, ��ȯ��2)
--�÷����� ������ ��� ��ȯ��1 ��ȯ
--�÷����� �������� ���� ��� ��ȯ��2 ��ȯ.
SELECT EMP_NAME, BONUS, NVL2(BONUS, 0.7, 0.1)
FROM EMPLOYEE;


SELECT EMP_NAME, DEPT_CODE, NVL2(DEPT_CODE, '�μ�����', '�μ�����') AS "�μ� ���� ����"
FROM EMPLOYEE;


-- NULLIF(�񱳴��1, �豳���2)
-- �ΰ��� ���� ��ġ�ϸ� NULL��ȯ
-- �ΰ��� ���� ��ġ���� ������ �񱳴�� 1��ȯ
SELECT NULLIF('123', '123') FROM DUAL;
--=============================================================================================
/*
�����Լ� ����.
DECODE (���ϰ��� �ϴ� ���(�÷� OR ������� OR �Լ���) , �񱳰�1, �����1)
*/
--���, �����, �ֹι�ȣ, �ֹι�ȣ ���ڸ��� ù ����.
SELECT EMP_ID, EMP_NAME, EMP_NO, SUBSTR(EMP_NO,8,1),
DECODE (SUBSTR(EMP_NO,8,1),'1',' ����� ','2',' ����� ') AS "����"
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, EMP_NO, SUBSTR(EMP_NO,8,1),
DECODE (SUBSTR(EMP_NO,8,1),'1',' ����� ') AS "����"
FROM EMPLOYEE;

--������ �޿��� ��ȸ�ؼ� �� ���޸�� �λ��ؼ� ��ȸ�غ�����.
--������ J7�λ���� �޿��� 10% �λ��� �޿��� ���̰� ���ּ���
--K6�� ����� �޿��� 15% �λ��� ������ ���̰� ���ּ���
-- J5 �λ���� �޿��� 20%�λ��� �� ó�� ���̰� ���ּ���


--�����, �����ڵ�, �����޿�, �λ�� �޿�. 
SELECT EMP_NAME AS"�����", JOB_CODE AS "���� �ڵ�", SALARY AS "���� �޿�",
DECODE(JOB_CODE,'J7',SALARY+SALARY*0.1,
                'J6',SALARY+SALARY*0.15,
                'J5',SALARY+SALARY*0.2,
                    SALARY * 1.05) AS "�λ�� �޿�"
FROM EMPLOYEE
ORDER BY JOB_CODE;


/*
CASE WHEN THEN
CASE WHEN ���ǽ�1 THEN ����� 1
     WHEN ���ǽ�2 THEN ����� 2
     ...
     ELSE �����99
     END
*/

SELECT EMP_NAME, SALARY,
CASE WHEN SALARY>=5000000 THEN '��ް�����'
     WHEN SALARY>=3000000 THEN '�߱ް�����'
     ELSE '�ʱް�����'
     END AS "����"
FROM EMPLOYEE;


----------------------------------------------------<�׷� �Լ�>-------------------------------------
/*1. SUM(����Ÿ���÷�):�ش� �÷������� �� �հ踦 ���ؼ� ��ȯ���ִ� �Լ�
--EMPLOYEE ���̺��� �� ����� �� �޿���
SELECT SUM(SALARY)   
FROM EMPLYEE; -- ��ü ����� �ϳ��� �׷����� ������. 
*/
--���� ������� �� �޿���
SELECT SUM(SALARY) AS "�ѱ޿��� ��"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1)IN('1','3'); --���� ������� �� �޿�

--�μ��ڵ尡 D5�� ��������� ������. 
SELECT SUM(SALARY*12) AS "D5��� ������"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';


--2. AVG(����Ÿ��) : �ش� �÷������� ��հ��� ���ؼ� ��ȯ
-- ��ü ����� ��� �޿� ��ȸ
SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;

--3. MIN(����Ÿ��) : 
SELECT MIN(EMP_NAME), MIN(SALARY), MIN(HIRE_DATE)
FROM EMPLOYEE;

--4. MAX(����Ÿ��) : ���� ���� �߿� ���� ū �� ���ؼ� ��ȯ
SELECT MAX(EMP_NAME), MAX(SALARY), MAX(HIRE_DATE)
FROM EMPLOYEE;

--5. COOUNT( * OR �÷� OR DISTINCT) :��ȸ�� �� ���� ���� ��ȯ
--   COUNT(*):��ȸ�� ����� ��� �� ���� ���� ��ȯ
--   COUNT(�÷�) : ������ �ش� �÷��ǰ���NULL�� �ƴѰ͸� �� ���� ���� ��ȯ
--   COUNT(DISTINCT �÷�)

--��ü ��� �� 
SELECT COUNT(*)
FROM EMPLOYEE;

--���� ��� ��
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN('2','4');

SELECT COUNT(BONUS)
FROM EMPLOYEE; -- ����� : 9, �ش� ���� NULL���� �ƴ� ��츸 ī������ �ϰ� �����. 

--�μ���ġ�� ���� ��� ��

SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;

--���� ������� �����Ǿ� �ִ� �μ��� ��
SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;






