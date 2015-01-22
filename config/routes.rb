Rails.application.routes.draw do

  root 'static#home'

  # POST /api/v1/cotacao
  # API da cotação do Bitcoin na Foxbit, que será acessada pelo robô e pelo próprio site para fornecer a cotação ao usuário.
  namespace :api, defaults: {format: :json} do #, path: '/api/v1' do
    scope :v1 do
      post 'cotacao' => 'api#cotacao'
    end
  end

end
