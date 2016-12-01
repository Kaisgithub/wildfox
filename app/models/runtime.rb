class Runtime < ActiveRecord::Base
  validates :describe, uniqueness: true, presence: true
end
