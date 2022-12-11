CREATE TABLE Vendas
(
    Id      INTEGER,
    Name    VARCHAR2(50),
    Gender  VARCHAR2(10),
    Salary  INTEGER,
    Country VARCHAR2(10),
        CONSTRAINT pk_employees PRIMARY KEY (Id)
);

Insert Into Employees Values (1, 'Mark', 'Male', 5000, 'USA');
Insert Into Employees Values (2, 'John', 'Male', 4500, 'India');
Insert Into Employees Values (3, 'Pam', 'Female', 5500, 'USA');
Insert Into Employees Values (4, 'Sara', 'Female', 4000, 'India');
Insert Into Employees Values (5, 'Todd', 'Male', 3500, 'India');
Insert Into Employees Values (6, 'Mary', 'Female', 5000, 'UK');
Insert Into Employees Values (7, 'Ben', 'Male', 6500, 'UK');
Insert Into Employees Values (8, 'Elizabeth', 'Female', 7000, 'USA');
Insert Into Employees Values (9, 'Tom', 'Male', 5500, 'UK');
Insert Into Employees Values (10, 'Ron', 'Male', 5000, 'USA');


Select Country, Gender, Sum(Salary) TotalSalary --colunas a serem selecionadas e operação de agrupamento realizada
From Employees
Group BY
      GROUPING SETS --agrupa de acordo com o que vem descrito abaixo
      (
            (Country, Gender),  --(1) separa a soma dos salários por país e cada um por gênero
            (Country),          --(2) separa a soma dos salários apenas por país, sem se preocupar com gênero
            (Gender) ,          --(3) separa apenas por gênero, n importando o país
            ()                  --(4) soma todos os salários existentes na tabela
      )
Order By Grouping(Country), Grouping(gender), gender;   --Ordem de preferência na ordenação

--de onde vem? Union de Selects com cada group by colocado dentro do set

--(1)
Select Country, Gender, Sum(Salary) as TotalSalary
From Employees  
Group By Country, Gender

UNION ALL   --une todas as informações de dois blocos

--(2)
Select Country, NULL, Sum(Salary) as TotalSalary
From Employees  
Group By Country

UNION ALL

--(3)
Select NULL, Gender, Sum(Salary) as TotalSalary
From Employees  
Group By Gender

UNION ALL

--(4)
Select NULL, NULL, Sum(Salary) as TotalSalary
From Employees 

