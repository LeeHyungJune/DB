/*
    참고 )
        HAVING 절
        ==> 그룹화한 결과를 필터링을 할 때
            필터링 조건을 기술하는 절...
            
        참고 )
            WHERE 절에는 그룹함수를 사용할 수 없다.
            HAVING 절에는 그룹합수를 사용할 수 있다.
            
*/

/*
    JOIN
    ==> Realation DataBase Management System 에서는 데이터의 중복을 피하기 위해서
        테이블을 분리하고 그럼으로써 테이블들 간의 관계가 형성이 되었다. 
        
        그런데 분리된 테이블에서 데이터를 추출해낼때 사용하는 문법이 JOIN 이다.
        
        참고 )
            오라클 역시 ER 형태의 데이터베이스다.
            ER
                엔티티(테이블)끼리의 관계를 이야기하고
                이런 관계들로 테이블을 관리하는 데이터베이스를 관계형데이터베이스라고 한다.
        
    참고 )
        관계형데이터베이스에서는 여러개의 테이블에서 동시에 검색하는 기능은 이미 가지고 있다.
        ==> 이때 여러개의 테이블에서 데이터를 동시에 검색하면 
            Cartesian Product 가 만들어지는데
            이 만들어진 결과에는 정확하지 않은 데이터도 포함되어 있다.
            따라서 정확한 데이터만 필터링해서 꺼내와야 하는데
            이때 이 필터링하는 작업이 JOIN 이다.
            
    종류 )
        
        Inner Join
        ==> 나열된 테이블들의 결과집합 안에서 꺼내오는 조인
            Equi Join
            ==> 조인을 할 때 동등비교연산자로 조인을 하는 경우
            
            Non Equi Join
            ==> 조인을 할 때 동등비교연산자 이외의 연산자로 조인을 하는 경우
            
        Outer Join
        ==> Catesian Product 에 포함되지 않는 데이터를 가져오는 조인
        
            형식 )
                
                테이블이름.필드이름 = 테이블이름.필드이름(+)
                
                이때 (+) 는 null 로 표현된어야 할 테이블쪽에 붙여준다.
            
        Self Join
        ==> 조인을 하는데 대상테이블이 같은 테이블을 사용하는 조인
        
    참고 )
        조인에서도 다른 일반조건을 사용할 수 있다.
        
*/

-- 영문색상이름 테이블
DROP TABLE ecolor;

CREATE TABLE ecolor(
    ceno NUMBER(3)  --  영문 컬러 일련번호
        CONSTRAINT ECLR_NO_PK PRIMARY KEY,
    code VARCHAR2(7)    --  컬러 코드값
        CONSTRAINT ECLR_CODE_UK UNIQUE
        CONSTRAINT ECLR_CODE_NN NOT NULL,
    name VARCHAR2(20)
        CONSTRAINT ECLR_name_NN NOT NULL
);

-- 데이터 추가
INSERT INTO
    ecolor
VALUES(
    100, '#FF0000', 'red'
);

INSERT INTO
    ecolor
VALUES(
    101, '#00FF00', 'green'
);

INSERT INTO
    ecolor
VALUES(
    102, '#0000FF', 'blue'
);

INSERT INTO
    ecolor
VALUES(
    103, '#800080', 'purple'
);

-- 영문컬러테이블 조회
SELECT * FROM ecolor;
COMMIT; --  메모리의 작업영역에서 작업한 내용을 데이터베이스에 적용시키는 명령


CREATE TABLE kcolor(
    ckno NUMBER(3)
        CONSTRAINT KCLR_NO_PK PRIMARY KEY,
    code VARCHAR2(7)
        CONSTRAINT KCLR_CODE_UK UNIQUE
        CONSTRAINT KCLR_CODE_NN NOT NULL,
    name VARCHAR2(20)
        CONSTRAINT KCLR_name_NN NOT NULL    
);

INSERT INTO
    kcolor
VALUES(
    100, '#FF0000', '빨강색'
);

