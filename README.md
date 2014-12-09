Bttendance
=================
Bttendance a is "Smart TA" application, established 2013/11/01.

## Installation (OS X)
1. Install [Ruby Version Manager (RVM)](http://rvm.io) with ```\curl -sSL https://get.rvm.io | bash -s stable```
2. Install Ruby 2.1+ with ```rvm install 2.1.5```
3. Install Rails 4.0+ with ```sudo gem install rails -v 4.1.8```
4. Install Postgres with [Homebrew](http://brew.sh)
    $ brew update
    $ brew doctor
    $ brew install postgresql
5. After cloning this repository, run ```bundle install``` to install dependencies.
6.
7. Set the ```DATABASE_URL``` environment variable to your desired Postgres development database URL
8. Run ```rake db:setup``` to setup the database (creates database if doesn't exist and autoruns all migrations).

## Tips
Run ```rake api:routes``` to list the API routes, e.g.
```
GET        /api/v1/users(.:format)
GET        /api/v1/users/:id(.:format)
POST       /api/v1/users(.:format)
PUT        /api/v1/users/:id(.:format)
GET        /api/v1/users/reset(.:format)
POST       /api/v1/users/login(.:format)
GET        /api/v1/schools(.:format)
GET        /api/v1/schools/:id(.:format)
POST       /api/v1/schools(.:format)
GET        /api/v1/courses(.:format)
GET        /api/v1/devices(.:format)
```

## Commands
#### Heroku commands
    // View Heroku instance logs (add --tail option for real-time log streaming to console)
    $ heroku logs —app bttendance-dev
    $ heroku logs —app bttendance

    // Add heroku-accounts plugin and create/set Heroku account automatically
    // Note: "Account nickname" is irrelevant, it can be whatever you want
    $ heroku plugins:install git://github.com/ddollar/heroku-accounts.git
    $ heroku accounts:add <account nickname> --auto
    $ heroku accounts:set <account nickname>


#### Postgres (psql) commands
    // Connect to local Bttendance DB
    $ psql bttendance

    // Connect to a remote DB (prod, dev, etc)
    $ psql <db_url, e.g. postgres://...>
    $ psql "dbname=<database> host=<host> user=<username> password=<password> port=<port> sslmode=require"

    // List databases on current server
    $ \list

    // List tables in currently-selected database
    $ \dt

    // List Postgres users on current machine
    $ \du

    // Describe structure of specific table
    $ \d+ <table name>

    // Describe all data of specific table
    $ SELECT * FROM <table name>;

    // Exit psql prompt
    $ \q

    // Drop all tables (WARNING : DO NOT USE IN PRODUCTION DATABASE SERVER)
    $ drop schema public cascade;
    $ create schema public;

#### Redis (redis-cli) commands
    // Connect to local redis-server instance
    $ redis-cli

    // Connect to a remote redis instance
    $ redis-cli <db_url, e.g. redis://...>
    $ redis-cli -h <host> -p <port> -a <auth password>

    // List all key/value pairs
    $ KEYS *

    // Get value for a specific key
    $ GET <key name>

    // Exit redis cli
    $ CTRL+C

    // Drop all key-values (WARNING : DO NOT USE IN PRODUCTION DATABASE SERVER)
    $ FLUSHALL

## Developer

#### Devin Doolin
- Email: icddevin@gmail.com

#### Hee Hwan Park
- Email: heehwan.park@gmail.com

#### The Finest Artist
- Email: contact@thefinestartist.com

#### Copyright 2015 @Bttendance Inc.
