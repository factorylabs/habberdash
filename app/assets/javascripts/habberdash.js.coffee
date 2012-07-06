# jQuery and jQuery UI -- and other plugins
#= require habberdash/dependencies/jquery-1.7.2
#= require habberdash/dependencies/jquery-ui-1.8.21.custom
#= require habberdash/dependencies/jquery_easing
#= require habberdash/dependencies/jquery_serialize_object
#
# Raphael and g.Raphael
#= require habberdash/dependencies/raphael/raphael
#= require habberdash/dependencies/raphael/g_raphael
#= require habberdash/dependencies/raphael/g_bar
#= require habberdash/dependencies/raphael/g_dot
#= require habberdash/dependencies/raphael/g_line
#= require habberdash/dependencies/raphael/g_pie
#
# Audio playback
#= require habberdash/dependencies/buzz.js
#
# Bootstrap (only tooltip)
#= require habberdash/dependencies/bootstrap
#
# Hotkeys
#= require habberdash/dependencies/mousetrap
#
# Filtering
#= require habberdash/dependencies/liquidmetal
#
# Spine
#= require habberdash/dependencies/spine
#= require habberdash/dependencies/spine/ajax
#= require habberdash/dependencies/spine/route
#= require habberdash/dependencies/spine/relation
#= require habberdash/dependencies/spine/touch
#
# HamlCoffee view helpers -- which may be removed
#= require habberdash/dependencies/hamlcoffee
#
# Native extensions (string methods)
#= require habberdash/dependencies/native_extensions
#
# Habberdash
#= require habberdash/habberdash
#
# require your own widgets here
#= require_tree ./habberdash/widgets
#
jQuery -> new Habberdash({el: $('#dashboard')})
