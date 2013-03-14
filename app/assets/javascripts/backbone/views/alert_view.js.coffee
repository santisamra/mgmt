class AlertView extends Backbone.View

  events:
    "click button" : "hideAlert"

  initialize: (options) ->
    @listenTo(Backbone, "alert:message", @displayMessage)

  displayMessage: (options) =>
    @$('.js-title').html(options.title)
    @$('.js-message').html(options.message)
    @$el.show()

  hideAlert: (event) ->
    @$el.hide()

# Export

window.Mgmt.Views.AlertView = AlertView