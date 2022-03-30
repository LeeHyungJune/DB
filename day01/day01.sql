/*
    자바주석 처리부분
    
    sqldeveloper 에서만 가능한 주석
    
    ------------------------------------------
    질의 명령
        질의 : 물어본다는 의미
        
        데이터베이스 관리시스템한테 해당 데이터가 어디있는지 문의를 한다고 해서
        질의 명령이라 한다.
        
SQL : Structured Qurey Language 의 약자
        구조화된 쿼리 언어
        
        이미 구조화되어있는 명령을 사용해서 데이터를 조작하는 언어
        프로그램이 불가능하다는 점이 특징
    
    명령종류 )
        1.  DML 명령
            -   Data Manipulation Language(데이터 조작 언어)
            ==> 데이터를 추가, 수정, 삭제, 조회하는 작업을 하는 명령
                
                데이터를 조작하는 방법
                      의미          명령
                C   : CREATE    -   INSERT
                R   : READ      -   SELECT
                U   : UPDATE    -   UPDATE
                D   : DELETE    -   DELETE
            
        2.  DDL 명령
            -   Data Definition Language(데이터 정의 언어) 
            ==> 개체를 만들고 수정하는 언어
            
                CREATE      :   개체(테이블, 사용자, 함수, 인덱스...) 를 만들때 사용하는 명령
                ALTER       :   개체를 수정하는 명령
                DROP        :   개체를 삭제하는 명령
                TRUNCATE    :   테이블을 잘라내는 명령
                
            
            
        3.  DCL 명령
            -   Data Control Language(데이터 제어 언어)
            ==> 작업을 적용시킨다던지 (TCL 명령 : Transaction Control Language)
                권한을 준다던지...
                
                COMMIT
                ROLLBACK
                
                GRANT
                REVOKE
            
            
 ------------------------------------------------------------------------------
 
*/

-- 이것은 오라클 주석

select * from emp;

select empno, ename, job, mgr, hiredate, sal, comm, dname, loc from emp e, dept d where d.deptno = e.deptno;

/*
    참고 )
        오라클의 질의명령은 명령을 구분하는 문자로 ; 을 사용한다
        
        따라서 질의명령을 작성하는데 ;(세미콜론)을 적지 않으면
        명령이 끝나지 않은 것으로 간주한다.
        
        하나의 명령이 종료되면 반드시 세미콜론(;)을 적어줘야 한다
*/

select  * from emp;

select * from dept;

-------------------------------------------------------------------------------
/*
    테이블의 구조를 조회해보는 명령
    형식 )
        dersctribe  테이블이름;
        desc    테이블이름;
    
*/    

-- emp 테이블의 구조를 조회해보자
describe emp;

desc emp;

/*
    오라클의 데이터 타입
        
        숫자
            NUMBER, NUMBER(숫자)  ->  숫자는 사용자릿수
            NUMBER(유효자릿수, 소수이하자릿수)
        문자
            CHAR
            ==> 고정 문자수 문자열 데이터 타입
            
                형식 )
                    CHAR(숫자)    --> 바이트 수 만큼의 문자 기억
                    CHAR(숫자 CHAR)   --> 숫자 갯수만큼의 문자 기억
            VARCHAR2
            ==> 가변 문자수 문자열 데이터 타입
                
                형식 )
                    VARCHAR2(숫자)    --> 숫자수 만큼의 바이트 만큼 문자 기억
                    VARCHAR2(숫자 VHAR)   --> 숫자 갯수 만큼의 문자를 기억할 수 있다.
                    
                예 )
                    
                    CHAR(10)
                    ==> 'A' ==> 이 문자를 기억할 때 10 바이트를 모두 사용한다.
                    VARCHAR2(10)
                    ==> 'A' ==> 1바이트로 문자를 기억
                    
        날짜
            DATE
                형식 )
                    DATE
        
*/
-------------------------------------------------------------------------------------
/*
    데이터 조회 명령
        
        SELECT
            컬럼 이름들... 콤마(,) 로 구분해서 나열
        FROM
            테이블 이름들... 콤마(,) 로 구분해서 나열
        [WHERE
                    ]
        [GROUP BY
        
        [HAVING
                    ]]
        [ORDER BY
                    ]
*/

-- 부서정보 테이블의 정보를 조회하세요.

SELECT
    deptno, dname, loc
FROM
    dept
;

-- 1 + 4 의 결과를 조회하시오.

select 1 + 4 from emp;

select '양동수' from emp;

/*
    문자열 데이터 표현 : '' 에 데이터 표현
    오라클에서는 문자와 문자열을 구분하지 않는다.
    
    참고 )
        오라클에서 테이블 이름, 칼럼 이름, 연산자, 함수이름 들은 대소문자를 구분하지 않는다.
        
*/

