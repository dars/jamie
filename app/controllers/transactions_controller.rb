class TransactionsController < ApplicationController
  layout 'main'
  def index
    @items = Transaction.all.order('created_at desc').page(params[:page])
  end
end
