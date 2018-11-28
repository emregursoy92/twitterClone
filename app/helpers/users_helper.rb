module UsersHelper
  def current_user?(user)
    user == current_user
  end



  def following?(user)
    !current_user.follower_relationships.find_by_id(user).nil?
  end

  def follows_you?(user)
    !user.followed_relationships.find_by_id(current_user).nil?
  end

  def relative_time(created_at)
    time_ago_in_words(created_at)
  end

  def formatted_time(created_at)
    created_at.strftime("%b %d, %Y")
  end


end