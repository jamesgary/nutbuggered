guard 'livereload', :apply_js_live => false do
  watch(%r{^spec/js/compiled/(.+\.js)$})
  watch(%r{^nutbuggered/js/(.+\.js)$})
end

guard 'coffeescript', {:output => 'nutbuggered/js/compiled', :all_on_start => true} do
  watch(%r{^app/(.+\.coffee)$})
end

guard 'coffeescript', {:output => 'spec/js/compiled', :all_on_start => true} do
  watch(%r{^spec/coffee/(.+\.coffee)$})
end

guard 'sass', :input => 'app/styles', :output => 'nutbuggered/css/compiled', :all_on_start => true
