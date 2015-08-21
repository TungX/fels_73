$(document).on "page:change", ->
  $(".audioButton").click ->
    $(".audio-play")[0].currentTime = 0
    $(".audio-play")[0].play()
