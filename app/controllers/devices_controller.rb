class DevicesController < ApplicationController
  layout "main"
  before_action :is_signed?
  before_action :check_role
  before_action :set_device, only: [:show, :edit, :update, :destroy]
  before_action :set_options, only: [:new, :edit]
  skip_before_filter :verify_authenticity_token, :only => [:deleTransaction]

  def index
    @devices = Device.all
    if params[:serial] and params[:serial] != ''
      @devices = @devices.where('SerialNumber=?', params[:serial])
    end
    if params[:demo] == '1'
      @devices = @devices.where('demo=?', true)
    end
    if params[:demo] == '2'
      @devices = @devices.where('demo != ?', true)
    end
    @devices = @devices.order('SerialNumber').page(params[:page])
  end

  def show

  end

  def new
    @device = Device.new
  end

  def edit
    @transaction = Transaction.where('device_id=?', @device.id).order('created_at desc')
  end

  def create
    @device = Device.new(device_params)

    respond_to do |format|
      if @device.save
        format.html {redirect_to @device, :notice => 'Device was successfully created.' }
      else
        format.html {render :new}
      end
    end
  end

  def update
    respond_to do |format|
      if @device.update(device_params)
        format.html { redirect_to @device, :notice => 'Device was successfully updated.' }
        format.json { render :show, status: :ok, location: @device }
      else
        format.html { render :edit }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

  end

  # TODO: 大量開通機器
  def readXls
    if (params[:xlsfile])
      ufile = params[:xlsfile]
      xlsfile = Spreadsheet.open ufile.tempfile.path
      sheet = xlsfile.worksheet 0
      raw = "INSERT INTO `device` (`ModelID`, `SerialNumber`, `FolderNameLocal`, `FolderNameOnline`, `FolderNameUpdate`, `IsCanLogin`, `SongServerGroupID`, `ProducersID`, `PublisherID`, `AgentsID`, `ConsumerID`, `Note`, `dealer_id`, `demo`) VALUES"
      sheet.each do |row|
        row.each do |t|
          serial = sprintf("HC000%03d", t.to_s);
          raw += "(0, '#{serial}', '', '', '', 1, 0, 0, 0, 0, 0, NULL, NULL, 1),<br>"
        end
      end
      render :text => raw
    end
  end

  # ajax 取得 devices
  def getItems
    @items = Device.joins(:dealer).where("SerialNumber Like ?", params[:keyword]+'%').order('SerialNumber')

  end

  private
    def set_options
      @dealers = User.where('role=?', 'dealer')
    end
    def set_device
      @device = Device.find(params[:id])
    end

    def device_params
      params.require(:device).permit(:ModelID, :SerialNumber, :FolderNameLocal, :FolderNameOnline, :FolderNameUpdate, :IsCanLogin, :SongServerGroupID, :ProducersID, :PublisherID, :AgentsID, :ConsumerID, :Note, :dealer_id, :demo)
    end
end