INSERT INTO
    kcolor
VALUES(
    101, '#00FF00', '녹색'
);

INSERT INTO
    kcolor
VALUES(
    102, '#0000FF', '파랑색'
);

commit;

select * from kcolor;
SELECT * FROM ecolor;

select
    * 
from
    ecolor, kcolor
;

select
    *
from
    emp e, emp ee
;

-- Inner Join
SELECT
    e.ceno ecno, e.code code, e.name ename, k.name kname
FROM
    ecolor e, kcolor k
WHERE
    e.code = k.code --  조인조건
;

-- Outer Join
SELECT
    e.ceno ecno, e.code code, e.name ename, k.name kname
FROM
    ecolor e, kcolor k
WHERE
    e.code = k.code(+) --  조인조건
;

--  self join
--  사원들의 사원이름, 상사번호, 상사이름, 상사급여 를 조회하시오

SELECT
    e.ename 사원이름, e.mgr 상사번호, s.ename 상사이름, s.sal 상사급여 
FROM
    emp e, emp s
WHERE
    e.mgr = s.empno(+)
;

create table sansa
as
    select * from emp;

-- 사원들의 사원이름, 직급, 급여, 급여등급 을 조회하시오

SELECT
    ENAME 사원이름, JOB 직급, SAL 급여, GRADE "급여 등급"
FROM
    EMP, SALGRADE
WHERE
    sal BETWEEN LOSAL AND HISAL -- 동등연산자가 아니기에 Non Equi Join
;

-- 사원들의 사원번호, 사원이름, 직급, 부서이름, 버서위치 를 조회하시오

SELECT
    EMPNO, ENAME, JOB, DNAME, LOC
FROM
    EMP E, DEPT D
WHERE
    e.deptno = d.deptno
;

-- 81년에 입사한 사원의
-- 사워이름, 직급, 입사일, 부서이름 조회

SELECT
    ENAME 사원이름, JOB 직급, TO_CHAR(HIREDATE,'YYYY"년" MM"월" DD"일"') 입사일, DNAME 부서이름
FROM
    EMP, DEPT
WHERE
    EMP.DEPTNO = DEPT.DEPTNO            -- 조인조건
    AND TO_CHAR(HIREDATE,'YY') = 81     -- 일반조건
;

----------------------------------------------------------------------------------------
/*
    ANSI JOIN
    ==> 질의 명령은 데이터베이스(DBMS) 에 따라서 약간씩 그 문법이 달라진다.
    
        ANSI 형식이란
        미국 국립 표준 협회(ANSI)에서 공통의 질의 명령을 만들고자 해서 통일된 방식의
        명령을 만들어 놓은 것.
        따라서 DBMS 를 가리지 않고 실행이 된다.
        
    -------------------------------------------------------------------------------------
    
    1.  Cross Join
        ==> 오라클의 Cartesian Product 를 생성하는 조인
            
            형식 )
                SELECT
                    필드이름, ...
                FROM
                    테이블1 CROSS JOIN
                ;

    
    2.  Inner Join
        ==> Equi Join, Non Equi Join, Self Join
            
            형식 )
                SELET
                    필드이름, ...
                FROM
                    테이블1 [INNER] JOIN 테이블2
                ON
                    조인조건
                ;
            
            참고 )
                조인조건은 ON 절에서 기술하고
                일반조건은 WHERE 절에서 기술한다.
            
            참고 )
                INNER JOIN 이 가장 일반적인 조인이기 때문에 INNER 라는 단어를 생략하면
                INNER JOIN 으로 해석해서 실행하게 된다.
            
    3.  Outer Join
        ==> Cartesian Product 에 없는 결과를 조회하는 조인 명령
        
            형식 )
                SELECT
                    필드이름, ...
                FROM
                    테이블1 LEFT || RIGHT || FULL OUTER JOIN 테이블2
                    ==> 이때 방향은 데이터가 있는 쪽 테이블을 가리키면 된다.
                ON
                    조인 조건...
                ;
    
     4. Self Join
     
            형식 )
                SELECT
                    필드,, ...
                FROM
                    테이블 이름
                JOIN
                    테이블2
                ON
                    조인조건1
                JOIN
                    테이블3
                ON
                    조인조건2
                ;
    
*/

