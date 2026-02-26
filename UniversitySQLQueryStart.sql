-- USE IN THIS SPECIFIC ORDER:
-- QueryStart
-- SQLQuery
-- QueryInserts
-- QuerySelects

USE master;
GO

IF DB_ID('University') IS NOT NULL
DROP DATABASE University
GO

CREATE DATABASE University;
GO

USE University;
GO
