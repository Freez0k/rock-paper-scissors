class Bot
  BOT_URL = "https://5eddt4q9dk.execute-api.us-east-1.amazonaws.com/rps-stage"

  def turn
    response = conn.get("/throw").body
    bot_turn = response[:body]

    if Game::WINS.keys.include?(bot_turn)
      bot_turn
    else
      bot_fallback
    end

  rescue Faraday::Error
    bot_fallback
  end

  private

  def conn
    Faraday.new(url: BOT_URL) do |f|
      f.options.timeout = 4
      f.options.open_timeout = 2
      f.adapter Faraday.default_adapter
      f.request :json
      f.response :json
    end
  end

  def bot_fallback
    turn = Game::WINS.keys.sample
    turn
  end
end
