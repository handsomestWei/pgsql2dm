--dm8 sql

-- 使用dm的嵌套表，自定义数组类型DM_ARRAY，实现pg数组的集合比较
CREATE or REPLACE TYPE DM_ARRAY is table of VARCHAR;

-- 包含，相当于pg的@> 使用MULTISET做集合交集运算
CREATE OR REPLACE FUNCTION f_array_is_include(s1 IN DM_ARRAY, 
                                              s2 IN DM_ARRAY)
    RETURN INT AS s3 DM_ARRAY;
    v_rs   INT;
    BEGIN
        s3 := s1 MULTISET INTERSECT s2;
        IF s3.COUNT = s2.COUNT THEN
            v_rs := 1;
        ELSE
            v_rs:= 0;
        END IF;
        RETURN v_rs;
    END;

-- 被包含，相当于pg的<@ 使用MULTISET做集合交集运算
CREATE OR REPLACE FUNCTION f_array_is_be_include(s1 IN DM_ARRAY, 
                                                 s2 IN DM_ARRAY)
    RETURN INT AS s3 DM_ARRAY;
    v_rs   INT;
    BEGIN
        s3 := s1 MULTISET INTERSECT s2;
        IF s3.COUNT = s1.COUNT THEN
            v_rs := 1;
        ELSE
            v_rs:= 0;
        END IF;
        RETURN v_rs;
    END;

-- 相等比较，相当于= 使用MULTISET做集合差集运算
CREATE OR REPLACE FUNCTION f_array_is_equal(s1 IN DM_ARRAY, 
                                            s2 IN DM_ARRAY)
    RETURN INT AS s3 DM_ARRAY;
    v_rs   INT;
    BEGIN
        IF s1.COUNT <> s2.COUNT THEN
            v_rs := 0;
        ELSE
            s3 := s1 MULTISET EXCEPT s2;
            IF s3.COUNT = 0 THEN
                v_rs := 1;
            ELSE
                v_rs:= 0;
            END IF;
        END IF;
        RETURN v_rs;
    END;

-- test
/*
select f_array_is_include(DM_ARRAY('qwe','asd'), DM_ARRAY('asd','qwe'));
select f_array_is_be_include(DM_ARRAY('qwe','asd'), DM_ARRAY('asd','qwe','ddd'));
select f_array_is_equal(DM_ARRAY('qwe','asd'), DM_ARRAY('asd','qwe'));
*/