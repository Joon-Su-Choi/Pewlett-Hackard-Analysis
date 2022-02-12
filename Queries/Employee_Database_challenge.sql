SELECT emp_no, first_name, last_name
FROM employees;

SELECT title, from_date, to_date
FROM titles;

-- Retirement table for employees who are born 
-- between January 1, 1952 and December 31, 1955

SELECT employees.emp_no, 
	employees.first_name, 
	employees.last_name, 
	titles.title, 
	titles.from_date, 
	titles.to_date
INTO retirement_titles
FROM employees
INNER JOIN titles
ON employees.emp_no = titles.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

SELECT * FROM retirement_titles

-- Use Dictinct with Orderby to remove duplicate rows

SELECT DISTINCT ON (retirement_titles.emp_no) retirement_titles.emp_no,
retirement_titles.first_name,
retirement_titles.last_name,
retirement_titles.title

INTO unique_titles
FROM retirement_titles
WHERE to_date = ('9999-01-01')
ORDER BY emp_no, to_date DESC;

SELECT * FROM unique_titles;

-- Retrieve the number of employees 
-- by their most recent job title who are about to retire

SELECT COUNT (unique_titles.title), unique_titles.title
INTO retiring_titles
FROM unique_titles
GROUP BY unique_titles.title
ORDER BY COUNT DESC; 

SELECT * FROM retiring_titles;

-- Create a mentorship-eligibility table that holds 
-- the current employees who were born 
-- between January 1, 1965 and December 31, 1965

SELECT emp_no, first_name, last_name, birth_date
FROM employees;

SELECT from_date, to_date
FROM dept_emp;

SELECT title
FROM titles;

SELECT DISTINCT ON (employees.emp_no) employees.emp_no,
employees.first_name,
employees.last_name,
employees.birth_date,
dept_emp.from_date,
dept_emp.to_date,
titles.title
INTO mentorship_eligibilty
FROM employees
LEFT JOIN dept_emp
ON (employees.emp_no = dept_emp.emp_no)
LEFT JOIN titles
ON (employees.emp_no = titles.emp_no)
WHERE (employees.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
    AND (dept_emp.to_date = '9999-01-01')
ORDER BY employees.emp_no

-- View mentorship_eligibility table
SELECT * FROM mentorship_eligibilty;

DROP TABLE retiring_titles
DROP TABLE retirement_titles
DROP TABLE mentorship_eligibilty
DROP TABLE unique_titles