class BadgeNominationsController < ApplicationController

  before_action :set_badge_nomination, only: [:show, :edit, :update, :destroy]
  before_action :check_auth, only: [:edit]

  def index
    status = params[:status]
    @badge_nominations = status ? BadgeNomination.where(status: status).order(:name) : BadgeNomination.order(:created_at)
  end

  def show
  end

  def new
    @badge_nomination = BadgeNomination.new
    @badge_nomination.status = 'pending'
  end

  def edit
  end

  def create
    @badge_nomination = BadgeNomination.new(badge_nomination_params)

    respond_to do |format|
      if @badge_nomination.save
        format.html { redirect_to @badge_nomination, notice: 'BadgeNomination was successfully created.' }
        format.json { render :show, status: :created, location: @badge_nomination }
      else
        format.html { render :new }
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
      params.require(:badge_nomination).permit(:name, :level, :status, :user_id, :nominator_id, :badge_id)
    end

    def check_auth
      return if current_user.try(:is_admin?)
      return if current_user.try(:is_librarian?)
      redirect_to @badge_nomination, warning: 'Only librarians, admins or the badge_nomination proposer can edit a badge_nomination.'
    end

end
