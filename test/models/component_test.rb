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

require 'test_helper'

class ComponentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