--  ANSI JOIN
--  CROSS JOIN
--  사원정보와 부서정보를 크로스조인하시오
SELECT
    *
FROM
    EMP CROSS JOIN DEPT
;

--  INNER JOIN
--  사원들의 사원이름, 직급, 부서번호, 부서이름 을 조회하시오
SELECT
    ENAME, JOB, E.DEPTNO, DNAME
FROM
    EMP E
    JOIN DEPT D
ON
    E.DEPTNO = D.DEPTNO
;

-- 81년 입사한 사원들의 사원이름, 직급, 입사년도, 부서이름을 조회하시오
SELECT
    ENAME 사원이름, JOB 직급, HIREDATE 입사일, DNAME 부서이름
FROM
    EMP INNER JOIN DEPT
ON  -- 조인 조건
    EMP.DEPTNO = DEPT.DEPTNO
WHERE
    TO_CHAR(HIREDATE,'YY') = 81 -- 일반조건
;

-- 사원들의 사원이름, 급여, 급여등급을 조회하시오. NON EQUI JOIN
SELECT
    ENAME, SAL, GRADE
FROM
    EMP JOIN SALGRADE
ON
    SAL BETWEEN LOSAL AND HISAL
;

--  사원들의 사원이름, 상사이름을 조회하시오
--  Inner Join
SELECT
    E.ENAME 사원이름, S.ENAME 상사이름
FROM
    EMP E JOIN EMP S
ON
    E.MGR = S.EMPNO
;

--  사원들의 사원이름, 상사이름을 조회하시오.
--  Outer Join
SELECT
    E.ENAME 사원이름, NVL(S.ENAME, '상사없음') 상사이름
FROM
    EMP E LEFT OUTER JOIN EMP S
ON
    E.MGR = S.EMPNO
;

--  사원들의 사원이름, 부서이름, 급여, 급여등급 을 조회하시오
SELECT
    ENAME, DNAME, SAL, GRADE
FROM
    EMP
JOIN 
    DEPT
ON  
    emp.deptno  =   dept.deptno
JOIN
    SALGRADE
ON
    SAL BETWEEN LOSAL AND HISAL
;

-------------------------------------------------------------------------------------------
/*
    NATURAL JOIN
    ==> 자동 조인
        반드시 조인 조건식에 사용하는 필드의 이름이 동일하고 
        반드시 동일한 필드가 한 개일 때 사용할 수 있는 조인
        자동으로 중복되는 필드를 사용해서 조인을 하기 때문에
        조인조건을 기술하지 않는다.
        
        
        형식 )
            SELECT
                필드이름, ...
            FROM
                테이블1
            NATURAL JOIN
                테이블2
            ;
            
    USING JOIN
    ==> 반드시 조인 조건식에 사용하는 필드의 이름이 동일한 경우
        그리고 같은 이름의 필드가 여러개 존재해도 무방하다.
        
        형식 )
            SELECT
                필드이름, ...
            FROM
                테이블1
            JOIN
                테이블2
            USING
                (조인에 사용할 필드 이름)
            ;
            
*/

-- 사원들의 사원이름, 부서이름을 조회하시오
SELECT
    ENAME 사원이름, DNAME 부서이름
FROM
    EMP
NATURAL JOIN
    DEPT
;

CREATE TABLE tmp
as
    SELECT
        E.*, DNAME
    FROM
        EMP E, DEPT D
    WHERE
        E.DEPTNO = D.DEPTNO
;

--  TMP 테이블과 부서정보 테이블을 이용해서
--  사원들의 사원이름, 부서위치를 조회하시오
SELECT
    ENAME, LOC
FROM
    TMP
JOIN
    DEPT
USING
    (DEPTNO)
