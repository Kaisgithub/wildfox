# == Schema Information
#
# Table name: modes
#
#  id         :integer          not null, primary key
#  modename   :string
#  kind_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ModeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
