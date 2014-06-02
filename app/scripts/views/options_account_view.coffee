class OptionsAccountView extends Backbone.View
  tagName: "tr"
  template: _.template($('#account-template').html())
  events:
    "click .destroy" : "destroyAccount"

  initialize: ()->
    @listenTo(this.model, 'destroy', @accountDestroyed)

  render: ()->
    @$el.html @template(@model.toJSON())
    return @

  destroyAccount: ()->
    console.log "OptionsAccountView#destroyAccount"
    @model.destroy
     success: ()->
       console.log "destroy success!"

  accountDestroyed: ()->
    console.log "OptionsAccountView#accountDestroyed"
    @remove()

window.OptionsAccountView = OptionsAccountView
