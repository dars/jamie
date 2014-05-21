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
