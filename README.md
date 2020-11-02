

# NBA Team Value Estimations
This group project investigates National Basketball Association (NBA)  teams' value with econometrics technics in R. There are two key questions the study hope to answer: what the determinants of NBA teams' value are, and the magnitude of these determinants.

## Data Description
The panel data is composted by thirty NBA teams' data during five seasons (2013-2017). The selected variables could be classified into two groups: team performance and home city economic conditions.  The details of the variables and their expected impact are listed below.

| Variable | Meaning | E􏰓pec􏰆ed Infl􏰉ence on Team Value |
| --- | --- |--- |
| `Value` (dependent variable) | NBA team value 􏰆 | +
| `Gdppercapita` | GDP per capita of the home city | +
| `Population` | Population of the home city | +
| `History` | Number of years team stays at current home city | +
| `Championship` | Number of championships in history | +
| `Salary` | Total salary of players in the team | +
| `Allstar` | Number of All-star players in the team | +
| `Win` | Winning percentage in a regular season | +
| `Point` | Team’s average points per game | +
| `Assist` | Team’s average assists per game | +
| `Turnover` | Team’s average turnover per game | -
| `Attendancerate` | Average number of attendances at home court | +
| `Revenue` | Team's revenue | +
| `East` | Whether the team belongs to the East or West | +


The correlation matrix of the variables is shown below.

![say sth](https://github.com/simon201918/NBA_Team_Value_Estimations/blob/main/correlation%20matrix.jpeg?raw=true)
 

## Model Selection
The candidate models are **OLS, fixed-effect model, and random-effect model**.

OLS doesn't work well with panel data because it could not control the unobserved heteroscedasticity. The fixed-effect model allows us to control the unobserved factors that affect each individuals differently and do NOT change over time. By definition, the random-effect model is a fixed-effect model that satisfies one additional assumption: PART of the error term is not correlated with explanatory variables, which unfortunately is a strong assumption. The statical evidence also suggests that the fixed-effect model works better than the random-effect model when estimating NBA teams' value. 

## Results
The optimal fixed-effect model's parameters and significance agree with the initial hypothesis, and the result is summarized below.

| Variable | Coefficien􏰆 and 􏰅􏰆significance level |
| --- | --- |
| `NBA team value (Lag one season)`  | 0.680***
| `Team’s average assists per game`  | 20.677
| `Team’s average turnover per game`  | -57.825***
| `Team’s average points per game`  | 2.813
| `Winning percentage in a regular season`  | -2.184
| `Number of All-star players in the team`  | 4.385
| `Numbers of years in current home city`  | -65.479***
| `Number of championships in history`  | 65.625**
| `Population`  | 0.001*
| `GDP per capita of the home city`  | 0.022***
| `Average number of attendances at home court`  | -0.008
| `Team Revenue`  | 2.973***
|    |  
| Observations  | 120
| R-Square  | 0.932
| Adjusted R-Square  | 0.893
| Note  | *p<0.1; **p<0.05; ***p<0.01


The limitations of this research include endogeneity, heteroskedasticity, and serial correlation. Adding more observations may mitigate these problems, though data is not always readily available and is costly to collect. 

The project may be valuable to both team managers and investors (supporting better hiring and investment decisions, etc.). 

## Source of data:
[NBA All-Star Game. (2018)](https://www.basketball-reference.com/allstar/NBA_2018.html)

[NBA Attendance. (2018)](http://www.espn.com/nba/attendance/_/year/2018/order/false)

[NBA Team List. (2018)](http://www.stat-nba.com/teamList.php)

[NBA Teams. (2018)](https://stats.nba.com/teams/)

[NBA Valuations. (2018)](https://www.forbes.com/nba-valuations/list/)
