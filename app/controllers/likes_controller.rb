class LikesController < ApplicationController
  before_action :set_like, only: %i[ show edit update destroy ]

  # GET /likes or /likes.json
  def index
    @likes = Like.all
  end

  # GET /likes/1 or /likes/1.json
  def show
  end

  # GET /likes/new
  def new
    @like = Like.new
  end

  # GET /likes/1/edit
  def edit
  end

  # POST /likes or /likes.json
  def create
    @like = Like.new
    @like.fan_id   = current_user.id
    @like.photo_id = params.fetch("like").fetch("photo_id")

    @like.save

    redirect_back fallback_location: root_path
  end

  # PATCH/PUT /likes/1 or /likes/1.json
  def update
    respond_to do |format|
      if @like.update(like_params)
        format.html { redirect_to @like, notice: "Like was successfully updated." }
        format.json { render :show, status: :ok, location: @like }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /likes/1 or /likes/1.json
  def destroy
    the_id = params.fetch("id")
    matching_likes = Like.where({ :id => the_id })
    the_like = matching_likes.first
    the_like.destroy

    redirect_back fallback_location: root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = Like.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def like_params
      params.expect(like: [ :fan_id, :photo, :references ])
    end
end
