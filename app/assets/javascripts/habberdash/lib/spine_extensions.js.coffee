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
      unless typeof(msg) == 'string'
        length = msg.length
        msg = msg.join(', ').replace(/, ([^,]*)$/, ($1, $2) -> ", and #{$2}")

      form.find("[name=#{name}]").
      after("<span class='help-inline'>#{msg}.</span>").
      closest('.control-group').
      addClass('error')
    @resize?()

  addCss: (options = {}) ->
    sheet = document.styleSheets[0]
    for selector, styles of options
      declarations = []
      declarations.push("#{name.toDash()}:#{value}") for name, value of styles
      console.debug(declarations)
      if sheet.insertRule
        sheet.insertRule("#{selector} {#{declarations.join(' !important;')} !important;}", sheet.cssRules?.length || 0)
      else
        sheet.addRule("#{selector} {#{declarations.join(';')}}", -1)

    console.debug(sheet.rules)

# Model Additions
#----------------------------------------------------------------------------------------------------/
Spine.Model.include
  validate: ->
    @errors = {length: 0, attributes: {}}
    return null

  addError: (attr, msg) ->
    if @errors.attributes[attr]
      if @errors.attributes[attr].indexOf(msg) == -1
        @errors.attributes[attr].push(msg)
        @errors.length += 1
    else
      @errors.attributes[attr] = [msg]
      @errors.length += 1
