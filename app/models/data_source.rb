class DataSource < ActiveRecord::Base
  validates :name, uniqueness: true, presence: true
  has_many :DataNode
end
