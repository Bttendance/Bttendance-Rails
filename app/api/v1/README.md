Bttendance API v1
=================

### Base URL for all API routes: ```/api/v1/```

Notes:
* JSON types are validated, so strings should be sent as strings, numbers as
numbers, and so on.
* Most parameters require a root object (user, school, course, etc), so if
something is going wrong that isn't obvious, check that first.
* Include a ```page``` parameter on [paginated](https://github.com/monterail/grape-kaminari)
result sets, e.g. ```?page=1```. By default, paginated results return the first page and typically 10 items.
* You can request more items per page by including a ```per_page``` parameter, e.g. ```?per_page=20```.
* All errors include a standard [HTTP informational status code](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html)
and message detailing the error.

## Table of Contents

* [Users](#users)
* [Schools](#schools)
* [Courses](#courses)
* [Schedules](#schedules)
* [Attendance Alarms](#attendance-alarms)
* [Attendances](#attendances)
* [Clickers](#clickers)
* [Notice](#notices)
* [Curiouses](#curiouses)

## Users

### GET ```/users```

_Returns all users, paginated_

Returns:
```json
[
  {
    "id": 1,
    "name": "Tae-hwan Kim",
    "email": "thefinestartist@bttendance.com",
    "schools_users": [
      {
        "identity": "30729099",
        "state": "supervisor",
        "school": {
          "id": 1,
          "name": "Yonsei University"
        }
      }
    ]
  },
  {
    "id": 2,
    "name": "Devin Doolin",
    "email": "icddevin@bttendance.com",
    "schools_users": []
  }
]
```

### GET ```/users/search?email=:email```

_Returns a single user with ```:email```_

Returns:
```json
{
  "id": 1,
  "name": "Tae-hwan Kim",
  "email": "thefinestartist@bttendance.com",
  "schools_users": [
    {
      "identity": "30729099",
      "state": "supervisor",
      "school": {
        "id": 1,
        "name": "Yonsei University"
      }
    }
  ]
}
```

### GET ```/users/:id```

_Returns a single user with ```:id```_

Returns:
```json
{
  "id": 1,
  "name": "Tae-hwan Kim",
  "email": "thefinestartist@bttendance.com",
  "schools_users": [
    {
      "identity": "30729099",
      "state": "supervisor",
      "school": {
        "id": 1,
        "name": "Yonsei University"
      }
    }
  ]
}
```

### POST ```/users/```

_Registers a user and returns the new user_

Params:
```ruby
requires :user, type: Hash do
  requires :email, type: String, desc: 'Email'
  requires :password, type: String, desc: 'Password'
  requires :name, type: String, desc: 'Name'
  optional :locale, type: String, desc: 'Locale'
  requires :devices_attributes, type: Array do
    requires :platform, type: String, desc: 'Platform'
    optional :uuid, type: String, desc: 'UUID'
    optional :mac_address, type: String, desc: 'MAC Address'
  end
end
```

Notes:
* ```locale``` is 'en' by default.
* Including an array of Devices in ```devices_attributes``` will create a Device for each object, belonging to the new user.

Returns:
```json
{
  "id": 1,
  "name": "Tae-hwan Kim",
  "email": "thefinestartist@bttendance.com"
}
```

### PUT ```/users/:id```

_Updates a user with ```:id``` and returns the updated user object_

Params:
```ruby
requires :user, type: Hash do
  optional :password, type: String, desc: 'Password'
  optional :new_password, type: String, desc: 'New Password'
  optional :email, type: String, desc: 'Email'
  optional :name, type: String, desc: 'Name'
  optional :locale, type: String, desc: 'Locale'
  optional :devices_attributes, type: Array do
    optional :id, type: Integer, desc: 'ID'
    optional :platform, type: String, desc: 'Platform'
    optional :uuid, type: String, desc: 'UUID'
    optional :mac_address, type: String, desc: 'MAC Address'
    optional :notification_key, type: String, desc: 'Notification Key'
    optional :_destroy, type: Boolean, desc: 'Destroy'
  end
  optional :schools_users_attributes, type: Array do
    optional :school_id, type: Integer, desc: 'School ID'
    optional :identity, type: String, desc: 'Identity'
    optional :state, type: String, desc: 'State'
    optional :_destroy, type: Boolean, desc: 'Destroy'
  end
  optional :courses_users_attributes, type: Array do
    optional :course_id, type: Integer, desc: 'Course ID'
    optional :state, type: String, desc: 'State'
    optional :_destroy, type: Boolean, desc: 'Destroy'
  end
end
```

Notes:
* To change the user's password, pass the old password as ```password``` to verify and the new password as ```new_password```.
* You can create Devices the same as user registration, simply don't include an ID in the Device object.
* To delete a Device, pass in the Device ID and pass ```_destroy: true``` in the Device object.
* You can create, update the state, and destroy a user's connection to schools and courses (but not the schools and courses themselves). For example, the following will add the School to the user's schools and update the Course state:
```json
{
    "user": {
      "schools_users_attributes": [
        {
          "school_id": 1,
          "identity": "30729099",
          "state": "supervisor"
        }
      ],
      "courses_users_attributes": [
        {
          "course_id": 1,
          "state": "supervising"
        }
      ]
    }
}
```

Returns:
```json
{
  "id": 1,
  "name": "Tae-hwan Kim",
  "email": "thefinestartist@bttendance.com",
  "schools_users": [
    {
      "identity": "30729099",
      "state": "supervisor",
      "school": {
        "id": 1,
        "name": "Yonsei University"
      }
    }
  ]
}
```

### POST ```/users/reset```

_Sends a password reset email to a user's email address on file_

Params:
```ruby
requires :email, type: 'String', desc: 'Email'
```

Returns:
```
true
```

### POST ```/users/login```

_Validates a user and returns the user object_

Params:
```ruby
requires :email, type: String, desc: 'Email'
requires :password, type: String, desc: 'Password'
requires :devices_attributes, type: Hash do
  requires :platform, type: String, desc: 'Platform'
  optional :uuid, type: String, desc: 'UUID'
  optional :mac_address, type: String, desc: 'MAC Address'
end
```

Returns:
```json
{
  "id": 1,
  "name": "Tae-hwan Kim",
  "email": "thefinestartist@bttendance.com",
  "schools_users": [
    {
      "identity": "30729099",
      "state": "supervisor",
      "school": {
        "id": 1,
        "name": "Yonsei University"
      }
    }
  ]
}
```

### GET ```/users/:id/courses```

_Returns a user with ```:id```'s courses_

Returns:
```json
[
  {
    "id": 1,
    "school_id": 1,
    "name": "Android 101",
    "instructor_name": "Tae-hwan Kim",
    "code": "ANDR101",
    "open": false,
    "start_date": null,
    "end_date": null
  },
  {
    "id": 2,
    "school_id": 1,
    "name": "iOS 101",
    "instructor_name": "Sang-hyun Lee",
    "code": "OBJC101",
    "open": false,
    "start_date": null,
    "end_date": null
  }
]
```

### GET ```/users/:id/preferences```

_Returns a user with ```:id```'s preferences_

Params:
```ruby
requires :preferences, type: Hash do
  optional :clicker, type: Boolean, desc: 'Clicker'
  optional :attendance, type: Boolean, desc: 'Attendance'
  optional :curious, type: Boolean, desc: 'Curious'
  optional :following, type: Boolean, desc: 'Following'
  optional :notice, type: Boolean, desc: 'Notice'
end
```

Returns:
```json
{
  "id": 2,
  "clicker": true,
  "attendance": true,
  "curious": false,
  "following": true,
  "notice": true
}
```

### PUT ```/users/:id/preferences```

_Updates a user with ```:id```'s preferences and returns the updated preferences object_

Returns:
```json
{
  "id": 2,
  "clicker": true,
  "attendance": true,
  "curious": false,
  "following": true,
  "notice": true
}
```

## Schools

### GET ```/schools```

_Returns all schools, paginated_

Returns:
```json
[
  {
    "id": 1,
    "name": "Yonsei University",
    "classification": "university"
  },
  {
    "id": 2,
    "name": "Korea University",
    "classification": "university"
  }
]
```

### GET ```/schools/:id```

_Returns a single school with ```:id```_

Returns:
```json
{
  "id": 1,
  "name": "Yonsei University",
  "classification": "university"
}
```

### POST ```/schools```

_Creates a school and returns the new school object_

Params:
```ruby
requires :school, type: Hash do
  requires :name, type: String, desc: 'Name'
  requires :classification, type: String, desc: 'Type'
  optional :courses_attributes, type: Array do
    requires :name, type: String, desc: 'Name'
    requires :instructor_name, type: String, desc: 'Instructor Name'
    requires :code, type: String, desc: 'Code'
    requires :open, type: Boolean, desc: 'Open'
    optional :information, type: String, desc: 'Information'
    optional :start_date, desc: 'Start Date'
    optional :end_date, desc: 'End Date'
  end
end
```

Notes:
* You can create courses at the same time as a school by including a new Course
object in the ```courses_attributes``` array.

Returns:
```json
{
  "id": 2,
  "name": "Korea University",
  "classification": "university"
}
```

### PUT ```/schools/:id```

_Updates a school with ```:id``` and returns the updated school object_

Params:
```ruby
requires :school, type: Hash do
  optional :name, type: String, desc: 'Name'
  optional :classification, type: String, desc: 'Type'
  optional :courses_attributes, type: Array do
    requires :name, type: String, desc: 'Name'
    requires :instructor_name, type: String, desc: 'Instructor Name'
    requires :code, type: String, desc: 'Code'
    requires :open, type: Boolean, desc: 'Open'
    optional :start_date, desc: 'Start Date'
    optional :end_date, desc: 'End Date'
  end
end
```

Notes:
* As when creating a school, you may also create new courses by passing an
array of the Course objects that you would like to create. Not that you can't update or delete existing courses here, only add new ones.

Returns:
```json
{
  "id": 3,
  "name": "Wall Street Institute",
  "classification": "institute"
}
```

## Courses

### GET ```/courses```

_Returns all courses, paginated_

Returns:
```json
[
  {
    "id": 3,
    "school_id": 3,
    "name": "English 101",
    "instructor_name": "Devin Doolin",
    "code": "ENGL101",
    "open": false,
    "start_date": null,
    "end_date": null
  },
  {
    "id": 4,
    "school_id": 3,
    "name": "Business English 101",
    "instructor_name": "Devin Doolin",
    "code": "BZEN101",
    "open": false,
    "start_date": null,
    "end_date": null
  }
]
```

### GET ```/courses/:id```

_Returns a single course with ```:id```_

Returns:
```json
{
  "id": 3,
  "school_id": 3,
  "name": "English 101",
  "instructor_name": "Devin Doolin",
  "code": "ENGL101",
  "open": false,
  "start_date": null,
  "end_date": null
}
```

### GET ```/courses/:id/users```

_Returns a course's users by type_

Returns:
```json
{
  "supervising": [
    {
      "id": 1,
      "name": "Tae-hwan Kim"
    }
  ],
  "attending": [
    {
      "id": 2,
      "name": "Devin Doolin"
    }
  ],
  "dropped": [],
  "kicked": []
}
```

### POST ```/courses```

_Creates a course and returns the new course object_

Params:
```ruby
requires :course, type: Hash do
  requires :school_id, type: Integer, desc: 'School ID'
  requires :name, type: String, desc: 'Name'
  requires :instructor_name, type: String, desc: 'Instructor Name'
  requires :code, type: String, desc: 'Code'
  requires :open, type: Boolean, desc: 'Open'
  optional :information, type: String, desc: 'Information'
  optional :start_date, type: Date, desc: 'Start Date'
  optional :end_date, type: Date, desc: 'End Date'
end
```

Returns:
```json
{
  "id": 5,
  "school_id": 1,
  "name": "Application Development with Advanced JavaScript",
  "instructor_name": "Devin Doolin",
  "code": "JSCR304",
  "open": false,
  "start_date": "2015-03-01",
  "end_date": "2015-06-19"
}
```

### PUT ```/courses/:id```

_Updates a course with ```:id``` and returns the updated course object_

Params:
```ruby
requires :course, type: Hash do
  optional :name, type: String, desc: 'Name'
  optional :instructor_name, type: String, desc: 'Instructor Name'
  optional :code, type: String, desc: 'Code'
  optional :open, type: Boolean, desc: 'Open'
  optional :information, type: String, desc: 'Information'
  optional :start_date, type: Date, desc: 'Start Date'
  optional :end_date, type: Date, desc: 'End Date'
  optional :courses_users_attributes, type: Array do
    optional :user_id, type: Integer, desc: 'User ID'
    optional :state, type: String, desc: 'State'
    optional :_destroy, type: Boolean, desc: 'Destroy'
  end
end
```

Notes:
* Similar to how users can attach courses via update, courses may also add and
remove users in a similar way. For example, the following will add a user to a class:

Returns:
```json
{
  "course": {
    "courses_users_attributes": [
      {
        "user_id": 1,
        "state": "attending"
      }
    ]
  }
}
```

### DELETE ```/courses/:id```

_Deletes a course with ```:id```_

Returns:
```
204
```

### GET ```/courses/:id/attendances```

_Returns a course's attendances, paginated_

Returns:
```json
[
  {
    "id": 1,
    "course_id": 1,
    "user_id": 1,
    "auto": false
  }
]
```

### GET ```/courses/:id/clickers```

_Returns a course's clickers, paginated_

Returns:
```json
[
  {
    "id": 1,
    "course_id": 1,
    "user_id": 1,
    "type": "ox",
    "message": "A message",
    "saved": false,
    "time_length": 45,
    "cheating": false,
    "privacy": "all"
  }
]
```

### GET ```/courses/:id/notices```

_Returns a course's notices, paginated_

Returns:
```json
[
  {
    "id": 1,
    "course_id": 1,
    "user_id": 1,
    "targeted": false,
    "message": "Some message"
  }
]
```

### GET ```/courses/:id/curiouses```

_Returns a course's curiouses, paginated_

Returns:
```json
[
  {
    "id": 1,
    "course_id": 1,
    "user_id": 2,
    "title": "What do?",
    "message": "What else do?"
  }
]
```

## Schedules

### POST ```/schedules```

_Creates a schedule and returns the new schedule object_

Params:
```ruby
requires :schedule, type: Hash do
  requires :course_id, type: Integer, desc: 'Course ID'
  requires :day_of_week, type: String, desc: 'Day of Week'
  requires :time, type: String, desc: 'Time'
  requires :timezone, type: String, desc: 'Timezone'
end
```

Notes:
* ```timezone``` represents a tz database time zone. A list of such exists on
[Wikipedia](http://en.wikipedia.org/wiki/List_of_tz_database_time_zones)

Returns:
```json
{
  "id": 1,
  "course_id": 1,
  "day_of_week": "mon",
  "time": "9:00 AM",
  "timezone": "Asia/Seoul"
}
```

### DELETE ```/schedules/:id```

_Deletes a schedule with ```:id```_

Returns:
```
204
```

## Attendance Alarms

### GET ```/attendance_alarms```

Returns:
```json
[
  {
    "id": 1,
    "course_id": 1,
    "schedule_id": 1,
    "user_id": 1,
    "scheduled_for": "2014-11-29 14:10:04",
    "manual": false,
    "active": true
  },
  {
    "id": 2,
    "course_id": 1,
    "schedule_id": 2,
    "user_id": 2,
    "scheduled_for": "2014-11-29 14:10:04",
    "manual": false,
    "active": true
  }
]
```

### POST ```/attendance_alarms```

_Creates an attendance alarm and returns the new attendance alarm object_

Params:
```ruby
requires :attendance_alarm, type: Hash do
  requires :course_id, type: Integer, desc: 'Course ID'
  requires :schedule_id, type: Integer, desc: 'Schedule ID'
  requires :user_id, type: Integer, desc: 'User ID'
  requires :scheduled_for, type: Date, desc: 'Scheduled For'
  requires :manual, type: Boolean, desc: 'Manual'
  requires :active, type: Boolean, desc: 'Active'
end
```

Notes:
* ```scheduled_for``` must be in a valid Ruby date format (i.e. DD/MM/YYYY).

Returns:
```json
{
  "id": 1,
  "course_id": 1,
  "schedule_id": 1,
  "user_id": 1,
  "scheduled_for": "2014-11-29 14:10:04",
  "manual": false,
  "active": true
}
```

### PUT ```/attendance_alarms/:id```

_Updates an attendance alarm with ```:id``` and returns the updated attendance alarm object_

Params:
```ruby
requires :attendance_alarm, type: Hash do
  optional :scheduled_for, type: Date, desc: 'Scheduled For'
  optional :manual, type: Boolean, desc: 'Manual'
  optional :active, type: Boolean, desc: 'Active'
end
```

Notes:
* ```scheduled_for``` must be in a valid Ruby date format (i.e. DD/MM/YYYY).

Returns:
```json
{
  "id": 1,
  "course_id": 1,
  "schedule_id": 1,
  "user_id": 1,
  "scheduled_for": "2014-11-29 14:10:04",
  "manual": false,
  "active": true
}
```

### DELETE ```/attendance_alarms/:id```

_Deletes an attendance alarm with ```:id```_

Returns:
```
204
```

## Attendances

### POST ```/attendances```

_Creates an attendance and returns the new attendance object_

Params:
```ruby
requires :attendance, type: Hash do
  requires :course_id, type: Integer, desc: 'Course ID'
  requires :user_id, type: Integer, desc: 'User ID'
  optional :auto, type: Boolean, desc: 'Auto'
end
```

Returns:
```json
{
  "id": 1,
  "course_id": 1,
  "user_id": 1,
  "auto": false
}
```

## Clickers

### GET ```/clickers/:id```

_Returns a single clicker with ```:id```_

Returns:
```json
{
  "id": 1,
  "course_id": 1,
  "user_id": 1,
  "type": "ox",
  "message": "A message",
  "saved": false,
  "time_length": 45,
  "cheating": false
}
```

### POST ```/clickers```

_Creates a clicker and returns the new clicker object_

Params:
```ruby
requires :clicker, type: Hash do
  requires :course_id, type: Integer, desc: 'Course ID'
  requires :user_id, type: Integer, desc: 'User ID'
  optional :type, type: String, desc: 'Type'
  optional :message, type: String, desc: 'Message'
  optional :saved, type: Boolean, desc: 'Saved'
  optional :time_length, type: Integer, desc: 'Time Length'
  optional :cheating, type: Boolean, desc: 'Cheating'
  optional :privacy, type: String, desc: 'Privacy'
end
```

Returns:
```json
{
  "id": 1,
  "course_id": 1,
  "user_id": 1,
  "type": "ox",
  "message": "A message",
  "saved": false,
  "time_length": 45,
  "cheating": false
}
```

### PUT ```/clickers/:id```

_Updates a clicker with ```:id``` and returns the updated clicker object_

Params:
```ruby
requires :clicker do
  optional :type, type: String, desc: 'Type'
  optional :message, type: String, desc: 'Message'
  optional :saved, type: Boolean, desc: 'Saved'
  optional :time_length, type: Integer, desc: 'Time Length'
  optional :cheating, type: Boolean, desc: 'Cheating'
  optional :privacy, type: String, desc: 'Privacy'
end
```

Returns:
```json
{
  "id": 1,
  "course_id": 1,
  "user_id": 1,
  "type": "ox",
  "message": "A different message",
  "saved": false,
  "time_length": 45,
  "cheating": false
}
```

### DELETE ```/clickers/:id```

_Deletes a clicker with ```:id```_

Returns:
```
204
```

## Notices

### POST ```/notices```

_Creates a notice and returns the new notice object_

Params:
```ruby
requires :notice, type: Hash do
  requires :course_id, type: Integer, desc: 'Course ID'
  requires :user_id, type: Integer, desc: 'User ID'
  optional :targeted, type: Boolean, desc: 'Targeted'
  optional :message, type: String, desc: 'Message'
  optional :notice_targets_attributes, type: Array do
    requires :user_id, type: Integer, desc: 'User ID'
  end
end
```

Returns:
```json
{
  "id": 1,
  "course_id": 1,
  "user_id": 1,
  "targeted": false,
  "message": "Some message"
}
```

### PUT ```/notices/:id```

_Updates a notice with ```:id``` and returns the updated notice object_

Params:
```ruby
requires :notice, type: Hash do
  optional :targeted, type: Boolean, desc: 'Targeted'
  optional :message, type: String, desc: 'Message'
  optional :notice_targets_attributes, type: Array do
    optional :id, type: Integer, desc: 'ID'
    optional :_destroy, type: Boolean, desc: 'Destroy'
  end
end
```

Returns:
```json
{
  "id": 1,
  "course_id": 1,
  "user_id": 1,
  "targeted": false,
  "message": "Some other message"
}
```

## Curiouses

### GET ```/curiouses/:id```

_Returns a specific curious with ```:id```_

Returns:
```json
{
  "id": 1,
  "course_id": 1,
  "user_id": 2,
  "title": "What do?",
  "message": "What else do?"
}
```

### POST ```/curiouses```

_Creates a curious and returns the new curious object_

Params:
```ruby
requires :curious, type: Hash do
  requires :course_id, type: Integer, desc: 'Course ID'
  requires :user_id, type: Integer, desc: 'User ID'
  requires :title, type: String, desc: 'Title'
  optional :message, type: String, desc: 'Message'
end
```

Returns:
```json
{
  "id": 1,
  "course_id": 1,
  "user_id": 2,
  "title": "What do?",
  "message": "What else do?"
}
```

### PUT ```/curiouses/:id```

_Updates a curious with ```:id``` and returns the updated curious object_

Params:
```ruby
requires :curious, type: Hash do
  optional :title, type: String, desc: 'Title'
  optional :message, type: String, desc: 'Message'
end
```

Returns:
```json
{
  "id": 1,
  "course_id": 1,
  "user_id": 2,
  "title": "How do?",
  "message": "How else do?"
}
```

### GET ```/curiouses/:id/comments```

_Returns a curiouses comments with ```:id```_

Returns:
```json
[
  {
    "id": 1,
    "commentable_id": 1,
    "commentable_type": "Curious",
    "user_id": 1,
    "message": "This question is deep. Real deep.",
    "created_at": "2014-12-22T07:35:38.139Z",
    "updated_at": "2014-12-22T07:35:38.139Z"
  }
]
```

### POST ```/curiouses/:id/comments```

_Adds a comment to a curious with ```:id``` and returns the new comment object_

Params:
```ruby
requires :user_id, type: Integer, desc: 'User ID'
requires :message, type: String, desc: 'Message'
```

Returns:
```json
{
  "id": 1,
  "commentable_id": 1,
  "commentable_type": "Curious",
  "user_id": 1,
  "message": "This question is stupid",
  "created_at": "2014-12-22T07:35:38.139Z",
  "updated_at": "2014-12-22T07:35:38.139Z"
}
```

### PUT ```/curiouses/:id/comments/:comment_id```

_Updates a comment with ```:comment_id``` on a curious with ```:id``` and returns the updated comment object_

Params:
```ruby
requires :message, type: String, desc: 'Message'
```

Returns:
```json
{
  "id": 1,
  "commentable_id": 1,
  "commentable_type": "Curious",
  "user_id": 1,
  "message": "This question is stupid\n EDIT: Jk.",
  "created_at": "2014-12-22T07:35:38.139Z",
  "updated_at": "2014-12-22T07:35:38.139Z"
}
```

### DELETE ```/curiouses/:id/comments/:comment_id```

_Deletes a comment with ```:comment_id``` from a curious with ```:id```_

Returns:
```
204
```

### POST ```/curiouses/:id/like```

_Likes a curious with ```:id```_

Params:
```ruby
requires :user_id, type: Integer, desc: 'User ID'
```

Returns:
```
201
```

### POST ```/curiouses/:id/unlike```

_Unlikes a curious with ```:id```_

Params:
```ruby
requires :user_id, type: Integer, desc: 'User ID'
```

Returns:
```
204
```

### POST ```/curiouses/:id/follow```

_Follows a curious with ```:id```_

Params:
```ruby
requires :user_id, type: Integer, desc: 'User ID'
```

Returns:
```
204
```

### POST ```/curiouses/:id/unfollow```

_Unfollows a curious with ```:id```_

Params:
```ruby
requires :user_id, type: Integer, desc: 'User ID'
```

Returns:
```
204
```