-- 조건 검색
/*
    SELECT
        컬럼이름
    FROM
        테이블이름
    WHERE
        조건(결과값이 반드시 논리값이 되어야 한다.)
    
    조건 )    
        비교연산자
        =       :   같다
        >       :   크다
        <       :   작다
        <=      :   작거나같다
        >=      :   크거나같다
        !=      :   다르다
        <>      :   다르다
        
        역시 오라클에서도 동시에 두 개를 비교하는 것은 안된다.
            예 )
                700 < sal < 1200 ===>   X
                
    참고 )
        오라클은 데이터의 형태를 매우 중요시한다.
        원칙적으로 문자는 문자끼리만 비교할 수 있고
        숫자는 숫자끼리만 비교할 수 있다.
        단, 
            날짜는 문자처럼 비교할 수 있다.
            이때 날짜 데이터와 문자데이터를 비교하는 것이 아니고 
            문자데이터를 날짜 데이터로 변환 후 비교하게 된다.
    
    참고 )
        오라클은 문자도 크기비교가 가능하다.
        아스키코드값으로 비교를 하기 때문에...
        
    참고 )
        오라클은 문자와 문자열의 구분이 없다.
        대신 문자열 데이터의 대소문자는 반드시 구분해서 처리해야 한다.
        
    참고 )
        조건을 비교하는 방법은 오라클이 한 줄을 출력할 때마다
        그 행이 조건에 맞는지를 확인한 후
        조건이 맞으면 출력하게 된다.
        
    참고 )
        조건절에 조건을 여러개 나열하는 경우는
        AND 또는 OR 연산자를 이용해서 나열한다.
        
        이때 조회시간은 처음 조건이 많이 걸러내는 조건일수록 짧아진다.
*/

-- 사원이름이 'smith' 인 사원의 급여를 조회하시오

select
    sal
from
    emp
where
    ename = 'smith'     --  데이터 자체는 대소문자를 구분해줘야 한다
;

--------------------------------------------------------------------------------

-- 사원 중 직급이 MANAGER 이고 부서번호가 10번ㅇ니 사원의 이름을 조회하시오.

SELECT
    ename
FROM
    emp
WHERE
    job = 'MANAGER' 
    AND DEPTNO = 10
;

/*
    EMP 테이블
        
        EMPNO       :   사원번호
        ENAME       :   사원이름
        JOB         :   사원직급
        MGR         :   상사번호
        HIREDATE    :   입사일
        SAL         :   급여
        COMN        :   커미션
        DEPTNO      :   부서번호
*/


/*
    1.
    사원 이름이 SMITH 인 사원의
        이름, 직급, 입사일을 조회하세요.
*/  
SELECT
    ENAME, JOB, HIREDATE
FROM
    EMP
WHERE
    ENAME = 'SMITH'
;
/*
    2.
    직급이 MANAGER 인 사원의 
        이름, 직급, 급여
    를 조회하시오
*/
SELECT
    ENAME, JOB, SAL
FROM
    EMP
WHERE
    JOB = 'MANAGER'
;
/*
    3.
    급여가 1500 을 넘는 사원들의 
        사원이름, 직급, 급여를 조회하시오
*/
SELECT
    ENAME, JOB, SAL
FROM
    EMP
WHERE
    SAL > 1500
;
/*
    이름이 'S' 이후의 문자로 시작하는 사원들의(s포함)
    사원이름, 직급, 급여를 조회하시오
*/
SELECT
    ENAME, JOB, SAL
FROM
    EMP
WHERE
    ENAME >= 'S'
;


/*
    입사일이 81년 8월 이전에 입사한 사원들의
        사원이름, 입사일, 급여를 조회하시오
*/
SELECT
    ENAME, HIREDATE, SAL
FROM
    EMP
WHERE
    HIREDATE < '81/08/01'
;

--  부서번호가 10 번 또는 30 번인 사원들의 이름, 직급, 부서번호 조회
SELECT
    ENAME, JOB, DEPTNO
FROM
    emp
WHERE
/*
    DEPTNO = 10
    OR DEPTNO = 30
*/
    DEPTNO IN(10, 30)
;

/*
    NOT 연산자
    ==> 조건식의 결과를 부정하는 연산자
        
        형식 )
            WHERE
                NOT 조건식
*/

-- 부서번호가 10번이 아닌 사원들의 이름, 직급, 부서번호를 조회하시오
SELECT
    ENAME, JOB, DEPTNO
FROM
    emp
