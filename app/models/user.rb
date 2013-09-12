class User < ActiveRecord::Base

  validates :email, uniqueness: true, presence: true
  

  validate :valid_email, on: :create

  include BCrypt 

  def password
    @password = Password.new(self.password_digest)
  end

  def password=(secret)
    @password = Password.create(secret)
    self.password_digest = @password
  end

  def valid_email
    errors.add(:email, "Not a valid email") unless email.match(/\w+@\w+\.\w{2,7}/)
  end

end
