class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_writer :login
  attr_accessor :skip_password_validation, :skip_email_validation
  validate :validate_name
  validate :password_complexity, unless: :skip_password_validation
  validates :name, presence: true
  validates :email, presence: true, allow_blank: false
  validates :email, format: { with: /\A[a-zA-Z0-9.!#$%&'\*\+\/=\?\^\_\`\{\|\}\~-]{1,64}@((?:[-a-z0-9]+\.)+[a-z]{2,})\s*\z/i, message: "Please provide valid email" }
  validates_uniqueness_of :email, unless: :skip_email_validation
  ## Database authenticatable
  field :name,               type: String, default: ""
  field :first_name,         type: String, default: ""
  field :last_name,          type: String, default: ""
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  # field :sign_in_count,      type: Integer, default: 0
  # field :current_sign_in_at, type: Time
  # field :last_sign_in_at,    type: Time
  # field :current_sign_in_ip, type: String
  # field :last_sign_in_ip,    type: String
  
  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      self.any_of({ :name => /^#{::Regexp.escape(login)}$/i}, { :email =>  /^#{::Regexp.escape(login)}$/i }).first
    else
      super
    end
  end

  def validate_name
    if User.where(email: name).exists?
      errors.add(:name, :invalid)
    end
  end

  def password_complexity
    # Regexp extracted from https://stackoverflow.com/questions/19605150/regex-for-password-must-contain-at-least-eight-characters-at-least-one-number-a
    return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,70}$/

    errors.add :password, 'Complexity requirement not met. Length should be atleast 8 characters and include: 1 uppercase, 1 lowercase, 1 digit and 1 special character'
  end

  def login
    @login || self.name || self.email
  end

  protected

  def password_required?
    return false if skip_password_validation
    super
  end
end
