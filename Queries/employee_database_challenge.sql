-- DELIVERABLE 1 --

-- 1. Retrieve the emp_no, first_name, and last_name columns from the Employees table
SELECT e.emp_no, 
    e.first_name, 
    e.last_name,
    t.title, 
    t.from_date,
    t.to_date
INTO retiring_emp_titles
FROM employees as e
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

-- 2. Use Distinct with Order by to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
    first_name,
    last_name,
    title,
INTO retiring_titles_unique
FROM retiring_emp_titles
WHERE to_date = ('9999-01-01')
ORDER BY emp_no, to_date DESC;

-- 3. Retrieve the number of employees by their most recent job title who are about to retire
SELECT COUNT(title),
	title as job_title
INTO retiring_titles_count
FROM retiring_titles_unique
GROUP BY job_title
ORDER BY count DESC;

-- DELIVERABLE 2 --

-- Create a table that holds the employees who are eligible to participate in a mentorship program
SELECT DISTINCT ON (e.emp_no) e.emp_no,
    e.first_name,
    e.last_name,
    e.birth_date,
    de.from_date,
    de.to_date,
    t.title
INTO mentorship_eligibilty
FROM employees as e
    INNER JOIN dept_emp as de
        ON (e.emp_no = de.emp_no)
    INNER JOIN titles as t
        ON (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01') 
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

