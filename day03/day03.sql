/*
    9.  REPLACE()
        ==> 문자열의 특정부분을 다른 문자열로 반환해주는 함수
        
            형식 )
                REPLACE(데이터, 찾을문자, 대치문자)
                
    10. TRIM
        ==> 문자열 중에서 앞 또는 뒤에 있는 지정한 문자를 삭제해서 반환해주는 함수
        
        참고 )
            중간에 있는 문자는 삭제하지 못한다.
        
            형식 )
                TRIM(삭제할문자 FROM 데이터)
            참고 )
                같은 문자가 앞, 뒤에 연속되어 있으면 모두 지운다.
            
            참고 )
                가끔 데이터 앞 또는 뒤에 공백문자가 들어간 경우가 있다.
                이런 경우를 대비해서 앞 뒤에 들어간 공백 문자를 제거할 목적으로 많이 사용한다.
                
        10 - 1
            LTRIM
            RTRIM
                형식 )
                    LTRIM(데이터, 삭제할 문자)
                    
    11. CHR()
        ==> ASCII 코드를 알려주면 그 코드에 해당하는 문자를 알려주는 함수
        
        형식 )
            CHR(아스키코드)
            
    12. ASCII()
        ==> 문자열에 해당하는 ASCII 코드를 알려주는 형식
        
        형식 )
            ASCII(데이터)
        
        참고 )
            두 글자 이상으로 된 문자열의 경우는
            첫 문자의 코드값을 반환해준다.
    
    13. TRANSLATE
        ==> REPLACE 와 마찬가지로 문자열 중 지정한 부분을
            바꿔준다.
            
            차이점 )
                REPLACE 함수는 바꿀 문자열 전체를 바꾸는데
                이 함수는 문자단위 처리한다.
            
            형식 )
                TRANSLATE(데이터, 바꿀문자열, 바뀔문자열)
            
            
*/

SELECT
    REPLACE('HONG GIL DONG','N','NN') 홍길동
FROM
    DUAL
;

SELECT
    REPLACE('    HONG GIL DONG        ',' ','') 홍길동
FROM
    DUAL
;

SELECT
    TRIM('    HONG GIL DONG        ') 홍길동
FROM
    DUAL
;

SELECT
    TRIM(' ' FROM '     HONG GIL DONG     ') 홍길동
FROM
    DUAL
;

SELECT
    LTRIM('000000000000000000000ORACLE000000000000000000','0') 오라클
FROM
    DUAL
;

SELECT
    RTRIM(
        LTRIM('000000000000000000000ORACLE000000000000000000','0') ,
        '0'
    ) RTRIM,
    TRIM('0' FROM '000000000ORACLE0000000000') TRIM
FROM
    DUAL
;

SELECT
    RTRIM(
        LTRIM('ooooooooooooracleoooooooooooooooo', 'o'),
        'o'
    ),
    TRIM('o' FROM 'ooooooooooooracleoooooooooooooooo')
FROM
    dual
;

-- ASCII()
SELECT
    ASCII('HONG') 코드값,
    CHR(ASCII('HONG')) 코드값2
FROM
    DUAL
;

SELECT
    TRANSLATE('ADBC','ABCD','1234')
    /*
        'A' --> 1
        'B' --> 2
        'C' --> 3
        'D' --> 4
        로 변환한다.
    */
FROM
    DUAL
;

--------------------------------------------------------------------------------
/*
    날짜 처리 함수
    
        ** 
        참고 )
            SYSDATE
            ==> 예약어. 
                현재 시스템의 날짜와 시간을 알려주는 예약어
                (의사 컬럼으로 보면 된다)
        
        참고 )
            날짜 - 날짜 의 연산식이 가능하다.
            날짜 연번끼리 - 연산을 하게된다.
            
            결합연산자를 쓴다는 것이 연산식이 안 된다는 뜻
            
            날짜데이터의 기준점은 1970년 1월 1일 0시 0분을 기준으로 한다.
            70년 1월 2일이라 함은 기준점에서 하루만큼의 데이터를 추가해서 만든다.
            
            참고 )
                날짜 연번 : 날수.시간
            
        참고 )
            날짜 데이터의 연산은 오직 - 연산만 가능하다.
            날짜 + 날짜,
            날짜 * 날짜,
            날짜 / 날짜
            는 허락하지 않는다.
        
        참고 )
            날짜 +(또는 -) 숫자이므로
                결국 날짜에서 원하는 숫자만큼 이동한 날짜가 된다.
*/

