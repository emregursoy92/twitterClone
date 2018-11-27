class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: :destroy

  def create
    @tweets = current_user.tweets.build(tweets_params)
    if @tweets.save
      flash[:success] = "New post created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'home/index'
    end
  end

  def destroy
    @tweets.destroy
    flash[:success] = "Post deleted"
    redirect_to request.referrer || root_url
  end

  private
  def tweets_params
    params.require(:tweet).permit(:content)
  end

  def correct_user
    @tweets = current_user.tweets.find_by(id: params[:id])
    redirect_to root_url if @tweets.nil?
  end

end
