module GamesHelper

  def recent_games
    recent_games = Game.most_recent(3)
    game_user = {}
    recent_games.each do |game|
      if game_user[game.user_id] == nil
        user = User.find_by_id(game.user_id)
        game_user[user.id] = user.name
      end
    end

    game_list = []
    recent_games.each do |game|
      if game.id != nil
        game_list << "#{game.name}, owned by #{game_user[game.user_id]}"
      end
    end
    return game_list
end
end