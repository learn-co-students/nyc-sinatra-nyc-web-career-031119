class Landmark < ActiveRecord::Base
  # add relationships here
  belongs_to :figure
  has_many :landmarks
end
