class DiariesController < ApplicationController
  before_action :set_diary, only: [:show, :edit, :update, :destroy]

  # GET /diaries
  def index
    @diaries = Diary.all
  end

  # GET /diaries/1
  def show
  end

  # GET /diaries/new
  def new
    @diary = Diary.new
  end

  # GET /diaries/1/edit
  def edit
  end

  # POST /diaries
  def create
    @diary = Diary.new(diary_params)

    if @diary.save
      redirect_to @diary, notice: 'Diary was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /diaries/1
  def update
    if @diary.update(diary_params)
      redirect_to @diary, notice: 'Diary was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /diaries/1
  def destroy
    @diary.destroy
    redirect_to diaries_url, notice: 'Diary was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diary
      @diary = Diary.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def diary_params
      params.require(:diary).permit(:title, :content, :user)
    end
end
