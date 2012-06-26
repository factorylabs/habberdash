Evergreen.require '/assets/habberdash/dependencies/jquery-1.7.2.js'
Evergreen.require '/assets/habberdash/dependencies/jquery_easing.js'
Evergreen.require '/assets/habberdash/dependencies/spine.js'
Evergreen.require '/assets/habberdash/dependencies/native_extensions.js'
Evergreen.require '/assets/habberdash/dependencies/hamlcoffee.js'
Evergreen.require '/assets/habberdash/habberdash.js'

window.testConfiguration = {
  readonly: false
  dashboards: [
    {
      id: 'foo'
      title: 'foo'
      color: '#DDD'
      backgroundColor: '#FFF'
      image: 'standard-light.jpg'
      centerImage: true
      widgets: [
        {
          type: 'twitter'
          title: 'widget1'
          endpoint: '/something/'
        },
        {
          type: 'twitter'
          title: 'widget2'
          endpoint: '/something/'
        },
      ]
    },
    {
      id: 'bar'
      title: 'bar'
      color: '#333'
      backgroundColor: '#111'
      image: 'standard-dark.jpg'
      centerImage: true
      widgets: []
    }
  ]
}
