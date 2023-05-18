
--Select the data that I will be using
--Data imported is limited to 37 countries

SELECT location, date, total_cases, new_cases, total_deaths, population

FROM PortfolioProject..CovidDeaths$
ORDER BY 1,2

--Total cases VS Total deaths
--Shows the likelyhood of dying if you get Covid in your country

SELECT location, date, total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage

FROM PortfolioProject.dbo.CovidDeaths$
WHERE location like '%canada%'
ORDER BY 1,2
--Recieved error had to change values from text to number in excel and reupload CovidDeaths because CAST(.... as INTEGER) did not work in query

--looking at total cases VS the population
--shows what percentage of population got covid

SELECT location, date, total_cases,population,(total_cases/population)*100 as PercentPopulationInfected

FROM PortfolioProject.dbo.CovidDeaths$
WHERE location like '%canada%'
ORDER BY 1,2

--Looking at countries with highest infection rates compared to the population
SELECT location,population, MAX(total_cases) AS HighestInfectionCount, Max((total_cases/population))*100 as PercentPopulationInfected

FROM PortfolioProject.dbo.CovidDeaths$
--WHERE location like '%canada%'
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC

--Showing Countries with highest death count by population

SELECT location, MAX(CAST(total_deaths as int)) AS TotalDeathCount
FROM PortfolioProject.dbo.CovidDeaths$
--WHERE location like '%canada%'
WHERE continent is not null
GROUP BY location, population
ORDER BY TotalDeathCount DESC

--exploring further to see which continents in the dataset had the highest death count

SELECT continent, MAX(CAST(total_deaths as int)) AS TotalDeathCount
FROM PortfolioProject.dbo.CovidDeaths$
--WHERE location like '%canada%'
WHERE continent is not null
GROUP BY continent
ORDER BY TotalDeathCount DESC

--VIEW OF ALL THE DAILY NUMBERS OF NEW CASES AND DEATHS WITH COUNTRIES IN THE DATASET
SET ANSI_WARNINGS OFF
GO
SELECT date, SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, NULLIF(SUM(new_deaths),0)/NULLIF(SUM(new_cases),0)*100 as DeathPercentage

FROM PortfolioProject.dbo.CovidDeaths$
WHERE continent is not null
GROUP BY date
ORDER BY 1,2
--had to amend above query due to divide by 0 errors

--Looking at the total population vs vaccinations in selected 37 countries

Select dea.continent, dea.location, dea.date,population,vac.new_vaccinations
FROM PortfolioProject..CovidDeaths$ dea
JOIN PortfolioProject..CovidVaccinations$ vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent is not null
ORDER BY 2,3



