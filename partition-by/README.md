# auto-partition
自动表分区

## pg实现
pg常见的自动表分区实现有两种方式。
+ partition分区+定时任务。在pg数据库使用partition of声明分区表，使用for values from基于时间做范围分区，定义创建分区的存储过程或函数。业务上使用定时任务，定时调用存储过程或函数。

+ inherits表继承+触发器。利用pg的表继承特性，在pg数据库使用inherits关键字声明继承表。对主表定义触发器，按设定的时间规则，将数据写入对应的继承表中。

## 适配达梦
达梦数据库没有pg的inherits关键字，没有表继承特性。有partition关键字，但分区策略更灵活。只需使用INTERVAL关键字设置分区的频率，自动实现范围分区。