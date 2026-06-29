/* =====================================================
   PROJECT: Employee Database Analysis using SQL
   ===================================================== */

/* Create Tables */

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(20),
    gender VARCHAR(10),
    dept_id INT,
    hire_date DATE
);

CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(20)
);

CREATE TABLE Salaries (
    emp_id INT PRIMARY KEY,
    salary DECIMAL(10,2)
);

/* Insert Data */

INSERT INTO Employees VALUES
(1,'Vasanthi','Female',101,'2022-01-15'),
(2,'Arun','Male',102,'2021-06-20'),
(3,'Priya','Female',101,'2023-03-10'),
(4,'Rahul','Male',103,'2020-09-05'),
(5,'Divya','Female',102,'2024-01-25');

INSERT INTO Departments VALUES
(101,'HR'),
(102,'IT'),
(103,'Finance');

INSERT INTO Salaries VALUES
(1,45000),
(2,60000),
(3,50000),
(4,75000),
(5,55000);

/* =====================================================
   Question 1: List all employees.
   ===================================================== */

SELECT *
FROM Employees;

/* =====================================================
   Question 2: Find the highest-paid employee.
   ===================================================== */

SELECT e.emp_name, s.salary
FROM Employees e
INNER JOIN Salaries s
ON s.emp_id = e.emp_id
WHERE s.salary =
(
    SELECT MAX(s1.salary)
    FROM Salaries s1
);

/* =====================================================
   Question 3: Find the average salary by department.
   ===================================================== */

SELECT d.dept_name,
       AVG(s.salary) AS avg_salary
FROM Employees e
INNER JOIN Departments d
ON e.dept_id = d.dept_id
INNER JOIN Salaries s
ON e.emp_id = s.emp_id
GROUP BY d.dept_name;

/* =====================================================
   Question 4: Rank employees by salary.
   ===================================================== */

SELECT e.emp_name,
       s.salary,
       RANK() OVER (ORDER BY s.salary DESC) AS salary_rank
FROM Employees e
INNER JOIN Salaries s
ON e.emp_id = s.emp_id;

/* =====================================================
   Question 5: Find employees hired after 2023.
   ===================================================== */

SELECT *
FROM Employees
WHERE hire_date >= '2024-01-01';

/* =====================================================
   Question 6: Count employees in each department.
   ===================================================== */

SELECT d.dept_name,
       COUNT(e.emp_id) AS employee_count
FROM Employees e
INNER JOIN Departments d
ON e.dept_id = d.dept_id
GROUP BY d.dept_name;

/* =====================================================
   Question 7: Find employees whose salary is above
   the average salary.
   ===================================================== */

SELECT e.emp_name,
       s.salary
FROM Employees e
INNER JOIN Salaries s
ON e.emp_id = s.emp_id
WHERE s.salary >
(
    SELECT AVG(salary)
    FROM Salaries
);

/* =====================================================
   Question 8: Find the second-highest salary.
   ===================================================== */

SELECT MAX(salary) AS second_highest_salary
FROM Salaries
WHERE salary <
(
    SELECT MAX(salary)
    FROM Salaries
);

/* =====================================================
   Question 9: Find the department with the highest
   average salary.
   ===================================================== */

SELECT TOP 1
       d.dept_name,
       AVG(s.salary) AS avg_salary
FROM Employees e
INNER JOIN Departments d
ON e.dept_id = d.dept_id
INNER JOIN Salaries s
ON e.emp_id = s.emp_id
GROUP BY d.dept_name
ORDER BY AVG(s.salary) DESC;

/* For MySQL, use:
LIMIT 1
*/

/* =====================================================
   Question 10: Show employee name, department name,
   and salary.
   ===================================================== */

SELECT e.emp_name,
       d.dept_name,
       s.salary
FROM Employees e
INNER JOIN Departments d
ON e.dept_id = d.dept_id
INNER JOIN Salaries s
ON e.emp_id = s.emp_id;
