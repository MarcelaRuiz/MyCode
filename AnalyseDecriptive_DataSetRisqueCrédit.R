#install.packages('mise')
#install.packages('pastecs')
#install.packages('gmodels')
#install.packages('car')

#Quelques librairies
library(mise)#Pour la mise � jour
library(pastecs) # Pour les stats
library(ggplot2) # Meilleure visualisation
library(gmodels) # Pour les tables de contingence
library(questionr)# Pour les fr�quence
library(car) # Pour le recodage des variables

#On charge les donn�es
data_set <- read.csv("german_credit.csv", header = TRUE, sep = ",")
#On v�rifie les variables
names(data_set)
#On v�rifie la classe
class(data_set)
#On v�rifie la dimension
dim(data_set)
#On visualise quelques donn�es
head(data_set)
#On r�cup�re des informations sur le type des variables
str(data_set)
#On v�rifie les valeurs manquantes
sum(is.na(data_set))
#On modifie le type des variables cat�gorielles
data_set$Cote_credit<-factor(data_set$Cote_credit)
data_set$Solde_compte<-factor(data_set$Solde_compte)
data_set$Historique_credit_statut<-factor(data_set$Historique_credit_statut)
data_set$But_credit<-factor(data_set$But_credit)
data_set$Epargne_statut<-factor(data_set$Epargne_statut)
data_set$Duree_emploi<-factor(data_set$Duree_emploi)
data_set$Taux_acompte<-factor(data_set$Taux_acompte)
data_set$Statut_genre<-factor(data_set$Statut_genre)
data_set$Garant<-factor(data_set$Garant)
data_set$Duree_residence<-factor(data_set$Duree_residence)
data_set$Proprietes_biens<-factor(data_set$Proprietes_biens)
data_set$Autres_credit<-factor(data_set$Autres_credit)
data_set$Type_logement<-factor(data_set$Type_logement)
data_set$Credit_banque<-factor(data_set$Credit_banque)
data_set$Occupation<-factor(data_set$Occupation)
data_set$Personnes_charge<-factor(data_set$Personnes_charge)
data_set$Tel<-factor(data_set$Tel)
data_set$Etranger<-factor(data_set$Etranger)
#On rev�rifie apr�s modification
str(data_set)
#On r�cup�re une synth�se des statistiques descriptives
summary(data_set)
#Visualisation de quelques variables qualitatives et quantitatives
#Visualisation de la variable cote_credit
table(data_set$Cote_credit)
freq(data_set$Cote_credit,valid=FALSE, total=TRUE,sort="DEC")
barplot(sort(table(data_set$Cote_credit)))
#Visualisation de la variable Solde_compte
table(data_set$Solde_compte)
freq(data_set$Solde_compte,valid=FALSE, total=TRUE,sort="DEC")
barplot(sort(table(data_set$Solde_compte)))
#Recodage des classes 3 et 4 de la variable Solde_compte
Solde_compte_new <- recode(data_set$Solde_compte,"1=1;2=2;3=3;4=3")
data_set$Solde_compte <- Solde_compte_new 
#Revisionnement apr�s couplage des classes 3 et 4
barplot(sort(table(data_set$Solde_compte)))
#On v�rifie que la variable Solde_compte admet 3 cat�gories
str(data_set)
# Tableau de contingence Cote_credit/Solde_compte
Tab_contingence<-table(data_set$Cote_credit,data_set$Solde_compte)
#On visualise le tableau de contingence
Tab_contingence
#On visualise les fr�quence dans le tableau de contingence
frequence<-prop.table(Tab_contingence)*100
frequence
lprop(Tab_contingence)#Pourcentages ligne
cprop(Tab_contingence)#Pourcentages colonne
#Visualisation du tableau de contingence
mosaicplot(Tab_contingence, col=c("antiquewhite4","antiquewhite3","antiquewhite1"))
#help(palette)#Pour visualiser les couleurs
#On calcule la chi valeur pour d�duire une d�pendance entre les variables
chisq.test(Tab_contingence)
#Statistique variable quantitative
#On r�cup�re les statisques de la variable dur�e
summary(data_set$Duree_credit_mois)
#Histogramme de la variable Duree_credit_mois
hist(data_set$Duree_credit_mois, col = "skyblue",
     main = "Histogramme de la variable -Dur�e du cr�dit-",
     xlab = "Dur�e",
     ylab = "Effectif")
