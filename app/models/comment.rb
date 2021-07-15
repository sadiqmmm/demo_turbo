class Comment < ApplicationRecord
  include ActionView::RecordIdentifier

  belongs_to :project
  after_create_commit { broadcast_prepend_to [project, :comments], target: "#{dom_id(project)}_comments" }
end
