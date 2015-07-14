class CompTiersController < ApplicationController
  before_action :set_comp_tier, only: [:show, :edit, :update, :destroy]

  def index
    @comp_tiers = CompTier.all
    @tiers = []
    (1..6).each { |n| @tiers.push CompTier.tier(n)}
  end

  def show
  end

  def new
    @comp_tier = CompTier.new
  end

  def edit
  end

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

  def destroy
    @comp_tier.destroy
    respond_to do |format|
      format.html { redirect_to comp_tiers_url, notice: 'Comp tier was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_comp_tier
      @comp_tier = CompTier.find(params[:id])
    end

    def comp_tier_params
      params.require(:comp_tier).permit(:name, :monthly_draw, :fixed_draw)
    end
end
