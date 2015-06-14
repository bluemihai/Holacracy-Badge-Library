class NominationVotesController < ApplicationController
  before_action :set_nomination_vote, only: [:show, :edit, :update, :destroy]

  def index
    @nomination_votes = NominationVote.all
  end

  def show
  end

  def new
    @nomination_vote = NominationVote.new
  end

  def edit
  end

  def create
    @nomination_vote = NominationVote.new(nomination_vote_params)

    respond_to do |format|
      if @nomination_vote.save
        format.html { redirect_to nomination_votes_path, notice: 'Nomination vote was successfully created.' }
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
end
