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
    validates :moderator_id, null: false
    validates :title, length: {minimum: 1}
    belongs_to :moderator,
        primary_key: :id,
        foreign_key: :moderator_id,
        class_name: :User
    has_many :posts,
        primary_key: :id,
        foreign_key: :sub_id,
        class_name: :Post
end
