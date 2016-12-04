class Order < ApplicationRecord
  belongs_to :user, counter_cache: true
  has_many :order_products
end
