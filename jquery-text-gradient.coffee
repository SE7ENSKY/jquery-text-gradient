###
@name jquery-text-gradient
@description Simple linear text gradient plugin for jQuery
@version 2.0.1
@author Se7enSky studio <info@se7ensky.com>
@example <h1 class="text-gradient" data-text-gradient="#000000-#ffffff">Just an example</h1>
###
###! jquery-text-gradient 2.0.1 http://github.com/Se7enSky/jquery-text-gradient###

# "431265" -> [67, 18, 101]
hex2arr = (s) ->
	[
		parseInt(s.substr(0, 2), 16)
		parseInt(s.substr(2, 2), 16)
		parseInt(s.substr(4, 2), 16)
	]
# [67, 18, 101] -> "431265"
arr2hex = (a) ->
	a[0].toString(16) + a[1].toString(16) + a[2].toString(16)

$.fn.textGradient = ->
	$.each @, ->
		# do lettering
		letters = $(@).text().split ''
		# $(@).html """<span>#{letters.join "</span><span>"}</span>"""

		# defaults
		from = [0, 0 ,0]
		to = [255, 255, 255]

		# read config from data-text-gradient attr
		configString = $(@).data 'text-gradient'
		if m = configString.match new RegExp '^#([0-9a-fA-F]{6})-#([0-9a-fA-F]{6})$'
			from = hex2arr m[1]
			to = hex2arr m[2]
		
		# fill with letters
		$(@).empty()
		for i in [0..letters.length-1]
			letter = letters[i]
			color = (from[j] + Math.round (to[j] - from[j]) * (i / letters.length) for j in [0..2])
			$(@).append """<span style="color: ##{arr2hex color}">#{letter}</span>"""

	@

$(".text-gradient").textGradient()