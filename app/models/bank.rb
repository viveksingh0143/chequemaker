class Bank < ActiveRecord::Base
  belongs_to :user
  
  mount_uploader :cheque_image, ImageUploader
end
