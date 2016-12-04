class Store < ApplicationRecord

  belongs_to :user, counter_cache: true
  
  has_attached_file :license_picture
  validates_attachment_content_type :license_picture, content_type: /\Aimage\/.*\z/
end
