class User < ActiveRecord::Base

  validates :email, uniqueness: true, presence: true


  include BCrypt 

  def password
    @password = Password.new(self.password_digest)
  end

  def password=(secret)
    @password = Password.create(secret)
    self.password_digest = @password
  end

  def valid_email

  end

end
