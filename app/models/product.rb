class Product < ActiveRecord::Base
  has_many :parts
  belongs_to :machine_type
  belongs_to :brand

  validates :brand_id, :machine_type_id, :product_nbr,
    presence: true
end
