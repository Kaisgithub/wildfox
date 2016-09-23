class MessageSerializer < ActiveModel::Serializer
  # attributes :sender_id, :recipient_id, :body
  # attributes :sender, :recipient, :body
  attributes :body
  belongs_to :sender
  belongs_to :recipient
end
