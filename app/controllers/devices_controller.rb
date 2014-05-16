class DevicesController < ApplicationController
  layout "main"
  before_action :is_signed?
  before_action :set_device, only: [:show, :edit, :update, :destroy]

  def index
    @devices = Device.all
  end

  def show

  end

  def new
    @device = Device.new
  end

  def edit
  end

  def create
    @device = Device.new(device_params)

    respond_to do |format|
      if @device.save
        set_flash 'success', 'User was successfully created.'
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

  private
    def set_device
      @device = Device.find(params[:id])
    end

    def device_params
      params.require(:device).permit(:ModelID, :SerialNumber, :FolderNameLocal, :FolderNameOnline, :FolderNameUpdate, :IsCanLogin, :SongServerGroupID, :ProducersID, :PublisherID, :AgentsID, :ConsumerID, :Note, :cus_name, :cus_uuid, :cus_birthday, :cus_tel, :cus_apply_at, :cus_address)
    end
end
