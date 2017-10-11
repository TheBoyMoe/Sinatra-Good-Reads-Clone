require './config/environment'
require './config/local_env'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

# enable patch, delete rest methods
use Rack::MethodOverride

use SearchController
use SessionsController
use BooksController
use ReviewsController
use ShelvesController
use UsersController
run ApplicationController
