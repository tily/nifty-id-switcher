class PopupAccountView extends Backbone.View
  tagName: "tr"
  template: _.template($('#account-template').html())
  events:
    "click .switch" : "switchAccount"

  initialize: ()->
    @sso = new Sso

  render: ()->
    @$el.html @template(@model.toJSON())
    return @

  switchAccount: ()->
    @trigger "switchStart", @model
    console.log "PopupAccountView#destroyAccount"
    @sso.switchTo @model.get("username"), @model.get("password"), (data)=>
      console.log "switch success"
      @trigger "switchEnd", @model

window.PopupAccountView = PopupAccountView
