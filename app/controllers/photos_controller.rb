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

  def create
    @photo = Photo.new
    @photo.image = params.fetch("input_image")
    @photo.caption = params.fetch("input_caption")
    @photo.owner_id = params.fetch("input_owner_id")

    if @photo.valid?
      @photo.save
      redirect_to("/photos", { :notice => "Photo created successfully." })
    else
      redirect_to("/photos", { :notice => "Photo failed to create successfully." })
    end
  end

  def new_comment
    the_id = params.fetch("input_photo_id")
    @the_photo = Photo.where({ :id => the_id }).at(0)

    comment = Comment.new
    comment.body = params.fetch("input_comment")
    comment.author_id = params.fetch("input_author_id")
    comment.photo_id = params.fetch("input_photo_id")

    if comment.valid?
      comment.save
      redirect_to("/photos/#{@the_photo.id}", { :notice => "Comment created successfully."} )
    else
      redirect_to("/photos/#{@the_photo.id}", { :alert => "Comment failed to create successfully." })
    end
  end

end
