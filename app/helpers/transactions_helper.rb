module TransactionsHelper
  def transaction_kind(kind)
    if kind == 1
      return raw("<span class='label label-primary'>年約</span>")
    else
      return raw("<span class='label label-info'>月約</span>")
    end
  end
end
