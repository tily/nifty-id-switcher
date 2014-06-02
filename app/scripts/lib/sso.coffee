'use strict'

window.Sso = class Sso
  loginUrl: 'https://sso.nifty.com/pub/login.cgi'
  logoutUrl: 'https://sso.nifty.com/pub/logout.cgi'
  service: 'top'
  back: 'https://www.nifty.com/niftop/cgi-bin/middle/redirect.cgi'
  csrfRegexp: /<input type="hidden" name="csrf" value="(.+)" \/>/
  whoamiRegexp: /"lgnid"\:"(.+?)"/

  whoAmI: (callback)->
    console.log "whoami"
    ajax = $.ajax
      url: "https://www.nifty.com/niftop/cgi-bin/low/sso_get_mailinfo_201211"
      dataType: "html"
    ajax.done (data)=>
      match = data.match @whoamiRegexp
      if match
        username = match[1]
        username = null if username == "(null)"
      else
        username = null
      callback(username)

  switchTo: (username, password, callback)->
    @username = username
    @password = password
    $.when(@logout())
     .then(@prepareLogin, @error)
     .then(@login, @error)
     .then(callback, @error)

  logout: ()=>
    console.log 'logout'
    $.ajax
      type: 'GET'
      url: @logoutUrl

  prepareLogin: (data)=>
    console.log 'prepareLogin'
    $.ajax
      type: 'GET'
      url: @loginUrl
      dataType: 'html'
      data:
        service: @service
        back: @back
        am: '1.2.0'

  login: (data)=>
    console.log 'login'
    match = data.match @csrfRegexp
    if match
      csrf = match[1]
      console.log 'csrf:', csrf
      $.ajax
        type: 'POST'
        url: @loginUrl
        dataType: 'html'
        data:
          service: @service
          back: @back
          csrf: csrf
          input_selector: 1
          op: 'login'
          password: @password
          username: @username
    else
      console.log "error" 

  error: (err)->
    console.log 'error', err

  logined: (err)->
    console.log 'logined', err
