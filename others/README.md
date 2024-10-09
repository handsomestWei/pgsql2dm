# others
其他

## 冲突处理
### pg实现
在pg中，使用on conflict关键字做数据冲突处理，实现save or update的效果。
```
-- pg sql例
insert into tb_xx (name, value) values (?,?) on conflict(name) do update set value =?;
```

### 适配达梦
在达梦数据库中，没有该关键字，可以使用merge into + when then条件表达式做等价实现。
```
-- dm sql改写例
merge into tb_xx 
using dual on name = 'test' 
when matched then update set value = '22' 
when not matched then insert (name, value) values ('test', '11');
```