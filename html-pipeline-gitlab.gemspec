# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'html/pipeline/gitlab/version'

Gem::Specification.new do |spec|
  spec.name          = 'html-pipeline-gitlab'
  spec.version       = Html::Pipeline::Gitlab::VERSION
  spec.authors       = ['Robert Schilling']
  spec.email         = ['schilling.ro@gmail.com']
  spec.summary       = %q{Extension filters for html-pipeline used by GitLab}
  spec.description   = %q{Extension filters for html-pipeline used by GitLab}
  spec.homepage      = 'https://github.com/Razer6/html-pipeline-gitlab'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^test/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 10.0'

  spec.add_runtime_dependency 'html-pipeline', '~> 1.11.0'
  spec.add_runtime_dependency 'gitlab_emoji', '~> 0.0.1.1'
  spec.add_runtime_dependency 'sanitize', '~> 2.1'
end
