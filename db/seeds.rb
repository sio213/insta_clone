require './db/seeds/users'
require './db/seeds/posts'

# 一括でseedsディレクトリ配下のRubyファイルを全て実行する
Dir[File.expand_path('./db/seeds/**/*.rb')].each do |file|
  require file
end
