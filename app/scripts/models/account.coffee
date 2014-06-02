class Account extends Backbone.Model
  localStorage: new Backbone.LocalStorage("Accounts")
  defaults:
    username: ""
    password: ""
    memo: ""

window.Account = Account

