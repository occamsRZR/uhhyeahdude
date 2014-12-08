# For more information see: http://emberjs.com/guides/routing/

Uyd.Router.map ()->
  @resource 'episodes', {path: '/episodes'}
  @resource 'episode', {path: '/episode/:episode_slug'}, ->
    @route 'timestamps'
    @route 'player'
    
Uyd.EpisodeRoute = Ember.Route.extend
  model: (params) ->
    jQuery.getJSON("/episodes/" + params.episode_slug)
    #@store.find 'episodes', params.episode_slug
  renderTemplate: ->
    @render {outlet: 'episode'}
