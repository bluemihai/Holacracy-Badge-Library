class NominationVotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_nomination_vote, only: [:show, :edit, :update, :destroy]
  before_action :ensure_badge_nomination_id_param, only: [:new]
  before_action :check_auth, only: [:index, :show]

  def index
    @nomination_votes = NominationVote.all
  end

  def show
  end

  def new
    @nomination_vote = NominationVote.new
    @badge_nomination = BadgeNomination.find_by_id(params[:badge_nomination_id])
    @badge = @badge_nomination.try(:badge)
    @badge_nominations = @badge ? [@badge_nomination] : BadgeNomination.pending
  end

  def edit
    @badge_nomination = BadgeNomination.find_by_id(params[:badge_nomination_id])
    @badge = @badge_nomination.try(:badge)
    @badge_nominations = @badge ? [@badge_nomination] : BadgeNomination.pending
  end

  def create
    @nomination_vote = NominationVote.new(nomination_vote_params)

    respond_to do |format|
      if @nomination_vote.save
        format.html { redirect_to @nomination_vote.badge_nomination, notice: 'Nomination vote was successfully created.' }
        format.json { render :show, status: :created, location: @nomination_vote }
      else
        format.html { render :new }
        format.json { render json: @nomination_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @nomination_vote.update(nomination_vote_params)
        format.html { redirect_to nomination_votes_path, notice: 'Nomination vote was successfully updated.' }
        format.json { render :show, status: :ok, location: @nomination_vote }
      else
        format.html { render :edit }
        format.json { render json: @nomination_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @nomination_vote.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Nomination vote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_nomination_vote
      @nomination_vote = NominationVote.find(params[:id])
    end

    def nomination_vote_params
      params.require(:nomination_vote).permit(:badge_nomination_id, :validator_id, :level, :comment)
    end

    def ensure_badge_nomination_id_param
      @badge_nomination = BadgeNomination.find_by_id(params[:badge_nomination_id])
      if params[:badge_nomination_id]
        redirect_to :back, alert: 'You cannot validate yourself' if @badge_nomination.user == current_user && !librarian_or_admin?          
      else
        flash.now[:alert] = 'Please start by clicking "Validate..." in the navigation bar to select a specific Badge Nomination.'
        return
      end
    end
    
    def check_auth
      return if librarian_or_admin?
      redirect_to root_path, alert: 'Only librariars and admins can view validations.'
    end
end
