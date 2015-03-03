class Product < ActiveRecord::Base
  validates :title,:description, :price, :image_url, presence: true
  validates_length_of :title, maximum: 10, :message => 'Must be at-least 10 characters long'
  validates :price,numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format:{with: %r{\.(gif|jpg|png)\Z}i, message:'must be a URL for jpg,gif
or png'}
 def self.latest
   Product.order(:updated_at).last
 end



end