#On visualise la fonction densit� pour mieux interpr�ter les pics
plot(density(data_set$Duree_credit_mois),xlab="Dur�e du cr�dit en mois",ylab="",main="Fonction densit�")
#Croisement quanti, quali pour analyse
#On visualise par un croisement avec la variable Cote_credit
boxplot(data_set$Duree_credit_mois ~ data_set$Cote_credit,main="C�te_cr�dit - Dur�e_cr�dit")
#Analyse variable Historique_credit_statut
table(data_set$Historique_credit_statut)#summary(data_set$Historique_credit_statut)
#freq(data_set$Historique_credit_statut,valid=FALSE, total=TRUE,sort="DEC")
barplot(sort(table(data_set$Historique_credit_statut)), main=" R�partition de la variable Historique du cr�dit")
#Recodage des classes 0 et 1 de la variable Historique_credit_statut et aussi des classes 3 et 4
Historique_new <- recode(data_set$Historique_credit_statut,"0=1;1=1;2=2;3=3;4=3")
data_set$Historique_credit_statut <- Historique_new
#Revisionnement apr�s couplage des classes 
barplot(sort(table(data_set$Historique_credit_statut)),main="R�partition apr�s regroupement des classes")
#On v�rifie que la variable Historique admet 3 cat�gories
str(data_set)
# Tableau de contingence Cote_credit/Historique_credit_statut
Tab_contingence_historique<-table(data_set$Cote_credit,data_set$Historique_credit_statut)
#On visualise le tableau de contingence
Tab_contingence_historique
#On visualise les fr�quence dans le tableau de contingence
frequence<-prop.table(Tab_contingence_historique)*100
frequence
lprop(Tab_contingence)#Pourcentages ligne
cprop(Tab_contingence)#Pourcentages colonne
#Visualisation du tableau de contingence
mosaicplot(Tab_contingence_historique, col=c("antiquewhite4","antiquewhite3","antiquewhite1"))
#help(palette)#Pour visualiser les couleurs
#On calcule la chi valeur pour d�duire une d�pendance entre les variables
chisq.test(Tab_contingence_historique)
#Analyse variable But_credit
table(data_set$But_credit)#summary(data_set$But_credit)
freq(data_set$But_credit,valid=FALSE, total=TRUE)
barplot(sort(table(data_set$But_credit)), main=" R�partition de la variable But du cr�dit")
#Recodage des classes de la variable But_credit_statut 
But_new <- recode(data_set$But_credit,"0=4;1=1;2=2;3=3;4=3;5=3;6=3;7=4;8=4;9=4;10=4")
data_set$But_credit <- But_new
#Revisionnement apr�s couplage des classes 
barplot(sort(table(data_set$But_credit)),main="R�partition apr�s regroupement des classes")
#On v�rifie que la variable Historique admet 3 cat�gories
str(data_set)
# Tableau de contingence Cote_credit/But_credit
Tab_contingence_but<-table(data_set$Cote_credit,data_set$But_credit)
#On visualise le tableau de contingence
Tab_contingence_but
#On visualise les fr�quence dans le tableau de contingence
frequence<-prop.table(Tab_contingence_but)*100
frequence
lprop(Tab_contingence_but)#Pourcentages ligne
cprop(Tab_contingence_but)#Pourcentages colonne
#Visualisation du tableau de contingence
mosaicplot(Tab_contingence_but, col=c("antiquewhite4","antiquewhite3","antiquewhite1","antiquewhite2"))
#help(palette)#Pour visualiser les couleurs
#On calcule la chi valeur pour d�duire une d�pendance entre les variables
chisq.test(Tab_contingence_historique)
#Etude de la variable Credit_demande
summary(data_set$Credit_demande)
#On visualise la fonction densit� pour mieux interpr�ter les z�nes � fort demande
plot(density(data_set$Credit_demande),xlab="Montant du cr�dit",ylab="",main="Fonction densit�")
#On visualise par un croisement entre la variable Credit_demande et Cote_credit
boxplot(data_set$Credit_demande ~ data_set$Cote_credit,main="Cr�dit demand� - C�te_cr�dit")
boxplot(data_set$Credit_demande ,main="Diagramme Cr�dit demand�")
#Analyse variable Epargne_statut
table(data_set$Epargne_statut)#summary(data_set$But_credit)
freq(data_set$Epargne_statut,valid=FALSE, total=TRUE)
barplot(sort(table(data_set$Epargne_statut)), main=" R�partition de la variable Epargne")
#Recodage des classes de la variable Epargne_statut 
Epargne_new <- recode(data_set$Epargne_statut,"1=1;2=2;3=3;4=3;5=4")
data_set$Epargne_statut <- Epargne_new
#Revisionnement apr�s couplage des classes 
barplot(sort(table(data_set$Epargne_statut)),main="R�partition apr�s regroupement des classes")
#On v�rifie que la variable Historique admet 4 cat�gories
str(data_set)
# Tableau de contingence Cote_credit/Epargne_statut
Tab_contingence_epargne<-table(data_set$Cote_credit,data_set$Epargne_statut)
#On visualise le tableau de contingence
Tab_contingence_epargne
#On visualise les fr�quence dans le tableau de contingence
frequence<-prop.table(Tab_contingence_epargne)*100
frequence
lprop(Tab_contingence_epargne)#Pourcentages ligne
cprop(Tab_contingence_epargne)#Pourcentages colonne
#Visualisation du tableau de contingence
mosaicplot(Tab_contingence_epargne, col=c("antiquewhite4","antiquewhite3","antiquewhite1","antiquewhite2"))
#help(palette)#Pour visualiser les couleurs
#On calcule la chi valeur pour d�duire une d�pendance entre les variables
chisq.test(Tab_contingence_epargne)
#Analyse variable Duree_emploi
table(data_set$Duree_emploi)#summary(data_set$Duree_emploi)
freq(data_set$Duree_emploi,valid=FALSE, total=TRUE)
barplot(sort(table(data_set$Duree_emploi)), main=" R�partition de la variable Dur�e de l'emploi")
#Recodage des classes de la variable Epargne_statut 
emploi_new <- recode(data_set$Duree_emploi,"1=1;2=1;3=2;4=3;5=4")
data_set$Duree_emploi <- emploi_new
#Revisionnement apr�s couplage des classes 
barplot(sort(table(data_set$Duree_emploi)),main="R�partition apr�s regroupement des classes")
#On v�rifie que la variable Duree_emploi admet 4 cat�gories
str(data_set)
# Tableau de contingence Cote_credit/Duree_emploi
Tab_contingence_emploi<-table(data_set$Cote_credit,data_set$Duree_emploi)
#On visualise le tableau de contingence
Tab_contingence_emploi
#On visualise les fr�quence dans le tableau de contingence
frequence<-prop.table(Tab_contingence_emploi)*100
frequence
lprop(Tab_contingence_emploi)#Pourcentages ligne
cprop(Tab_contingence_emploi)#Pourcentages colonne
#Visualisation du tableau de contingence
mosaicplot(Tab_contingence_emploi, col=c("antiquewhite4","antiquewhite3","antiquewhite1","antiquewhite2"))
#help(palette)#Pour visualiser les couleurs
#On calcule la chi valeur pour d�duire une d�pendance entre les variables
chisq.test(Tab_contingence_emploi)
#Analyse variable Taux_acompte
table(data_set$Taux_acompte)#summary(data_set$Taux_acompte)
freq(data_set$Taux_acompte,valid=FALSE, total=TRUE)
barplot(sort(table(data_set$Taux_acompte)), main=" R�partition de la variable Taux_acompte")
# Tableau de contingence Cote_credit/Taux_acompte
Tab_contingence_acompte<-table(data_set$Cote_credit,data_set$Taux_acompte)
#On visualise le tableau de contingence
Tab_contingence_acompte
#On visualise les fr�quence dans le tableau de contingence
frequence<-prop.table(Tab_contingence_acompte)*100
frequence
lprop(Tab_contingence_acompte)#Pourcentages ligne
cprop(Tab_contingence_acompte)#Pourcentages colonne
#Visualisation du tableau de contingence
mosaicplot(Tab_contingence_acompte, col=c("antiquewhite4","antiquewhite3","antiquewhite1","antiquewhite2"))
#help(palette)#Pour visualiser les couleurs
#On calcule la chi valeur pour d�duire une d�pendance entre les variables
chisq.test(Tab_contingence_acompte)
#Analyse variable Statut_genre
table(data_set$Statut_genre)#summary(data_set$Statut_genre)
freq(data_set$Statut_genre,valid=FALSE, total=TRUE)
barplot(sort(table(data_set$Statut_genre)), main=" R�partition de la variable Statut & genre")
#Recodage des classes de la variable Statut_genre 
statut_new <- recode(data_set$Statut_genre,"1=1;2=1;3=2;4=3")
data_set$Statut_genre <- statut_new
#Revisionnement apr�s couplage des classes 
barplot(sort(table(data_set$Statut_genre)),main="R�partition apr�s regroupement des classes")
#On v�rifie que la variable Duree_emploi admet 4 cat�gories
str(data_set)
# Tableau de contingence Cote_credit/Statut
Tab_contingence_statut<-table(data_set$Cote_credit,data_set$Statut_genre)
#On visualise le tableau de contingence
Tab_contingence_statut
#On visualise les fr�quence dans le tableau de contingence
frequence<-prop.table(Tab_contingence_statut)*100
frequence
lprop(Tab_contingence_statut)#Pourcentages ligne
cprop(Tab_contingence_statut)#Pourcentages colonne
#Visualisation du tableau de contingence
mosaicplot(Tab_contingence_statut, col=c("antiquewhite4","antiquewhite3","antiquewhite1","antiquewhite2"))
#help(palette)#Pour visualiser les couleurs
#On calcule la chi valeur pour d�duire une d�pendance entre les variables
chisq.test(Tab_contingence_statut)
#Analyse variable Garant
table(data_set$Garant)#summary(data_set$Garant)
freq(data_set$Garant,valid=FALSE, total=TRUE)
barplot(sort(table(data_set$Garant)), main=" R�partition de la variable Garant")
#Recodage des classes de la variable Garant
garant_new <- recode(data_set$Garant,"1=1;2=2;3=2")
data_set$Garant <- garant_new
#Revisionnement apr�s couplage des classes 
barplot(sort(table(data_set$Garant)),main="R�partition apr�s regroupement des classes")
#On v�rifie que la variable Duree_emploi admet 2 cat�gories
str(data_set)
# Tableau de contingence Cote_credit/Garant
Tab_contingence_garant<-table(data_set$Cote_credit,data_set$Garant)
#On visualise le tableau de contingence
Tab_contingence_garant
#On visualise les fr�quence dans le tableau de contingence
frequence<-prop.table(Tab_contingence_garant)*100
frequence
lprop(Tab_contingence_garant)#Pourcentages ligne
cprop(Tab_contingence_garant)#Pourcentages colonne
#Visualisation du tableau de contingence
mosaicplot(Tab_contingence_garant, col=c("antiquewhite4","antiquewhite2"))
#help(palette)#Pour visualiser les couleurs
#On calcule la chi valeur pour d�duire une d�pendance entre les variables
chisq.test(Tab_contingence_garant)
#Analyse variable Duree_residence
table(data_set$Duree_residence)#summary(data_set$Duree_residence)
freq(data_set$Duree_residence,valid=FALSE, total=TRUE)
barplot(sort(table(data_set$Duree_residence)), main=" R�partition de la variable Dur�e de r�sidence")
# Tableau de contingence Cote_credit/Duree_residence
Tab_contingence_residence<-table(data_set$Cote_credit,data_set$Duree_residence)
#On visualise le tableau de contingence
Tab_contingence_residence
#On visualise les fr�quence dans le tableau de contingence
frequence<-prop.table(Tab_contingence_residence)*100
frequence
lprop(Tab_contingence_residence)#Pourcentages ligne
cprop(Tab_contingence_residence)#Pourcentages colonne
#Visualisation du tableau de contingence
mosaicplot(Tab_contingence_residence, col=c("antiquewhite4","antiquewhite3","antiquewhite1","antiquewhite2"))
#help(palette)#Pour visualiser les couleurs
#On calcule la chi valeur pour d�duire une d�pendance entre les variables
chisq.test(Tab_contingence_residence)
#Analyse variable Biens
table(data_set$Proprietes_biens)#summary(data_set$Proprietes_biens)
freq(data_set$Proprietes_biens,valid=FALSE, total=TRUE)
barplot(sort(table(data_set$Proprietes_biens)), main=" R�partition de la variable Propri�t�s_biens")
# Tableau de contingence Cote_credit/Proprietes_biens
Tab_contingence_biens<-table(data_set$Cote_credit,data_set$Proprietes_biens)
#On visualise le tableau de contingence
Tab_contingence_biens
#On visualise les fr�quence dans le tableau de contingence
frequence<-prop.table(Tab_contingence_biens)*100
frequence
lprop(Tab_contingence_biens)#Pourcentages ligne
cprop(Tab_contingence_biens)#Pourcentages colonne
#Visualisation du tableau de contingence
mosaicplot(Tab_contingence_biens, col=c("antiquewhite4","antiquewhite3","antiquewhite2","antiquewhite1"))
#help(palette)#Pour visualiser les couleurs
#On calcule la chi valeur pour d�duire une d�pendance entre les variables
chisq.test(Tab_contingence_biens)
#Statistique variable quantitative Age
summary(data_set$Age)
#Histogramme de la variable Duree_credit_mois
hist(data_set$Age, col = "skyblue",
     main = "Histogramme de la variable Age",
     xlab = "Dur�e",
     ylab = "Effectif")