-- 사원들의 근무일수를 조회하시오.
SELECT
    ENAME 이름, 
    SYSDATE - HIREDATE 근무일수
FROM
    EMP
;

SELECT
    SYSDATE + 10 "10일 후"
FROM
    DUAL
;

--------------------------------------------------------------------------------
/*
    날짜 데이터 처리 함수
    
        1.  ADD_MONTHS()
            ==> 현재 날짜에서 지정한 달 수를 더하거나 뺀 날짜를 알려준다.
        
            형식 )
                ADD_MONTHS(날짜,더할 개월수)
                
            참고 )
                더할 개월수에 음수를 입력하면 
                해당 개월수를 뺀 날짜를 알려준다.
                
        2.  MONTHS_BETWEEN
            ==> 두 날짜 데이터의 개월수를 알려주는 함수
            
            형식 )
                MONTHS_BETWEEN(날짜, 날짜)
        
        
        3.  LAST_DAY
            ==> 지정한 날짜가 포함된 월의 마지막 날짜를 알려주는 함수
            
        4.  NEXT_DAY
            ==> 지정한 날짜 이후에 가장 처음 오는 지정한 요일에 해당하는 날짜를 알려주는 함수
            
            형식 _
                NEXT_DAY(날짜, 요일)
                
                참고 )
                    요일 정하는 방법
                        
                        1.  우리는 한글 세팅이 된 오라클이므로
                            '월', '화', '수', ...
                            '월요일', '화요일' ...
                        2.  영문권에서는
                            'SUN','MON'...
                            'SUNDAY','MONDAY'...
        
        
    5. ROUND()
        ==> 날짜를 지정한 부분에서 반올림하는 함수
            이때 지정부분은 년, 월, 일....
            
            형식 )
                ROUND(날짜, 기준단위)
*/

SELECT
    ADD_MONTHS(SYSDATE, 4) AS "4달뒤",
    ADD_MONTHS(SYSDATE, -3) AS "3개월전"
FROM
    dual
;

-- 사원들의 근무 개월수를 조회하시오
SELECT
    ENAME 사원이름,
    HIREDATE 입사일,
    FLOOR(MONTHS_BETWEEN(SYSDATE,HIREDATE)) "근무 개월수"
FROM
    EMP
;

-- 이번달 마지막 날짜를 조회하시오
SELECT LAST_DAY(SYSDATE) FROM DUAL;

-- 사원들의 첫번째 월급을 조회하시오(급여 지급은 매월 말일로 한다)
SELECT
    ENAME 사원이름, SAL 급여, HIREDATE 입사일, LAST_DAY(HIREDATE) "첫 월급날"
FROM
    EMP
;

-- 사원들의 첫번째 월급을 조회하시오. 급여지급은 매월 1일로 한다.

SELECT
    ENAME 사원이름, SAL 급여, HIREDATE 입사일, LAST_DAY(HIREDATE) +1 "첫 월급날"
FROM
    EMP
;

-- 이번주 일요일이 몇일인지 조회하시오
SELECT
    NEXT_DAY(SYSDATE,'일')
FROM
    DUAL
;

-- 올 성탄절 이후 첫 토요일은?/
SELECT
    NEXT_DAY('2022/12/25','토'),
    NEXT_DAY(TO_DATE('2022/12/25','YYYY/MM/DD'),'토') AS "성탄절 후 첫 토요일"
    -- 이 경우는 날짜데이터를 입력해야 하지만
    -- 문자로 입력해도 실행되는 이유는 문자데이터를 날짜데이터로 변환해주는
    -- 함수가 자동호출되서 날짜 데이터로 변환해주기 때문에 그렇다.
FROM
    DUAL
;

-- 현재 시간을 년도를 기준으로 반올림하시오
SELECT TO_CHAR(ROUND(SYSDATE, 'YEAR'),'YYYY/MM/DD HH:mi:ss') 반올림 FROM DUAL;

-- 현재 시간을 월을 기준으로 반올림하시오
SELECT SYSDATE, ROUND(SYSDATE, 'MONTH') "월 반올림" FROM DUAL;

