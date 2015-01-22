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

  def cotacao

    # Pegando o número de bitcoins desejados.
    requestedBtcAmount = params[:amount].to_f || 1.0

    # Acessando API da Foxbit para pegar orderbook.
    response = HTTParty.get "https://api.blinktrade.com/api/v1/BRL/orderbook?crypto_currency=BTC"

    # Interpretando o JSON
    orderbook = JSON.parse(response.body)
    asks = orderbook["asks"]

    # Algoritmo que faz a média de valor do número de Bitcoins a serem comprados.
    generalBtcAmount = 0
    finalPrice = 0
    asks.each do |ask|

      # Calcula quantos bitcoins faltam para serem adicionados ao cálculo e caso ainda existam, utiliza o próximo Ask.
      remainingBtcAmount = truncate(requestedBtcAmount - generalBtcAmount)

      if remainingBtcAmount > 0

        # Calcula quantos BTC's da ask atual precisam ser adicionados à quantidade geral de Bitcoins (se todos os btc da ask atual ou se apenas uma parte dos btc's dessa ask).
        if truncate(generalBtcAmount + ask[1]) > remainingBtcAmount
          tempAmount = remainingBtcAmount
        else
          tempAmount = truncate(generalBtcAmount + ask[1])
        end

        # Soma a quantidade de bitcoins desse ask à quantidade geral de bitcoins (somente a quantidade necessária de BTC).
        generalBtcAmount = truncate(generalBtcAmount + tempAmount)

        # Soma ao preço final do Bitcoin o valor da ask atual * quantidade de bitcoins oferecidos pela ask atual.
        finalPrice += ask[0] * tempAmount

      else
        break
      end
    end

    # Trunca o valor final dos bitcoins para 2 casas decimais (mais legível)
    finalPrice = truncate(finalPrice,2)

    # logger.debug()

    # Renderizando o valor final na página em formato de JSON
    render json: finalPrice

  end

end