WHERE
--    NOT DEPTNO = 10
    DEPTNO != 10
;

/*
    5.
        급여가 1000 ~ 3000 인 사원들의 
        이름, 직급, 급여 조회
*/
SELECT
    ENAME, JOB, SAL
FROM
    EMP
WHERE
    SAL > 1000
    AND SAL < 3000
;
/*
    6.  
        직급이 MANAGER 이면서 급여가 1000 이상인 사원들의
        사원이름, 직급, 입사일, 급여 조회
*/
SELECT
    ENAME, JOB, HIREDATE, SAL
FROM
    EMP
WHERE
    JOB = 'MANAGER'
    AND SAL > 1000
;

-------------------------------------------------------------------------
/*
    특별한 조건 연산자
    
    1.  BETWEEN ~ AND
    ==> 데이터가 특정 범위 안에 있는지를 확인하는 연산자
        
        형식 )
            컬럼 이름    BETWEEN    데이터1  AND  데이터2
            ==>  작은 데이터가 먼저 와야 함
            컬럼의 내용이 데이터1 과 데이터2 사이에 있는지를 검사한다.
            
                예 )
                급여가 1000 ~ 3000 사이인 사원들의 
                사원이름,급여를 조회하세요.

SELECT
    ENAME, SAL
FROM
    EMP
WHERE
    SAL BETWEEN 1000 AND 3000
;
            주의 )
                값이 작은 데이터가 데이터1에 와야 한다.
                
                부정을 할 경우에는 BETWEEN 앞에 NOT 을 붙여준다.
                
    2.  IN
    ==> 데이터가 주어진 데이터들 중 하나인지를 검사하는 연산자
    
        형식 )
            필드  IN(데이터1, 데이터2, ...)
            
            예 )
                부서번호가 10, 30 번인 사원들의 
                이름, 직급, 부서번호를 조회하시오
SELECT
    ENAME, JOB, DEPTNO
FROM
    EMP
WHERE
    DEPTNO IN (10, 30)
;
            
    3.  LIKE    (문자열 비교 연산자)
    ==> 문자열을 처리하는 경우에만 사용하는 방법으로
        문자열의 일부분을 와일드 카드 처리하여
        조건식을 제시하는 방법
        
        형식 ) 
            필드 LIKE '와일드카드'
        의미 )
            데이터가 지정한 문자열 형식과 동일한지를 판단한다.
            
        참고 )
            와일드카드 사용법
                
                _   :   한 개당 한 글자만을 와일드카드로 지정하는 것
                %   :   글자수에 관계없이 모든 문자를 포함하는 와일드카드
                문자를 쓰게 되면 그 위치에 문자가 와야한다.
                
                예 )
                    'M%'    -   'M' 으로 시작하는 모든 문자열
                    'M__'   -   'M' 으로 시작하는 3 문자로 이루어진 문자열
                    '%M%'   -   M 이 포함된 모든 문자열
                    '%M'    -   M 으로 끝나는 문자열
                    

    
*/


/*
    직급이 MANAGER, SALESMAN 이 아닌 사원들의
    사원이름, 직급, 급여를 조회하세요.
*/
SELECT
    ENAME, JOB, SAL
FROM
    EMP
WHERE
    JOB NOT IN ('MANAGER', 'SALESMAN')
;

----------------------------------------------------------------------
/*
    LIKE
*/

/*
    이름이 다섯글자인 사원들의
    사원이름, 직급을 조회하세요.
*/
SELECT
    ENAME, JOB
FROM
    emp
WHERE
    ENAME LIKE '_____'
;

/*  
    입사일이 1월인 사원들의 사원이름, 입사일 조회하시오
*/
SELECT
    ename, hiredate
FROM
    emp
WHERE
    hiredate like '__/01/__'    --  81/01/01
;


/*
    참고 )
        조회되는 컬럼의 별칭을 부여해서 조회 가능.
        
        형식 )
            컬럼이름    별칭
            
            컬럼이름    AS  별칭
            
            컬럼이름    "별칭"
            
            컬럼이름    AS  "별칭"
            
            참고 )
                공백이 포함된 별칭의 경우는 큰 따옴표로 감싼다.
*/

---------------------------------------------------------------------------------

/*
    문제 1 )
        부서번호가 10번인 사원들의
            이름, 직급, 입사일, 부서번호
        를 조회하시오
*/
SELECT
    ENAME, JOB, HIREDATE, DEPTNO
FROM
    EMP
WHERE
    DEPTNO = 10
;
/*
    문제 2 )
        직급이 'SALESMAN' 인 사원들의
            이름, 직급, 급여
        를 조회하시오
        단, 필드 이름은 제시한 이름으로 조회되게 하시오
*/
SELECT
    ENAME "이름", JOB AS 직급, SAL AS "급여"
