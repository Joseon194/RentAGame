class ReviewsController < ApplicationController
  def create
       review = Review.create(review_params)
       redirect_to review.game #need to redirect to show
   end

   private
   def review_params
       params.require(:review).permit(:content, :user_id, :game_id, user_attributes:[:name, :password, :password_confirmation])
   end
end
