class StaticPagesController < ApplicationController

  def home
    layout "wide"
    redirect_to my_profile_path if user_signed_in?
  end

  def in_develop
  end

  def terms_of_use
  end

  def privacy_policy
  end
end
