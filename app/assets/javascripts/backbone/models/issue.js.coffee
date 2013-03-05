class Issue extends Backbone.Model

  defaults:
    estimated_hours: 0
    worked_hours: 0

  urlRoot: ->
    "/projects/#{@project}/issues"

  initialize: (options)->
    @project = options.project

# Exports

window.Mgmt.Models.Issue = Issue