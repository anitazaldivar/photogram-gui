class UsersController < ApplicationController
  def index
    matching_users = User.all
    @list_of_users = matching_users.order({ :username => :asc})
    render({ :template => "user_templates/index"})
  end

  def show
    path = params.fetch("path_username")
    matching_users = User.where( { :username => path})
    @the_user = matching_users.at(0)

    if @the_user == nil
      redirect_to("/")
    else
      render({ :template => "user_templates/show"})
    end
  end

  def create
    @user = User.new
    @user.username = params.fetch("input_username")

    if @user.valid?
      @user.save
      redirect_to("/users/#{@user.username}", { :notice => "User created successfully." })
    else
      redirect_to("/users/#{@user.username}", { :notice => "User failed to create successfully." })
    end
  end

  def update
    path = params.fetch("path_username")
    @the_user = User.where({ :id => path }).at(0)

    @the_user.username = params.fetch("input_username")

    if @the_user.valid?
      @the_user.save
      redirect_to("/users/#{@the_user.username}", { :notice => "User updated successfully."} )
    else
      redirect_to("/users/#{@the_user.username}", { :alert => "User failed to update successfully." })
    end
  end
end
