# Imports
ProjectMember = window.Mgmt.Models.ProjectMember

class ProjectMemberCollection extends Backbone.Collection.extend({
  model: ProjectMember

  url: ->
    "/projects/#{@project}/members"

  initialize: (project) ->
    @project = project
})

window.Mgmt.Collections.ProjectMemberCollection = ProjectMemberCollection
