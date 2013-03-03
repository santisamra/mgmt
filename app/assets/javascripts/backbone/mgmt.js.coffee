#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Mgmt =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}

$ ->
  new Mgmt.Routers.Repositories()
  Backbone.history.start(pushState: true)