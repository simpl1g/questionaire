class LinksController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_link, only: [:show, :edit, :update, :destroy]

  def index
    @links = params[:tag].present? ? Link.tagged_with(params[:tag]) : Link.all
    @tags = Tag.cloud_for(Link, links_path(tag: '')).to_json
  end

  def new
    @link = Link.new
  end

  def create
    @link = current_user.links.build(link_params)

    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, notice: 'Link was successfully created.' }
        format.json { render action: 'show', status: :created, location: @link }
      else
        format.html { render action: 'new' }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to @link, notice: 'Link was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url }
      format.json { head :no_content }
    end
  end

  private
    def set_link
      @link = current_user.links.find(params[:id])
    end

    def link_params
      params.require(:link).permit(:url, :private, :description, :tag_list)
    end
end
