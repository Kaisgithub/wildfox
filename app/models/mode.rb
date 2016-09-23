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

class Mode < ActiveRecord::Base
  belongs_to :kind
  validates :modename, presence: true, uniqueness: true
end
