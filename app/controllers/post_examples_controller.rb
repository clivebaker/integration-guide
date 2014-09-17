class PostExamplesController < ApplicationController
  before_action :set_post_example, only: [:show, :edit, :update, :destroy]

  # GET /post_examples
  # GET /post_examples.json
  def index
    @post_examples = PostExample.all
  end

  # GET /post_examples/1
  # GET /post_examples/1.json
  def show
  end

  # GET /post_examples/new
  def new
    @post_example = PostExample.new
  end

  # GET /post_examples/1/edit
  def edit
  end

  # POST /post_examples
  # POST /post_examples.json
  def create
    @post_example = PostExample.new(post_example_params)

    respond_to do |format|
      if @post_example.save
        format.html { redirect_to @post_example, notice: 'Post example was successfully created.' }
        format.json { render :show, status: :created, location: @post_example }
      else
        format.html { render :new }
        format.json { render json: @post_example.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /post_examples/1
  # PATCH/PUT /post_examples/1.json
  def update
    respond_to do |format|
      if @post_example.update(post_example_params)
        format.html { redirect_to @post_example, notice: 'Post example was successfully updated.' }
        format.json { render :show, status: :ok, location: @post_example }
      else
        format.html { render :edit }
        format.json { render json: @post_example.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /post_examples/1
  # DELETE /post_examples/1.json
  def destroy
    @post_example.destroy
    respond_to do |format|
      format.html { redirect_to post_examples_url, notice: 'Post example was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  def api_receipt_post
    @url = params["url"]
    @json = params["json"]
    @response = HTTParty.post(@url.to_str, :body =>@json, :headers => {'Content-Type' => 'application/json'})
    render "post_examples/post_receipt_response"
  end

  def custom_json
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post_example
      @post_example = PostExample.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_example_params
      params.require(:post_example).permit(:name, :json_string, :user_id)
    end
end
