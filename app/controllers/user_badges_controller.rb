class UserBadgesController < ApplicationController

  def new
    @user_badge = UserBadge.new
  end

  def create
    @user_badge = UserBadge.new(user_badge_params)

    respond_to do |format|
      if @user_badge.save
        format.html { redirect_to root_path, notice: "Badge '#{@user_badge.badge.name}' was successfully granted to #{@user_badge.user.try(:name)}." }
        format.json { render :show, status: :created, location: @user_badge }
      else
        format.html { render :new }
        format.json { render json: @user_badge.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  
  def user_badge_params
    params.require(:user_badge).permit(:level, :user_id, :badge_id)
  end

end
