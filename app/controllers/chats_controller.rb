# app/controllers/chats_controller.rb
class ChatsController < ApplicationController
  before_action :set_awaiting_pain_level, only: [:process_input]

  def index
    @messages = []
    @awaiting_pain_level = false
  end

  def process_input
    @user_input = params[:user_input]
    @messages = JSON.parse(params[:messages] || '[]')
    @awaiting_pain_level = params[:awaiting_pain_level] == 'true'

    if @user_input.blank?
      render json: { messages: @messages, awaiting_pain_level: @awaiting_pain_level } and return
    end

    @messages << { sender: "Você", text: @user_input }

    if @awaiting_pain_level
      begin
        pain_level = Integer(@user_input)
        if pain_level > 5
          bot_response = "Dor de cabeça grave identificada. Recomenda-se consultar um médico. Horário disponível: Amanhã às 14:00."
        else
          bot_response = "Dor de cabeça leve, deve ser atendida pelo Médico João. Horário disponível: 14:30."
        end
        @awaiting_pain_level = false
      rescue ArgumentError
        bot_response = "Por favor, insira um nível de dor válido entre 1 e 10."
      end
    else
      bot_response = analyze_symptoms(@user_input)
    end

    @messages << { sender: "HealSync", text: bot_response }

    render json: { messages: @messages, awaiting_pain_level: @awaiting_pain_level }
  end

  private

  def analyze_symptoms(input)
    case input.downcase
    when /dor no peito/
      "Sintoma grave: Dor no peito. Por favor, procure um médico: Médico Pedro disponível às 17:46."
    when /febre/, /tosse/
      "Possível caso de infecção respiratória. Recomenda-se procurar um médico."
    when /dor de cabeça/
      @awaiting_pain_level = true
      "Você mencionou dor de cabeça. Qual é o nível da dor em uma escala de 1 a 10?"
    else
      "Sintoma não identificado. Por favor, forneça mais detalhes ou consulte um médico."
    end
  end

  def set_awaiting_pain_level
    @awaiting_pain_level ||= false
  end
end
