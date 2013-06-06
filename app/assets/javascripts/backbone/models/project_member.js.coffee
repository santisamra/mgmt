class ProjectMember extends Backbone.Model
  # defaults:
  #   'login': 'Enter a user name'

  initialize: (options)->
    @github = options.github

# Exports
window.Mgmt.Models.ProjectMember = ProjectMember
