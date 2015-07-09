class BadgesController < ApplicationController
  before_action :set_badge, only: [:show, :edit, :update, :destroy, :propose, :accept, :reject]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :check_auth, only: [:edit, :accept, :reject]

  def index
    @badges = Badge.order(:status).order(:name)
    @accepted = Badge.accepted.order(:name)
    @proposed = Badge.proposed.order(:name)
    @draft = Badge.draft.order(:name)
  end

  def show
  end

  def new
    template = Badge.find_by_id(params[:template_id])
    @badge = template ? template.dup : Badge.new
    @badge.status = template ? 'proposed' : 'draft'
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

  def propose
    @badge.status = 'proposed'
    if @badge.save
      redirect_to @badge, notice: 'Badge status successfully changed to "proposed".'
    else
      redirect_to @badge, alert: 'Unable to change badge status to "proposed".'
    end
  end

  def reject
    @badge.status = 'draft'
    if @badge.save
      redirect_to @badge, notice: 'Badge status successfully changed back to "draft"'
    else
      redirect_to @badge, alert: 'Unable to change badge status back to "draft".'
    end
  end

  def accept
    @badge.status = 'accepted'
    if @badge.save
      redirect_to @badge, notice: 'Badge status successfully changed to "accepted".'
    else
      redirect_to @badge, alert: 'Unable to change badge status to "accepted".'
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
      params.require(:badge).permit(:name, :description, :proposer_id, :status, :proposal_date, :levels, :level_1, :level_2, :level_3, :level_4, :level_5, :level_6, :level_7, :level_8, :level_9, :focus, :feedback)
    end

    def check_auth
      return if current_user.try(:is_admin?)
      return if current_user.try(:is_librarian?)
      return if @badge.status == 'draft'
      where = request.env["HTTP_REFERER"] || root_path
      redirect_to where, alert: 'Only librarians and admins can take that action.'
    end
end