#On visualise la fonction densit� pour mieux interpr�ter les pics
plot(density(data_set$Age),xlab="Age",ylab="",main="Fonction densit�")
#Croisement quanti, quali pour analyse
#On visualise par un croisement avec la variable Cote_credit
boxplot(data_set$Age ~ data_set$Cote_credit,main="C�te_cr�dit - Age")
#Analyse variable Autres cr�dits
table(data_set$Autres_credit)#summary(data_set$Autres_credit)
freq(data_set$Autres_credit,valid=FALSE, total=TRUE)
barplot(sort(table(data_set$Autres_credit)), main=" R�partition de la variable Autres cr�dits")
#Recodage des classes de la variable Autres_credit
credit_new <- recode(data_set$Autres_credit,"1=1;2=1;3=2")
data_set$Autres_credit <- credit_new
#Revisionnement apr�s couplage des classes 
barplot(sort(table(data_set$Autres_credit)),main="R�partition apr�s regroupement des classes")
#On v�rifie que la variable Duree_emploi admet 2 cat�gories
str(data_set)
# Tableau de contingence Cote_credit/Garant
Tab_contingence_credits<-table(data_set$Cote_credit,data_set$Autres_credit)
#On visualise le tableau de contingence
Tab_contingence_credits
#On visualise les fr�quence dans le tableau de contingence
frequence<-prop.table(Tab_contingence_credits)*100
frequence
lprop(Tab_contingence_credits)#Pourcentages ligne
cprop(Tab_contingence_credits)#Pourcentages colonne
#Visualisation du tableau de contingence
mosaicplot(Tab_contingence_credits, col=c("antiquewhite4","antiquewhite2"),main="Croisement des variables Autres cr�dits et Co�t du  cr�dit")
#help(palette)#Pour visualiser les couleurs
#On calcule la chi valeur pour d�duire une d�pendance entre les variables
chisq.test(Tab_contingence_credits)
#Analyse variable Type du logement
table(data_set$Type_logement)#summary(data_set$Type_logement)
freq(data_set$Type_logement,valid=FALSE, total=TRUE)
barplot(sort(table(data_set$Type_logement)), main=" R�partition de la variable Type du logement")
# Tableau de contingence Cote_credit/Type_logement
Tab_contingence_logement<-table(data_set$Cote_credit,data_set$Type_logement)
#On visualise le tableau de contingence
Tab_contingence_logement
#On visualise les fr�quence dans le tableau de contingence
frequence<-prop.table(Tab_contingence_logement)*100
frequence
lprop(Tab_contingence_logement)#Pourcentages ligne
cprop(Tab_contingence_logement)#Pourcentages colonne
#Visualisation du tableau de contingence
mosaicplot(Tab_contingence_logement, col=c("antiquewhite4","antiquewhite3","antiquewhite2"))
#help(palette)#Pour visualiser les couleurs
#On calcule la chi valeur pour d�duire une d�pendance entre les variables
chisq.test(Tab_contingence_logement)
#Analyse variable du Nombre d'autres cr�dits
table(data_set$Credit_banque)#summary(data_set$Credit_banque)
freq(data_set$Credit_banque,valid=FALSE, total=TRUE)
barplot(sort(table(data_set$Credit_banque)), main=" R�partition de la variable Nombre d'autres cr�dits")
#Recodage des classes de la variable Autres_credit
Nbcredit_new <- recode(data_set$Credit_banque,"1=1;2=2;3=2;4=2")
data_set$Credit_banque <- Nbcredit_new
#Revisionnement apr�s couplage des classes 
barplot(sort(table(data_set$Credit_banque)),main="R�partition apr�s regroupement des classes")
#On v�rifie que la variable Duree_emploi admet 2 cat�gories
str(data_set)
# Tableau de contingence Cote_credit/Garant
Tab_contingence_Nbcredits<-table(data_set$Cote_credit,data_set$Credit_banque)
#On visualise le tableau de contingence
Tab_contingence_Nbcredits
#On visualise les fr�quence dans le tableau de contingence
frequence<-prop.table(Tab_contingence_Nbcredits)*100
frequence
lprop(Tab_contingence_Nbcredits)#Pourcentages ligne
cprop(Tab_contingence_Nbcredits)#Pourcentages colonne
#Visualisation du tableau de contingence
mosaicplot(Tab_contingence_Nbcredits, col=c("antiquewhite4","antiquewhite2"),main="Croisement des variables Nombre cr�dits et Co�t du  cr�dit")
#help(palette)#Pour visualiser les couleurs
#On calcule la chi valeur pour d�duire une d�pendance entre les variables
chisq.test(Tab_contingence_Nbcredits)
#Analyse variable Occupation
table(data_set$Occupation)#summary(data_set$Occupation)
freq(data_set$Occupation,valid=FALSE, total=TRUE)
barplot(sort(table(data_set$Occupation)), main=" R�partition de la variable Occupation")
# Tableau de contingence Cote_credit/Garant
Tab_contingence_Occupation<-table(data_set$Cote_credit,data_set$Occupation)
#On visualise le tableau de contingence
Tab_contingence_Occupation
#On visualise les fr�quence dans le tableau de contingence
frequence<-prop.table(Tab_contingence_Occupation)*100
frequence
lprop(Tab_contingence_Occupation)#Pourcentages ligne
cprop(Tab_contingence_Occupation)#Pourcentages colonne
#Visualisation du tableau de contingence
mosaicplot(Tab_contingence_Occupation, col=c("antiquewhite3","antiquewhite1","antiquewhite4","antiquewhite2"),main="Croisement des variables Occupation et Co�t du  cr�dit")
#help(palette)#Pour visualiser les couleurs
#On calcule la chi valeur pour d�duire une d�pendance entre les variables
chisq.test(Tab_contingence_Occupation)
#Analyse variable Personnes � charge
table(data_set$Personnes_charge)#summary(data_set$Personnes_charge)
freq(data_set$Personnes_charge,valid=FALSE, total=TRUE)
barplot(sort(table(data_set$Personnes_charge)), main=" R�partition de la variable Personnes � charge" )
# Tableau de contingence Cote_credit/Garant
Tab_contingence_Personnes_charge<-table(data_set$Cote_credit,data_set$Personnes_charge)
#On visualise le tableau de contingence
Tab_contingence_Personnes_charge
#On visualise les fr�quence dans le tableau de contingence
frequence<-prop.table(Tab_contingence_Personnes_charge)*100
frequence
lprop(Tab_contingence_Personnes_charge)#Pourcentages ligne
cprop(Tab_contingence_Personnes_charge)#Pourcentages colonne
#Visualisation du tableau de contingence
mosaicplot(Tab_contingence_Personnes_charge, col=c("antiquewhite3","antiquewhite1"),main="Croisement des variables Personnes � charge et Co�t du  cr�dit")
#help(palette)#Pour visualiser les couleurs
#On calcule la chi valeur pour d�duire une d�pendance entre les variables
chisq.test(Tab_contingence_Personnes_charge)
#Analyse variable Etranger
table(data_set$Etranger)#summary(data_set$Etranger)
freq(data_set$Etranger,valid=FALSE, total=TRUE)
barplot(sort(table(data_set$Etranger)), main=" R�partition de la variable Etranger/Citoyen" )
# Tableau de contingence Cote_credit/Etranger
Tab_contingence_Etranger<-table(data_set$Cote_credit,data_set$Etranger)
#On visualise le tableau de contingence
Tab_contingence_Etranger
#On visualise les fr�quence dans le tableau de contingence
frequence<-prop.table(Tab_contingence_Etranger)*100
frequence
lprop(Tab_contingence_Etranger)#Pourcentages ligne
cprop(Tab_contingence_Etranger)#Pourcentages colonne
#Visualisation du tableau de contingence
mosaicplot(Tab_contingence_Etranger, col=c("antiquewhite3","antiquewhite1"),main="Croisement des variables Etranger/Citoyen et Co�t du  cr�dit")
#help(palette)#Pour visualiser les couleurs
#On calcule la chi valeur pour d�duire une d�pendance entre les variables
chisq.test(Tab_contingence_Etranger)
