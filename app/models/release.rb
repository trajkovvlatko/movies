class Release < ActiveRecord::Base
  attr_accessible :approved, :certification, :confirmed, :country_id, :movie_id, :primary, :release_date
  belongs_to :country
  belongs_to :movie
end
