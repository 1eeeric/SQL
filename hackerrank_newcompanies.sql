SELECT DISTINCT founders.company_code, founder, leads.num_leads, seniors.num_seniors, managers.num_managers, employees.num_employees FROM company as founders
INNER JOIN
	(SELECT company_code, COUNT(lead_manager_code) AS num_leads FROM lead_manager GROUP BY company_code) AS leads
ON founders.company_code = leads.company_code
INNER JOIN
	(SELECT company_code, COUNT(senior_manager_code) AS num_seniors FROM senior_manager GROUP BY company_code) AS seniors
ON founders.company_code = seniors.company_code
INNER JOIN
	(SELECT company_code, COUNT(manager_code) AS num_managers FROM manager GROUP BY company_code) AS managers
ON founders.company_code = managers.company_code
INNER JOIN
	(SELECT company_code, COUNT(employee_code) AS num_employees FROM employee GROUP BY company_code) AS employees
ON founders.company_code = employees.company_code
ORDER BY company_code;