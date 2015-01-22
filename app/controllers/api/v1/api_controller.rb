# #encoding: utf-8
# class Api::v1::ApiController < ActionController::Metal
#     include ActionController::Rendering
#     include ActionController::MimeResponds
#     include AbstractController::Callbacks
#     include AbstractController::Rendering
#     include ActionView::Layouts
#     include ActionController::Renderers::All
#     append_view_path "#{Rails.root}/app/views"

#     # Gem para fazer requisições à API's
#     require 'httparty'
#     respond_to :json

#     # POST /api/cotacao (params: { amount: x.xx })
#     # Recebe como parâmetro uma quantidade de bitcoins e calcula, de acordo com a orderbook da Foxbit, quanto custa essa quantidade de Bitcoin levando em consideração as ordens de venda de Bitcoin existentes.
#     def cotacao

#         # Pegando o número de bitcoins desejados.
#         requestedBtcAmount = params[:amount] || 1.0
#         requestedBtcAmount = requestedBtcAmount.to_f

#         # Acessando API da Foxbit para pegar orderbook.
#         response = HTTParty.get "https://api.blinktrade.com/api/v1/BRL/orderbook?crypto_currency=BTC"

#         # Interpretando o JSON
#         orderbook = JSON.parse(response.body)
#         asks = orderbook["asks"]

#         # Debug
#         # logger.debug(asks)

#         # Algoritmo que faz a média de valor do número de Bitcoins a serem comprados.
#         generalBtcAmount = 0.0
#         finalPrice = 0.0

#         asks.each do |ask|

#           # Calcula quantos bitcoins faltam para serem adicionados ao cálculo e caso ainda existam, utiliza o próximo Ask.
#           remainingBtcAmount = truncate(requestedBtcAmount - generalBtcAmount)

#           if remainingBtcAmount > 0

#             # Calcula quantos BTC's da ask atual precisam ser adicionados à quantidade geral de Bitcoins (se todos os btc da ask atual ou se apenas uma parte dos btc's dessa ask).
#             if truncate(generalBtcAmount + ask[1]) >= requestedBtcAmount
#               tempAmount = remainingBtcAmount
#             else
#               tempAmount = ask[1]
#             end

#             # Soma a quantidade de bitcoins desse ask à quantidade geral de bitcoins (somente a quantidade necessária de BTC).
#             generalBtcAmount = truncate(generalBtcAmount + tempAmount)

#             # Soma ao preço final do Bitcoin o valor da ask atual * quantidade de bitcoins oferecidos pela ask atual.
#             finalPrice += ask[0] * tempAmount

#             # Debug
#             # logger.debug("Quantidade[i]: #{tempAmount}\t\tPreço[i]: #{ask[0]}\t\tRestante[i]: #{remainingBtcAmount}\t\tGeneralBtcAmount[i]: #{generalBtcAmount}")

#           else

#             # Debug
#             # logger.debug("==========ELSE===========")
#             # logger.debug("Quantidade requerida: #{requestedBtcAmount}")
#             # logger.debug("Quantidade final: #{generalBtcAmount}")
#             # logger.debug("Quantidade restante: #{remainingBtcAmount}")
#             break
#           end
#         end

#         # Trunca o valor final dos bitcoins para 2 casas decimais (mais legível)
#         finalPrice = truncate(finalPrice,2)

#         # Montando o JSON para renderizar na página
#         finalJson = {
#           :requestedAmount => requestedBtcAmount,
#           :amount => generalBtcAmount,
#           :price => finalPrice
#         }.to_json

#         # Debugs
#         # logger.debug("=========FINAL=========")
#         # logger.debug("Preço final: R$#{finalPrice}")
#         # logger.debug("Quantidade requerida: #{requestedBtcAmount}")
#         # logger.debug("Quantidade final: #{generalBtcAmount}")
#         # logger.debug(finalJson)

#         # Renderizando o valor final na página em formato de JSON
#         render json: finalJson

#     end

#     private
#         # Método responsável por truncar números de ponto flutuante.
#         # O truncamento padrão é quebrar o número na 8ª casa decimal: 1.1234567891011 para 1.12345678, mas um argumento pode ser passado informando um número de casas decimais diferente.
#         def truncate(number, decimalCases = 8)
#             temp = 1.0
#             while decimalCases > 0 do
#               temp = temp * 10.0
#               decimalCases -= 1
#             end
#             return (number * temp.to_i).floor / temp
#         end

# end
