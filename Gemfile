=begin
Copyright 2014 Michal Papis <mpapis@gmail.com>

See the file LICENSE for copying permission.
=end

#ruby=2.0.0

source "https://rubygems.org"

gemspec

group :development do
  # statistics only on MRI 2.0 - avoid problems on older rubies
  gem "yard",      :platforms => [:mri_20]
  gem "redcarpet", :platforms => [:mri_20]
  gem "simplecov", :platforms => [:mri_20]
  gem "coveralls", :platforms => [:mri_20]
end
