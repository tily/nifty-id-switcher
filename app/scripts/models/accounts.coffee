class Accounts extends Backbone.Collection
  model: Account
  localStorage: new Backbone.LocalStorage("Accounts")

window.Accounts = Accounts
