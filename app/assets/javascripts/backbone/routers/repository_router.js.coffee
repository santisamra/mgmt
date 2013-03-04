# Imports

RepositoryCollectionView = window.Mgmt.Views.RepositoryCollectionView
IssueCollectionView = window.Mgmt.Views.IssueCollectionView

class RepositoryRouter extends Backbone.Router

  routes:
    "repositories"        : "index"
    "repositories/:repo"  : "show"

  initialize: ->
    @organization = $("body").data("organization")
    @github = new Github
      auth: "oauth"
      token: $("body").data("token")

  index: -> 
    user = @github.getUser()
    user.orgRepos(@organization, _onOrgRepoReponse)

  show: (repo)->
    issues = @github.getIssues(@organization, repo)
    issues.list({}, _onIssuesResponse)

  # Private methods

  _onOrgRepoReponse = (error, repos) ->
    if error
      alert("There was an error fetching the repositories")
      return
    
    publicRepositories = new RepositoryCollectionView
      el: $('#public-repos')
      privacy: 'public'
      repositories: repos

    privateRepositories = new RepositoryCollectionView
      el: $('#private-repos')
      privacy: 'private'
      repositories: repos

    publicRepositories.render()
    privateRepositories.render()

  _onIssuesResponse = (error, issues) ->
    if error
      alert("There was an error fetching the issues")
      return

    console.log(issues)
    issueCollection = new IssueCollectionView
      model: issues
      el: $("#issues")
    issueCollection.render()

# Exports

window.Mgmt.Routers.RepositoryRouter = RepositoryRouter