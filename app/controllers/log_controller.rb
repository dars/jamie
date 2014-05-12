class LogController < ApplicationController
  layout 'main'
  def index
    @logs = Log.all.order('DateTime Desc').page(params[:page])
  end
end
