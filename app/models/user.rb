class User < ApplicationRecord
  include PgSearch

  mount_uploader :avatar, PhotoUploader
  after_create :set_email_for_search
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :collections
  has_many :items, through: :collections

  has_many :reminders_others, class_name: 'Reminder'

  has_many :my_reminders, through: :items, source: :reminders

  has_many :networks
  has_many :network_users, through: :networks

  has_one :default_network, -> {where(name: "Tous")}, class_name: 'Network'

  has_many :pending_network_users, -> {where(status: "pending")}, through: :networks, source: :network_users
  has_many :validate_network_users, -> {where(status: nil)}, through: :networks, source: :network_users
  has_many :default_network_users, through: :default_network,  source: :network_users

  has_many :friends, through: :default_network_users, source: :user

  has_many :friend_requests, -> {where(status: "pending")}, class_name: 'NetworkUser'

  pg_search_scope :search_by_email_and_username,
    against: [ :email, :username, :email_for_search ],
    using: { tsearch: { prefix: true } }

  private

  # method avoid to use a bigger search gem, transform "bob.dylan@dividi.fr" in "bob dylan"
  def set_email_for_search
    self.email_for_search = self.email.split('@')[0].split('.').join(' ')
    self.save
  end
end
