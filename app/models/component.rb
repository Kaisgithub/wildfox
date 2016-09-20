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
require 'bunny'

class Component < ActiveRecord::Base

  belongs_to :component_type
  belongs_to :component_state
  validates :describe, presence: true, uniqueness: true

  after_update do
    conn = Bunny.new(:hostname => "localhost")
    conn.start

    ch   = conn.create_channel
    q    = ch.queue("hello")
    msg  = ARGV.empty? ? describe : ARGV.join(" ")
    q.publish(msg, :persistent => true)
    puts " [x] Sent #{msg}"

    conn.close
  end

end
