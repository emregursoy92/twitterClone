class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @tweet = current_user.tweets.build
    @feed_items = current_user.feed.paginate(page: params[:page], per_page: 10)
    @users = User.paginate(page: params[:page])

  end

  def user_page

  end
end
