Rails.application.routes.draw do
  root "game#play"
  post "/start", to: "game#start", as: :game_start
end
