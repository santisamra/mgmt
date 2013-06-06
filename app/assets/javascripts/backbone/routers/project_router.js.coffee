# Imports

ProjectCollectionView = window.Mgmt.Views.ProjectCollectionView
IssueCollectionView = window.Mgmt.Views.IssueCollectionView
ProjectMemberView = window.Mgmt.Views.ProjectMemberView
ProjectMemberCollectionView = window.Mgmt.Views.ProjectMemberCollectionView
MilestoneCollectionView = window.Mgmt.Views.MilestoneCollectionView

class ProjectRouter extends Backbone.Router

  routes:
    "projects"                     : "index"
    "projects/:project"            : "show"
    "projects/:project/settings"   : "settings"

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
    projectMemberCollectionView = new ProjectMemberCollectionView
      el:$('#users')
      project: project
    milestones = @github.getMilestones(@organization, @project)
    milestones.list({}, @_onMilestonesResponse)

  settings: (project)->
    @project = project
    milestones = @github.getMilestones(@organization, @project)
    milestones.list({}, @_onMilestonesResponse)

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

  _onMilestonesResponse: (error, milestones) =>
    if error
      Backbone.trigger('alert:message',
        message: "There was an error fetching the milestones"
      )
      return

    milestoneCollection = new MilestoneCollectionView
      project: @project
      model: milestones
      el: $("#milestones")
    milestoneCollection.render()

# Exports

window.Mgmt.Routers.ProjectRouter = ProjectRouter
