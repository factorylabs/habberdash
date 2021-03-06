class Habberdash.Widget extends Spine.Controller

  @specification: (spec) ->
    @spec = {
      version:     1
      image:       'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAJYAAAB+BAMAAAA0OPU+AAAABGdBTUEAALGPC/xhBQAAADBQTFRFodLgfcDUcLrP+v3+lMzbsNnlWq/I8vn7iMXXZLTLwuLrTKnD2Ozy5fP3////QaO/f/5WUwAAA51JREFUaN7t2F1IU1EcAHAfknowc32YIOFDIMGiPVhkor4VaaSlOdSlYNBDJo0eLFlmaJCtDCuMItP1oGiYWiBiKlx7UCltliHN0bVyG6txPegYY19yu5v7uFu7u+c/9xT3/7RduD/Ox//c8z8njo5dxAmWYAmWYAmWYAnW/2hZ09teS2NjOVvqvyJTExEL62IuYsIojYFlVSNP6GNg1WxQyLB5yzmAomyX9WR7yJNVL4X6oNaoTpsc/KTZZ70igNZehLLz2C/Zl3zW0TKg5W7FylkWNor8QaWB28WkUq/c/+B2wEJ1MKvD85JuQh6SXJ4wFoKsce9rE6qN/xbEjkyQ5csA3YKY1U5/w9JA+eWftloPlhhkoSlQ3hcgNhbICO86IiAWKwdqVbQtN9gySiAWe+I0RA0KiT6INdQQeFEn2xVqzUOs/ew3s9ShlgFiHUIRg2IG/50S03oa2TLeH27rWRGD5zFsaPuZAe3Fs9ZyEX9gWnQlP2VMxbSq+a3DuHuHXc1rybD3If6GadNxrbUGXmwB1zrIP2DZuFYiv9UVO4tqx7Ve8KaXFHsebTxjn1MEqE2aI0qTSgJgmSNkq046BquZ3ixxWisqaP31hPNjYQLXcjZOKxNsrXL2cQZsWTiHvhXLsorDFXChGS/HsvZlqfjXUSZePaFG7/mzog/XYq0zfyEekl0SPIupLqkTvrG71wDp4j+We+6o0svun1UJHPm1A9PydMuoPbMlvnyaK+kJ3BrTu2dkcG+2U9h1NO9mRqnwa3K+D+oHwLnDPhCRMskhZ5iIu6xOBjqnOSPVJRrgeXuE+4OaJYHeAzznSgjqFPhOwdmCuyXinGG2h13TZVHdm9gTwnSwLMo7GGt+6DdCkRf1fY4zqSeof13izdwNXTg+neFd6DdfKonN3TM5L+0un/30fbZ7WzqGJNzLCZZgBcXjRpHykdyeSj8bvjPSmJJ8QJTSLrrbZBY1EmArnyQ/P2hdnacrqr50kKSmnyTzSFLrIEkZ2Eo6byrtHBw3OOuH9NXFiqJ4dfdOquScy1RhgI+X7Q/tutGZ8/anRU+75pgiUWXWjxGuH9Z6uGVZpm2/thbvOea2mMI5UWI2kouuqw+PRGVZFYor/XMBiyqRunTcBUVEix7QO1BhwPpN0666ysLorIJra0jOWOvePs5Ort9yLUcx9ovMPeGg9SNt09AOpnI+rbJ/u65wzJgXhPUoWIIlWILFHX8Bp2SrBA/jZNkAAAAASUVORK5CYII='
      summary:     'Define this in your spec.'
      authors:     ['Factory Design Labs']
      email:       'is.team@factorylabs.com'
      homepage:    'http://github.com/factory/habberdash'
      description: 'Define this in your spec. This is to describe in further detail what your widget widgets.'
    }
    @spec[propertyName] = value for propertyName, value of spec
    @spec

  constructor: ->
    super

  # Idea for later:
  #@addDependency: (name, source) ->
    #console.debug('addDependency', name, source)
