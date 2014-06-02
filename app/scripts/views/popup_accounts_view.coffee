window.PopupAccountsView = class PopupAccountsView extends Backbone.View
  el: $('#account-list')
  template: _.template($('#accounts-template').html())
  events:
    "click #add-account": "addAccount"

  initialize: (accounts)->
    @sso = new Sso
    @sso.whoAmI (username)=>
      if username
        @updateStatus(username + " でログイン中")
      else
        @updateStatus("ログインしていません")

    @accounts = accounts

    @listenTo(@accounts, 'add', @accountAdded)

    @render()
    @accounts.fetch()

  render: ()->
    @$el.html(@template())

  accountAdded: (account)->
    console.log "OptionsAccountsView#AccountAdded"

    view = new PopupAccountView({model: account})

    @listenTo(view, 'switchStart', @switchStarted)
    @listenTo(view, 'switchEnd', @switchEnded)

    console.log view.render().el
    console.log @$("#accounts")
    @$("#accounts").append(view.render().el)

  updateStatus: (text)->
    @$('#status #status-detail').html(text)

  switchStarted: (model)->
    console.log 'switchStart', model
    @$("button").addClass("disabled")
    @updateStatus(model.get('username') + "へ切替中")

  switchEnded: (model)->
    console.log 'switchEnd', model
    @$("button").removeClass("disabled")
    @updateStatus(model.get('username') + "でログイン中")

