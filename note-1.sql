# 1、查看数据库版本 管理命令，mysql --version或者mysql -V
SELECT VERSION();

# 2、注释：单行注释使用#或者--开头，多行注释，使用/*注释内容*/

# 3、常量、表达式与函数
SELECT 100;
SELECT 'Lisa'
SELECT 100*99;
SELECT VERSION();

# 4、起别名
 # 方法一：
 SELECT 100*99 AS '积';
 SELECT last_name AS '姓',first_name AS '名' FROM employees;
 
 # 方法二：不带AS关键字
SELECT last_name '姓',first_name '名' FROM employees;

# 案例：关键字中带有特殊符号，如空格,#等
SELECT email 'Employee Email address' FROM employees;

# 5、去除重复项
SELECT DISTINCT department_id FROM employees;
 
# 6、列中字符串拼接,使用CONCAT()
SELECT CONCAT(last_name,first_name) AS '姓名' FROM employees;

# 7、安全等于符号 <=>,即可以判断=，也可以判断null值
SELECT last_name,salary FROM employees WHERE salary <=> 12000;
SELECT last_name,salary FROM employees WHERE commission_pct <=> NULL;

# 8、案例：计算用户员工的年薪，年薪的公式为：salary * 12(1 + commission_pct)，commission_pct代表佣金
-- 如果commission_pct（佣金），需要使用IFNULL()函数
SELECT last_name,department_id,salary * 12 *(1+IFNULL(commission_pct,0)) AS '年薪' FROM employees;

/* 9、面试题：
   SELECT * FROM employees 和
   SELECT  * FROM employees where commission_pct like '%%' and last_name like '%%';
   查询结果是否一致？
   答：不一致，第二个语句会去除列值为null的数据

*/
SELECT  * FROM employees WHERE commission_pct LIKE '%%' AND last_name LIKE '%%';

/*----------------------------------------排序---------------------------------------------------------*/

# 10、按年薪的高低显示员工的所有信息和年薪
SELECT *,department_id,salary * 12 *(1+IFNULL(commission_pct,0)) AS '年薪' FROM employees ORDER BY '年薪' DESC;

SELECT *,department_id,salary * 12 *(1+IFNULL(commission_pct,0)) AS '年薪' FROM employees ORDER BY salary * 12 *(1+IFNULL(commission_pct,0)) DESC;

# 11、【多字段排序】先按工资升序排序，再按员工编号排序(隐含条件：员工的工资如果相同，则按编号排序)
SELECT last_name,employee_id,salary FROM employees ORDER BY salary ASC,employee_id DESC;

# 12、【按函数排序】按员工名字的长度进行排序
SELECT last_name,employee_id,salary,LENGTH(CONCAT(last_name,first_name)) AS '名字长度' FROM employees ORDER BY LENGTH(CONCAT(last_name,first_name)) DESC;
SELECT last_name,employee_id,salary,LENGTH(CONCAT(last_name,first_name)) AS '名字长度' FROM employees ORDER BY 名字长度 DESC;

# 13、查询工资不在8000到17000之间的员工姓名和工资，按工资降序
SELECT last_name,salary FROM employees WHERE salary NOT BETWEEN 8000 AND 17000 ORDER BY salary DESC;

/*------------------------------------------------单行函数使用---------------------------------------------------------*/
# 14、函数分类：1）单行函数,如concat(),length(),isnull()；2）分组函数,做统计使用，又称统计函数、聚合函数、组函数

# 15、字符函数
SELECT LENGTH("Ben World");  -- 获取字符串长度
SELECT LENGTH("张三丰hahaha");
SHOW VARIABLES LIKE '%char%';

SELECT CONCAT(first_name," ",last_name)  AS 'Full Name' FROM employees; -- 字符串拼接
SELECT UPPER(last_name) FROM employees; -- 字符串全部大写
SELECT LOWER(last_name) FROM employees; -- 字符串全部小写

# 16、substr函数：字符串截取,注意SQL中的索引都是从1开始
SELECT SUBSTR("李莫愁爱上了陆展元",7) AS out_put
SELECT SUBSTR("李莫愁爱上了陆展元",1,3) AS out_put -- 第二个参数表示截取的长度

# 17、instr函数：判断子串是否在源串中,返回子串在主串中第一次出现的的索引位置，如果找不到则返回0
SELECT INSTR("杨不悔爱上了殷梨亭","殷梨亭") AS out_put;
SELECT INSTR("杨不悔爱上了殷梨亭，殷梨亭也喜欢杨不悔","殷梨亭") AS out_put;
SELECT INSTR("杨不悔爱上了殷梨亭","婷婷") AS out_put;

# 18、trim函数：默认去除字符串前后的空格，可以去除指定的字符(串)，只能前后去除
SELECT TRIM("      张翠山       ") AS out_put;
SELECT TRIM('a' FROM "aaaaaa张aa无aa忌aaaaaaaa") AS out_put;

# 19、lpad函数：字符串左填充,第二个字符串为字符串的总长度
SELECT LPAD("赵敏",6,"*") AS out_put;

# 20、rpad函数：字符串右填充
SELECT RPAD("小昭",12,"wahaha") AS out_put;

# 21、replace函数：字符串替换,全部替换
SELECT REPLACE('张无忌爱上周芷若','周芷若','赵敏') AS out_put;
SELECT REPLACE('周芷若、周芷若、还是周芷若爱上了张无忌','周芷若','赵敏') AS out_put;

