class GameController < ApplicationController
  def play
  end

  def start
    outcome = Game.new.start(turn_params)
    @message = outcome[:result]
    @bot_turn = outcome[:bot_turn]
    @player_turn = turn_params
    @result_title = case @message
                    when :win then "YOU WON!"
                    when :lose then "YOU LOST!"
                    else "IT'S A DRAW!"
                    end
    @result_subtitle = case @message
                       when :win
                         "You with #{@player_turn} win"
                       when :lose
                         "Curb with #{@bot_turn} wins"
                       else
                         "You both chose #{@player_turn}"
                       end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  private

  def turn_params
    params.expect(:player_turn)
  end
end
