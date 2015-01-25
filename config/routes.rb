#encoding: utf-8
#
###
### Arquivo de rotas do projeto.
###
#
# Este arquivo é o responsável por gerenciar as rotas do projeto. Existe
# também uma API que foi criada para ser utilizada tanto por esse site como
# pelo robô do Twitter.
#
# ===== API =====
#
#   [POST] /api/v1/cotacao
#      Essa rota recebe um parâmetro chamado "amount" via POST, que é a
#      quantidade de bitcoins para qual se deseja saber a cotação / valor.
#      Essa API retornará um objeto JSON com os seguintes atributos:
#
#         @requestedAmount: a quantidade de bitcoins enviada por quem
#         fez a requisição à API. Ou seja, requestedAmount == amount (o que
#         foi enviado como parâmetro via POST). Valor padrão é 1.0 BTC.
#
#         @amount: a quantidade de bitcoins para o preço (@price) retornado
#         pela API. Normalmente esse atributo tem o mesmo valor que o atributo
#         @requestedAmount, exceto quando o quantidade de bitcoins solicitada
#         por quem chamou a API é maior do que a quantidade de bitcoins
#         disponível para venda na exchange. Um cenário para esse caso seria:
#
#             Requisição: amount=51
#             Resposta: {@requestedAmount: 51, @amount: 40, @price: 10500.00}
#
#             Nesse caso, a quantidade de bitcoins pedida por quem chamou a
#             API foi de 51 BTC. A exchange só tinha 40 BTC, por isso
#             amount=40 e é diferente de @requestedAmount=51.
#             O preço de R$10.500,00 retornado diz respeito aos 40 bitcoins
#             disponíveis na exchange, ou seja, diz respeito ao atributo
#             @amount.
#
#         Seu valor padrão é 1.0 BTC.
#
#
#         @price: o preço da quantidade de bitcoins retornada (@amount).
#         Esse preço é obtido SOMENTE através das ordens existentes
#         no orderbook da Foxbit. Leva em conta o preço de cada ordem e
#         a quantidade de bitcoins disponível para essa ordem; caso não tenha
#         totalizado a quantidade de bitcoins solicitada, pega a próxima ordem
#         do orderbook da Foxbit - e assim por diante.
#
#
##
Rails.application.routes.draw do

  # Rota padrão para a página inicial do site.
  root 'static#home'

  # POST /api/v1/cotacao
  # API da cotação do Bitcoin na Foxbit, que será acessada pelo robô e pelo próprio site para fornecer a cotação ao usuário.
  namespace :api, defaults: {format: :json} do
    scope :v1 do
      post 'cotacao' => 'api#cotacao'
    end
  end

end
