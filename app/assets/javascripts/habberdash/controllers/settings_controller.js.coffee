class Habberdash.SettingsController extends Habberdash.Modal

  constructor: ->
    @attributes = {class: 'settings'}
    super({title: 'Settings'})

    @html(@view('settings'), Habberdash.config)
    @show()
