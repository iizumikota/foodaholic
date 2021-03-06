class AlbumsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @albums = Album.all
  end

  def show
    @images = @album.images.all
  end

  def new
    @album = Album.new
    @image = @album.images.build
  end

  def edit
  end

  def create
    @album = Album.new(item_params)

    respond_to do |format|
      if @album.save
        params[:images]['image_url'].each do |a|
          @image = @album.images.create!(:image_url => a)
        end
        format.html { redirect_to @album, notice: 'Item was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @album.update(item_params)
        params[:images]['image_url'].each do |a|
          @image = @album.images.create!(:image_url => a)
        end
        format.html { redirect_to @album, notice: 'Item was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @album.destroy
    respond_to do |format|
      format.html { redirect_to albums_url, notice: 'Item was successfully destroyed.' }
    end
  end

  private
  def set_item
    @album = Album.find(params[:id])
  end

  def item_params
    params.require(:album).permit(:title, images_attributes: [:id, :album_id, :image_url])
  end
end
