class Comment < ApplicationRecord
  include ActionView::RecordIdentifier
  belongs_to :project
  after_create_commit { boardcast_prepend_to [project, :comments], target: "#{dom_id(@project)}_comments" }
  # or after_create_commit { broadcast_prepend_to [project, :comments], target: "project_#{project.id}_comments" }
end
