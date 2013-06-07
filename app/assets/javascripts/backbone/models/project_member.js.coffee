class ProjectMember extends Backbone.Model
  # defaults:
  #   'login': 'Enter a user name'
  urlRoot: ->
    "/projects/" + @project + "/members"

  initialize: (options)->
    @github = options.github
    @project = options.project

# Exports
window.Mgmt.Models.ProjectMember = ProjectMember
