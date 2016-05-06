[![Code Climate](https://codeclimate.com/repos/5716a784f58374007c000951/badges/e6194632db1d8a1e40bc/gpa.svg)](https://codeclimate.com/repos/5716a784f58374007c000951/feed)
[![Test Coverage](https://codeclimate.com/repos/5716a784f58374007c000951/badges/e6194632db1d8a1e40bc/coverage.svg)](https://codeclimate.com/repos/5716a784f58374007c000951/coverage)
[![Issue Count](https://codeclimate.com/repos/5716a784f58374007c000951/badges/e6194632db1d8a1e40bc/issue_count.svg)](https://codeclimate.com/repos/5716a784f58374007c000951/feed)

# Pager API

![Pager](http://iplp.com/pagers/images/448/Gold+Alphanumeric+Pager+-+2871+-+3+-+400.jpg)

API Pagination done right. Pager API is a library to help you add `meta` information and the adecuate header with pagination information based on the [JSON API standard](http://jsonapi.org) for your Rails app.

## Table of contents
- [Quick start](#quick-start)
- [Configuration](#configuration)
- [Usage](#usage)
- [Bug tracker & feature request](#bug-tracker-&-feature-request)
- [Documentation or Installation instructions](#documentation)
- [Contributing](#contributing)
- [Community](#community)
- [Heroes](#heroes)
- [License](#license)


## Quick Start

`pager_api` depends on [Kaminari](https://github.com/amatsuda/kaminari) or [WillPaginate](https://github.com/mislav/will_paginate) to handle pagination. You need to add one of these gems to your Gemfile **before** the `pager_api` gem:

```ruby
# gem 'will_paginate'
# gem 'kaminari'
gem 'pager_api'
```

And then execute:

```console
% bundle
```

## Configuration

**This step is totally optional**

The gem comes with an installer for you to configure it, for example to switch between pagination handlers or whether or not to include the `Link` header or meta information. To install it you just need to run:

```console
% rails g pager_api:install
```

This will create a file under the `initializers` directory called `pager_api.rb`. You can easily configure it there to meet your needs.

By default `pager_api` uses [Kaminari](https://github.com/amatsuda/kaminari). Configure the `pager_api.rb` initializer in order to use [WillPaginate](https://github.com/mislav/will_paginate).

## Usage

In the controller where you are providing a paginated collection, you may have something like this:

```ruby
class UsersController < ApplicationController

	def index
		users = User.page(params[:page]).per(15)
		render json: users, meta: { pagination: { 
											per_page: 15,
											total_pages: 10,
											total_objects: 150
										} }
	end
end
```

With `pager_api` it is really easy to achieve the above by:

```ruby
class UsersController < ApplicationController

	def index
	   # You can have any scope for the User class in this case
	   # You can even send the paginated collection
		paginate User.unscoped, per_page: 15 
	end
end
```

This will output a json object like:

```json
{
    "users": [
    	...
    ],
    "meta": {
        "pagination": {
            "per_page": 15,
            "total_pages": 1,
            "total_objects": 15,
            "links": {
                "first": "/api/users?page=1",
                "last": "/api/users?page=1"
            }
        }
    }
}
```

As you can see, the pagination metadata also includes the links information for the `first` and `last` page, but it will also create the `next` and the `prev` keys when necessary.

By default it will also include a `Link` header with the following information:

```
# Link: <http://example.com/api/v1/users?page="2">; rel="next",
# <http://example.com/api/v1//users?page="5">; rel="last",
# <http://example.com/api/v1//users?page="1">; rel="first",
# <http://example.com/api/v1/users?page="1">; rel="prev",
```

The header will be created with the corresponding `first`, `last`, `prev` and `next` links.

## Bug tracker & feature request

Have a bug or a feature request? [Please open a new issue](https://github.com/IcaliaLabs/pager-api/issues). Before opening any issue, please search for existing issues.

## Contributing

Please submit all pull requests against a separate branch. Although `pager_api` does not have tests yet, be a nice guy and add some for your feature. We'll be working hard to add them too.

In case you are wondering what to attack, we have a milestone with the version to work, some fixes and refactors. Feel free to start one.

Thanks!

## Heroes

**Abraham Kuri**

+ [http://twitter.com/kurenn](http://twitter.com/kurenn)
+ [http://github.com/kurenn](http://github.com/kurenn)
+ [http://klout.com/#/kurenn](http://klout.com/#/kurenn)

## License

Code and documentation copyright 2015 Icalia Labs. Code released under [the MIT license](LICENSE).