;

------------------------------------------------------------------------------------------------

/*
    부질의(SUB QUERY, 서브질의)
    ==> 질의명령 안에 다시 질의명령을 포함하는 경우
        포함되는 그 질의 명령을 서브질의 또는 서브쿼리 라고 부른다.
        
        예 )
            이름이 SMITH 인 사우너과 같은 부서에 있는 사원들의 정보를 조회하시오.
            ==> 이 경우 SMITH 의 부서번호를 알아내기 위해서 먼저 질의명령이 실행되어야 한다.
            
            ==> 꺼내온 부서번호를 이용해서 정보를 조회
            
            이때 위의 질의 명령을 아래 메인 질의명령에서 조회해서 사용해야 한다.
            
        참고 )
            이때 서브질의를 감싸는 질의 명령을 메인질의 명령이라 부른다.
            
        서브질의의 위치에 따른 결과
            1.  SELECT 절
                ==> 이 부분에 사용되는 질의명령은 결과가 반드시 한 행, 한 필드가 나와야한다.
                
            2.  FROM 절
                ==> FROM 절에는 테이블이 나열되어야 한다.
                    그런데 조희 질의 명령의 결과는 마치 테이블과 같다.
                    그러면 이 조회 질의 명령의 결과를 테이블처럼 사용할 수 있는 방법
                    
                    이때 FROM 절 안에 들어가는 서브질의를 
                    특별히 마치 테이블과 같다해서 
                        INLINE TABLE
                    이라고 부른다.
                    
                    이때 사용은 질의명령을 보낼때 사용한 별칭을
                    사용해서 데이터를 꺼내야 한다.
                    
            3.  WHERE 절
                1.  단일행 단일필드로 결과가 발생하는 경우
                ==> 결과를 비교에 사용하면 된다.
                2.  다중행 단일필드로 결과가 발생하는 경우(여러 사람의 특정 컬럼만 뽑아 왔을 때)
                    참고 )
                        서브질의의 결과가 다중행 단일필드로 발생하는 경우
                        이때 사용하는 연산자
                        
                        IN      :   여러개의 데이터 중 하나만 맞으면 되는 경우
                                ==> 묵시적으로 여러 값 중 하나와 동등 비교 처리를 한다.
                                
                        ANY     :   여러개의 데이터 중 하나만 맞으면 되는 경우                               
                                ==> 대소비교 연산자도 사용가능                              
                                
                        ALL     :   여러개의 데이터가 모두 맞으면 되는 경우
                                ==> 동등비교는 사용할 수 없고
                                    대소비교할 때 사용한다.
                        
                3.  복수행 복수의 필드로 결과가 발생하는 방법
                        
                        
                        EXISTS  :   질의 명령의 결과가 있으면 참, 없으면 거짓
                        
*/
SELECT
    ENAME, JOB, SAL
FROM
    EMP
WHERE
    deptno = (
                SELECT
                    DEPTNO
                FROM
                    EMP
                WHERE
                    ename = 'SMITH'
              )
;

--  사원들의 사원이름, 부서번호, 부서이름, 부서위치

SELECT
    ENAME, DEPTNO, 
    (
        SELECT 
            DNAME
        FROM
            DEPT
        WHERE
            DEPTNO = EMP.DEPTNO
    ) 부서이름,
    (
        SELECT 
            LOC
        FROM
            DEPT
        WHERE
            DEPTNO = EMP.DEPTNO
    ) 부서위치
FROM
    EMP
;

--  조건절에 단일행 단일필드의 결과
--  SMITH 사원과 동일한 부서의 사원들의 정보를 조회하시오

SELECT
    ENAME, JOB, SAL
FROM
    EMP
WHERE
    DEPTNO = (
                SELECT
                    DEPTNO
                FROM
                    EMP
                WHERE
                    ENAME = 'SMITH' 
                )
;

--  10번 부서 사원들의 직급 평균을 구하시오.

SELECT
    JOB 직급이름, AVG(SAL)
