# == Schema Information
#
# Table name: component_states
#
#  id                :integer          not null, primary key
#  component_type_id :integer
#  state             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class ComponentState < ActiveRecord::Base
  belongs_to :component_type
  has_many :components
end
