--  DML (INSERT, UPDATE, DELETE)

ALTER TABLE EMP1
MODIFY JOB VARCHAR2(10 CHAR);

ALTER TABLE EMP1
MODIFY ENAME VARCHAR2(10 CHAR);

/*
    문제 1) 
        EMP1 테이블에 다음 데이터를 입력하시오
        이름  :   둘리
        직급  :   머슴
        급여  :   10
        입사일:   현재시간
*/
INSERT INTO
    EMP1(ENAME, JOB, SAL, HIREDATE, EMPNO)
VALUES(
    '둘리', '머슴', 10, SYSDATE, 1005
);

/*
    문제 2) 
        EMP1 테이블에 다음 데이터를 입력하시오
        이름  :   고길동
        직급  :   심통
        입사일:   2022년 03월 21일
*/
INSERT INTO
    EMP1(ENAME, JOB, HIREDATE, empno)
VALUES(
    '고길동', '심통', '2022/03/21', 1006 
);
/*
    문제 3) 
        EMP1 테이블에 다음 데이터를 입력하시오
        이름  :   희동이
        직급  :   대장
        급여  :   NULL
        입사일:   2022년 01월 01일
*/
INSERT INTO
    EMP1(ENAME, JOB, sal, HIREDATE, empno)
VALUES(
    '희동이', '대장', null ,'2022/01/01', 1007
);
-- 데이터 수정
/*
    문제 4) 
        EMP1 테이블에 다음 데이터를 수정하시오
       제니, 로제, 리사, 지수
       사원의 이름을 이름 앞에 'Ms.' 를 부텽서
       이름이 만들어지게 수정하시오
       나머지 사원들은 이름 앞에 'Mr.' 을 붙여서
       수정하시오
*/



UPDATE
    EMP1
SET
    ENAME = CASE 
                 WHEN ENAME = '제니' THEN CONCAT('Ms.',ENAME)
                 WHEN ENAME = '리사' THEN CONCAT('Ms.',ENAME)
                 WHEN ENAME = '지수' THEN CONCAT('Ms.',ENAME)
                 WHEN ENAME = '로제' THEN CONCAT('Ms.',ENAME)
                 ELSE CONCAT('Mr.',ENAME)
            END
;

/*
    문제 5) 
        EMP1 테이블에서
        입사년도가 81년 인 사원만
        급여를 25% 인상하는데 10단위 이하는 
        버림으로 처리하시오.
*/
UPDATE
    emp1
SET
    SAL = TRUNC((SAL*1.25),-2)
WHERE
    TO_CHAR(HIREDATE, 'YY') = 81
;

--  다른 테이블의 데이터 복사
/*
    문제 6 )
        EMP 테이블의 'SMITH' 사원의 데이터를 복사해서
        EMP1 테이블에 입력하시오.
*/
INSERT INTO
    EMP1
(   SELECT
     *
    FROM
     EMP
    WHERE
     ENAME = 'SMITH'
)
;

--  데이터 삭제
/*
    문제 7 )
        EMP1 테이블에서 부서번호가 10번인 사원만 삭제하시오.
*/
DELETE
FROM
    EMP1
WHERE
    DEPTNO = 10
;
/*
    문제 8 )
        EMP1 테이블에서 이름이 'H' 로 끝나는 사원만 삭제하시오.
*/
DELETE
FROM
    EMP1
WHERE
    ENAME LIKE '%H'
;   

UPDATE
    emp1
SET
    HIREDATE = TO_DATE('2022년 03월 21일', 'YYYY"년" MM"월" DD"일"')
WHERE
    ENAME = 'Mr.고길동'
;

UPDATE
    emp1
SET
    HIREDATE = TO_DATE('2022년 01월 01일', 'YYYY"년" MM"월" DD"일"')
WHERE
    ENAME = 'Mr.희동이'
;



















