class Bank < ActiveRecord::Base
  belongs_to :user
  has_many :transactions

  validates :name, presence: true
  validates :account_number, presence: true
  validates :user, presence: true

  mount_uploader :cheque_image, ImageUploader

  scope :enabled, -> { where(status: true) }
end
