class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable

  belongs_to :region
  has_many :stores
  has_many :orders

  has_attached_file :id_card_picture
  validates_attachment_content_type :id_card_picture, content_type: /\Aimage\/.*\z/

  has_attached_file :id_card_reverse_picture
  validates_attachment_content_type :id_card_reverse_picture, content_type: /\Aimage\/.*\z/

end
