# Be a RDBMS Rockstar

Welcome to my RDBMS learning journey! This repository showcases my understanding of RDBMS(PostgreSQL) concepts through both explanatory content and practical assignments.

## 📚 Blog Content

### Explain the Primary Key and Foreign Key concepts in PostgreSQL?

প্রাইমারি কী: একটি টেবিলের প্রতিটি রো ইউনিকলি আইডেন্টিফাই করার জন্য ব্যবহার করা হয়। এটি NULL হতে পারে না এবং ইউনিক হতে হবে।
**উদাহরণ:**

```
id SERIAL PRIMARY KEY
```

ফরেন কী: একটি টেবিলের কলাম যা অন্য টেবিলের প্রাইমারি কীকে রেফারেন্স করে। এটি সম্পর্ক তৈরি করে এবং সম্পর্ক মেইন্টেন করে।
**উদাহরণ:**

```
user_id INTEGER REFERENCES users(id)
```

### What is the difference between the VARCHAR and CHAR data types?

VARCHAR: ভেরিয়েবল-লেংথ ক্যারেক্টার স্ট্রিং। সর্বোচ্চ n ক্যারেক্টার সংরক্ষণ করে, কিন্তু প্রকৃত স্টোরেজ ব্যবহৃত ক্যারেক্টারের উপর নির্ভর করে।
উদাহরণ: VARCHAR(100) "Hello" স্টোর করলে মাত্র ৫ বাইট ব্যবহার করবে।

CHAR(n): ফিক্সড-লেংথ ক্যারেক্টার স্ট্রিং। সর্বদা n ক্যারেক্টার স্টোর করে, কম ক্যারেক্টার দিলে স্পেস দিয়ে প্যাড করে।
উদাহরণ: CHAR(10) "Hi" স্টোর করলে "Hi " (৮টি স্পেস সহ) স্টোর করবে।

### Explain the purpose of the WHERE clause in a SELECT statement.

WHERE ক্লজ ব্যবহার করা হয় ডাটা ফিল্টার করার জন্য। এটি শর্ত স্পেসিফাই করে যে কোন রো বা এর সমষ্টি রিটার্ন করে।

**উদাহরণ:**

```postgreSQL
SELECT * FROM employees WHERE id = 99;
--- or
SELECT * FROM employees WHERE salary > 50000;
```

### What are the LIMIT and OFFSET clauses used for?

LIMIT: ডাটাবেজ থেকে সর্বোচ্চ কতগুলো রো রিটার্ন করা হবে তা নির্দিষ্ট করে।
**উদাহরণ:**

```
SELECT * FROM products LIMIT 10; (প্রথম ১০টি প্রোডাক্ট রিটার্ন করবে)
```

OFFSET: কতগুলো রো স্কিপ করে LIMIT রেজাল্ট দেখানো শুরু করবে তা নির্দিষ্ট করে। পেজিনেশনে ব্যবহৃত হয়।
**উদাহরণ:**

```
SELECT * FROM products LIMIT 10 OFFSET 20; (২১তম থেকে ৩০তম রেকর্ড রিটার্ন করবে)
```

### What is the significance of the JOIN operation, and how does it work in PostgreSQL?

JOIN অপারেশন একাধিক টেবিল থেকে ডাটা কম্বাইন করার জন্য ব্যবহৃত হয়। PostgreSQL-এ বিভিন্ন ধরনের JOIN আছে:

INNER JOIN: শুধুমাত্র ম্যাচিং রেকর্ড রিটার্ন করে

LEFT JOIN: বাম টেবিলের সব রেকর্ড + ডান টেবিলের ম্যাচিং রেকর্ড

RIGHT JOIN: ডান টেবিলের সব রেকর্ড + বাম টেবিলের ম্যাচিং রেকর্ড

FULL JOIN: উভয় টেবিলের সব রেকর্ড

### How can you modify data using UPDATE statements?

UPDATE স্টেটমেন্ট দিয়ে টেবিলের এক্সিস্টিং ডাটা আপডেট করা যায়।
**সিনট্যাক্স:**

```
UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition;
```

**উদাহরণ:**

```
UPDATE employees
SET salary = salary * 1.10
WHERE department = 'IT';
```

এই কুয়েরি IT বিভাগের সকল কর্মচারীর বেতন ১০% বাড়াবে।

### Explain the GROUP BY clause and its role in aggregation operations.

GROUP BY ক্লজ একই মান বিশিষ্ট রেকর্ডগুলিকে গ্রুপ করে এবং অ্যাগ্রিগেট ফাংশন (COUNT, SUM, AVG ইত্যাদি) প্রয়োগ করতে সাহায্য করে।
**উদাহরণ:**

```
SELECT department, COUNT(*) as employee_count, AVG(salary) as avg_salary
FROM employees
GROUP BY department;
```

এই কুয়েরিটি প্রতিটি ডিপার্টমেন্টের কর্মচারী সংখ্যা এবং গড় বেতন দেখাবে।

### How can you calculate aggregate functions like COUNT(), SUM(), and AVG() in PostgreSQL?

PostgreSQL-এ অ্যাগ্রিগেট ফাংশনগুলি ডাটার উপর ক্যালকুলেট করে:

**COUNT():** রেকর্ড সংখ্যা রিটার্ন করে

```
SELECT COUNT(*) FROM products;
```

**SUM():** সংখ্যাসূচক কলামের মানগুলির যোগফল রিটার্ন করে

```
SELECT SUM(quantity) FROM order_items;
```

**AVG():** সংখ্যাসূচক কলামের গড় মান রিটার্ন করে

```
SELECT AVG(price) FROM products;
```

এই ফাংশনগুলি সাধারণত GROUP BY ক্লজের সাথে ব্যবহার করা হয়।
