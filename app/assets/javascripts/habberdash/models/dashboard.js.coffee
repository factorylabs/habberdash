class Habberdash.Dashboard extends Spine.Model
  @configure 'Dashboard', 'title', 'color', 'image', 'backgroundType'
  @belongsTo 'configuration', 'Habberdash.Configuration'

  @defaults:
    color: '#444'
    image: '/assets/backgrounds/standard-dark.jpg'
    backgroundType: 'center-scale' # tile, center, scale


  constructor: (attrs = {}) ->
    super($.extend({}, Habberdash.Dashboard.defaults, attrs))


  validate: ->
    super
    @addError('title', "can't be blank") unless @title

    @addError('color', "can't be blank") unless @color
    @addError('color', 'is malformed') unless /^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/i.test(@color)

    @addError('image', 'is malformed') if @image && !/((http|https):\/)?\/?([\w-]+\.)+[\w-]+(\/[\w- .\/?%&=]*)?/i.test(@image)
    return @errors.attributes if @errors.length


  updateAttributes: (attrs, options) ->
    if attrs['id'] && @id && attrs['id'] != @id
      attrs['id'] = attrs['id'].toSlug()
      if Habberdash.Dashboard.findByAttribute('id', attrs['id'])
        delete(attrs.id)
      else
        @changeID(attrs['id'], false)
    super


  widgets: ->
    [
      {
        type: 'demo'
      }
      {
        type: 'example'
        title: 'Something'
      }
    ]
