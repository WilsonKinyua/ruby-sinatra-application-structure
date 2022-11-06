# Sinatra Application Structure


## Setup

Run these commands to install the dependencies and start the server:

```console
$ bundle install
$ bundle exec rake server (will start the server on port 8000 by default 😃)
```


## Separation of Concerns with File Structure

So far, we've been setting up the file structure for our application in a way
that nicely [**separates the concerns**][soc] of our code. Each folder, and each file
within that folder, has a clearly defined responsibility. Let's review:

- `app/models`: Our Active Record models. Responsible for code that accesses and
  updates data in our database using classes that inherit from
  `ActiveRecord::Base`.
- `config`: Code in this folder is responsible for our environment setup, like
  requiring files/gems, and establishing a connection to the database.
- `db/migrate`: Our Active Record migrations. Responsible for creating and
  altering the structure of the database (making new tables, adding columns to
  existing tables, etc).
- `db/seeds.rb`: Lets us easily add sample data to the database.
- `spec`: Our RSpec tests.
- `Gemfile`: Lists all the gems our application depends on.
- `Rakefile`: Code for common tasks that we can easily run from the command
  line, like `rake console`.

By organizing our code this way and clearly separating out the different parts
of the application, it becomes much easier for us and other developers to know
where to add new code when it's time to build onto or modify our app.

> **Note**: This file structure also closely mirrors the structure of a typical
> Rails application, as you'll see in the next phase!


## Resources

- [Separation of concerns][soc]
- [Model-View-Controller pattern][mvc]
- [Rerun gem][rerun]

[soc]: https://en.wikipedia.org/wiki/Separation_of_concerns
[rerun]: https://github.com/alexch/rerun
[mvc]: https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller
