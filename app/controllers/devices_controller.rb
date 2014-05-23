class DevicesController < ApplicationController
  layout "main"
  before_action :is_signed?
  before_action :set_device, only: [:show, :edit, :update, :destroy]
  before_action :set_options, only: [:new, :edit]
  skip_before_filter :verify_authenticity_token, :only => [:deleTransaction]

  def index
    @devices = Device.all
  end

  def show

  end

  def new
    @device = Device.new
  end

  def edit
    @transaction = Transation.where('device_id=?', @device.id)
  end

  def create
    @device = Device.new(device_params)

    respond_to do |format|
      if @device.save
        set_flash 'success', 'Device was successfully created.'
        format.html {redirect_to @device }
      else
        format.html {render :new}
      end
    end
  end

  def update
    respond_to do |format|
      if @device.update(device_params)
        set_flash 'success', 'Device was successfully updated.'
        format.html { redirect_to @device }
        format.json { render :show, status: :ok, location: @device }
      else
        format.html { render :edit }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

  end

  def device_report
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
      # 找到相關機器
      @devices = Device.select('ID', 'SerialNumber', 'dealer_id').where('dealer_id=?', dealer_id)
      # 該月總天數
      @base_days = Time.days_in_month(Date.today.month)

      @devices.each do |device|
        days = alive_days device.ID, Date.today
        item = {
          'days' => days,
          'serial' => device.SerialNumber,
          'dealer_id' => device.dealer_id
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
    @trans = Transation.new(
        :device_id => params[:device_id],
        :start_date => params[:start_date],
        :end_date => params[:end_date],
        :type => params[:type]
    )
    @trans.save
    @device = Device.find(params[:device_id])
    set_flash 'success', 'Transaction was successfully created.'
    redirect_to edit_device_path(@device)
  end

  def deleTransaction
    @transaction = Transation.find(params[:id])
    if @transaction
      @device = Device.find(@transaction.device_id)
      @transaction.destroy
      set_flash 'success', 'Transaction was successfully destroyed.'
      redirect_to edit_device_path(@device)
    else
      redirect_to device_path
    end
  end

  private
    def set_options
      @dealers = User.where('role=?', 'dealer')
    end
    def set_device
      @device = Device.find(params[:id])
    end

    def device_params
      params.require(:device).permit(:ModelID, :SerialNumber, :FolderNameLocal, :FolderNameOnline, :FolderNameUpdate, :IsCanLogin, :SongServerGroupID, :ProducersID, :PublisherID, :AgentsID, :ConsumerID, :Note, :cus_name, :cus_uuid, :cus_birthday, :cus_tel, :cus_apply_at, :cus_address, :dealer_id)
    end
end
