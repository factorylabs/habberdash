# Controller Additions
#----------------------------------------------------------------------------------------------------/
Spine.Controller.include
  view: (name, options = {}) ->
    JST["habberdash/views/#{name}"](options)

  trace: ->
    return unless App.debugMode && window.console && window.console.log
    try console.log(arguments)
    catch e

  displayErrors: (form, errors) ->
    form.find('.error, .warning').removeClass('error warning')
    form.find('span.help-inline').remove()
    for name, msg of errors
      form.find("[name=#{name}]").
      after("<span class='help-inline'>#{msg}.</span>").
      closest('.control-group').
      addClass('error')
    @resize?()

# Valdatable Model -- Inherit from this if you want validation helper methods.
#----------------------------------------------------------------------------------------------------/
class Spine.ValidatableModel extends Spine.Model

  constructor: ->
    super
    @errors = {length: 0, attributes: {}}


  validate: ->
    return @errors.attributes if @errors.length


  addError: (attr, msg) ->
    if @errors.attributes[attr]
      if @errors.attributes[attr].indexOf(msg) == -1
        @errors.attributes[attr].push(msg)
        @errors.length += 1
    else
      @errors.attributes[attr] = [msg]
      @errors.length += 1
