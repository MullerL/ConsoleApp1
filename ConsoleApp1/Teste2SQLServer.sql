CREATE DATABASE [BancoFinanciamento]

USE [BancoFinanciamento]
GO

CREATE TABLE [dbo].[Cliente](
	[IdCliente] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[Nome] [varchar](100) NOT NULL,
	[UF] [varchar](2) NOT NULL,
	[Celular] [varchar](14) NOT NULL,
)
GO

CREATE TABLE [dbo].[Financiamento](
	[IdFinanciamento] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[IdCliente] [int] NOT NULL FOREIGN KEY REFERENCES [Cliente]([IdCliente]),
	[TipoFinanciamento] [varchar](100) NOT NULL,
	[ValorTotal] [decimal](9,2) NOT NULL,
	[DataVencimento] [datetime] NOT NULL,
)
GO

CREATE TABLE [dbo].[Parcela](
	[IdParcela] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[IdFinanciamento] [int] NOT NULL FOREIGN KEY REFERENCES [Financiamento]([IdFinanciamento]),
	[NumeroParcela] [int] NOT NULL,
	[ValorParcela] [decimal](9,2) NOT NULL,
	[DataVencimento] [datetime] NOT NULL,
	[DataPagamento] [datetime] NULL,
)
GO
--Inserts Cliente
--insert into Cliente values ('ze','SP','(11)98888-3333')
--insert into Cliente values ('joao','SP','(11)98888-3333')
--insert into Cliente values ('antonio','SP','(11)98888-3333')

--Financiamento

--insert into Financiamento values (1,'Casa',12000.00, '2020-09-22')
--insert into Financiamento values (2,'Moto',20000.00, '2020-10-22')

--Parcela
--insert into Parcela values (1,1,4000.00, '2020-07-22', '2020-07-22')
--insert into Parcela values (1,2,4000.00, '2020-08-22', null)
--insert into Parcela values (1,3,4000.00, '2020-09-22', null)

--insert into Parcela values (3,1,5000.00, '2020-07-22', '2020-07-22')
--insert into Parcela values (3,2,5000.00, '2020-08-22', '2020-08-22')
--insert into Parcela values (3,3,5000.00, '2020-09-22', '2020-09-22')
--insert into Parcela values (3,4,5000.00, '2020-10-22', null)


--- Listar todos os clientes do estado de SP que tenham mais de 60% das parcelas pagas.
select case when count(P.DataPagamento) > (count(*) - count(P.DataPagamento)) then C.Nome end 
from Cliente C
inner join Financiamento F on F.[IdCliente] = C.IdCliente
inner join Parcela P on P.IdFinanciamento = F.IdFinanciamento
where C.UF = 'SP'
group by C.Nome


--- Listar os primeiros 4 clientes que tenham alguma parcela com mais de 05 dias atrasadas 
--(Data Vencimento maior que data atual E data pagamento nula)
select distinct top 4 C.Nome from Cliente C
inner join Financiamento F on F.[IdCliente] = C.IdCliente
inner join Parcela P on P.IdFinanciamento = F.IdFinanciamento
where DATEDIFF(day, P.DataVencimento, getdate()) > 5 and P.DataPagamento is null

--- Listar todos os clientes que já atrasaram em algum momento duas ou mais parcelas em mais de 10 dias, 
--e que o valor do financiamento seja maior que R$ 10.000,00.
select case when count(P.DataVencimento) > 1 then C.Nome end from Cliente C
inner join Financiamento F on F.[IdCliente] = C.IdCliente
inner join Parcela P on P.IdFinanciamento = F.IdFinanciamento
where DATEDIFF(day, P.DataVencimento, getdate()) > 10 and P.DataPagamento is null
and F.ValorTotal > 10000.00
group by C.Nome