#Implementa��o de regress�o multilinear
#utilizando estima��o por envelopes
#Autor: Felipe Pinto Marinho
#Data:11/03/2022

#Carregando algumas bibliotecas importantes
library(Renvlp)

#Utiliza��o no dataset do mestrado
#Sele��o da dimens�o do envelope
selec_dim = u.xenv(Dados_1_treino[, -6], Rad_treino)
plot(1:length(selec_dim$aic.seq), selec_dim$aic.seq, type = "b", col = "blue")
u_otimo = selec_dim$u.bic

#Ajuste do modelo de envelope para os preditores
EP = xenv(Dados_1_treino[, -6], Rad_treino, u_otimo)
names(EP)
dim(EP$eta)
dim(EP$Gamma)
dim(EP$Omega)
dim(EP$mu)

#Previs�o no teste
Y_hat_envelope = rep(0, nrow(Dados_1_teste))
for (k in 1:nrow(Dados_1_teste)) {
  Y_hat_envelope[k] = pred.xenv(EP, Dados_1_teste[k, -6])$value
}

metricas(Y_hat_envelope, Rad_teste)
