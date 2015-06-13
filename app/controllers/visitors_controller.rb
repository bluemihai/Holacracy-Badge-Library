class VisitorsController < ApplicationController
  def index
    @badges = Badge.all
    @users = User.all
  end

  def about
  end
end