FROM
    EMP
WHERE
    JOB = 'SALESMAN'
;
/*
    문제 3 )
        급여가 1000 보다 적은 사원들의
        이름, 직급, 급여를 조회하시오.
                
*/
SELECT
    ENAME, JOB, SAL
FROM
    EMP
WHERE
    SAL < 1000
;
/*
    문제 4 )
        사원 이름이 'M' 이전의 문자로 시작하는 사원들의
        사원이름, 직급, 급여를 조회하시오.
                
*/
SELECT
    ENAME, JOB, SAL
FROM
    EMP
WHERE
    ENAME < 'M'
;
/*
    문제 5 )
        입사일이 1981년 9월 8일 입사한 사원의
        이름, 직급, 입사일을 조회하시오.
*/
SELECT
    ENAME, JOB, HIREDATE
FROM
    EMP
WHERE
    HIREDATE = '81/09/08'
;
/*
    문제 6 )
      사원이름이 'M' 이후 문자로 시작하는 사원 중
      급여가 1000 이상인 사원의
      사원이름, 급여, 직급을 조회하시오
*/
SELECT
    ENAME, SAL, JOB
FROM
    EMP
WHERE
    ENAME > 'M'
    AND SAL >= 1000
;

/*
    문제 7 )
      직급이 'MANAGER' 이고 급여가 1000보다 크고
      부서번호가 10번인 사원의
      사원이름, 직급, 급여, 부서번호를 조회하시오
*/
SELECT
    ENAME, JOB, SAL, DEPTNO
FROM
    EMP
WHERE
    JOB = 'MANAGER'
    AND SAL > 1000
    AND DEPTNO = 10
;
/*
    문제 8 )
      직급이 'MANAGER' 인 사원을 제외한 사원들의
      사원이름, 직급, 입사일을 조회하시오
      단, NOT 연산자를 사용하시오.
*/
SELECT
    ENAME, JOB, HIREDATE
FROM
    EMP
WHERE
    NOT JOB = 'MANAGER'
;
/*
    문제 9 )
      사원 이름이 'C' 로 시작하는 것보다 크고 
      'M' 으로 시작하는 것보다 작은 사원의 
      사원이름, 직급, 급여을 조회하시오
      단, BETWEEN 연산자를 사용하시오
*/
SELECT
    ENAME, JOB, SAL
FROM
    EMP
WHERE
    ENAME BETWEEN 'C' AND 'M'
;
/*
    문제 10 )
      급여가 800, 950 이 아닌 사원들의
      사원이름, 직급, 급여을 조회하시오
      단, IN 연산자를 사용하시오
*/
SELECT
    ENAME, JOB, SAL
FROM
    EMP
WHERE
    SAL NOT IN (800, 950)
;

/*
    문제 11 )
      사원이름이 S로 시작하고 다섯글자인 사원들의
      사원이름, 직급, 급여를 조회하시오
*/
SELECT
    ENAME, JOB, SAL
FROM
    EMP
WHERE
    ENAME LIKE 'S____'
;
/*
    문제 12 )
      입사일이 3일인 사원들의 
      사원이름, 직급, 입사일을 조회하시오
*/
SELECT
    ENAME, JOB, HIREDATE
FROM
    EMP
WHERE
    HIREDATE LIKE '__/__/03'
;

/*
    문제 13 )
     사원 이름의 글자 수가 4글자 이거나 5글자인 사원의
     사원이름, 직급을 조회하시오
*/
SELECT
    ENAME, JOB
FROM
    EMP
WHERE
    ENAME LIKE '____'
    OR ENAME LIKE '_____'
;

/*
    문제 14 )
     입사년도가 81년도이거나 82년도인 사원들의 
     사원이름, 급여, 입사일을 조회하시오
*/
SELECT
    ENAME, SAL, HIREDATE
FROM
    EMP
WHERE
    HIREDATE LIKE '81%'
    OR HIREDATE LIKE '82%'
;

/*
    문제 15 )
     사원 이름이 S로 끝나는 사원의
     사원이름, 급여, 커미션을 조회하시오
*/
SELECT
    ENAME, SAL, COMM
FROM
    EMP 
WHERE
    ENAME LIKE '%S'
;

/*
    데이터 결합 연산자
        형식 )
            
            데이터1 || 데이터2
            
*/
select 10 || 20 frin dual;

-- 사원들 이름에 Mr. 을 붙여서 조회
select
    'Mr' || ename 사원이름, sal || '달러' , hiredate
from
    emp
;