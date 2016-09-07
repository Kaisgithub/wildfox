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

require 'test_helper'

class ComponentStateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
