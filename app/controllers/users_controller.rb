class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :holders]

  def index
    @users = User.order('short')
    @badges = Badge.accepted.order('name')
  end

  def holders
    @users = User.active.order('short')
    @badges = Badge.accepted.order('name')
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :badge_set_id, :glassfrog_id, :legacy_p_unit_grant,
        :librarian, :comp_admin, :bootstrapper, :focus_time, :active)
    end
end
