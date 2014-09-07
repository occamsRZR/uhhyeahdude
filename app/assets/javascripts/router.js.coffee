# For more information see: http://emberjs.com/guides/routing/

UhhYeahDudeArchive.Router.map ()->
  @resource 'episodes', ->
    @route 'episode_timestamps',
      path: ':slug'


UhhYeahDudeArchive.Router.reopen
  notifyGoogleAnalytics: ->
    ga 'send', 'pageview', {
      page: @get 'url'
      title: @get 'url'
    }.on 'didTransition'
  
