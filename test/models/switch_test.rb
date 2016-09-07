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

require 'test_helper'

class SwitchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
