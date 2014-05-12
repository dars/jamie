class UsersController < ApplicationController
  layout 'main'

  def index
    @users = User.all
  end

end
