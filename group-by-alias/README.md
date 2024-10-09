# group-by-alias
group by别名

## pg实现
在pg数据库中，group by字段支持别名和智能group by，若select段内的别名关联有表达式，会优先在group by之前执行。和一般数据库的sql执行顺序不同。
```
-- pg sql例。对别名ct字段执行GROUP BY之前，会先执行to_char函数
SELECT to_char(create_time , 'yyyy-MM-dd') AS ct FROM tb_xx GROUP BY ct;
```

## 适配达梦
需要显式的将别名关联的表达式作用在group by分组中。
```
-- dm sql改写例
SELECT to_char(create_time , 'yyyy-MM-dd') AS ct FROM tb_xx GROUP BY to_char(create_time , 'yyyy-MM-dd');
```