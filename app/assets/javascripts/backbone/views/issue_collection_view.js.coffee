class IssueView extends Backbone.View

  events:
    "click .js-edit": "edit"

  initialize: (options) ->
    @number = @$el.data('number')
    @status = @$el.data('status')
    @type = @$el.data('type')

  render: ->
    title = @model.title
    @$('.js-issue-title').attr("title", title)
    title = title.substring(0, 48) + " ..." if title.length > 49
    @$('.js-issue-title').html(title)
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