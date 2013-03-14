# Imports

ProjectCollectionView = window.Mgmt.Views.ProjectCollectionView
IssueCollectionView = window.Mgmt.Views.IssueCollectionView

class ProjectRouter extends Backbone.Router

  routes:
    "projects"            : "index"
    "projects/:project"   : "show"

  initialize: ->
    @organization = $("body").data("organization")
    @github = new Github
      auth: "oauth"
      token: $("body").data("token")

  index: -> 
    user = @github.getUser()
    user.orgRepos(@organization, @_onOrgRepoReponse)

  show: (project)->
    @project = project
    issues = @github.getIssues(@organization, @project)
    issues.list({}, @_onIssuesResponse)

  # Private methods

  _onOrgRepoReponse: (error, projects) =>
    if error
      Backbone.trigger('alert:message',
        message: "There was an error fetching the projects repositories from github"
      )
      return
    
    publicProjects = new ProjectCollectionView
      el: $('#public-projects')
      privacy: 'public'
      projects: projects

    privateProjects = new ProjectCollectionView
      el: $('#private-projects')
      privacy: 'private'
      projects: projects

    publicProjects.render()
    privateProjects.render()

  _onIssuesResponse: (error, issues) =>
    if error
      Backbone.trigger('alert:message',
        message: "There was an error fetching the issues"
      )
      return

    issueCollection = new IssueCollectionView
      project: @project
      model: issues
      el: $("#issues")
    issueCollection.render()

# Exports

window.Mgmt.Routers.ProjectRouter = ProjectRouter