# == Schema Information
#
# Table name: kinds
#
#  id         :integer          not null, primary key
#  kindname   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Kind < ActiveRecord::Base
  has_many :modes
  validates :kindname, presence: true, uniqueness: true
end
