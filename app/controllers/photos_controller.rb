class PhotosController < ApplicationController
  def index
    matching_photos = Photo.all

    @list_of_photos = matching_photos.order({ :created_at => :desc})
    render({ :template => "photo_templates/index"})
  end

  def show
    path = params.fetch("path_photo_id")
    matching_photos = Photo.where({ :id => path})

    @the_photo = matching_photos.at(0)
    render({ :template => "photo_templates/show"})
  end

  def delete 
    path = params.fetch("path_photo_id")
    matching_photos = Photo.where({ :id => path})

    @the_photo = matching_photos.at(0)
    @the_photo.destroy
    redirect_to("/photos", { :notice => "Photo deleted successfully."} )
    #render({ :template => "photo_templates/delete"})
  end

  def update
    the_id = params.fetch("path_photo_id")
    @the_photo = Photo.where({ :id => the_id }).at(0)

    @the_photo.image = params.fetch("query_image")
    @the_photo.caption = params.fetch("query_caption")

    if @the_photo.valid?
      @the_photo.save
      redirect_to("/photos/#{@the_photo.id}", { :notice => "Photo updated successfully."} )
    else
      redirect_to("/photos/#{@the_photo.id}", { :alert => "Photo failed to update successfully." })
    end
  end
  
end
