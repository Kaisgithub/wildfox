class DataNode < ActiveRecord::Base
  validates :name, uniqueness: true, presence: true
  belongs_to :DataSource
  has_many :ControlDatum
  has_many :StateDatum

end
