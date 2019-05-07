# == Schema Information
#
# Table name: posts
#
#  id        :bigint           not null, primary key
#  title     :string           not null
#  url       :string
#  content   :text
#  sub_id    :integer          not null
#  author_id :integer          not null
#

class Post < ApplicationRecord
    validates :title, :sub_id, :author_id, presence: true
    validates :title, length: {minimum: 1}
    belongs_to :sub,
        primary_key: :id,
        foreign_key: :sub_id,
        class_name: :Sub 
    
    belongs_to :author,
        primary_key: :id,
        foreign_key: :author_id,
        class_name: :User
end
