spec_files = [
  "../js/compiled/fixtures.js",
  "../js/compiled/models/arc_spec.js",
  "../js/compiled/models/director_spec.js",
  "../js/compiled/models/grid_spec.js",
  "../js/compiled/models/level_spec.js",
  "../js/compiled/models/map_spec.js",
  "../js/compiled/models/path_spec.js",
  "../js/compiled/models/stage_spec.js",
  "../js/compiled/models/tree_spec.js",
  "../js/compiled/models/wave_spec.js",

  "../js/compiled/models/creeps/creep_spec.js",
  "../js/compiled/models/towers/tower_spec.js",
  "../js/compiled/models/towers/boxer_tower_spec.js",

  "../js/compiled/views/map_view_spec.js",
]
require ["../../nutbuggered/js/compiled/boot.js"], ->
  console.log("App is loaded")
  require spec_files, ->
    console.log("Specs are loaded")
    beforeEach ->
      @addMatchers({
        toEqualAbout: (expected) ->
          fudge = 0.00000000000001
          @message = ->
            "Expected " + expected + " to be about " + @actual
          if Array.isArray(@actual)
            passes = @actual.length == expected.length
            for i in [0...@actual.length]
              a = @actual[i]
              e = expected[i]
              passes &&= (a - fudge) < e < (a + fudge)
          else
            passes = (@actual - fudge) < expected < (@actual + fudge)
          return passes
      })
