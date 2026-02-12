class GameController < ApplicationController
  def play
  end

  def start
    result = Game.new.start(turn_params).to_s
    @message = result

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
