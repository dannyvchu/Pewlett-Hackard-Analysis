-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

DROP TABLE retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT d.dept_name, dm.emp_no, dm.from_date, dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm ON d.dept_no = dm.dept_no;


-- Joining retirement_info and dept_emp tables
SELECT r.emp_no, r.first_name, r.last_name, d.to_date
INTO current_emp
FROM retirement_info as r
LEFT JOIN dept_employees as d
ON r.emp_no = d.emp_no
WHERE d.to_date = ('9999-01-01');

SELECT * FROM current_emp;
SELECT * FROM dept_manager;

-- Employee count by department number
SELECT d.dept_no, COUNT(c.emp_no)
INTO dept_count
FROM current_emp as c
LEFT JOIN dept_employees as d
ON c.emp_no = d.emp_no
GROUP BY d.dept_no
ORDER BY d.dept_no;

SELECT * FROM dept_employees
ORDER BY to_date DESC;

-- Create emp_info table
SELECT e.emp_no, 
	e.first_name, 
	e.last_name,
	e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_employees as de
ON (e.emp_no = de.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');

-- Create man_info table
SELECT d.dept_no,
	d.dept_name,
	m.emp_no,
	e.first_name,
	e.last_name,
	m.from_date,
	m.to_date
INTO manager_info
FROM dept_manager as m
INNER JOIN departments as d
ON (m.dept_no = d.dept_no)
INNER JOIN current_emp as e
ON (e.emp_no = m.emp_no)

-- Update current_emp table with dept info
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_employees as de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments as d
ON (d.dept_no = de.dept_no)

-- tailored sales team list
SELECT r.emp_no,
	r.first_name,
	r.last_name,
	d.dept_name
INTO sales_retire_info
FROM retirement_info as r
JOIN dept_employees as de
ON (r.emp_no = de.emp_no)
JOIN departments as d
ON (d.dept_no = de.dept_no)
WHERE dept_name = 'Sales';

-- tailored sales and development team list
SELECT r.emp_no,
	r.first_name,
	r.last_name,
	d.dept_name
INTO sales_dev_retire_info
FROM retirement_info as r
JOIN dept_employees as de
ON (r.emp_no = de.emp_no)
JOIN departments as d
ON (d.dept_no = de.dept_no)
WHERE dept_name IN ('Sales','Development');

