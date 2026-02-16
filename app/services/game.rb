class Game 
  WINS = {
    "rock" => "scissors",
    "paper" => "rock",
    "scissors" => "paper"
  }

  def start(player_turn)
    current_bot_turn = bot_turn
    {
      result: result(player_turn, current_bot_turn),
      bot_turn: current_bot_turn
    }
  end

  private

  def bot_turn
    Bot.new.turn
  end

  def result(player_turn, bot_turn)
    return :draw if player_turn == bot_turn
    WINS[player_turn] == bot_turn ? :win : :lose
  end
end
