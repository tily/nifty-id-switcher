class OptionsAccountsView extends Backbone.View
  el: $('#account-management')
  template: _.template($('#accounts-template').html())
  events:
    "click #add-account": "addAccount"
    "change #display-password": "displayPassword"

  initialize: (accounts)->
    @accounts = accounts

    @listenTo(@accounts, 'add', @accountAdded)

    @render()
    @accounts.fetch()

  render: ()->
    @$el.html(@template())

  accountAdded: (account)->
    console.log "OptionsAccountsView#AccountAdded"

    view = new OptionsAccountView({model: account})
    console.log view.render().el
    console.log @$("#accounts")
    @$("#accounts").append(view.render().el)

  addAccount: ()->
    console.log "OptionsAccountsView#addAccount"

    @accounts.create
      username: @$("#username").val()
      password: @$("#password").val()
      memo: @$("#memo").val()

    @$("#username").val('')
    @$("#password").val('')
    @$("#memo").val('')

window.OptionsAccountsView = OptionsAccountsView
