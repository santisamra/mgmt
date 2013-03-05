# Imports

Issue = window.Mgmt.Models.Issue

class IssueView extends Backbone.View

  events:
    "click .js-edit"    : "edit"
    "click .js-save"    : "save"
    "click .js-cancel"  : "cancel"

  initialize: (options) ->
    @project = options.project
    @id = @$el.data('id')
    @number = @$el.data('number')
    @status = @$el.data('status')
    @type = @$el.data('type')

  createIssue: (estimatedHours, workedHours) =>
    issue = new Issue
      estimated_hours: estimatedHours
      worked_hours: workedHours
    issue.project = @project
    issue.id = @id
    issue

  # Event Handlers

  edit: (event) ->
    event.preventDefault()
    @setEditControlsMode(true)

  save: (event) ->
    event.preventDefault()
    @setEditControlsMode(false)
    
    estimatedHours = @$('.js-edit-eh').val()
    workedHours = @$('.js-edit-wh').val()
    @$('.js-eh').html(estimatedHours)
    @$('.js-wh').html(workedHours)

    issue = @createIssue(estimatedHours, workedHours)
    issue.save null, error: @onSaveError


  cancel: (event) ->
    event.preventDefault()
    @setEditControlsMode(false)

    @$('.js-edit-eh').val(@$('.js-eh').html())
    @$('.js-edit-wh').val(@$('.js-wh').html())

  # Callbacks

  onSaveError: (model, xhr, options) =>
    alert("There was an error!")


  # View Methods

  render: ->
    title = @model.title
    @$('.js-issue-title').attr("title", title)
    title = title.substring(0, 48) + " ..." if title.length > 49
    @$('.js-issue-title').html(title)
    @$('.js-issue-link').attr('href', @model.html_url)
    @$('.js-timeago').timeago()

  setEditControlsMode: (edit) ->
    @$(".js-edit-eh")[if edit then 'show' else 'hide']()
    @$(".js-edit-wh")[if edit then 'show' else 'hide']()
    @$(".js-save")[if edit then 'show' else 'hide']()
    @$(".js-cancel")[if edit then 'show' else 'hide']()
    @$(".js-eh")[if edit then 'hide' else 'show']()
    @$(".js-wh")[if edit then 'hide' else 'show']()
    @$(".js-edit")[if edit then 'hide' else 'show']()

class IssueCollectionView extends Backbone.View

  initialize: (options) ->
    @project = options.project

  render: ->
    for issue in @model
      issueView = new IssueView 
        project: @project
        el: @$("[data-number=#{issue.number}]")
        model: issue
      issueView.render()

# Exports

window.Mgmt.Views.IssueView = IssueView
window.Mgmt.Views.IssueCollectionView = IssueCollectionView