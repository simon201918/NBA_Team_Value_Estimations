library(haven)
nba <- read_dta("NBA.dta")
View (nba)
attach(nba)

# change numercial to categorical
str(nba)
ew <- as.factor(ew)
team <- as.factor(team)
have_allstar<- factor(have_allstar, levels=c(0,1), labels=c("no allstar", "have allstar"))
cate_allstar<- factor(cate_allstar, levels=c(0,1,2), labels=c("no allstar", "average allstar","many allstar"))
#season<- factor(season, levels=c(13,14,15,16,17), labels=c("Season 13", "Season 14","Season 15","Season 16","Season 17"))
east<- factor(east, levels=c(0,1), labels=c("West", "East"))
west<- factor(west, levels=c(0,1), labels=c("East", "West"))


# assign newly generated data from global environment to nba.r
detach(nba)
nba$have_allstar<-have_allstar
nba$cate_allstar<-cate_allstar
#nba$season<-season
nba$east<-east
nba$west<-west
attach(nba)
str(nba)

library(plm)
nba_pdata <- pdata.frame(nba, index=c("team","season")) # declare the panel data dimensions

#1 data description
# Will changes in some variables leads to changes in the value of team?
#1.1 First, draw the correlation matrix
View(nba)
correlation_matrix <- nba[, c(3,4,6,7,8,9,10,12,13,14,15,16,17)] 
View(correlation_matrix)
str(correlation_matrix)
library(ggcorrplot)
ggcorrplot(cor(correlation_matrix, method = "pearson", use = "complete.obs")) 
# describe the result of ggcorrplot by interprete the correlation between value and other Xs. For example, a high correlation between season and value means the overall value of NBA teams is increaisng in recent years. Note that we treat season as numerical variable in this matrix.

#1.2 Do some plot of key varibles that we may interested in: how they are connected to team value over time
library(ggplot2)
#1.2.1 Check the relationship between value and revenue
ggplot(nba, aes(x=revenue, y=value)) +
  geom_line(aes(group=team)) +
  facet_wrap(~ team, scales = "free") +
  xlab("revenue") +
  ylab("Value") +
  ggtitle("Plot team value by revenue, 2013-2017") +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())
# Indicates positive relationship: expecting a positive sign of revenue

# 1.2.2 Check the relationship between value and win (which is an indicator of popularity among locals)
ggplot(nba, aes(x=win, y=value)) +
  geom_line(aes(group=team)) +
  facet_wrap(~ team, scales = "free") +
  xlab("win") +
  ylab("Value") +
  ggtitle("Plot team value by win, 2013-2017") +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())
# no distinct pattern, probabaliy hard to say the relationship. But why? Need theory support

# 1.2.3 Check the relationship between value and turnover (which is an indicator of popularity among locals)
ggplot(nba, aes(x=turnover, y=value)) +
  geom_line(aes(group=team)) +
  facet_wrap(~ team, scales = "free") +
  xlab("turnover") +
  ylab("Value") +
  ggtitle("Plot team value by turnover, 2013-2017") +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())
# Indicates negative relationship: expecting a negative sign of turnover

# 1.2.3 Check the relationship between value and allstar (which is an indicator of popularity among locals)
ggplot(nba, aes(x=allstar, y=value)) +
  geom_line(aes(group=team)) +
  facet_wrap(~ team, scales = "free") +
  xlab("allstar") +
  ylab("Value") +
  ggtitle("Plot team value by allstar, 2013-2017") +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())


# 1.2.4 Check the relationship between value and history (which is an indicator of popularity among locals)
ggplot(nba, aes(x=history, y=value)) +
  geom_line(aes(group=team)) +
  facet_wrap(~ team, scales = "free") +
  xlab("History") +
  ylab("Value") +
  ggtitle("Plot team value by history, 2013-2017") +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())
# Indicates positive relationship: expecting a positive sign of history

# 1.2.5 Check the relationship between value and point (which is an indicator of popularity among locals)
ggplot(nba, aes(x=point, y=value)) +
  geom_line(aes(group=team)) +
  facet_wrap(~ team, scales = "free") +
  xlab("point") +
  ylab("Value") +
  ggtitle("Plot team value by point, 2013-2017") +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())
# Not decisive, but why? One theory: Defense is also, or even more important. If team can score a lot but also let the competitor score even more (poor defense), then the point earn doesn't really matters

