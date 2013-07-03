class Vote::AgreesController < ApplicationController
  before_action :set_vote_agree, only: [:show, :edit, :update, :destroy]

  # GET /vote/agrees
  def index
    @vote_agrees = Vote::Agree.all
  end

  # GET /vote/agrees/1
  def show
  end

  # GET /vote/agrees/new
  def new
    @vote_agree = Vote::Agree.new
  end

  # GET /vote/agrees/1/edit
  def edit
  end

  # POST /vote/agrees
  def create
    @vote_agree = Vote::Agree.new(vote_agree_params)

    if @vote_agree.save
      redirect_to @vote_agree, notice: 'Agree was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /vote/agrees/1
  def update
    if @vote_agree.update(vote_agree_params)
      redirect_to @vote_agree, notice: 'Agree was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /vote/agrees/1
  def destroy
    @vote_agree.destroy
    redirect_to vote_agrees_url, notice: 'Agree was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote_agree
      @vote_agree = Vote::Agree.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def vote_agree_params
      params.require(:vote_agree).permit(:user_id)
    end
end
