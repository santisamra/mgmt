class RepositoryCollectionView extends Backbone.View

  # Public Methods

  repoGroupTemplate: JST['backbone/templates/repositories/item_group']
  repoItem: JST['backbone/templates/repositories/item']

  initialize: (options) ->
    this.repositories = options.repositories
    this.privacy = options.privacy

    # DOM Cache
    this.$repoList = this.$('.js-repo-list')

  render: ->
    i = 0
    this.$repoList.html("")
    for repo in this.repositories when this._repoShouldBeListed(repo)
      do (repo) =>
        this.$repoList.append(this.repoGroupTemplate()) if i % 4 is 0
        this.$(".js-repo-group:last").append(this.repoItem(repoName: repo.name))
        i++
    this.$(".js-repo-count").text(i)

  # Private Methods

  _repoShouldBeListed: (repo) ->
    (repo.private and this.privacy is 'private') or (not repo.private and this.privacy is 'public')

# Exports

window.Mgmt.Views.RepositoryCollectionView = RepositoryCollectionView