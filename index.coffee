HerokuSecure =
  register: (plugin, options, next) ->
    plugin.ext('onRequest', (request, next) ->
      if request.headers['x-forwarded-proto'] != 'https'
        next({error: 'must use https'}).code(400)
      else
        next()
    )

    next()

HerokuSecure.register.attributes =
  name: 'hapi-heroku-https'
  version: '0.0.1'


#AMD
if (typeof define != 'undefined' && define.amd)
  define([], -> return HerokuSecure)
#Node
else if (typeof module != 'undefined' && module.exports)
    module.exports = HerokuSecure;