class Project < ApplicationRecord
  after_create_commit { broadcast_prepend_to target: 'projects' }
  has_many :comments, dependent: :destroy
end
