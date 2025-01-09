
/*
오라클에서 제공하는 객체들에 대해서 배우고 있다. 
시퀀스<SEQUENCE>

자동으로 번호를 발생시켜주는 역할을 하는 객체
정수값을 순차적으로 일정값 씩 증가시키면서 생성해줌(기본적으로는 1씩 증가)
ㄷEX) 회원번호, 사원번호, 게시글번호 등 절대 겹처서는 안되는 데이터들.


1. 시퀀스 객체 생성 하는 법
[표현법]
CREATE TABLE SEQUENCE 시퀀스명

좀더 커스텀 하고 싶다면? 
[상세 표현법]
CREATE SEQUENCE 시퀀스 명
[START WITH 시작숫자]  --> 처음으로 발생시킬 시작값 지정된다.(기본값 1)
[INCREAMENT BY 숫자] -- 얼마나 , 몇씩 증가 시킬건지에 대한 구문(기본값 1)


100 에서 시작해서 200 으로 지나 301 까지 왔는데 302에서 멈췄으면 좋겠다. (마무리값)
[MAXVALUE 숫자]   --> 이거 안쓰면, 무한대인가요? 그런건 아닌데, 최대값이 너무 커서 꼭 지정해줘야함.(최대값 지정)
[MINVALUE 숫자]  --> 최소값 지정 -> 최대값을 찍고 첫값으로 다시 돌아와서 시작할때. 시퀀스가 한 번 끝나고 다시 돌아올떄. 
[CYCLE|NOCYCLE] --> 값 순환 여부 지정(NOCYCLE)
[NOCACHE|CACHE 바이트 크기]  --> 캐시메모리 할당(기본값 CACHE 20)

* 캐시메모리 : 임시공간
        미리 발생될 값들을 생성해서 저장해두는 공간
        매번 호출 될때마다 새롭게 번호를 생성한느 것이 아니라. 
        캐시 메모리 공간에 미리 생성된 값들을 가져다 쓸수가 있다. (속도가 빨라짐)
        접속이 해제가 되면 , 캐시메모리에 미리 만들어둔 번호들이 사라진다. 
        번호가 일정하게 부여 안될 수 있으니 확인을 잘 해야한다. 
*/
CREATE SEQUENCE SEQ_TEST;
--[참고] 현재 계정이 소유하고 있는 시퀀스의 구조들을 보고자 할때 사용함

SELECT * FROM USER_SEQUENCES;

CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

/*시퀀스 사용 하는 방법에 대해서 알아보자.

시퀀스명.CURRVAL : 현재 시퀀스의 값 (마지막으로 성공적으로 수행된  NEXTVAL의 값)
시퀀스명.NEXTVAL : 시퀀스값에 일정값을 증가시켜서 발생된 값..
                    현재 시퀀스값에서 INCREAMENT BY 값 만큼 증가된 값. 
                    --시퀀스명.CURRVAL+INCREMENT BY

*/

SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
--ORA-08002: sequence SEQ_EMPNO.CURRVAL is not yet defined in this session
*Action:   select NEXTVAL from the sequence before selecting CURRVAL

--NEXTVAL를 단 한번도 수행하지 않는 이상 CURRVAL 할 수 없음
--왜? 마지막으로 성공적으로 수행된 NEXT VAL 값이 CURRVAL 이기 때문이다. 

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --300
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 마지막으로 성공한 NEXT 값을 출력 (300)

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --305
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --310

SELECT * FROM USER_SEQUENCES

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --지정한 MAX VALUE값을 초과 했지 때문에 오류 발생 (실패!)

SELECT SEQ_EMPNO.CURRVAL FROM DUAL; --310;

/*
3. 시퀀스 구조 변경
ALTER SEQUENCES 시퀀스명
[INCREAMENT BY 숫자] -- 얼마나 , 몇씩 증가 시킬건지에 대한 구문(기본값 1)
100 에서 시작해서 200 으로 지나 301 까지 왔는데 302에서 멈췄으면 좋겠다. (마무리값)
[MAXVALUE 숫자]   --> 이거 안쓰면, 무한대인가요? 그런건 아닌데, 최대값이 너무 커서 꼭 지정해줘야함.(최대값 지정)
[MINVALUE 숫자]  --> 최소값 지정 -> 최대값을 찍고 첫값으로 다시 돌아와서 시작할때. 시퀀스가 한 번 끝나고 다시 돌아올떄. 
[CYCLE|NOCYCLE] --> 값 순환 여부 지정(NOCYCLE)
[NOCACHE|CACHE 바이트 크기]  --> 캐시메모리 할당(기본값 CACHE 20)

    -- START WITH 는 변경이 불가하다. 이미 시작했는데 어캐 바꾸누? 라고 선생님이 하심. 
    
*/


ALTER SEQUENCE SEQ_EMPNO
INCREMENT BY 10
MAXVALUE 400;

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
--310 + 10  == 320


--시퀀스 삭제 하기
 DROP SEQUENCE SEQ_EMPNO;
 
-- 사원번호로 활용할 시퀀스 생성해보자.
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
        , '차은우'
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
        , '반데사르'
        , '222222=2222222'
        , 'J2'
        ,'S1'
        , SYSDATE
        );
        
        
        --쿼바는 NEXTVAL의 마지막 값을 수행 하는 문.
    
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
        , '차은우'
        , '111111=1111111'
        , 'J7'
        ,'S1'
        , SYSDATE
        );















