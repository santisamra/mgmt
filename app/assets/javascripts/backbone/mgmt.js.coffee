#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./views
#= require_tree ./routers

window.Mgmt =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}

$ ->
  new Mgmt.Views.AlertView(el: '.js-alert')
  new Mgmt.Routers.ProjectRouter()
  Backbone.history.start(pushState: true)
