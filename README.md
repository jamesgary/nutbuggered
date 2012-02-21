# What is NutBuggered?

It's a [tower defense](http://en.wikipedia.org/wiki/Tower_defense) game featuring squirrels defending their homeland against swarms of bugs.

Initially for [Pokki's 1up contest](http://www.pokki.com/1up/), but planning to release as a general HTML5 shortly. If you're on Windows, you can try NutBuggered out now: http://www.pokki.com/download/?name=NutBuggered&etag=Pokki_NutBuggered

**Note**: Code style, organization, and odor took a sharp nose dive in the final hours before the contest deadline. You've been warned.

## Development

Run guard to generate all the html, css, and javascript from haml, scss, and coffescript files.

    bundle exec guard

### Instant TDD Feedback

Two helpful techniques that made TDDing this much easier:

* Running guard will also start [LiveReload](https://github.com/mockko/livereload), so when you open your browser to ```nutbuggered/nutbuggered/spec/jasmine/jasmine.html``` for Jasmine, turn on the LiveReload plugin to get automatics refreshes upon saving any coffeescript file.
* I made a desktop notifications reporter for Jasmine, so you never have to leave your terminal to see Jasmine reuslts. Just set chrome://settings/content to accept Notifications from all sites (because I couldn't figure out how to turn it on for just local pages), and you should see notifications everytime ```jasmine.html``` is saved.
