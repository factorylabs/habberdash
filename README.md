# Habberdash

The most best and awesomest open source dashboard framework/system ever.  Srsly!


## The Story

A while back our team purchased some nice big displays and mounted them on a wall near our work spaces.  This was
awesome, because now we could put up all our sweet ass metrics that show how nerdy and amazing we are.  Mostly things
like the status of our projects, and visuals that can help us track our development progress on ongoing projects.

But when we started to look into the options available we were a little less than impressed.  Many dashboard services
are fairly expensive, and none had the ability to allow us to write the type of widgets that we wanted to.  To top it
off, there wasn't any that looked good.  Bummer!  So, we decided to write our own kick ass dashboard, and so Habberdash
was born.


## Installation

Put the gem in your Gemfile, and require the adapter that's appropriate.

    gem 'habberdash', require: 'habberdash/active_record'

The gem comes with three adapters, and you can require the one you need directly in your Gemfile.  The one's we've
provided should cover most of your needs, but please feel free to contribute others if you need something else.

- Active Record (`habberdash/active_record`)
- Mongoid (`habberdash/mongoid`)
- Redis (`habberdash/redis`)

Run the install generator (if you're using Active Record this is required):

    rails generate habberdash:install

This generator adds a route to mount Habberdash in your application, which can be changed if you want it namespaced,


## Usage

Once you've installed Habberdash into your application, you can access it (by default) at `/habberdash`.  The default
dashboards will be available initially, and you can create your own, or modify the default dashboards.  The number of
dashboards is not limited.

Then start putting widgets into your dashboards.. Pretty simple, right?  Ok, so now you want a custom widget.. Of course
you do, and that's why we wrote Habberdash.  You'll see that we provide you with some useful widgets, but the Habberdash
Project is really about providing a framework that you can easily build your own awesome widgets for.

A widget is really just a definition for a bit of code that is comprised of three parts, and are more or less relevant
in this order:

1. The widget specification.
2. The widget view.
3. The widget endpoint (or data source).

### The Widget Specification

When you define a widget you'll need to specify it's properties and options.  These are used to generate information
about the widget in lists, and to build the forms that collects the configuration for a given widget instance.  It reads
a lot like a gemspec with some additional information.

### The Widget View

For a widget to work, it must have a view.  We'll get into the details of this more, but for now, just consider this
some html.  The view (in simple terms) is just a representation of some data into a more human friendly display.

### The Widget Endpoint

An endpoint is really your data source.  This can be many things.  We'll be adding an example endpoint in the gem, and
we will play around with websockets as well, and see if it's worth providing.


## The "Framework"

We've built Habberdash on top of some pretty great frameworks.  There's really no way to build a project like this
without some considerable underlying libraries, and for our own sanity we've chosen Coffeescript and Sass.  We've used
jQuery and Spine to build the basic structure of the dashboard, and inherit from the Spine.Controller for the widgets.

This structure provides the ability to jump out of the Habberdash framework and add to the base Spine application in
whatever ways you want, but also makes it easy to create widgets in a structured way.  We know you may not have some of
these libraries in your project, and that you may disagree with some of them, but we've done everything we can to make
writing your own widgets simple and efficient, while not keeping you locked into a restrictive framework that's overly
complicated or not well documented.

We've included all javascript dependencies as internal javascript dependencies to help mitigate the requirements for
you, while also providing a solid and well documented structure to build on top of.
