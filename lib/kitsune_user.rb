require 'digest/sha1'
class KitsuneUser < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :email, :password, :password_confirmation
  
  validates_confirmation_of :password, :if => :password_required?
  validates_presence_of :password, :if => :password_required?
  validates_presence_of :email
  validates_format_of :email, :with => %r{.+@.+\..+}
  validates_uniqueness_of :email, :case_sensitive => false
  before_save :initialize_salt, :encrypt_password
  
  def generate_hash(string)
    Digest::SHA1.hexdigest(string)
  end
  
  def initialize_salt
    if new_record?
      self.salt = generate_hash("--#{Time.now.utc}--#{password}--")
    end
  end
  
  def remember_me!
    self.remember_token = encrypt("--#{Time.now.utc}--#{password}--#{id}--")
    save(false)
  end
  
  def authenticated?(password)
    encrypted_password == encrypt(password)
  end
  
  def encrypt(string)
    generate_hash("--#{salt}--#{string}--")
  end
  
  def encrypt_password
    return if password.blank?
    self.encrypted_password = encrypt(password)
  end
  
  def password_required?
    encrypted_password.blank? || !password.blank?
  end
  
  def self.authenticate(email, password)
    return nil unless user = find_by_email(email)
    return user if user.authenticated?(password)
  end
end