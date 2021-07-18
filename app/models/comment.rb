class Comment < ApplicationRecord
  include ActionView::RecordIdentifier
  belongs_to :project
  # after_create_commit { broadcast_prepend_to [project, :comments], target: "#{dom_id(project)}_comments" }
  # or after_create_commit { broadcast_prepend_to [project, :comments], target: "project_#{project.id}_comments" }

  after_create_commit { broadcast_prepend_to [project, :comments], target: "#{dom_id(project)}_comments" }
  after_update_commit { broadcast_replace_to [project, :comments], target: "#{dom_id(project)}_comments" }
  after_destroy_commit { broadcast_remove_to [project, :comments], target: "#{dom_id(project)}_comments" }
end
