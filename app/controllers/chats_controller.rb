class ChatsController < ApplicationController
  before_action :set_chat_state

  def index

  end

  def respond
    user_input = params[:user_input]
    return render json: { response: "Por favor, insira uma mensagem válida." }, status: :bad_request if user_input.blank?


    session[:chat_history] ||= []
    session[:chat_history] << { user: true, content: user_input }

    if session[:awaiting_pain_level]
      bot_response = process_pain_level(user_input)
    else
      bot_response = process_symptoms(user_input)
    end


    render json: { response: bot_response }
  end

  def clear_chats
    session[:chat_history] = []
    session[:awaiting_pain_level] = false
    render json: { success: true, message: "Histórico do chat limpo." }
  end

  private

  def set_chat_state
    session[:chat_history] ||= []
    session[:awaiting_pain_level] ||= false
  end

  def process_pain_level(user_input)
    begin
      pain_level = Integer(user_input)
      if pain_level > 5
        bot_response = "Dor de cabeça grave detectada. Recomenda-se que você consulte um médico. Horário disponível: Hoje às 14:00. Horário do atendimento: 14:00."
      else
        bot_response = "Dor de cabeça leve. Medico João receita que você tome um paracetamol."
      end
      session[:awaiting_pain_level] = false
    rescue ArgumentError
      bot_response = "Por favor, insira um nível de dor válido entre 1 e 10."
    end
    update_bot_response(bot_response)
    bot_response
  end

  def process_symptoms(user_input)
    case user_input.downcase
    when /dor no peito/
      bot_response = "Sintoma grave: Dor no peito. Por favor, procure um médico. Médico disponível: Pedro. Horário do atendimento: 17:46."
    when /febre/, /tosse/
      bot_response = "Possível caso de infecção respiratória. Recomenda-se um médico."
    when /dor de cabeça/
      bot_response = "Você mencionou dor de cabeça. Qual é o nível da dor em uma escala de 1 a 10?"
      session[:awaiting_pain_level] = true
    else
      bot_response = "Sintoma não identificado. Por favor, forneça mais detalhes ou consulte um médico."
    end
    update_bot_response(bot_response)
    bot_response
  end

  def update_bot_response(bot_response)
    session[:chat_history] << { user: false, content: bot_response }
  end
end
