$(document).on 'ready page:load', ->
  $(".wecks-entry.link").on "click", (e) ->
    e.preventDefault()
    $('.wecks-entry.content').toggle()
