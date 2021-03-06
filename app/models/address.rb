class Address < ActiveRecord::Base
  belongs_to :customer
  belongs_to :user
  belongs_to :city

  validates :street, presence: true

  def to_s
    %(#{street}, #{city})
  end
end