--------------------------------------------------------------------------------
/*
    변환함수
    ==> 함수는 데이터 형태에 따라서 사용하는 함수가 달라진다.
        그런데 만약 사용하려는 데이터가 함수에 필요한 데이터가 아닌경우에는
        데이터의 형태를 변호나해서 사용해야 한다.
        ==> 데이터의 형태를 바꾸어서 특정 함수에 사용가능하도록 만들어 주는 함수
        
                TO_CHAR()           TO_CHAR()
                ----------->      <-----------
        NUMBER  <----------- CHAR ----------->  DATE
                TO_NUMBER()         TO_DATE()
        
    1.  TO_CHAR()
        ==> 날짜나 숫자를 문자 데이터로 변환시켜주는 함수
        
        형식1 )
            TO_CHAR(날짜 또는 숫자)
        
        형식2 )
            TO_CHAR(날짜 또는 숫자, 형식)
            ==> 바꿀 때 원하는 형태를 지정해서 문자열로 변환시키는 방법
            
            주의사항 )
                숫자를 문자로 변환할 때 형식으로 사용하는 문자는 
                    9   :   무효숫자는 표현 안함
                    0   :   무효숫자도 표현함.
            
    2.  TO_DATE()
        ==> 문자로 된 내용을 날짜 데이터로 변환시켜주는 함수.
        
            형식1 )
                TO_DATE(날짜 형식 문자열)
            
            형식2 )
                TO_DATE(날짜형식의 문자데이터, '변환형식')
                ==> 문자열이 오라클이 지정하는 형식의 날짜처럼
                    만들지 못한 경우 사용하는 방법
                    
                    '12/09/91' 처럼 월, 일, 년의 순서로 문자가 만들어졌다면
                    TO_DATE('12/09/91', 'MM/DD/YY')
                    
                    참고 )
                        여기에서의 변환형식이란?
                        입력한 문자데이터가 어떤 의미를 가지고 만들었는지를
                        알려주는 기능.
            
    3.  TO_NUMBER()
        =>  숫자형식의 문자데이터를 숫자로 변환시켜주는 함수
            문자 데이터는 +, - 연산이 안되기 때문에 생겨난 함수이다.
            
            형식1 )
                TO_NUMBER(문자데이터)
            
            형식2 )
                TO_NUMBER(데이터, 변환형식)
                
                변환형식
                    현재 문자열이 어떤 의미로 만들어 졌는지를 알려주는 기능
            
                '1,234' + '5,678'
                TO_NUMBER('1,234','9,999')
*/

/*
    사원들의 사원이름, 입사일, 부서번호를 조회하시오
    단, 입사일은 '0000년 00월 00일' 의 형식으로 조회되게 하시오.
*/
SELECT
    ENAME 사원이름, TO_CHAR(HIREDATE,'YYYY')|| '년 '|| TO_CHAR(HIREDATE,'MM')||'월 '|| TO_CHAR(HIREDATE, 'DD')|| '일' 입사일,
    TO_CHAR(HIREDATE, 'YYYY"년 "MM"월 "DD"일') 한글입사일, 
    DEPTNO 부서번호
FROM
    EMP
;

-- 급여가 100 ~ 999 사이인 사원의 정보를 조회하시오.
SELECT
    ENAME, SAL
FROM
    EMP
WHERE
--    TO_CHAR(SAL) LIKE '___'
    LENGTH(TO_CHAR(SAL)) = 3
;

-- 사원 급여를 조회하는데 앞에는 $를 붙이고 3자리마다 , 를 붙여서 조회하시오.
SELECT
    ENAME 사원이름, SAL 급여,
    TO_CHAR(SAL,'$9,999,999,999,999') 문자급여1,
    TO_CHAR(SAL,'$0,000,000') 문자급여2
FROM
    EMP
;
--------------------------------------------------------------------------------
-- TO_DATE ()

-- 자신이 지금까지 몇일동안 살고 있는지를 알아보자.

SELECT 
    FLOOR(SYSDATE - TO_DATE('1997.01.17')) "살아온 날수",
    FLOOR(SYSDATE - TO_DATE('97-01-17'))   날수,
    FLOOR(SYSDATE - TO_DATE('97/01/17'))   날수2,
    FLOOR(SYSDATE - TO_DATE('97#01#17'))   날수3,
    FLOOR(SYSDATE - TO_DATE('970117'))   날수4
FROM 
    DUAL
