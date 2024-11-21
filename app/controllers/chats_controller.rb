class ChatsController < ApplicationController
  def index
    @messages = []
    @awaiting_pain_level = false
  end

  def process_input
    @messages = JSON.parse(params[:messages])
    @awaiting_pain_level = params[:awaiting_pain_level] == 'true'
    user_input = params[:user_input]

    if @awaiting_pain_level
      begin
        pain_level = Integer(user_input)
        if pain_level > 5
          bot_response = "Dor de cabeça hum entendido. Recomenda-se que você consulte \n um médico. \n Horário disponível: Amanhã às 14:00.\n Horário do atendimento: 10:00"
        else
          bot_response = "Dor de cabeça leve, deve ser atendida pelo Medico ('jOÃO'\n Horário disponível: 14:30\n Horario de atendimento: 14:00"
        end
        @awaiting_pain_level = false
      rescue ArgumentError
        bot_response = "Por favor, insira um nível de dor válido entre 1 e 10."
      end
    else
      if user_input.downcase.include?("dor no peito")
        bot_response = "Sintoma grave : Dor no peito. Por favor, procure um medico:\n Medico disponivel:('Pedro').\n Horario do atendimento: 17:46"
      elsif user_input.downcase.include?("febre") && user_input.downcase.include?("tosse")
        bot_response = "Possível caso de infecção respiratória. Recomenda-se um(a) médico."
      elsif user_input.downcase.include?("dor de cabeça")
        bot_response = "Você mencionou dor de cabeça. Qual é o nível da dor em uma escala de 1 a 10?"
        @awaiting_pain_level = true
      else
        bot_response = "Sintoma não identificado. Por favor, forneça mais detalhes ou consulte um médico."
      end
    end

    @messages << { sender: "Você", text: user_input }
    @messages << { sender: "HealSync", text: bot_response }

    respond_to do |format|
      format.js
    end
  end
end