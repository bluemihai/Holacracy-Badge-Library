class BadgeLevelsController < ApplicationController
  before_action :set_badge_level, only: [:show, :edit, :update, :destroy]

  # GET /badge_levels
  # GET /badge_levels.json
  def index
    @badge_levels = BadgeLevel.all
  end

  # GET /badge_levels/1
  # GET /badge_levels/1.json
  def show
  end

  # GET /badge_levels/new
  def new
    @badge_level = BadgeLevel.new
  end

  # GET /badge_levels/1/edit
  def edit
  end

  # POST /badge_levels
  # POST /badge_levels.json
  def create
    @badge_level = BadgeLevel.new(badge_level_params)

    respond_to do |format|
      if @badge_level.save
        format.html { redirect_to @badge_level, notice: 'Badge level was successfully created.' }
        format.json { render :show, status: :created, location: @badge_level }
      else
        format.html { render :new }
        format.json { render json: @badge_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /badge_levels/1
  # PATCH/PUT /badge_levels/1.json
  def update
    respond_to do |format|
      if @badge_level.update(badge_level_params)
        format.html { redirect_to @badge_level, notice: 'Badge level was successfully updated.' }
        format.json { render :show, status: :ok, location: @badge_level }
      else
        format.html { render :edit }
        format.json { render json: @badge_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /badge_levels/1
  # DELETE /badge_levels/1.json
  def destroy
    @badge_level.destroy
    respond_to do |format|
      format.html { redirect_to badge_levels_url, notice: 'Badge level was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_badge_level
      @badge_level = BadgeLevel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def badge_level_params
      params.require(:badge_level).permit(:badge_id, :level_id, :description)
    end
end
