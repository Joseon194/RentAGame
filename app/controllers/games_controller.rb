require 'pry'

class GamesController < ApplicationController
    before_action :to_user_not_authenticated?, except: [:index, :show, :new]

    def new
        @game = Game.new
    end

    def create
        @game = current_user.games.build(game_params)
        if @game.valid? && @game.save
            redirect_to game_path(@game)
        else
            render :new
        end
    end

    def index
        @games = Game.all
    end

    def show
        @game = Game.find(params[:id])
        @review_user = {}
        @game.reviews.each do |review|
            if @review_user[review.user_id] == nil
               user = User.find_by_id(review.user_id)
               @review_user[user.id] = user.name
            end
        end
    end

    def collection
        @Game = current_user.games.all
    end

    def edit
        @game = Game.find(params[:id])
        if @game.user != current_user
            redirect_to root_path
        end
    end

    def update
        @game = Game.find(params[:id])
        if @game.user == current_user && @game.valid? && @game.update(game_params)
            redirect_to game_path(@game)
        else
            render :edit
        end
    end

    def destroy
        @game = Game.find_by(id: params[:id])
        if @game.user == current_user
            @game.delete # SQLite3::ConstraintException: FOREIGN KEY constraint failed 
            redirect_to collection_path(@game.user)
            binding.pry
        end
    end

    private
    def game_params
        params.require(:game).permit(:name, :genre, :company, :platform, :user_id)
    end
end
