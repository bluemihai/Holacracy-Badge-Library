class BadgeSetsController < ApplicationController
  before_action :set_badge_set, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @badge_sets = BadgeSet.all
  end

  def show
  end

  def new
    @badge_set = BadgeSet.new
  end

  def edit
  end

  def create
    @badge_set = BadgeSet.new(badge_set_params)

    respond_to do |format|
      if @badge_set.save
        format.html { redirect_to new_badge_set_entry_path(badge_set_id: @badge_set.id), notice: 'Badge set was successfully created.' }
        format.json { render :show, status: :created, location: @badge_set }
      else
        format.html { render :new }
        format.json { render json: @badge_set.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @badge_set.update(badge_set_params)
        format.html { redirect_to @badge_set, notice: 'Badge set was successfully updated.' }
        format.json { render :show, status: :ok, location: @badge_set }
      else
        format.html { render :edit }
        format.json { render json: @badge_set.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @badge_set.destroy
    respond_to do |format|
      format.html { redirect_to badge_sets_url, notice: 'Badge set was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_badge_set
      @badge_set = BadgeSet.find(params[:id])
    end

    def badge_set_params
      params.require(:badge_set).permit(:proposer_id, :name, :comp_tier_id)
    end
end