# 22、Round函数：四舍五入。默认取整
SELECT ROUND(1.56) -- 返回值：2
SELECT ROUND(1.13) -- 返回值：1
SELECT ROUND(-1.15) -- 返回值：-1
SELECT ROUND(-1.98) -- 返回值：-2

SELECT ROUND(-1.9852,2) -- 返回值：-1.99

# 23、ceil函数：向上取整，返回大/等于该数的最小整数
SELECT CEIL(-1.98) -- 返回值：-1
SELECT CEIL(-1.01) -- 返回值：-1
SELECT CEIL(2.55) -- 返回值：3
SELECT CEIL(3.05) -- 返回值：4

# 24、floor函数：向小取整，返回小/等于该数的最大整数
SELECT FLOOR(1.87) -- 返回值：1
SELECT FLOOR(-1.03) -- 返回值：-1

# 25、TRUNCATE函数：小数截取
SELECT TRUNCATE(1.879666,2) -- 返回值：1.87

# 26、MOD函数：取余数,实际计算方法：a - a / b * b
SELECT MOD(11,3)   -- 返回值：2
SELECT MOD(-11,3) -- 返回值：-2
SELECT MOD(11,-3) -- 返回值：2

# 27、常用日期函数
SELECT NOW(); -- 返回系统日期 + 时间
SELECT DATE(NOW()); -- 返回年月日
SELECT CURDATE(); -- 返回系统日期，不包含时间
SELECT CURTIME(); -- 返回系统时间。不包含日期

# 28、获取指定的年月日时分秒
SELECT YEAR(NOW());
SELECT MONTH(NOW());
SELECT DAY(NOW());
SELECT HOUR(NOW());
SELECT MINUTE(NOW());
SELECT SECOND(NOW());

SELECT last_name,YEAR(hiredate) FROM employees;
SELECT MONTHNAME(NOW());

# str_to_date():将字符串日期转换为指定日期格式
SELECT STR_TO_DATE("2012-6-20","%Y-%m-%d"); -- 返回2012-06-20
SELECT STR_TO_DATE("2012-6-5","%Y-%c-%d"); 

# date_format():将日期转换为字符串
SELECT DATE_FORMAT("2018/9/9","%Y年%c月%d日");

# 28、其它函数
SELECT VERSION(); -- 返回当前数据库版本
SELECT DATABASE(); -- 返回当前数据库名
SELECT USER() -- 返回当前用户

# 29、IF函数,SQL中是否相等用"="
SELECT IF(10 = 2,"equal","Not Equal");
SELECT last_name,commission_pct,IF(commission_pct IS NOT NULL,"有奖金哦","抱歉,没有奖金") AS '是否有奖金' FROM employees;

# 30、Case语句的两种结构（❤❤❤❤❤重点掌握❤❤❤❤❤）
/*
	结构一：
case 要判断的字段或表达式
when 常量1 then 要显示的值1或语句1;
when 常量2 then 要显示的值2或语句2;
...
else 要显示的值n或语句n;
end
*/

/*案例：查询员工的工资，要求

部门号=30，显示的工资为1.1倍
部门号=40，显示的工资为1.2倍
部门号=50，显示的工资为1.3倍
其他部门，显示的工资为原工资

*/

SELECT last_name,department_id,salary AS '原工资',
CASE department_id
WHEN 20 THEN salary * 1.1
WHEN 30 THEN salary * 1.2
WHEN 40 THEN salary * 1.3
ELSE salary
END AS '新工资' FROM employees;

/*
		结构二：
case 
when 条件1 then 要显示的值1或语句1
when 条件2 then 要显示的值2或语句2
。。。
else 要显示的值n或语句n
end


#案例：查询员工的工资的情况
如果工资>20000,显示A级别
如果工资>15000,显示B级别
如果工资>10000，显示C级别
否则，显示D级别

*/

SELECT last_name,salary,
CASE
WHEN salary > 20000 THEN 'A'
WHEN salary > 15000 THEN 'B'
WHEN salary > 10000 THEN 'C'
ELSE 'D'
END  
AS '工资级别' 
FROM employees;

/*-------------------------------------------------------分组函数使用---------------------------------------------------------*/

# 31、sum(),avg(),max(),min(),count()函数的简单使用
SELECT SUM(salary) FROM employees;
SELECT AVG(salary) FROM employees;
SELECT MAX(salary) FROM employees;
SELECT MIN(salary) FROM employees;
SELECT COUNT(last_name) FROM employees;

# 32、distinct关键字和分组函数的联合使用(❤❤❤❤❤重点掌握❤❤❤❤❤)

SELECT SUM(DISTINCT salary) AS '去重',SUM(salary) AS'不去重' FROM employees;
SELECT COUNT(DISTINCT salary) AS '去重',COUNT(salary) AS'不去重' FROM employees;

# 33、count函数的几种写法
SELECT COUNT(salary) FROM employees; -- 字段名称
SELECT COUNT('任意字段值') FROM employees; 
SELECT COUNT(*) FROM employees; 
SELECT COUNT(1) FROM employees; 
-- 注意：在INNODB存储引擎下，COUNT(*)和COUNT(1)的效率差不多，但是高于COUNT(’字段值‘)

# 34、【案例】查询员工表中最大入职时间与最小入职时间相差的天数
SELECT DATEDIFF(MAX(hiredate),MIN(hiredate)) AS difference FROM employees;

