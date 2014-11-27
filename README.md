Bttendance
=================
Bttendance a is Bluetooth-based attendance check and "Smart TA" application, established 2013/11/01.

## Installation

1. After cloning this repository, run ```bundle install``` to install dependencies.
2. Set the ```DATABASE_URL``` environment variable to your desired Postgres development database URL
3. Run ```rake db:setup``` to setup the database (creates database if doesn't exist and autoruns all migrations).

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

## Developer

#### The Finest Artist
- Email: thefinestartist@bttendance.com

#### Devin Doolin
- Email: icddevin@gmail.com

#### Copyright 2014 @Bttendance Inc.
