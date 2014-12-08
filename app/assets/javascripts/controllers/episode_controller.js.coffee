Uyd.EpisodeIndexController = Ember.ObjectController.extend
  setupController: (controller, episode) ->
    controller.set('model', episode)
