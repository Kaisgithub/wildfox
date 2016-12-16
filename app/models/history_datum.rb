class HistoryDatum < ActiveRecord::Base
  validates :describe, presence: true

end
