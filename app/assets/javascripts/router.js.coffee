# For more information see: http://emberjs.com/guides/routing/

Uyd.Router.map ()->
  @resource 'episodes', ->
    @route 'timestamps'

# Google Analytics
Uyd.Router.reopen(
  notifyGoogleAnalytics: ->
    ga 'send', 'pageview', {
      page: @get('url')
      title: @get('url')
    }.on('didTransition')
)