;

SELECT FLOOR(SYSDATE - TO_DATE('03/29/97','MM/DD/YY')) FROM DUAL;   
--  2097년으로 되어있기 때문에 음수가 나온다.

SELECT FLOOR(SYSDATE - TO_DATE('12261994','MMDDYYYY')) FROM DUAL;

SELECT FLOOR(SYSDATE - TO_DATE('19941226')) FROM DUAL;

--------------------------------------------------------------------------------
--  TO_NUMBER

--  '123' 과 '456' 을 더한 결과를 조회하시오.
SELECT '123' + '456' result FROM DUAL;  
--  이 경우 형변환 함수가 자동호출이 되기 때문에 계산이 된다.

SELECT TO_NUMBER('123') + TO_NUMBER('456') FROM DUAL;
--  이게 정석

-- '1,234' + '5,678' 를 계산하시오
SELECT 
    TO_NUMBER('1,234','9,999') + 
    TO_NUMBER('5,678','9,999') "1,234 + 5,678" 
FROM 
    DUAL
;

--------------------------------------------------------------------------------
/*
    기타 함수
    
    1.  NVL()
        ==> NULL 데이터는 모든 연산(함수)에 적용되지 못한다.
            이 문제를 해결하기 위해서 제시된 함수.
            
            의미 )
                NULL 데이터이면 강제로 지정한 데이터로 바꾸어서
                연산, 함수에 적용하도록 하는 함수.
                
            형식 )
                NVL(데이터, 바뀔 내용)
                
            ***
            주의 )
                지정한 데이터와 바뀔 내용은 반드시 형태가 일치해야 한다.
    
    2.  NVL2()
        형식 )
            NVL2(필드이름, 처리내용1, 처리내용2)
        
        의미 )
            필드의 내용이 NULL 이면 처리내용2를
            NULL 이 아니면 처리내용1으로 처리하시오.

    3.  NULLIF
        형식 )
            NULLIF(데이터1,데이터2)
        
        의미 )
            두 데이터가 같으면 NULL 로 처리하고
            두 데이터가 다르면 데이터1 으로 처리하시오.
            
    4.  COALESCE()
        형식 )
            COALESCE(데이터1, 데이터2, ...)
        
        의미 )
            여러 개의 데이터 중 가장 첫 번째 나오는 NULL 이 아닌 데이터를 출력하시오
    
    
    
*/

SELECT
    ENAME 사원이름, --NVL(COMM, 'NONE') 커미션 -- 대체할 데이터의 형태가 달라서 에러발생
    NVL(TO_CHAR(COMM),'없음') 커미션문자,
    NVL(COMM, 0) 커미션숫자 -- 이 경우 TURNER와 NULL이 구분이 안된다.
/*
    반드시 데이터와 대체할 데이터의 형태는 일치시켜줘야 한다.
*/
FROM
    EMP
;

--  NVL2
--  커미션이 있으면 급여를 급여 + 커미션으로 출력하고
--  커미션이 없으면 급여를 급여만 출력하시오
SELECT
    ENAME, NVL2(COMM, SAL+COMM, SAL) 급여
FROM
    EMP
;

--  커미션을 출력하는데 만약 커미션이 NULL 이면 급여를 대신 출력하도록 하시오
SELECT
    ENAME, COMM, SAL, COALESCE(COMM, SAL, 0)
FROM
    EMP
;

/*
    문제 1)
        COMM 이 존재하면 
            현재 급여의 10% 를 인상한 금액 + 커미션을
        존재하지 않으면
            현재 급여의 5% 를 인상한 금액 + 100
        으로 조회하시오.
        조회 내용은
            사원이름, 급여, 커미션, 지급급여
        로 조회하시오
*/
SELECT
    ENAME 사원이름, SAL 급여, COMM 커미션, FLOOR(NVL2(COMM, SAL*1.1+COMM, SAL*1.05+100)) 지급급여
FROM
    EMP
;
/*
    문제 1)
        커미션에 50% 를 추가해서 지급하고자 한다
        만약 커미션이 존재하지 않으면
        급여를 이용해서 10% 를 지급하고자 한다.
        조회 내용은
            사원이름, 급여, 커미션, 지급급여
        로 조회하시오
*/
SELECT
    ENAME 사원이름, SAL 급여, COMM 커미션, ROUND(NVL(SAL + COMM *1.5, SAL *1.1)) 지급급여
