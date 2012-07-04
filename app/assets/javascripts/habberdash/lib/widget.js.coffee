class Habberdash.Widget extends Spine.Controller

  @specification: (spec) ->
    @spec = spec


  @addDependency: (name, source) ->
    console.debug('addDependency', name, source)


  constructor: ->
    super

