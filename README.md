# Sinatra Application Structure

## Learning Goals

- Understand the typical file structure for a Sinatra application
- Use the Rerun gem to help speed up development

## Introduction

In this lesson, we'll discuss how to use Sinatra and Active Record together,
and how to organize our code in different files to help with our application's
**separation of concerns**.

We'll also see some common gems used to speed up development when working with a
Sinatra application.

## Setup

This lesson has a good amount of starter code already set up for you. The
majority of this code should be familiar — all of it was taken from a previous
Active Record lesson on creating a many-to-many association. For the Active
Record side of things, we have the models, migrations and seed data all set up.
Run these commands to install the dependencies and set up the database:

```console
$ bundle install
$ bundle exec rake db:migrate db:seed
```

> **Note**: Running `rake db:migrate db:seed` on one line will run the
> migrations first, then the seed file. It's a nice way to save a few
> keystrokes!

We'll be working with the models and migrations more in the next lesson. For
now, let's review the project's file structure and talk about how our code is
organized.

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

In the last lesson on Sinatra, we also saw some new code for writing a web
server. How does that code fit in with our current file structure? Let's break
it down a bit. Here's what that web server-specific code looks like in the
`config.ru` file:

```rb
require 'sinatra'

class App < Sinatra::Base

  get '/' do
    '<h2>Hello <em>World</em>!</h2>'
  end

end

run App
```

Where does this code belong? Well, we can leave _some_ of it in the `config.ru`
file so that we'll be able to run our server with `rackup config.ru`. But we can
also organize it a bit better so that we don't end up writing all of our
Sinatra-specific code in one file!

Let's make a new file for the `App` class, called `application_controller.rb`,
and move it to a new folder called `app/controllers` (alongside the `app/models`
folder). Let's also update the class name to `ApplicationController` so it
matches the name of the file:

```rb
# app/controllers/application_controller.rb
class ApplicationController < Sinatra::Base

  get '/' do
    '<h2>Hello <em>World</em>!</h2>'
  end

end
```

Since our `config/environment.rb` file does the work of `require`-ing all our
gems as well as all the files in the `app` folder, we can just require the
`config/environment.rb` file in our `config.ru` file and then run our
`ApplicationController`:

```rb
# config.ru
require_relative "./config/environment"

run ApplicationController
```

Now as our application grows, it's easier to add code to the right place without
having one file grow out of control!

Try running the server with this updated file structure and make sure your
server still works:

```console
$ rackup config.ru
```

You should still be able to visit
[http://localhost:9292/](http://localhost:9292/) and see the HTML response from
the server.

> **Aside**: You may be wondering: What's a controller? Why `ApplicationController`?
>
> The reason for using a `controllers` folder and a class named with
> `Controller` at the end is because of a software pattern known as
> Model-View-Controller, or MVC. We'll cover MVC in more depth in the next
> phase, but essentially, it's a common pattern used by web app developers
> that helps with the separation of concerns of different parts of the
> application:
>
> - Models: responsible for working with the database
> - Views: responsible for what the user sees on the webpage (typically, views are
>   some form of HTML template)
> - Controllers: responsible for receiving a request and using the model to
>   generate data needed for the view
>
> For now, we won't go into too much depth on this subject — just know that MVC
> is a very common pattern in web development, and as long as you stick with
> this file structure, you'll be set up nicely to learn more about MVC down the
> road.

## Running a Development Server

As developers, it's very helpful to be able to make small changes to our code
and see what effect they have with as little friction as possible. Right now,
any time we make a change to the code for our controller, we need to:

- Stop the server with `control + c`
- Re-start the server with `rackup config.ru`

We can simplify this process by using the [Rerun][rerun] Ruby gem, which watches
for changes to our file system and reloads the program (similar to webpack
development server's hot reload feature when working with React applications).

The Rerun gem is already included in the Gemfile, so we can try it out. To
run our server in development mode using Rerun, run this command:

```console
$ bundle exec rerun -b 'rackup config.ru'
```

Then make a request to [http://localhost:9292/](http://localhost:9292/) in the
browser. Just like before, we'll still see the "Hello World!" message. But now
we can make changes to the application and simply refresh the page in the
browser to see those changes, without having to manually restart the server!

Try updating the `ApplicationController` and change the HTML being returned from
the `GET /` route. Then refresh the page in the browser. You should see your new
code reflected in the updated response.

> **Note**: It can take a few moments for `rerun` to fully restart the server.
> Keep an eye on the terminal output to see when the server has been
> successfully restarted.

To make it a bit easier to start the server, we can also make a custom Rake
task. Add this to your `Rakefile`:

```rb
desc "Start the server"
task :server do
  exec "rerun -b 'rackup config.ru'"
end
```

Now we can run the server with this Rake command:

```console
$ bundle exec rake server
```

## Conclusion

We've now built out the core structure of our Sinatra applications. We'll
be introducing one or two more new gems in this section, but for the most
part, this setup is what you'll use for the rest of this phase. The file
structure you've seen here is also similar to what you'll use in the next
phase with Rails, so by building it up gradually over the course of this
phase, you've hopefully gained familiarity with many of these common
conventions.

## Resources

- [Separation of concerns][soc]
- [Model-View-Controller pattern][mvc]
- [Rerun gem][rerun]

[soc]: https://en.wikipedia.org/wiki/Separation_of_concerns
[rerun]: https://github.com/alexch/rerun
[mvc]: https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller
