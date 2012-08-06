require 'ostruct'
class Admin::AlbumsController < AdminController
  load_and_authorize_resource
  before_filter :redirect_to_new_if_no_albums, :only => :index
  before_filter :load_albums_unless_present

  def index
    redirect_to [:admin, @albums.first]
  end

  def show
    respond_to do |format|
      format.html # just render
      format.json { render json: @album.photos.map(&:as_jq_upload).to_json}
    end
  end

  def create
    if @album.save
      redirect_to [:admin, @album]
    else
      render :action => :new
    end
  end

  def update
    if @album.update_attributes(params[:album])
      respond_to do |format|
        format.html { redirect_to [:admin, @album] }
        format.json { render json: @album.photos.map(&:as_jq_upload).to_json}
      end
    else
      respond_to do |format|
        format.html { render :action => :show }
        format.json { render :json => [{error: @album.errors.full_messages}]}
      end
    end
  end

  # too lazy to make a controller just for this
  def delete_photo
    photo = Photo.find(params[:photo_id])

    if can?(:delete, photo)
      photo.destroy
    end

    respond_to do |format|
      format.html { redirect_to [:admin, photo.album] }
      format.json { render json: photo.as_jq_upload.to_json }
    end
  end

  private

  def load_albums_unless_present
    unless request.xhr?
      @albums ||= Album.accessible_by(current_ability)
    end
  end

  def redirect_to_new_if_no_albums
    redirect_to :action => :new if @albums.empty?
  end
end
