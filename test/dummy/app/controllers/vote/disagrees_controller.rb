class Vote::DisagreesController < ApplicationController
  before_action :set_vote_disagree, only: [:show, :edit, :update, :destroy]

  # GET /vote/disagrees
  def index
    @vote_disagrees = Vote::Disagree.all
  end

  # GET /vote/disagrees/1
  def show
  end

  # GET /vote/disagrees/new
  def new
    @vote_disagree = Vote::Disagree.new
  end

  # GET /vote/disagrees/1/edit
  def edit
  end

  # POST /vote/disagrees
  def create
    @vote_disagree = Vote::Disagree.new(vote_disagree_params)

    if @vote_disagree.save
      redirect_to @vote_disagree, notice: 'Disagree was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /vote/disagrees/1
  def update
    if @vote_disagree.update(vote_disagree_params)
      redirect_to @vote_disagree, notice: 'Disagree was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /vote/disagrees/1
  def destroy
    @vote_disagree.destroy
    redirect_to vote_disagrees_url, notice: 'Disagree was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote_disagree
      @vote_disagree = Vote::Disagree.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def vote_disagree_params
      params.require(:vote_disagree).permit(:user_id)
    end
end
