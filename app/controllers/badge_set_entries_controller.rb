class BadgeSetEntriesController < ApplicationController
  before_action :set_badge_set_entry, only: [:show, :edit, :update, :destroy]

  def index
    @badge_set_entries = BadgeSetEntry.all
  end

  def show
  end

  def new
    @badge_set_entry = BadgeSetEntry.new
    @badge_set = BadgeSet.find_by_id(params[:badge_set_id])
  end

  def edit
  end

  def create
    @badge_set_entry = BadgeSetEntry.new(badge_set_entry_params)

    respond_to do |format|
      if @badge_set_entry.save
        format.html { redirect_to new_badge_set_entry_path(badge_set_id: @badge_set_entry.badge_set.id), notice: 'Badge set entry was successfully created.' }
        format.json { render :show, status: :created, location: @badge_set_entry }
      else
        @badge_set_entry.badge_set_id = params[:badge_set_id]
        format.html { render :new }
        format.json { render json: @badge_set_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @badge_set_entry.update(badge_set_entry_params)
        format.html { redirect_to @badge_set_entry, notice: 'Badge set entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @badge_set_entry }
      else
        format.html { render :edit }
        format.json { render json: @badge_set_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @badge_set_entry.destroy
    respond_to do |format|
      format.html { redirect_to badge_set_entries_url, notice: 'Badge set entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_badge_set_entry
      @badge_set_entry = BadgeSetEntry.find(params[:id])
    end

    def badge_set_entry_params
      params.require(:badge_set_entry).permit(:badge_set_id, :badge_id, :level)
    end
end
