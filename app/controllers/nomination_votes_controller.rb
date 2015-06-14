class NominationVotesController < ApplicationController
  before_action :set_nomination_vote, only: [:show, :edit, :update, :destroy]

  # GET /nomination_votes
  # GET /nomination_votes.json
  def index
    @nomination_votes = NominationVote.all
  end

  # GET /nomination_votes/1
  # GET /nomination_votes/1.json
  def show
  end

  # GET /nomination_votes/new
  def new
    @nomination_vote = NominationVote.new
  end

  # GET /nomination_votes/1/edit
  def edit
  end

  # POST /nomination_votes
  # POST /nomination_votes.json
  def create
    @nomination_vote = NominationVote.new(nomination_vote_params)

    respond_to do |format|
      if @nomination_vote.save
        format.html { redirect_to @nomination_vote, notice: 'Nomination vote was successfully created.' }
        format.json { render :show, status: :created, location: @nomination_vote }
      else
        format.html { render :new }
        format.json { render json: @nomination_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nomination_votes/1
  # PATCH/PUT /nomination_votes/1.json
  def update
    respond_to do |format|
      if @nomination_vote.update(nomination_vote_params)
        format.html { redirect_to @nomination_vote, notice: 'Nomination vote was successfully updated.' }
        format.json { render :show, status: :ok, location: @nomination_vote }
      else
        format.html { render :edit }
        format.json { render json: @nomination_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nomination_votes/1
  # DELETE /nomination_votes/1.json
  def destroy
    @nomination_vote.destroy
    respond_to do |format|
      format.html { redirect_to nomination_votes_url, notice: 'Nomination vote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nomination_vote
      @nomination_vote = NominationVote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def nomination_vote_params
      params.require(:nomination_vote).permit(:badge_nomination_id, :voter_id, :level, :comment)
    end
end
