# FA project, Factor Analysis
install.packages("psych")
install.packages("GPArotation")

library(psych)
library(GPArotation)

# 1. loading data
data("USJudgeRatings")
df <- USJudgeRatings
head(df)
dim(df)
str(df)          
summary(df)       
# 43 judges, 12 ratings

# 2. checking correlation
R <- cor(df)
R
pairs(df, main="Visualization of correlation between judge ratings")
#shows relationships between variables, some variables are strongly correlated, others less so

# 3. checking the validity of FA
#squared multiple correlations (SMC)
smc <- smc(R) 
smc

# value close to 1 -> variable is well correlated with others -> we can go with FA
# KMO
KMO(R)

# Bartlett's test
cortest.bartlett(R, n = nrow(df))

# 4. Determine number of factors
eig <- eigen(R)$values
eig
#Take factors with eigenvalue > 1, so the first and second -> 2 factors

# scree plot
plot(eig, type="b", main="Scree plot",
     xlab="Factor number", ylab="Eigenvalue")
abline(h=1, col="red", lty=2)

# 5. Factor analysis
#with rotation
fa1 <- factanal(df, factors=2, rotation="none", scores="regression")
fa1
# very strong correlations between variables for ML

# Attempt on correlation matrix using ML method with orthogonal rotation
fa2 <- factanal(covmat = R,
                factors = 2,
                n.obs = nrow(df),
                rotation = "varimax")

fa2
#the data essentially has a structure close to one-factor

#With 1 factor
fa3 <- factanal(covmat = R,
                factors = 1,
                n.obs = nrow(df))

fa3
# Even with 1 factor it doesn't work due to strong correlations

# 6.PAF
fa_paf_2 <- fa(df,
               nfactors = 2,
               fm = "pa",
               rotate = "varimax")

fa_paf_2

#7. Factor diagram
fa.diagram(fa_paf_2)

# 8. Factor scores
scores_paf <- factor.scores(df, fa_paf_2)
head(scores_paf$scores)

# 9. Visualization of PAF results
par(mar = c(5, 5, 4, 2))
plot(scores_paf$scores[,1], scores_paf$scores[,2],
     xlab = "Factor 1 (PAF)",
     ylab = "Factor 2 (PAF)",
     main = "Judges' positions in factor space (PAF – 2 factors)",
     pch = 19,
     col = "blue")

# Observation labels
text(scores_paf$scores[,1], scores_paf$scores[,2],
     labels = rownames(df),
     pos = 3,
     cex = 0.7)