FROM
    EMP
;

SELECT
    ENAME 사원이름, COMM 커미션, SAL 급여, COALESCE(COMM * 1.5, SAL * 1.1) 지급커미션
FROM
    EMP
;



--------------------------------------------------------------------------------
/*
    조건 처리 함수
    ==> 함수라기 보다는 오히려 명령에 가깝다.
        자바의 switch~case, IF 를 대신하기 위해서 만들어 놓은 것
        
    1.  DECODE  :  switch~case 명령에 해당하는 함수
        
        형식 )
            
            DECODE(필드이름, 값1, 처리내용1,
                             값2, 처리내용2,
                             ...
                             처리내용n)
        
        의미 )
            필드의 내용이 
                값1과 같으면 처리내용1
                값2와 같으면 처리내용2
                ...
                그 이외의 값은 처리내용n
                으로 처리하시오.
        
        주의 )
            DECODE 함수 내에서는 조건식을 사용할 수 없다.
    
    2.  CASE : IF 명령에 해당하는 명령
        
        형식1 )
            
            CASE    WHEN    조건식1    THEN    내용1
                    WHEN    조건식2    THEN    내용2
                    ...
                    ELSE    내용N
            END
        
         의미 )
            조건식1이 참이면 내용1을
            조건식2가 참이면 내용2를
            ...
            그 이외에는 내용n을 실행하시오.
            
        형식2 )
            CASE    필드이름    WHEN    값1  THEN    실행내용1
                                WHEN    값2  THEN    실행내용2
                                ...
                                ELSE    내용N
            END
        
        의미 )
            DECODE 함수와 동일한 의미
       
            
            
            
*/

/*
    사원들의 사원이름, 사원직급, 부서번호, 부서이름 을 조회하시오.
    부서이름은
        부서번호가 10 이면 회계부
                   20 이면 연구부
                   30 이면 영업부
                   나머지는 관리부
    로 처리하시오
*/
SELECT
    ENAME 사원이름, JOB 사원직급, DEPTNO 부서번호,
    DECODE(DEPTNO, 10, '회계부',
                   20, '연구부',
                   30, '영업부',
                   '관리부') 부서이름
FROM
    EMP
;

SELECT
    ENAME 사원이름, COMM 커미션, SAL 급여,
    COALESCE(SAL + COMM * 1.5, SAL * 1.1) 지급커미션,
    CASE    WHEN    COMM IS NULL THEN SAL * 1.1
            WHEN    COMM*1.5 > SAL*1.1  THEN COMM*1.5
            ELSE    SAL*1.1
    END "지급급여"
FROM
    EMP
;


/*
    급여가 1000 미만이면 20% 인상하고
            1000 ~ 3000 미만이면 15% 인상하고
            3000    이상이면 10% 인상한
    사원들의
        사원이름, 직급, 급여, 인상급여를 조회하시오.
*/

SELECT
    ENAME 사원이름, JOB 직급, SAL 급여,
    FLOOR(
    CASE  WHEN  SAL < 1000 THEN SAL*1.2
          WHEN  SAL < 3000 THEN SAL*1.15
          ELSE  SAL*1.1
    END) "인상급여"
FROM
    EMP
;

--------------------------------------------------------------------------------
/*
    그룹함수
    ==> 여러 행의 데이터를 하나로 만들어서 뭔가를 계산하는 함수
    
        ***
        참고 )
            그룹함수는 결과가 오직 한 개만 나오게 된다.
            따라서 그룹함수는 결과가 여러개 나오는 경우와 혼용해서 사용할 수 없다.
            오직 결과가 한줄로만 나오는 것과만 혼용할 수 있다.
    
    1.  SUM
    ==> 데이터의 합계를 구하는 함수
        형식 )
            SUM(필드이름)
            
    2.  AVG
    ==> 데이터의 평균을 구하는 함수
        형식 )
            AVG(필드이름)
        
        참고 )
            NULL 데이터는 모든 연산에서 제외가 되기 때문에
            평균을 구하는 연산에서도 완전히 제외된다.
        
    3.  COUNT
    ==> 데이터들의 갯수를 구하는 함수
        지정한 필드 중에서 데이터가 존재하는 필드의 갯수를 알려주는 함수
        형식 )
            COUNT(필드이름)
            
        참고 )
            필드이름 대신 * 를 사용하면
            각각의 필드의 카운트를 따로 구한 후
            그 결과 중에서 가장 큰 값을 알려준다.
            
    4.  MAX / MIN
    ==> 지정한 필드의 데이터 중에서 가장 큰값(또는 작은값)을 알려주는 함수 
        형식 )
            MAX(필드이름)
        
    ----------------------몰라도 되는 애들--------------------------------------
    5.  STDDEV
    ==> 표준편차를 구해주는 함수
    
    6.  VARIANCE
    ==> 분산을 구해주는 함수
    
*/

