module TemplatesPaths
  extend self

  def templates
    Hash[
      Rails.application.assets.each_logical_path.
      select { |file| file.end_with?('html', 'json') }.
      reject { |file| file.end_with?('bower.json', 'package.json', 'composer.json', 'sache.json') }.
      map { |file| [file, ActionController::Base.helpers.asset_path(file)] }
    ]
  end
end
