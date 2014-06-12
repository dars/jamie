class Lease < ActiveRecord::Base
  include ActiveModel::Dirty
  has_one :device, :foreign_key => 'ID', :primary_key => 'device_id'
  before_save do
    self.uuid = self.uuid.upcase
    if self.device_id_changed?
      @log = LeaseDeviceLog.new(
        :lease_id  => self.id,
        :device_id => self.device_id
      )
      @log.save
    end
  end
end
