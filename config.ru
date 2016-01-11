#\ -s puma
require 'rack/rewrite'

REDIRECTS = eval(ENV['REDIRECTS'] || '') || {}

use Rack::Rewrite do
  REDIRECTS.each do |from, to|
    r301 %r{.*}, "https://#{to}$&", if: -> (env) { env['SERVER_NAME'] == from }
  end
end

run -> (env) { [200, {}, []] }
