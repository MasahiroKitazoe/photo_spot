class Spot < ActiveRecord::Base 
  has_many :reviews
  belongs_to :prefecture
end