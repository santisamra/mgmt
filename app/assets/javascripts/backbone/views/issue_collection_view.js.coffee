class IssueView extends Backbone.View

  events:
    "click .js-edit": "edit"

  initialize: (options) ->
    @number = @$el.data('number')
    @status = @$el.data('status')
    @type = @$el.data('type')

  render: ->
    @$('.js-issue-title').html(@model.title)
    @$('.js-issue-link').attr('href', @model.html_url)
    @$('.js-timeago').timeago()

  edit: (event) ->
    alert("EDIT ME!")

class IssueCollectionView extends Backbone.View

  render: ->
    for issue in @model
      issueView = new IssueView 
        el: @$("[data-number=#{issue.number}]")
        model: issue
      issueView.render()

# Exports

window.Mgmt.Views.IssueView = IssueView
window.Mgmt.Views.IssueCollectionView = IssueCollectionView