UhhYeahDudeArchive.EpisodeTimestampsNewController = Ember.ObjectController.extend(
  save: ->
    @get('store').commit()
  
  transitionAfterSave: ( ->
  
  ).observes('content.id')
)
