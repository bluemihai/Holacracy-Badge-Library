class BadgesController < ApplicationController
  before_action :set_badge, only: [:show, :edit, :update, :destroy]
  before_action :check_auth, only: [:edit]

  def index
    status = params[:status]
    @badges = status ? Badge.where(status: status).order(:name) : Badge.order(:name)
  end

  def show
  end

  def new
    @badge = Badge.new
    @badge.status = 'draft'
    @badge.proposer = current_user
  end

  def edit
  end

  def create
    @badge = Badge.new(badge_params)

    respond_to do |format|
      if @badge.save
        format.html { redirect_to @badge, notice: 'Badge was successfully created.' }
        format.json { render :show, status: :created, location: @badge }
      else
        format.html { render :new }
        format.json { render json: @badge.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @badge.update(badge_params)
        format.html { redirect_to badges_path, notice: 'Badge was successfully updated.' }
        format.json { render :show, status: :ok, location: @badge }
      else
        format.html { render :edit }
        format.json { render json: @badge.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @badge.destroy
    respond_to do |format|
      format.html { redirect_to badges_url, notice: 'Badge was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_badge
      @badge = Badge.find(params[:id])
    end

    def badge_params
      params.require(:badge).permit(:name, :description, :proposer_id, :status, :proposal_date, :levels, :level_1, :level_2, :level_3, :level_4, :level_5, :level_6, :level_7, :level_8, :level_9)
    end

    def check_auth
      return if current_user == @badge.proposer
      return if current_user.try(:is_admin?)
      return if current_user.try(:is_librarian?)
      redirect_to @badge, warning: 'Only librarians, admins or the badge proposer can edit a badge.'
    end
end
