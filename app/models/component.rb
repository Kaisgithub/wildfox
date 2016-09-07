# == Schema Information
#
# Table name: components
#
#  id                 :integer          not null, primary key
#  component_type_id  :integer
#  component_state_id :integer
#  describe           :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Component < ActiveRecord::Base

  belongs_to :component_type
  belongs_to :component_state
  validates :describe, presence: true, uniqueness: true

end