FROM
    EMP
WHERE
    JOB IN (
            SELECT
                JOB
            FROM
                EMP
            WHERE
                DEPTNO = 10 --  질의명령의 값은 다중값으로 발생한다.
                            --  CLERK, PRESIDENT, MANAGER
            )
GROUP BY
    JOB
;

--------------------------------------------------------------------------------------------------

--  IN
--  직급이 MANAGER 인 사원과 같은 부서에 속한 사원들의
--  사원이름, 직급, 부서번호 를 조회하시오
SELECT
    ENAME 사원이름, JOB 직급, DEPTNO 부서번호
FROM
    EMP
WHERE
    DEPTNO IN (
                SELECT
                    DEPTNO
                FROM
                    EMP
                WHERE
                    JOB = 'MANAGER'
                )
;

--  ANY
--  각 부서의 평균 급여보다 한 부서라도 급여가 높은 사원들의
--  사원이름, 사원급여, 부서번호 를 조회하시오
SELECT
    ENAME, SAL, DEPTNO
FROM
    EMP
WHERE
    SAL > ANY (
                SELECT
                    AVG(SAL)
                FROM
                    EMP
                GROUP BY
                    DEPTNO
                )
;

--  모든 각 부서의 급여 평균보다 높은 급여를 받는 사원들의
--  사원이름, 사원급여, 부서번호 를 조회하시오
SELECT
    ENAME, SAL, DEPTNO
FROM
    EMP
WHERE
    SAL > ALL ( 
                SELECT
                    AVG(SAL)
                FROM
                    EMP
                GROUP BY
                    DEPTNO
                )
;

--  사원 중 40번 부서 사원이 존재하면 모든 사원들의
--  사원 이름, 부서번호 를 조회하시오
SELECT
    scott.emp.ENAME, scott.emp.DEPTNO
FROM
    scott.EMP
    /*
        테이블을 가리킬 때 원칙은
            계정.테이블이름
        의 형식으로 사용해야 한다.
        하지만 접속계정이 가지고 있는 테이블에 한해서는
        테이블 이름만 기술해도 된다.
    */
WHERE
    EXISTS (--  부정은 NOT EXISTS
            SELECT
                *
            FROM
                EMP
            WHERE
                DEPTNO = 40
            )
    
;

--------------------------------------------------------------------------------------------
--  사원들의 사원이름, 부서번호, 부서원수, 부서평균급여, 부서급여합계 를 조회하시오
SELECT
    ENAME 사원이름, DEPTNO 부서번호, cnt 부서원수, avg 부서평균급여, sum 부서급여합계
FROM
    EMP,
    (   
        SELECT
            DEPTNO dno, COUNT(*) cnt, ROUND(AVG(SAL),2) avg, SUM(SAL) sum
        FROM
            EMP
        GROUP BY
            DEPTNO
    )
WHERE
    DEPTNO = dno
;

SELECT
    ENAME, DEPTNO,
    (
        SELECT
            COUNT(*)
        FROM
            EMP
        WHERE
            DEPTNO = E.DEPTNO  
    ) 부서원수,     
    (
        SELECT
            ROUND(AVG(SAL),2)
        FROM
            EMP
        WHERE
            DEPTNO = E.DEPTNO  
    ) 부서평균급여,
    (
        SELECT
            SUM(SAL)
        FROM
            EMP
        WHERE
            DEPTNO = E.DEPTNO  
    ) 부서급여합계  
FROM
    EMP E
;

----------------------------------------------------------------------------------------------------
--  회사 평균 급여보다 적게 받는 사원들의
--  사원이름, 직급, 입사일, 급여 를 조회하시오

SELECT
    ENAME, JOB, HIREDATE, SAL
FROM
    EMP
WHERE
    SAL < ALL (
                SELECT
                    AVG(SAL)
                FROM
                    EMP
                )
;

SELECT ROUND(AVG(SAL)) FROM EMP;

-------------------------------------------------------------------------------------------






