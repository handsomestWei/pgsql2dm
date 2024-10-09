# array-opt
数组集合运算

## pg实现
在pg数据库中，运算符<@表示被包含集合运算符，类似的还有@>包含运算等。
```
-- pg sql例
select * from tb_xx where ARRAY[#{indexCode}] ::_text <@ index_codes;
```

## 适配达梦
达梦数据库中没有类似的运算符。可以使用自定义二元运算符来实现。也可自定义数组类型，和使用MULTISET集合运算函数一起实现该功能，需要改写sql，同时在dao层自定义类型处理器。