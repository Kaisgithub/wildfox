# == Schema Information
#
# Table name: component_types
#
#  id         :integer          not null, primary key
#  typename   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ComponentType < ActiveRecord::Base
  has_many :components
  has_many :component_states
  validates :typename, presence: true, uniqueness: true
end
