class CompTiersController < ApplicationController
  before_action :set_comp_tier, only: [:show, :edit, :update, :destroy]

  # GET /comp_tiers
  # GET /comp_tiers.json
  def index
    @comp_tiers = CompTier.all
  end

  # GET /comp_tiers/1
  # GET /comp_tiers/1.json
  def show
  end

  # GET /comp_tiers/new
  def new
    @comp_tier = CompTier.new
  end

  # GET /comp_tiers/1/edit
  def edit
  end

  # POST /comp_tiers
  # POST /comp_tiers.json
  def create
    @comp_tier = CompTier.new(comp_tier_params)

    respond_to do |format|
      if @comp_tier.save
        format.html { redirect_to @comp_tier, notice: 'Comp tier was successfully created.' }
        format.json { render :show, status: :created, location: @comp_tier }
      else
        format.html { render :new }
        format.json { render json: @comp_tier.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comp_tiers/1
  # PATCH/PUT /comp_tiers/1.json
  def update
    respond_to do |format|
      if @comp_tier.update(comp_tier_params)
        format.html { redirect_to @comp_tier, notice: 'Comp tier was successfully updated.' }
        format.json { render :show, status: :ok, location: @comp_tier }
      else
        format.html { render :edit }
        format.json { render json: @comp_tier.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comp_tiers/1
  # DELETE /comp_tiers/1.json
  def destroy
    @comp_tier.destroy
    respond_to do |format|
      format.html { redirect_to comp_tiers_url, notice: 'Comp tier was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comp_tier
      @comp_tier = CompTier.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comp_tier_params
      params.require(:comp_tier).permit(:name, :monthly_draw, :fixed_draw)
    end
end
