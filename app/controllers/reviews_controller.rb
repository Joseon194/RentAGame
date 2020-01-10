class ReviewsController < ApplicationController
    def new
        @game = Game.find_by_id(params[:game_id])
    end

  def create
       # review = Review.create(review_params)
       @game = Game.find_by_id(params[:game_id])
        @review = @game.reviews.create(review_params)
       redirect_to game_path(@game) #need to redirect to show
   end

  def edit
    @review = Review.find_by_id(params[:id])
    if 
    @review.user != current_user
    redirect_to review.game(user.id)
  end
end

  def index
    @game = Game.find_by_id(params[:game_id])
  end

   private
   def review_params
       params.require(:review).permit(:content, :user_id, :game_id, user_attributes:[:name, :password, :password_confirmation])
   end
end
