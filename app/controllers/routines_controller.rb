class RoutinesController < ApplicationController
  before_action :set_routine, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show]
  # GET /routines
  # GET /routines.json
  def index
    @routines = Routine.all
  end

  # GET /routines/1
  # GET /routines/1.json
  def show
  end

  # GET /routines/new
  def new
    @routine = current_user.routines.build
  end

  # GET /routines/1/edit
  def edit
  end

  # POST /routines
  # POST /routines.json
  def create
    @routine = current_user.routines.build(routine_params)

    respond_to do |format|
      if @routine.save
        format.html { redirect_to @routine, notice: 'Routine was successfully created.' }
        format.json { render :show, status: :created, location: @routine }
      else
        format.html { render :new }
        format.json { render json: @routine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /routines/1
  # PATCH/PUT /routines/1.json
  def update
    respond_to do |format|
      if @routine.update(routine_params)
        format.html { redirect_to @routine, notice: 'Routine was successfully updated.' }
        format.json { render :show, status: :ok, location: @routine }
      else
        format.html { render :edit }
        format.json { render json: @routine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /routines/1
  # DELETE /routines/1.json
  def destroy
    @routine.destroy
    respond_to do |format|
      format.html { redirect_to routines_url, notice: 'Routine was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def like
    @routine = Routine.find(params[:id])
    @routine.like_by current_user
    redirect_to :back
  end

  def unlike
    @routine = Routine.find(params[:id])
    @routine.unliked_by current_user
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_routine
      @routine = Routine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def routine_params
      params.require(:routine).permit(:title, :routine)
    end
end