# 1.2.6 Check the relationship between value and championship (which is an indicator of popularity among locals)
ggplot(nba, aes(x=championship, y=value)) +
  geom_line(aes(group=team)) +
  facet_wrap(~ team, scales = "free") +
  xlab("championship") +
  ylab("Value") +
  ggtitle("Plot team value by championship, 2013-2017") +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())
# No good story: limited observation of team with championship record

# 1.2.7 Check the relationship between value and gdppercapita (which is an indicator of popularity among locals)
ggplot(nba, aes(x=gdppercapita, y=value)) +
  geom_line(aes(group=team)) +
  facet_wrap(~ team, scales = "free") +
  xlab("gdppercapita") +
  ylab("Value") +
  ggtitle("Plot team value by gdppercapita, 2013-2017") +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())
# Indicates positive relationship: expecting a positive sign of gdppercapita

# 1.2.8 Check the relationship between value and revenue (which is an indicator of popularity among locals)
ggplot(nba, aes(x=revenue, y=value)) +
  geom_line(aes(group=team)) +
  facet_wrap(~ team, scales = "free") +
  xlab("revenue") +
  ylab("Value") +
  ggtitle("Plot team value by revenue, 2013-2017") +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())
# Indicates a STRONG positive relationship: expecting a positive sign of revenue


# 2.Regressions
library(plm)
nba_pdata <- pdata.frame(nba, index=c("team","season")) # declare the panel data dimensions
attach(nba_pdata)

# 2.1 without deleting any variable 
#Pooled OLS
pols.<- plm(value ~ assist+turnover+point+win+allstar+history+championship+population+gdppercapita+attendencerate+revenue+east,
            data=nba_pdata, model="pooling")

#Pooled OLS with dummies
pols.id.<- plm(value ~ assist+turnover+point+win+allstar+history+championship+population+gdppercapita+attendencerate+revenue+east+team,
               data=nba_pdata, model="pooling")

# 2.2 Fixed Effect
FixedET <- plm(value ~ assist+turnover+point+win+allstar+history+championship+population+gdppercapita+attendencerate+revenue+east,
               data=nba_pdata, model="within")
FixedET1 <- plm(value ~ assist+turnover+point+win+allstar+history+championship+population+gdppercapita+attendencerate+revenue+east+as.numeric(season),
                data=nba_pdata, model="within")
FixedET2 <- plm(value ~ assist+turnover+point+win+allstar+history+championship+population+gdppercapita+attendencerate+revenue+east+factor(season),data=nba_pdata, model="within")

# 2.3 Random Effect
RandomET <- plm(value ~ assist+turnover+point+win+allstar+history+championship+population+gdppercapita+attendencerate+revenue+east,
                data=nba_pdata, model="random")
RandomET1 <- plm(value ~ assist+turnover+point+win+allstar+history+championship+population+gdppercapita+attendencerate+revenue+east+as.numeric(season),
                 data=nba_pdata, model="random")
RandomET2 <- plm(value ~ assist+turnover+point+win+allstar+history+championship+population+gdppercapita+attendencerate+revenue+east+factor(season),data=nba_pdata, model="random")

# Calcluate AIC
AIC_adj <- function(mod){
  # Number of observations
  n.N <- nrow(mod$model)
  # Residuals vector
  u.hat <- residuals(mod)
  # Variance estimation
  s.sq <- log( (sum(u.hat^2)/(n.N)))
  # Number of parameters (incl. constant) + one additional for variance estimation
  p <- length(coef(mod)) + 1
  # Note: minus sign cancels in log likelihood
  aic <- 2*p + n.N * ( log(2*pi) + s.sq + 1 )
  return(aic)
}

a1<-AIC_adj(pols.)
a2<-AIC_adj(pols.id.)
a3<-AIC_adj(FixedET)
a4<-AIC_adj(FixedET1)
a5<-AIC_adj(FixedET2)
a6<-AIC_adj(RandomET)
a7<-AIC_adj(RandomET1)
a8<-AIC_adj(RandomET2)

library(stargazer)
stargazer(pols.,pols.id.,FixedET,FixedET1,FixedET2,RandomET,RandomET1,RandomET2,
          no.space=TRUE, column.labels = c("Pool OLS","Pool OLS with ID","FE","FE(linear)","FE(dummy)","RE","RE(linear)","RE(dummy)"),type="html",
          out="~/Desktop/raw_resuts.html",omit = c("team","season","Constant"),omit.stat = c("f","ser"),
          add.lines=list(c("AIC", round(a1,2), round(a2,2), round(a3,2), round(a4,2), 
                           round(a5,2), round(a6,2), round(a7,2), round(a8,2))))
