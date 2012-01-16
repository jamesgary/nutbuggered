guard 'coffeescript', :output => 'nutbuggered/js/compiled' do
  watch(%r{^app/(.+\.coffee)$})
end

guard 'coffeescript', :output => 'spec/js/compiled' do
  watch(%r{^spec/coffee/(.+\.coffee)$})
end

guard 'livereload', :apply_js_live => false do
  watch(%r{^spec/javascripts/compiled/(.+\.js)$})
  watch(%r{^nutbuggered/js/(.+\.js)$})
end
