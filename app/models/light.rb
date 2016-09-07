# == Schema Information
#
# Table name: lights
#
#  id           :integer          not null, primary key
#  component_id :integer
#  describe     :string
#  state        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Light < ActiveRecord::Base
  belongs_to :component
end
