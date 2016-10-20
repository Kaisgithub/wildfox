# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  sender_id    :integer
#  recipient_id :integer
#  body         :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Message < ActiveRecord::Base
  belongs_to :recipient, class_name: 'User', inverse_of: :received_messages
  belongs_to :sender, class_name: 'User', inverse_of: :sent_messages
end
