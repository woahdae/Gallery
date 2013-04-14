require 'ostruct'
class Admin::CategoriesController < AdminController
  load_and_authorize_resource
  before_filter :redirect_to_new_if_no_categories, :only => :index
  before_filter :load_categories_unless_present
  after_filter :expire_category_cache, :only => [:update, :delete_photo]

  def index
    redirect_to [:admin, @categories.last]
  end

  def show
    respond_to do |format|
      format.html # just render
      format.json { render json: @category.photos.map(&:as_jq_upload).to_json}
    end
  end

  def create
    if @category.save
      redirect_to [:admin, @category]
    else
      render :action => :new
    end
  end

  def update
    if @category.update_attributes(params[:category])
      respond_to do |format|
        format.html { redirect_to [:admin, @category] }
        format.json { render json: @category.photos.map(&:as_jq_upload).to_json}
      end
    else
      respond_to do |format|
        format.html { render :action => :show }
        format.json { render :json => [{error: @category.errors.full_messages}]}
      end
    end
  end

  def sort
    @category.update_attributes(params[:category])
    respond_to do |format|
      format.js
    end
  end

  # too lazy to make a controller just for this
  def delete_photo
    photo = Photo.find(params[:photo_id])

    if can?(:delete, photo)
      photo.destroy
    end

    respond_to do |format|
      format.html { redirect_to [:admin, photo.category] }
      format.json { render json: photo.as_jq_upload.to_json }
    end
  end

  private

  def load_categories_unless_present
    unless request.xhr?
      @categories ||= Category.accessible_by(current_ability)
    end
  end

  def redirect_to_new_if_no_categories
    redirect_to :action => :new if @categories.empty?
  end

  def expire_category_cache
    expire_fragment(@category)
  end
end
