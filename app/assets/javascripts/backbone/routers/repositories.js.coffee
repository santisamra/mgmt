Repositories = window.Mgmt.Views.Repositories

window.Mgmt.Routers.Repositories = Backbone.Router.extend
  routes:
    "repositories": "index"

  index: ->
    github = new Github
      auth: "oauth"
      token: $("body").data("token")
  
    user = github.getUser()
    organization = $("body").data("organization")
    user.orgRepos(organization, _onOrgRepoReponse)

  # Private methods

  _onOrgRepoReponse = (error, repos) ->
    if error
      alert("There was an error fetching the repositories")
      return
    
    publicRepositories = new Repositories
      el: $('#public-repos')
      privacy: 'public'
      repositories: repos

    privateRepositories = new Repositories
      el: $('#private-repos')
      privacy: 'private'
      repositories: repos

    publicRepositories.render()
    privateRepositories.render()