CREATE TABLE "departments" (
  "dept_no" varchar(4) PRIMARY KEY,
  "dept_name" varchar(40)
);

CREATE TABLE "employees" (
  "emp_no" int PRIMARY KEY,
  "emp_title_id" varchar(10),
  "birth_date" date,
  "first_name" varchar(14),
  "last_name" varchar(16),
  "sex" char(1),
  "hire_date" date
);

CREATE TABLE "titles" (
  "title_id" varchar(10) PRIMARY KEY,
  "title" varchar(50)
);

CREATE TABLE "salaries" (
  "emp_no" int,
  "salary" int
);

CREATE TABLE "dept_emp" (
  "emp_no" int,
  "dept_no" varchar(4)
);

CREATE TABLE "dept_manager" (
  "dept_no" varchar(4),
  "emp_no" int
);

ALTER TABLE "salaries" ADD FOREIGN KEY ("emp_no") REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD FOREIGN KEY ("emp_no") REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD FOREIGN KEY ("dept_no") REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD FOREIGN KEY ("dept_no") REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD FOREIGN KEY ("emp_no") REFERENCES "employees" ("emp_no");
