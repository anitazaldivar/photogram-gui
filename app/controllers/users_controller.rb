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
end
