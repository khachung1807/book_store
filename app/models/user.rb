class User < ApplicationRecord
  enum user_type: {customer: 0, employee: 1, admin: 2}
  enum gender: {male: 1, female: 2, trans: 3}
  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :employees

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  attr_reader :activation_token, :remember_token, :reset_token
  before_create :create_activation_digest
  before_save :email_downcase
  has_secure_password

  validates :name, presence: true,
    length: {maximum: Settings.name_max_length}
  validates :gender,  presence: true, inclusion: {in: genders.keys}
  validates :birthday, presence: true,
    inclusion: {in: (Date.today - 100.years..Date.today)}
  validates :address, presence: true,
    length: {maximum: Settings.address_max_length}
  validates :phone_number, presence: true,
    length: {in:
      Settings.phone_number_min_length..Settings.phone_number_max_length}
  validates :email, presence: true,
    length: {maximum: Settings.email_max_length},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, allow_nil: true,
    length: {minimum: Settings.password_min_length}

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password? token
  end

  def activated
    update_columns activated: true, activated_at: Time.zone.now
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def remember
    @remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def forget
    update_attributes remember_digest: nil
  end

  def create_reset_digest
    @reset_token = User.new_token
    update_attributes reset_digest:  User.digest(reset_token)
    update_attributes reset_sent_at: Time.zone.now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < Settings.reset_password_time.hours.ago
  end
  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end

    def gender_attributes_for_select
      genders.map do |gender, _|
        [I18n.t(
          "activerecord.attributes.#{model_name.i18n_key}.genders.#{gender}"
        ), gender]
      end
    end
  end

  private

  def email_downcase
    email.downcase!
  end

  def create_activation_digest
    @activation_token = User.new_token
    self.activation_digest = User.digest activation_token
  end
end
