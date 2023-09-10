class ActiveTagRelation < ApplicationRecord
  belongs_to :active
  belongs_to :tag
end
