class HomeController < ApplicationController
    skip_before_action :authenticate_user!

  def home
    @nav_class = "navbar-fixed-top"
    if current_user
      @user = current_user
      @organization = current_user.organization
    end
  end
end