--  사원들의 급여의 합계를 조회하시오
SELECT
    SUM(SAL) 총급여, MAX(SAL) "최대 급여", MIN(SAL) "최소 급여",
    COUNT(*) 사원수, ROUND(AVG(SAL)) "평균 급여", ROUND(AVG(COMM)) "평균 커미션"
FROM
    EMP
;

SELECT AVG(COMM), FLOOR(SUM(COMM)/14) FROM EMP;

--------------------------------------------------------------------------------
/*
    GROUP BY
    ==> 그룹 함수에 적용되는 그룹을 지정하는 것.
        조회를 할 때 대상을 그룹핑을 해서 조회하는 방법

        예 )
            부서별 급여의 합계를 구하고 싶다.
            직급별 급여의 평균을 조회하고 싶다.

        형식 )
            
            SELECT
                그룹함수, 그룹 기준 필드
            FROM
                테이블 이름
            [WHERE
                조건식]
            GROUP BY
                필드 이름
            [HAVING
                조건]
            ORDER BY
                필드이름...
      
      참고 )
        GROUP BY 를 사용하는 경우에는
        GROUP BY 에 적용된 필드는 같이 조회할 수 있다.
     
     HAVING
     ==>    그룹화 한 경우 계산된 그룹 중에서 출력에 
            적용될 그룹을 지정하는 조건식을 기술하는 절
     
        ***
        참고 )
            WHERE 조건절 계산에 포함된 데이터를 선택하는 조건절
            HAVING 조건은 그룹화해서 계산한 후 출력할지 말지를 결정하는 조건절
            
            
        *****
        참고 )
            WHERE 절 안에서는 그룹함수를 사용할 수 없다.
            하지만 HAVING 절 안에서는 그룹함수를 사용할 수 있다.
*/

SELECT 
    SUM(SAL), DEPTNO
FROM
    EMP
GROUP BY
    DEPTNO
ORDER BY
    DEPTNO
;

--  직급별 급여평균을 직급명과 함께 조회하시오
SELECT
    JOB 직급, ROUND(AVG(SAL)) "급여 평균"
FROM
    EMP
GROUP BY
    JOB
ORDER BY
    AVG(SAL)
;

/*
    부서별 최대 급여를 조회하는데 
    부서번호가 
        10번이면 회계부
        20번이면 연구부
        30번이면 영업부
        그 이외는 관리부
    조회되게 하고
    부서번호, 부서이름, 부서최대급여
    를 조회하시오
*/
SELECT
    DEPTNO 부서번호, 
    DECODE(DEPTNO, 10, '회계부',
                    20, '연구부',
                    30, '영업부',
                    '관리부') 부서이름,
    MAX(SAL) 부서최대급여
    --  최대급여를 받는 사람이 다수일 경우가 있기 때문에 사람은 안됨
FROM
    EMP
GROUP BY
    DEPTNO
;

select dname, ename, sal
from emp e, dept d
where (e.deptno, sal) in (select deptno, max(sal)
                              from emp e1
                            group by deptno)
and  e.deptno = d.deptno;

--  부서별 평균 급여를 조회하시오. 
--  단, 부서평균 급여가 2000 이상인 부서만 조회되도록 하시오
SELECT
    DEPTNO 부서번호, ROUND(AVG(SAL)) "부서별 평균 급여"
FROM
    EMP E

GROUP BY
    DEPTNO

HAVING
    AVG(SAL) >= 2000
;

--  직급별 사원수를 조회하시오
--  단, 사원수가 1명인 직급은 조회되지 않게 하시오.

SELECT
    JOB 직급, COUNT(*) 사원수
FROM
    EMP
GROUP BY
    JOB
HAVING
    COUNT(*) > 1
;


































































































































































































