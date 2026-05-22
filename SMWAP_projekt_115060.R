# Projekt FA, oceny sędziów USA
install.packages("psych")
install.packages("GPArotation")

library(psych)
library(GPArotation)

# 1. Otwieramy dane
data("USJudgeRatings")
df <- USJudgeRatings
head(df)
dim(df)
str(df)          
summary(df)       
# 43 sędziów, 12 ocen

# 2. Sprawdzamy korelacje
R <- cor(df)
R
pairs(df, main="Wizualizacja korelacji ocen sędziów")
#pokazuje powiązania między zmiennymi, niektóre zmienne są mocno ze sobą powiązane, a inne mniej

# 3. Sprawdzamy zasadność analizy czynnikowej
#kwadrat korelacji wielorakiej (SMC)
smc <- smc(R) 
smc

#wyartość bliska 1 -> zmienna dobrze powiązana z innymi -> jest sens użyć FA
# KMO
KMO(R)

# Test Bartletta
cortest.bartlett(R, n = nrow(df))

# 4. Określamy liczbę czynników
eig <- eigen(R)$values
eig
#Bierzemy czynniki z eigenvalue > 1, czyli pierwszy i drugi-> 2 czynniki

# Wykres osypiska (scree plot)
plot(eig, type="b", main="Wykres osypiska",
     xlab="Numer czynnika", ylab="Wartość własna")
abline(h=1, col="red", lty=2)

# 5. Analiza czynnikowa
#z rotacją
fa1 <- factanal(df, factors=2, rotation="none", scores="regression")
fa1
# bardzo silne korelacje pomiędzy zmiennymi dla ML

# próba na macierzy korelacji metodą ML z rotacją ortogonalną
fa2 <- factanal(covmat = R,
                factors = 2,
                n.obs = nrow(df),
                rotation = "varimax")

fa2
#dane mają w praktyce strukturę bliską jednoczynnikowej

#z 1 czynnikiem
fa3 <- factanal(covmat = R,
                factors = 1,
                n.obs = nrow(df))

fa3
#nawet dla 1 czynnika nie działa ze wzgledu na silną korelacje

# 6.PAF
fa_paf_2 <- fa(df,
               nfactors = 2,
               fm = "pa",
               rotate = "varimax")

fa_paf_2

#7. diagram czynnikowy
fa.diagram(fa_paf_2)

# 8. wartości czynnikowe
scores_paf <- factor.scores(df, fa_paf_2)
head(scores_paf$scores)

# 9. Wizualizacja wyników PAF
par(mar = c(5, 5, 4, 2))
plot(scores_paf$scores[,1], scores_paf$scores[,2],
     xlab = "Czynnik 1 (PAF)",
     ylab = "Czynnik 2 (PAF)",
     main = "Położenie sędziów w przestrzeni czynnikowej (PAF – 2 czynniki)",
     pch = 19,
     col = "blue")

# podpisy obserwacji
text(scores_paf$scores[,1], scores_paf$scores[,2],
     labels = rownames(df),
     pos = 3,
     cex = 0.7)





