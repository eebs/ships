# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  Morris.Line
    element: 'sold_chart'
    data: $('#sold_chart').data('sold')
    xkey: 'sell_date'
    ykeys: ['archon', 'thanatos']
    labels: ['Archon Price', 'Thanatos Price']
    ymin: '1400000000'