# note: R detects a singularities problem for FixedET1, therefore the result of FixedET and FixedET1 is exactly the same ("season" is droped by R)


# 2.4 choose optimal OLS
phtest(pols.id.,pols.) #use POLS ID
# optimal: POLS ID

# 2.5 Choose optimal Random
phtest(RandomET1,RandomET) # tricky!Sequense matters, no result
pFtest(RandomET2,RandomET1) # choose RandomET2
phtest(RandomET1,RandomET2) # tricky!Sequense matters, no result
# optimal: RandomET2

# 2.6 Choose optimal FE
pFtest(FixedET2,FixedET1) # use dummy!
pFtest(FixedET2,FixedET)  # use dummy!
phtest(FixedET1,FixedET) # It's the same model (season is droped)
# optimal: FixedET2

# 2.7 Pool OLS vs RE
phtest(RandomET2,pols.id.) # tricky!Sequense matters, no result

#2.8 RE vs FE
phtest(FixedET2,RandomET2) # use FixedET2


# test for cross-sectional dependence 
pcdtest(FixedET2) # no cross-sectional dependence! Such a relief:) 

# test for serial correlation
# pbgtest(FixedET2)  # serial correlation exists
pwartest(FixedET2) # serial correlation exists

# fix serial correlation
FixedET2.lag1 <- plm(value ~ I(lag(value, k=1))+assist+turnover+point+win+allstar+history+championship+population+gdppercapita+attendencerate+revenue+east+factor(season),data=nba_pdata, model="within")
a4.1<-AIC_adj(FixedET2.lag1)
summary(FixedET2.lag1)
# pbgtest(FixedET2.lag1)  # serial correlation exists, let's use the send test
pwartest(FixedET2.lag1) # serial correlation do not exists (weak evidence), great!

FixedET2.lag2 <- plm(value ~ I(lag(value, k=1))+I(lag(value, k=2))+assist+turnover+point+win+allstar+history+championship+population+gdppercapita+attendencerate+revenue+east+factor(season),data=nba_pdata, model="within")
a4.2<-AIC_adj(FixedET2.lag2)
summary(FixedET2.lag2)
# pbgtest(FixedET2.lag2)  # serial correlation exists, let's use the second test then
pwartest(FixedET2.lag2) # serial correlation do not exists (strong evidence)

library(stargazer)
stargazer(FixedET2,FixedET2.lag1,FixedET2.lag2,
          no.space=TRUE, column.labels = c("FE(dummy)","FE(dummy,lag=1)","FE(dummy,lag=2)"),type="html",
          out="~/Desktop/FEs.html",omit = c("team","season","Constant"),omit.stat = c("f","ser"),
          add.lines=list(c("AIC",round(a4,2), round(a4.1,2), round(a4.2,2))))
# Considering serial correlation, the optimal model is now FE(dummy,lag=1). Even though lag two periods will fix serial correlation compeletely, we will lose 2*30=60 observations as trade off. Since we only have 150 observations, it should be better to choose lag=1 and lose 30 observations.

# Now, use HAC standard error to replace traditional s.e.
library(lmtest)
coeftest(FixedET2.lag1, vcov=vcovHC(FixedET2.lag1,type="HC0",cluster="group"))
cov.FixedET2.lag1 <- vcovHC(FixedET2.lag1,type="HC0",cluster="group")
robust.se.FixedET2.lag1 <- sqrt(diag(cov.FixedET2.lag1))

stargazer(FixedET2.lag1,FixedET2.lag1,se=list(NULL,robust.se.FixedET2.lag1), type="html", out="~/Desktop/compare.html", no.space=TRUE, column.labels = 
            c("FE with lag=1","FE with lag=1 and HAC"), 
          omit = c("team","season","Constant"),omit.stat = c("f","ser"))

# To output the final result:
stargazer(FixedET2.lag1,se=list(robust.se.FixedET2.lag1), type="html", out="~/Desktop/final result.html", no.space=TRUE, column.labels = 
            c("FE with lag=1 and HAC"), 
          omit = c("team","season","Constant"),omit.stat = c("f","ser"))


