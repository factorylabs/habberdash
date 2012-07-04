class Habberdash.Dashboard extends Spine.ValidatableModel
  @configure 'Dashboard', 'title', 'color', 'image', 'backgroundType'
  @belongsTo 'configuration', 'Habberdash.Configuration'

  @defaults:
    color: '#222'
    image: '/assets/backgrounds/standard-dark.jpg'
    backgroundType: 'center-scale' # tile, center, scale


  constructor: ->
    super


  validate: ->
    @addError('title', "Can't be blank") unless @title

    @addError('color', "Can't be blank") unless @color
    @addError('color', 'Is malformed') unless /^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/i.test(@color)

    @addError('image', 'URL is malformed') unless /((http|https):\/)?\/?([\w-]+\.)+[\w-]+(\/[\w- .\/?%&=]*)?/i.test(@image)
    super
