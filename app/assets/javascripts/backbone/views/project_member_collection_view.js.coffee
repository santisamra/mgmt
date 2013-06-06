ProjectMember = window.Mgmt.Models.ProjectMember
ProjectMemberCollection = window.Mgmt.Collections.ProjectMemberCollection

class ProjectMemberView extends Backbone.View

  userTemplate: JST['backbone/templates/users/user']

  events:
    'submit js-user-delete': 'clear'

  initialize: (options) ->
    @project = options.project
    @token = @$('.user-delete input[name="authenticity_token"]').val()
    @listenTo(@model, 'destroy', @clear)

  clear: ->
    @model.destroy


class ProjectMemberCollectionView extends Backbone.View

  events:
    'submit .js-user-add':  'create'

  initialize: (options) ->
    @col = new ProjectMemberCollection(options.project)
    @listenTo(@col, 'add', @add)
    @col.fetch()
    @input = @.$('add-user-textfield')

  create: (e) ->
    e.preventDefault()
    @col.create({login: @input.val})
    @input.val('')

  add: (member) ->
    view = new ProjectMemberView({model: member})
    $(@el).append(view.render().el)

  # handleAddUserCallback: (data) =>
  #   @$('#users-list').append(@userTemplate(user: data, project: @project, token: @token))

# Exports
window.Mgmt.Views.ProjectMemberView = ProjectMemberView
window.Mgmt.Views.ProjectMemberCollectionView = ProjectMemberCollectionView
