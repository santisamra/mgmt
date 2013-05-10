class ProjectMemberView extends Backbone.View

  userTemplate: JST['backbone/templates/users/user']

  events:
    "submit .js-user-add" : "handleSubmit"

  initialize: (options) ->
    @project = options.project
    @token = @$('.user-delete input[name="authenticity_token"]').val()

  handleSubmit: (event) =>
    event.preventDefault()
    $.post(@project + '/add_user', { user: @$('#add-user-textfield').val()}, @handleAddUserCallback)

  handleAddUserCallback: (data) =>
    @$('#users-list').append(@userTemplate(user: data, project: @project, token: @token))

# Exports
window.Mgmt.Views.ProjectMemberView = ProjectMemberView