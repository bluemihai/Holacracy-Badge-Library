class BadgeNominationsController < ApplicationController
  before_action :set_badge_nomination, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  # before_action :check_auth, only: [:edit, :destroy]
  before_action :ensure_badge_id_param, only: [:new]

  def index
    status = params[:status]
    @badge_nominations = status ? BadgeNomination.where(status: status).order(:name) : BadgeNomination.order(:created_at)
  end

  def show
    @validations = @badge_nomination.validations.order('level DESC')
  end

  def new
    @nominator = current_user
    @badge_nomination = BadgeNomination.new
    @badge_nomination.status = 'pending'
    @badge_nomination.badge_id = params[:badge_id] if params[:badge_id]
    @badge = Badge.find_by_id(@badge_nomination.badge_id)
    @badge_nomination.user_id = params[:user_id] if params[:user_id]
    session[:badge_id] = @badge.id
  end

  def edit
    @nominator = current_user
    @badge = Badge.find_by_id(@badge_nomination.badge_id)
  end

  def create
    @badge_nomination = BadgeNomination.new(badge_nomination_params)
    if params[:badge_id]
      @badge_nomination.badge_id = params[:badge_id] 
      @badge = Badge.find_by_id(params[:badge_id])
    end

    respond_to do |format|
      if @badge_nomination.save
        format.html { redirect_to badge_nominations_path, notice: 'BadgeNomination was successfully created.' }
        format.json { render :show, status: :created, location: @badge_nomination }
      else
        format.html do
          @nominator = current_user
          @badge = Badge.find(session[:badge_id])
          @badge_nomination.badge_id = @badge.id
          render :new
        end
        format.json { render json: @badge_nomination.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @badge_nomination.update(badge_nomination_params)
        format.html { redirect_to users_path, notice: 'BadgeNomination was successfully updated.' }
        format.json { render :show, status: :ok, location: @badge_nomination }
      else
        format.html { render :edit }
        format.json { render json: @badge_nomination.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @badge_nomination.destroy
    respond_to do |format|
      format.html { redirect_to badge_nominations_url, notice: 'BadgeNomination was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_badge_nomination
      @badge_nomination = BadgeNomination.find(params[:id])
    end

    def badge_nomination_params
      params.require(:badge_nomination).permit(:name, :level_nominated, :level_granted, :status, :user_id, :nominator_id, :badge_id, :evidence)
    end

    def ensure_badge_id_param
      return if params[:badge_id]
      redirect_to root_path, alert: 'Please select "Nominate For..." in the navigation bar and select a specific Badge.'
    end
end
