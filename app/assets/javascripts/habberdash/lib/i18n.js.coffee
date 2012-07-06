Habberdash.extend {
  locale: ->
    return @localization.determined if @localization.determined
    if @localization.enabled
      locale = []
      if navigator.language && (locale = navigator.language.toString().split('-')).length
        topLocale = @I18n[locale[0]] || {}
        subLocale = if locale.length > 1 then topLocale["_#{locale[1].toUpperCase()}_"]
      if !@I18n[locale[0]]
        locale = @localization.preferedLocale
        topLocale = @I18n[locale[0]] || {}
        subLocale = if locale.length > 1 then topLocale["_#{locale[1].toUpperCase()}_"]
    return @determinedLocale = {top: topLocale || {}, sub: subLocale || {}}

  I18n: (sourceString, args...) ->
    locale = @locale()
    translation = (locale.sub[sourceString] || locale.top[sourceString] || sourceString || '').toString()
    return if args.length then translation.printf.apply(translation, args) else translation

  translateHtml: (el) ->
    return unless Habberdash.localization.enabled
    locale = @locale()

    el.find('*').contents().each ->
      translated = false

      if typeof(@data) == 'string'
        source = $.trim(@data)
        @data = translated if source && (translated = (locale.sub[source] || locale.top[source]))

      if @nodeName == 'IMG' && @attributes['src']
        source = @attributes['src'].nodeValue
        $(@).attr('src', translated) if source && (translated = (locale.sub[source] || locale.top[source]))

      if @nodeName == 'INPUT'
        if @attributes['type'] && @attributes['value'] && ['submit', 'reset', 'button'].indexOf(@attributes['type'].nodeValue.toLowerCase()) > -1
          source = $.trim(@attributes['value'].nodeValue)
          $(@).attr('value', translated) if source && (translated = (locale.sub[source] || locale.top[source]))
        if @attributes['placeholder']
          source = $.trim(@attributes['placeholder'].nodeValue)
          $(@).attr('placeholder', translated) if source && (translated = (locale.sub[source] || locale.top[source]))
}
