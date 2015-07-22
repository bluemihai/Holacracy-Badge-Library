class BadgesController < ApplicationController
  before_action :set_badge, only: [:show, :edit, :update, :destroy, :propose, :accept, :reject]
  before_action :authenticate_user!, except: [:index, :detailed, :show]
  before_action :check_auth, only: [:edit, :accept, :reject]
  before_action :warn_if_not_proposer, only: [:edit]

  def index
    @badges = Badge.order(:status).order(:name)
    @accepted = Badge.accepted.order(:name)
    @proposed = Badge.proposed.order(:name)
    @draft = Badge.draft.order(:name)
  end

  def detailed
    @badges = Badge.order(:status).order(:name)
    @accepted = Badge.accepted.order(:name)
    @proposed = Badge.proposed.order(:name)
    @draft = Badge.draft.order(:name)
  end

  def show
  end

  def new
    @users = librarian_or_admin? ? User.all : [current_user]
    template = Badge.find_by_id(params[:template_id])
    @badge = template ? template.dup : Badge.new
    @badge.status = template ? 'proposed' : 'draft'
  end

  def edit
    @users = librarian_or_admin? ? User.all : [current_user]
  end

  def create
    @badge = Badge.new(badge_params)
    @badge.status = 'draft'

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
    @badge.proposal_date = DateTime.now.to_date
    if @badge.save
      redirect_to @badge, notice: 'Badge proposed.  Please notify Badge Librarian via Slack or e-mail.'
    else
      redirect_to @badge, alert: 'Unable to change badge status to "proposed".'
    end
  end

  def reject
    @badge.objections.build(librarian: current_user, objection: true)
    @badge.status = 'draft'
    if @badge.save
      redirect_to @badge, notice: 'Badge status successfully changed back to "draft"'
    else
      redirect_to @badge, alert: 'Unable to change badge status back to "draft".'
    end
  end

  def accept
    o = @badge.objections.build(librarian_id: params[:librarian_id], objection: false)
    notice_or_alert = nil
    if o.valid?      
      if last_non_objection?
        o.save!
        @badge.update_attributes(status: 'accepted', acceptance_date: DateTime.now.to_date)
        notice_or_alert = { notice: "Your (last remaining) non-objection was recorded.  Badge status is now 'accepted'" }
      else
        o.save!
        notice_or_alert = { notice: "Your non-objection was recorded.  Badge status unchanged" }
      end
    else
      notice_or_alert = { alert: "Your non-objection was invalid." }
    end
    redirect_to @badge, notice_or_alert
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
    if @badge.badge_sets.count > 0
      notice_or_alert = { alert: 'This badge is part of at least one badge set.  Delete those first and try again.' }
    elsif @badge.badge_nominations.count > 0
      notice_or_alert = { alert: 'There are pending nominations for this badge.  Delete those first and try again.' }
    else
      notice_or_alert = { notice: 'Badge was successfully destroyed.'}
      @badge.destroy
    end
    respond_to do |format|
      format.html { redirect_to holders_path, notice_or_alert }
      format.json { head :no_content }
    end
  end

  private
    def set_badge
      @badge = Badge.find(params[:id])
    end

    def badge_params
      params.require(:badge).permit(:name, :description, :proposer_id, :status, :proposal_date, :levels, :level_1,
        :level_2, :level_3, :level_4, :level_5, :level_6, :level_7, :level_8, :level_9, :focus, :feedback,
        :mechanism, :acceptance_date)
    end

    def check_auth
      return if current_user.try(:is_admin?)
      return if current_user.try(:is_librarian?)
      return if @badge.status == 'draft'
      where = request.env["HTTP_REFERER"] || root_path
      redirect_to where, alert: 'Only librarians and admins can take that action.'
    end

    def warn_if_not_proposer
      if @badge.proposer && @badge.proposer != current_user
        flash.now[:alert] = "This badge was proposed by #{@badge.proposer.short}.  Do you have the proposer's permission to edit it?"
      end
    end

    def last_non_objection?
      @badge.objections.count > 0  # TODO Adjust for case where there are more than 2 Badge Librarians
    end
end
