-- Data Engineering
-- I created a DB sql_challenge

-- Create the departments table
CREATE TABLE departments (
    dept_no VARCHAR(4) PRIMARY KEY,
    dept_name VARCHAR(40) UNIQUE NOT NULL
);

-- Create the employees table
CREATE TABLE employees (
    emp_no INT PRIMARY KEY,
    emp_title_id VARCHAR(10) NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR(14) NOT NULL,
    last_name VARCHAR(16) NOT NULL,
    sex CHAR(1) NOT NULL,
    hire_date DATE NOT NULL
);

-- Create the titles table
CREATE TABLE titles (
    title_id VARCHAR(10) PRIMARY KEY,
    title VARCHAR(50) NOT NULL
);

-- Create the salaries table
CREATE TABLE salaries (
    emp_no INT,
    salary INT NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

-- Create the dept_emp table
CREATE TABLE dept_emp (
    emp_no INT,
    dept_no VARCHAR(4),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

-- Create the dept_manager table
CREATE TABLE dept_manager (
    dept_no VARCHAR(4),
    emp_no INT,
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

-- Import Data into the Tables

COPY departments(dept_no, dept_name) 
FROM '/Users/davidflores/Develop/Aprendizaje/Develop/Tecnologico Monterrey/Challenge/Sql Challenge/data/departments.csv' 
DELIMITER ',' 
CSV HEADER;

COPY employees(emp_no, emp_title_id, birth_date, first_name, last_name, sex, hire_date) 
FROM '/Users/davidflores/Develop/Aprendizaje/Develop/Tecnologico Monterrey/Challenge/Sql Challenge/data/employees.csv' 
DELIMITER ',' 
CSV HEADER;

COPY titles(title_id, title) 
FROM '/Users/davidflores/Develop/Aprendizaje/Develop/Tecnologico Monterrey/Challenge/Sql Challenge/data/titles.csv' 
DELIMITER ',' 
CSV HEADER;

COPY salaries(emp_no, salary) 
FROM '/Users/davidflores/Develop/Aprendizaje/Develop/Tecnologico Monterrey/Challenge/Sql Challenge/data/salaries.csv' 
DELIMITER ',' 
CSV HEADER;

COPY dept_emp(emp_no, dept_no) 
FROM '/Users/davidflores/Develop/Aprendizaje/Develop/Tecnologico Monterrey/Challenge/Sql Challenge/data/dept_emp.csv' 
DELIMITER ',' 
CSV HEADER;

COPY dept_manager(dept_no, emp_no) 
FROM '/Users/davidflores/Develop/Aprendizaje/Develop/Tecnologico Monterrey/Challenge/Sql Challenge/data/dept_manager.csv' 
DELIMITER ',' 
CSV HEADER;

-- Data Analysis

--1. List the employee number, last name, first name, sex, and salary of each employee:
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no;

--2. List the first name, last name, and hire date for the employees who were hired in 1986:
SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

--3. List the manager of each department along with their department number, department name, employee number, last name, and first name:
SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM dept_manager dm
JOIN departments d ON dm.dept_no = d.dept_no
JOIN employees e ON dm.emp_no = e.emp_no;

-- 4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name:
SELECT de.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
JOIN employees e ON de.emp_no = e.emp_no
JOIN departments d ON de.dept_no = d.dept_no;

--5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B:
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--6. List each employee in the Sales department, including their employee number, last name, and first name:
SELECT e.emp_no, e.last_name, e.first_name
FROM dept_emp de
JOIN employees e ON de.emp_no = e.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

--7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name:
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
JOIN employees e ON de.emp_no = e.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');

--8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name):
SELECT last_name, COUNT(*) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;
