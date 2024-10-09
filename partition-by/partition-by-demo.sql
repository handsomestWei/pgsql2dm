--dm8 sql

-- 创建分区表。
-- 对create_time字段的值，按月自动创建分区，设置负载因子，设置初始分区。分区后，达梦的分区表的表名不支持自定义
create table tb_xx (id varchar(48) not null,create_time timestamp,update_time timestamp) 
PARTITION BY RANGE 
             ( 
                          create_time 
             ) 
             INTERVAL 
             ( 
                          NUMTOYMINTERVAL (1, 'month') 
             ) 
             ( PARTITION P_BEFORE_2024 VALUES LESS THAN (TO_DATE ('2024-01-01', 'yyyy-mm-dd'))) STORAGE 
             ( 
                          FILLFACTOR 85, 
                          BRANCH(32,32) 
             );


-- 分区数据清除函数，业务上可配合定时任务使用。
-- dm不支持直接在函数里执行删除数据操作，需要声明自治事务AUTONOMOUS_TRANSACTION
CREATE OR REPLACE function func_clean_partition_for_tb_xx(p_partition_method IN int default 1, p_keep_day IN int default 90) RETURN int AS 
DECLARE PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    delete from tb_xx where "create_time" < add_days(now(), -p_keep_day);
    commit;
    return 0;
END;
