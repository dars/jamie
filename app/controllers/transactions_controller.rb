class TransactionsController < ApplicationController
  before_action :is_signed?
  before_action :check_role
  layout 'main'
  def index
    @items = Transaction.all.order('created_at desc').page(params[:page])
  end
end
