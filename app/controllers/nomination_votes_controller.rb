class NominationVotesController < ApplicationController
  before_action :set_nomination_vote, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]
  before_action :ensure_badge_nomination_id_param, only: [:new]

  def index
    @nomination_votes = NominationVote.all
  end

  def show
  end

  def new
    @nomination_vote = NominationVote.new
    @validators = (current_user.is_librarian? || current_user.is_admin?) ? User.all : [current_user]
    @badge_nomination = BadgeNomination.find_by_id(params[:badge_nomination_id])
    @badge = @badge_nomination.try(:badge)
    @badge_nominations = @badge ? [@badge_nomination] : BadgeNomination.pending
  end

  def edit
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
      format.html { redirect_to nomination_votes_url, notice: 'Nomination vote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_nomination_vote
      @nomination_vote = NominationVote.find(params[:id])
    end

    def nomination_vote_params
      params.require(:nomination_vote).permit(:badge_nomination_id, :voter_id, :level, :comment)
    end

    def ensure_badge_nomination_id_param
      return if params[:badge_nomination_id]
      redirect_to root_path, alert: 'Please select "Validate..." in the navigation bar and select a specific Badge Nomination.'
    end
end
