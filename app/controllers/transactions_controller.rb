class TransactionsController < ApplicationController
  before_action :is_signed?
  layout 'main'
  def index
    @items = Transaction.all.order('created_at desc').page(params[:page])
  end
end
