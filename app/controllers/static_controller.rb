# encoding: utf-8
#
# Controle responsável por gerenciar todas as páginas
# estáticas do site e algumas ações básicas como controle
# da API.
#
class StaticController < ApplicationController

  # Gem para fazer requisições à API's
  require 'httparty'
  respond_to :json

  def home
  end

  def sobre
  end

  # def cotacao

  #   # Pegando o número de bitcoins desejados.
  #   requestedBtcAmount = params[:amount] || 1.0
  #   requestedBtcAmount = requestedBtcAmount.to_f

  #   # Acessando API da Foxbit para pegar orderbook.
  #   response = HTTParty.get "https://api.blinktrade.com/api/v1/BRL/orderbook?crypto_currency=BTC"

  #   # Interpretando o JSON
  #   orderbook = JSON.parse(response.body)
  #   asks = orderbook["asks"]

  #   # Debug
  #   # logger.debug(asks)

  #   # Algoritmo que faz a média de valor do número de Bitcoins a serem comprados.
  #   generalBtcAmount = 0.0
  #   finalPrice = 0.0

  #   asks.each do |ask|

  #     # Calcula quantos bitcoins faltam para serem adicionados ao cálculo e caso ainda existam, utiliza o próximo Ask.
  #     remainingBtcAmount = truncate(requestedBtcAmount - generalBtcAmount)

  #     if remainingBtcAmount > 0

  #       # Calcula quantos BTC's da ask atual precisam ser adicionados à quantidade geral de Bitcoins (se todos os btc da ask atual ou se apenas uma parte dos btc's dessa ask).
  #       if truncate(generalBtcAmount + ask[1]) >= requestedBtcAmount
  #         tempAmount = remainingBtcAmount
  #       else
  #         tempAmount = ask[1]
  #       end

  #       # Soma a quantidade de bitcoins desse ask à quantidade geral de bitcoins (somente a quantidade necessária de BTC).
  #       generalBtcAmount = truncate(generalBtcAmount + tempAmount)

  #       # Soma ao preço final do Bitcoin o valor da ask atual * quantidade de bitcoins oferecidos pela ask atual.
  #       finalPrice += ask[0] * tempAmount

  #       # Debug
  #       # logger.debug("Quantidade[i]: #{tempAmount}\t\tPreço[i]: #{ask[0]}\t\tRestante[i]: #{remainingBtcAmount}\t\tGeneralBtcAmount[i]: #{generalBtcAmount}")

  #     else

  #       # Debug
  #       # logger.debug("==========ELSE===========")
  #       # logger.debug("Quantidade requerida: #{requestedBtcAmount}")
  #       # logger.debug("Quantidade final: #{generalBtcAmount}")
  #       # logger.debug("Quantidade restante: #{remainingBtcAmount}")
  #       break
  #     end
  #   end

  #   # Trunca o valor final dos bitcoins para 2 casas decimais (mais legível)
  #   finalPrice = truncate(finalPrice,2)

  #   # Montando o JSON para renderizar na página
  #   finalJson = {
  #     :requestedAmount => requestedBtcAmount,
  #     :amount => generalBtcAmount,
  #     :price => finalPrice
  #   }.to_json

  #   # Debugs
  #   # logger.debug("=========FINAL=========")
  #   # logger.debug("Preço final: R$#{finalPrice}")
  #   # logger.debug("Quantidade requerida: #{requestedBtcAmount}")
  #   # logger.debug("Quantidade final: #{generalBtcAmount}")
  #   # logger.debug(finalJson)

  #   # Renderizando o valor final na página em formato de JSON
  #   render json: finalJson

  # end

end
