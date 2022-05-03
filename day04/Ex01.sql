/*
    문제 1 )
        직급이 MANAGER 인 사원의
        사원이름, 직급, 입사일, 급여, 부서이름을 조회하시오

*/
SELECT
    ENAME 사원이름, JOB 직급, HIREDATE 입사일, SAL 급여, DNAME 부서이름
FROM
    EMP, DEPT
WHERE
    emp.deptno = dept.deptno
    AND JOB = 'MANAGER'
;

/*
    문제 2 )
        사원이름이 5 글자인 사원들의
        사원이름, 직급, 입사일, 급여, 급여등급을 조회하시오
*/
SELECT
    ENAME 사원이름, JOB 직급, HIREDATE 입사일, SAL 급여, GRADE 급여등급
FROM
    EMP, SALGRADE
WHERE
    SAL BETWEEN LOSAL AND HISAL
    AND LENGTH(ENAME) = 5
;

/*
    문제 3 )
       입사일이 81년이고
       직급이 MANAGER인 사원들의
       사원이름, 직급, 입사일, 급여, 급여등급, 부서이름, 부서위치를 조회하시오
*/
SELECT
    ENAME 사원이름, JOB 직급, HIREDATE 입사일, SAL 급여, GRADE 급여등급,
    DNAME 부서이름, LOC 부서위치
FROM
    EMP E
    JOIN DEPT D
        ON E.DEPTNO = D.DEPTNO
    JOIN SALGRADE S
        ON E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE
    TO_CHAR(HIREDATE, 'YY') = 81
    AND JOB = 'MANAGER'
;

/*
    문제 4 )
        사원들의
        사원이름, 직급, 급여, 급여등급, 상사이름
        을 조회하시오
        
        보너스 )
            상사가 없는 사원은 상사이름을 '상사없음'으로 조회하시오
*/
SELECT
    E.ENAME 사원이름, E.JOB 직급, E.SAL 급여, GRADE 급여등급, NVL(EE.ENAME, '상사없음') 상사이름
FROM
    EMP E
    JOIN EMP EE
        ON E.MGR = EE.EMPNO(+)
    JOIN SALGRADE S
        ON E.sal BETWEEN S.LOSAL AND S.HISAL
ORDER BY
    E.SAL
;

SELECT
    E.ENAME AS 사원이름, E.JOB AS 직급, E.SAL AS 급여, GRADE AS 급여등급, NVL(EE.ENAME, '상사없음') 상사이름
FROM
    EMP E,  SALGRADE S, EMP EE
WHERE
    E.sal BETWEEN S.LOSAL AND S.HISAL
    AND E.MGR = EE.EMPNO(+)
;

/*
    문제 5 )
        사원들의
        사원이름, 직급, 급여, 상사이름, 부서이름, 급여등급을 조회하시오
*/
SELECT
    E.ENAME 사원이름, E.JOB 직급, E.SAL 급여, EE.ENAME 상사이름, DNAME 부서이름, GRADE 급여등급
FROM
    EMP E
    JOIN EMP EE
        ON E.MGR = EE.EMPNO
    JOIN DEPT D
        ON E.DEPTNO = D.DEPTNO
    JOIN SALGRADE S
        ON E.SAL BETWEEN S.LOSAL AND S.HISAL
;

SELECT
    E.ENAME 사원이름, E.JOB 직급, E.SAL 급여, NVL(S.ENAME, '상사없음') 상사이름, DNAME 부서이름, GRADE 등급
FROM
   EMP E, EMP S, DEPT D, SALGRADE
WHERE
    E.MGR = S.EMPNO(+)
    AND E.DEPTNO = D.DEPTNO
    AND E.SAL BETWEEN LOSAL AND HISAL
;

-- 위 문제들을 ANSI JOIN 을 사용한 질의명령을 작성하시오

--------------------------------------------------------------------------------------------------
-- GROUP BY
/* 
    문제 1 )
        각 부서별로 최소 급여를 조회하려고 한다.
        각 부서별
            부서번호, 최소급여
        를 조회하시오
*/

SELECT
    DEPTNO, MSAL
FROM
    EMP,
    (
        SELECT
            DEPTNO DNO, MIN(SAL) MSAL
        FROM
            EMP
        GROUP BY
            DEPTNO
    )
WHERE
    DEPTNO = DNO
;
