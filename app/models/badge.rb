class Badge < ActiveRecord::Base
  attr_accessible :badge, :min_points
  has_many :user_badges, :dependent => :destroy
  has_many :users, :through => :user_badges
end
