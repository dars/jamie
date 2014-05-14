
class User < ActiveRecord::Base
  include BCrypt
  before_save {self.email = self.email.downcase}
  before_save {self.session_token ||= Digest::SHA1.hexdigest(SecureRandom.urlsafe_base64.to_s)}
  has_secure_password

  belongs_to :license, :class_name => 'Licensee', :foreign_key => 'license_id'

  # def password
  #   @password ||= Password.new(password_hash)
  # end
  #
  # def password=(new_password)
  #   @password = Password.create(new_password)
  #   self.password_hash = @password
  # end
end
