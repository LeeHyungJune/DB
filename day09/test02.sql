--  test02 계정으로 접속해서 작업

CREATE TABLE test02(
    NO NUMBER(2)
);

CREATE OR REPLACE VIEW shono
AS
    SELECT
        NO
    FROM
        test02   
;

GRANT CREATE VIEW TO test01;

GRANT SELECT ANY TABLE TO test01;

REVOKE CREATE VIEW FROM test01;

SELECT
    *
FROM
    SCOTT.EMP
WHERE
    DEPTNO = 10
;

SELECT
    *
FROM
    JENNIE.MEMB
;

--  test01에게 권한을 줄 수 있는 권한까지 포함해서 scott.emp 를 조회하는 수 있는 권한을 주시오
GRANT SELECT ON scott.emp TO test01 WITH GRANT OPTION;

