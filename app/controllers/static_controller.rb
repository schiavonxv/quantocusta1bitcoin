# encoding: utf-8
#
###
### Controle que gerencia as páginas estáticas do site.
###
#
# Controle responsável por gerenciar todas as páginas
# estáticas do site e algumas ações básicas como controle
# da API.
#
##
class StaticController < ApplicationController

  # Gem para fazer requisições à API's
  require 'httparty'
  respond_to :json

  # Action do controlador que renderiza a página inicial do site.
  # Basicamente seta meta tags na página inicial para melhorar o SEO.
  def home
    descript = "Saiba quanto custa 1 Bitcoin no Brasil e aprenda a comprar com facilidade. Quanto custa um bitcoin? Descubra!"
    set_meta_tags :description => descript,
		  :author => "FoxBit",
   		  :robots => "index, follow",
		  :Copyright => "Copyright FoxBit Serviços Digitais SA 2014. All Rights Reserved.",
                  :keywords => "bitcoin, btc, foxbit, comprar bitcoin, calculadora bitcoin, quanto custa bitcoin, quanto vale bitcoin, preço bitcoin, vender bitcoin",
                  :og => {
                    :title => :title,
                    :type => "website",
                    :description => descript,
                    :url => "http://www.quantocusta1bitcoin.com.br",
                    :locale => "pt_BR",
                    :image => "http://imgh.us/logo_46.svg"
                  },
                  :twitter => {
                    :card => "summary",
                    :site => "@foxbit",
                    :title => "Quanto custa 1 bitcoin? Descubra!",
                    :description => descript,
                    :url => "http://www.quantocusta1bitcoin.com.br",
                    :image => "http://imgh.us/logo_46.svg"
                  },
                  :"DC.Title" => :title,
                  :"DC.Subject" => ["bitcoin", "btc", "foxbit", "comprar bitcoin", "calculadora bitcoin", "quanto custa bitcoin", "quanto vale bitcoin", "preço bitcoin", "vender bitcoin"],
                  :"DC.Description" => descript,
                  :"DC.Publisher" => "Foxbit",
                  :"DC.Contributor" => "Foxbit",
                  :"DC.Date" => "2015-01",
                  :"DC.Language" => "pt_BR"

  end

end
