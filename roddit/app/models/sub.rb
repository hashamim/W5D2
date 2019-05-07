# == Schema Information
#
# Table name: subs
#
#  id           :bigint           not null, primary key
#  title        :string           not null
#  description  :string
#  moderator_id :integer          not null
#

class Sub < ApplicationRecord
    validates :title, :moderator_id, null: false
    belongs_to :moderator,
        primary_key: :id,
        foreign_key: :moderator_id,
        class_name: :User
end
