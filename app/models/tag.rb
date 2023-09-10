class Tag < ApplicationRecord
    validates :name, presence: true
    has_many :active_tag_relations, dependent: :destroy
    has_many :actives, through: :active_tag_relations, dependent: :destroy
end
