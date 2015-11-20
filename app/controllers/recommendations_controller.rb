class RecommendationsController < ApplicationController
  def index
    @recommendations = Recommendation.all.page(params[:page]).per(15)
  end

  def new
    @recommendation = Recommendation.new
  end

  def create
    @recommendation = Recommendation.new(recommendation_params)
    @recommendation.user = current_user;
    
    if @recommendation.save
      flash[:notice]= t('recommendation_saved')
      redirect_to recommendations_path
    else
      flash[:alert]= t('check_required_field')
      redirect_to new_recommendation_path
    end
  end

  def recommendation_params
    params.require(:recommendation).permit(:book_isbn,:book_title)
  end
end
