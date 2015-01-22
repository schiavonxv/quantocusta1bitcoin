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

  # Action do controlador que renderiza a página inicial do site.
  def home
    descript = "Saiba a cotação do Bitcoin no Brasil e compre bitcoins com facilidade. Quanto custa um bitcoin? Descubra!"
    set_meta_tags :description => descript,
                  :keywords => "bitcoin, btc, brasil, preço, comprar",
                  :og => {
                    :title => :title,
                    :type => "website",
                    :description => descript,
                    :url => "http://quantocusta1bitcoin.com.br/",
                    :locale => "pt_BR",
                    :image => "http://imgh.us/logo_46.svg"
                  },
                  :twitter => {
                    :card => "summary",
                    :site => "@foxbitcoin",
                    :title => :title,
                    :description => descript,
                    :url => "http://quantocusta1bitcoin.com.br/",
                    :image => "http://imgh.us/logo_46.svg"
                  }
  end

end
