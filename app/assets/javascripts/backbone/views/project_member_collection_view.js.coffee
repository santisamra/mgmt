ProjectMember = window.Mgmt.Models.ProjectMember
ProjectMemberCollection = window.Mgmt.Collections.ProjectMemberCollection

class ProjectMemberView extends Backbone.View

  events:
    "click .js-user-delete": "clear"

  initialize: (options) ->
    @project = options.project
    @model = new ProjectMember(github: @model, project: @project)
    @token = @$('.user-delete input[name="authenticity_token"]').val()
    # @listenTo(@model, 'destroy', @clear)

  clear: ->
    debugger
    console.log("Deleting model")
    console.log(@model.attributes)
    @model.destroy()
    @$el.hide()

class ProjectMemberCollectionView extends Backbone.View

  userTemplate: JST['backbone/templates/users/user']

  events:
    'submit .js-user-add':  'create'

  initialize: (options) ->
    @project = options.project
    self = @
    @col = new ProjectMemberCollection(options.project)
    @col.fetch success: (collection)-> 
      for member in collection.models
        self.add(new ProjectMember(member))

  create: (e) ->
    e.preventDefault()
    @input = $('#add-user-textfield').val()
    @col.create({login: @input}) 

  add: (member) ->
    debugger
    view = new ProjectMemberView({model: member, project: @project, el: @$("[data-member-name=#{member.attributes.login}]")})
    $(@el).append(view.render().el)

  # render: ->
  #   for member in @model
  #     projectMemberView = new ProjectMemberView
  #       project: @project
  #       model: member
  #       el: @$("[data-member-name=#{member.login}]")
  #     projectMemberView.render()

# Exports
window.Mgmt.Views.ProjectMemberView = ProjectMemberView
window.Mgmt.Views.ProjectMemberCollectionView = ProjectMemberCollectionView
