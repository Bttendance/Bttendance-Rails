Bttendance API v1
=================

### Base URL for all API routes: ```/api/v1/```

## Users

### GET ```/users```

_Gets all users_

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

### GET ```/users/:id```

_Gets a single user with ```:id```_

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
  optional :devices_attributes, type: Array do
    requires :platform, type: String, desc: 'Platform'
    optional :uuid, type: String, desc: 'UUID'
    optional :mac_address, type: String, desc: 'MAC Address'
    optional :notification_key, type: String, desc: 'Notification Key'
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

_Updates a user and returns the updated user object_

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

### GET ```/users/reset```

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
requires :device, type: Hash do
  requires :uuid, type: String, desc: 'UUID'
  optional :platform, type: String, desc: 'Platform'
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

_Returns a user's courses_

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

## Devices

## Schools

## Courses

## Schedules

## Attendance Alarms

## Attendances

## Clickers

## Notices

## Curious
