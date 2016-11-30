# Haml has a so called 'ugly' rendering mode, which renders HTML with no
# indentation. Ugly rendering is on by default in production environments and
# off in development. The truth is, you don't really need nice HTML indentation
# in development mode: both Safari and Chrome Web inspectors will indent HTML
# for you automatically. Therefore the only thing you are likely to notice
# after turning ugly rendering on is faster HTML rendering speed!
# https://coderwall.com/p/tashig/why-you-should-start-using-haml-s-ugly-mode-in-development-today
Haml::Template.options[:ugly] = true
