class LeasesController < ApplicationController
  layout 'main'
  before_action :is_signed?
  before_action :check_role
  before_action :set_lease, only: [:show, :edit, :update, :destroy]

  # GET /leases
  # GET /leases.json
  def index
    @leases = Lease.all.page(params[:page])
  end

  # GET /leases/1
  # GET /leases/1.json
  def show
  end

  # GET /leases/new
  def new
    @lease = Lease.new
  end

  # GET /leases/1/edit
  def edit
    @transaction = Transaction.where('lease_id=?', @lease.id).order('created_at desc')
  end

  # POST /leases
  # POST /leases.json
  def create
    @lease = Lease.new(lease_params)

    respond_to do |format|
      if @lease.save
        format.html { redirect_to @lease, :notice => '用戶資料已成功建立.' }
        format.json { render :show, status: :created, location: @lease }
      else
        format.html { render :new }
        format.json { render json: @lease.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leases/1
  # PATCH/PUT /leases/1.json
  def update
    respond_to do |format|
      if @lease.update(lease_params)
        format.html { redirect_to @lease, :notice => '用戶資料已更新.' }
        format.json { render :show, status: :ok, location: @lease }
      else
        format.html { render :edit }
        format.json { render json: @lease.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leases/1
  # DELETE /leases/1.json
  def destroy
    @lease.destroy
    respond_to do |format|
      format.html { redirect_to leases_url, :notice => '用戶資料已刪除.' }
      format.json { head :no_content }
    end
  end

  def price_report
    @dealers = User.where('role=?', 'dealer')
    @total_count = 0
    @total_price = 0
    @items = []
    if (is_dealer?)
      dealer_id = current_user.id
    elsif(params[:dealer])
      dealer_id = params[:dealer]
    end
    if(dealer_id)
      # 找到經銷商
      @dealer = User.find(dealer_id)

      # 找到所屬用戶
      @leases = Lease.where('dealer_id=?', dealer_id)

      # 該月總天數
      @base_days = Time.days_in_month(Date.today.month)

      @leases.each do |lease|
        days = alive_days lease.id, Date.today
        item = {
            'days' => days,
            'name' => lease.name,
            'dealer_id' => lease.dealer_id
        }
        if (days > 0)
          if (days == @base_days)
            # 滿該月總天數以 42 計算
            @total_price += 42
            item['price'] = 42
          else
            # 不滿該月總天數以 (42/該月總天數)x貢獻天數
            @total_price += ((42.00/@base_days)*days).floor
            item['price'] = ((42.00/@base_days)*days).floor
          end
          # 該月有貢獻機器
          @total_count += 1
          @items.push item
        end
      end
    end
  end

  def addTransaction
    @trans = Transaction.new(
        :lease_id => params[:lease_id],
        :start_date => params[:start_date],
        :end_date => params[:end_date],
        :kind => params[:type]
    )
    @trans.save
    @lease = Lease.find(params[:lease_id])
    redirect_to edit_lease_path(@lease), :notice => 'Transaction was successfully created.'
  end

  def deleTransaction
    @transaction = Transaction.find(params[:id])
    if @transaction
      @lease = Lease.find(@transaction.lease_id)
      @transaction.soft_delete
      redirect_to edit_lease_path(@lease), :notice => 'Transaction was successfully destroyed.'
    else
      redirect_to leases_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lease
      @lease = Lease.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lease_params
      params.require(:lease).permit(:name, :uuid, :birthday, :tel, :apply_at, :address, :device_id)
    end
end
