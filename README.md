# pgsql2dm
数据库迁移适配，PostgreSQL到达梦8

## 策略
### 数据库兼容性配置
使用DM提供的控制台工具，修改兼容性参数项COMPATIBLE_MODE，值设为7，设置为兼容pg数据库模式。其他参数按需修改。

### 声明同义词
有功能相同的函数，可通过声明同义词的方式来替代。

### 语义改写
使用相同语义的sql来替代，或者放在业务代码里实现。

## 常见问题
+ [自动表分区](https://github.com/handsomestWei/pgsql2dm/tree/main/partition-by)
+ [数组集合运算](https://github.com/handsomestWei/pgsql2dm/tree/main/array-opt)
+ [group by别名](https://github.com/handsomestWei/pgsql2dm/tree/main/group-by-alias)
+ [其他](https://github.com/handsomestWei/pgsql2dm/tree/main/others)

## 适配方案
### 动态修改
减少对原项目的侵入。利用数据库连接库提供的能力，例如使用阿里的Druid数据源，运行时拦截sql，并自定义改写，实现动态修改。

### 静态修改
可以使用工具[mybatis-mapper2sql](https://github.com/handsomestWei/mybatis-mapper2sql)做抽取和测试验证