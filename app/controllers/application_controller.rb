class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Método responsável por truncar números de ponto flutuante.
  # O truncamento padrão é quebrar o número na 8ª casa decimal: 1.1234567891011 para 1.12345678, mas um argumento pode ser passado informando um número de casas decimais diferente.
  def truncate(number, decimalCases = 8)
    temp = 1.0
    while decimalCases > 0 do
      temp = temp * 10.0
      decimalCases -= 1
    end
    return (number * temp.to_i).floor / temp
  end

end
