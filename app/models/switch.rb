# == Schema Information
#
# Table name: switches
#
#  id           :integer          not null, primary key
#  component_id :integer
#  describe     :string
#  state        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Switch < ActiveRecord::Base
  belongs_to :component

end
