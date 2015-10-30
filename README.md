# Open To-do API

Open To-do API is an externally usable API for a basic to-do list application. This API will allow users to modify user accounts and to-do items from the command line.

This app powers Open To-do API at *coming soon*

## Getting Started

## Software requirements

- Rails 4.2.4

- Ruby 2.2.3

- PostgreSQL 9.3.x or higher

## Navigate to the Rails application

```
$ cd ~/bloc/open-to-do-api
```

## Set configuration files

```
$ cp config/database.yml.template config/database.yml
$ cp config/initializers/mail.rb.template config/initializers/mail.rb
```

## Create the database

```
$ pgstart
$ rake db:create
```

## Migrating and seeding the database

```
$ rake db:migrate
$ rake db:seed
```

## Starting the local server

```
$ rails server

    or

$ rails s
```

## Production Deployment

```
$ git push heroku master
$ heroku run rake db:migrate
```

## Support

Bug reports and feature requests can be filed with the rest for the Ruby on Rails project here:
* [File Bug Reports and Features](https://github.com/yamuda9/open-to-do-api/issues)

## License

Open To-do API is released under the *LICENSE-NAME* license.

## Copyright

copyright:: (c) Copyright 2015 Open To-do API. All Rights Reserved.
