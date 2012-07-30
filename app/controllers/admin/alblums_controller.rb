require 'ostruct'
class Admin::AlblumsController < AdminController
  load_and_authorize_resource
  before_filter :redirect_to_new_if_no_alblums, :only => :index
  before_filter :load_alblums_unless_present

  def index
    redirect_to [:admin, @alblums.first]
  end

  def show
    respond_to do |format|
      format.html # just render
      format.json { render json: @alblum.photos.map(&:as_jq_upload).to_json}
    end
  end

  def create
    if @alblum.save
      redirect_to [:admin, @alblum]
    else
      render :action => :new
    end
  end

  def update
    if @alblum.update_attributes(params[:alblum])
      respond_to do |format|
        format.html { redirect_to [:admin, @alblum] }
        format.json { render json: @alblum.photos.map(&:as_jq_upload).to_json}
      end
    else
      respond_to do |format|
        format.html { render :action => :show }
        format.json { render :json => [{error: @alblum.errors.full_messages}]}
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
      format.html { redirect_to [:admin, photo.alblum] }
      format.json { render json: photo.as_jq_upload.to_json }
    end
  end

  private

  def load_alblums_unless_present
    unless request.xhr?
      @alblums ||= Alblum.accessible_by(current_ability)
    end
  end

  def redirect_to_new_if_no_alblums
    redirect_to :action => :new if @alblums.empty?
  end
end
