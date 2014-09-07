UhhYeahDudeArchive.EpisodesRoute = Ember.Route.extend
  model: ->
    episodes = []
    Ember.$.getJSON 'http://33.33.33.6:3000/episodes.json', (episodes) ->
      console.log episodes
