module GamesHelper

  def recent_games
    recent_games = Game.most_recent(3)
    game_user = {}
    recent_games.each do |game|
      if game_user[game.user_id] == nil
        game_user[user.id] = user.name
      end
    end

    game_list = []
    recent_games.each do |game|
      if game.id != nil
        game_list << "#{game.name}, rented by #{game_user[game_user.id]}"
      end
    end
    return game_list
end
