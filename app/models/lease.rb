class Lease < ActiveRecord::Base
  include ActiveModel::Dirty
  has_one :device, :foreign_key => 'ID', :primary_key => 'device_id'
  belongs_to :dealer, :class_name => 'User', :foreign_key => 'dealer_id'
  before_save do
    self.uuid = self.uuid.upcase
    if self.device_id_changed?
      # 存入 device change log
      @log = LeaseDeviceLog.new(
        :lease_id  => self.id,
        :device_id => self.device_id
      )
      @log.save

      # 依選定的 device 設定所屬經銷商
      @device = Device.find(self.device_id)
      if(@device)
        self.dealer_id = @device.dealer_id
      end
    end
  end
end
