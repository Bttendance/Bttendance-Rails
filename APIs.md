API-2.0
=================
####Error JSON
    Status Code
        401         : Auto Sign Out

        441         : Update Recommended
        442         : Update Required

        555         : Database Migrating
        503         : Server Down
    { 
        "type"      : "type", (log, toast, alert)
        "title"     : "title",
        "message"   : "message"
    }

####PushNoti JSON
    { 
        "type": "type", (
            attdWillStart, 
            attdStarted, 
            attdOnGoing, 
            attdChecked, 
            attdClaimed, 
            attdAbscent, 

            clickerStartd, 
            clickerOnGoing, 

            noticePosted, 
            noticeAgain, 
            noticeUpdated, 

            curiousPosted, 
            curiousLiked, 
            curiousCommented, 

            courseCreated,
            addedAsManager, 
            kickedFromCourse
            )
        "courseID: : "courseID",
        "title" : "title",
        "message": "message"
    }

####Email JSON
    { 
        "email": "email"
    }
####Locale
    Every API has locale for it's parameter.
=================

###Sockets
####put : api/socket/connect => res.ok();
    email
    password

=================
###User
####post : api/user/signup => User
    email
    password (unhashed)
    name
    locale

    deviceType
    deviceUuid

####get : api/user/auto/signin => User
#####Status Code 
    userId
    email
    password
    locale

    appVersion

####get : api/user/signin => User
    userId
    email
    password (unhashed)
    locale

    deviceType
    deviceUuid

####put : api/user/forgot/password => Email
    email
    locale

####put : api/user/update/password => User
    userId
    email
    password
    locale

    passwordOld
    passwordNew

####put : api/user/update/name => User
    userId
    email
    password
    locale

    name

####put : api/user/update/email => User
    userId
    email
    password
    locale

    emailNew

####get : api/user/search => User
    userId
    email
    password
    locale

    search

####get : api/user/courses => CourseJSON + attendance_rate, clicker_rate, notice_unseen ***
    userId
    email
    password
    locale

####put : api/device/update/notificationKey => Device
    userId
    email
    password
    locale

    deviceType
    deviceUuid
    notificationKey

###Setting
####put : api/setting/update/attendance => Setting
    userId
    email
    password
    locale

    attendance

####put : api/setting/update/clicker => Setting
    userId
    email
    password
    locale

    clicker

####put : api/setting/update/notice => Setting
    userId
    email
    password
    locale

    notice

####put : api/setting/update/curiousCreated => Setting
    userId
    email
    password
    locale

    curiousCreated

####put : api/setting/update/curiousFollowing => Setting
    userId
    email
    password
    locale

    curiousFollowing

###QuestionSet
####get : api/questionSet/course => QuestionSet List
    userId
    email
    password
    locale

    courseId

####post : api/questionSet/create => QuestionSet
    userId
    email
    password
    locale

    courseId
    message
    type
    time
    cheating
    privacy

####put : api/questionSet/edit => QuestionSet
    userId
    email
    password
    locale

    questionId
    message
    type
    time
    cheating
    privacy

####delete : api/questionSet/remove => QuestionSet
    userId
    email
    password
    locale

    questionId

###UserSchool
####put : api/userSchool/update/identity => UserSchool
    userId
    email
    password
    locale

    schoolId
    identity

###School
####post : api/school/create => School
    userId
    email
    password
    locale

    name
    type

####get : api/school/all => School LIST
    userId
    email
    password
    locale

####put : api/school/enroll => School
    userId
    email
    password
    locale

    schoolId
    identity

###Course
####get : api/course/info => Course
    userId
    email
    password
    locale

    courseId

####post : api/course/create/instant => Course
    userId
    email
    password
    locale

    name
    schoolId
    instructor

####get : api/course/search => Course
    userId
    email
    password
    locale

    courseId or courseCode

####delete : api/course/remove => Course
    userId
    email
    password
    locale

    courseId

####put : api/course/open => Course
    userId
    email
    password
    locale

    courseId
####put : api/course/close => Course
    userId
    email
    password
    locale

    courseId

###UserCourse
####put : api/userCourse/attend => UserCourse
    userId
    email
    password
    locale

    courseId

####put : api/userCourse/dettend => UserCourse
    userId
    email
    password
    locale

    courseId

####put : api/course/add/manager => UserCourse
    userId
    email
    password
    locale

    courseId
    manager

####delete : api/course/resign/manager => UserCourse
    userId
    email
    password
    locale

    courseId

####delete : api/course/remove/student => UserCourse
    userId
    email
    password
    locale

    courseId
    studentId

####get : api/course/students => UserCourse LIST
    userId
    email
    password
    locale

    courseId

###Record
####get : api/course/attendance/grades => SimpleUsersJSON LIST + grade (string count/total) + student_id
    userId
    email
    password
    locale

    courseId

####get : api/course/clicker/grades => SimpleUsersJSON LIST + grade (string count/total) + student_id
    userId
    email
    password
    locale

    courseId

####put : api/course/export/grades => EmailJSON
    userId
    email
    password
    locale

    courseId

###Attendance
####get : api/attendance/feed => Attendance List
    userId
    email
    password
    locale

    courseId

####post : api/attendance/start => Attendance
    userId
    email
    password
    locale

    courseId
    type

####get : api/attendance/from/courses => Attendance Id List
    userId
    email
    password
    locale

    courseIds

####put : api/attendance/found/device => Attendance
    userId
    email
    password
    locale

    attendanceId
    uuid

####put : api/attendance/toggle/manually => Attendance
    userId
    email
    password
    locale

    attendanceId
    userId

####delete : api/attendance/remove => Attendance
    userId
    email
    password
    locale

    attendanceId

###Clicker
####get : api/clicker/feed => Clicker List
    userId
    email
    password
    locale

    courseId

####post : api/post/start/clicker => Clicker
    userId
    email
    password
    locale

    courseId
    message
    type
    time
    cheating
    privacy

####put : api/clicker/click => Clicker
    userId
    email
    password
    locale

    clickerId
    choice

####put : api/clicker/send => Clicker
    userId
    email
    password
    locale

    clickerId
    message

###Notice
####get : api/notice/feed => Notice LIST
    userId
    email
    password
    locale

    courseId

####post : api/post/create/notice => Notice
    userId
    email
    password
    locale

    courseId
    message

####put : api/notice/seen => Notice
    userId
    email
    password
    locale

    noticeId

###Curious
####get : api/curious/feed => Curious LIST
    userId
    email
    password
    locale
    
    courseId

=================

###Guide
####view : guide/clicker
    locale
    deviceType
    appVersion
####view : guide/attendance
    locale
    deviceType
    appVersion
####view : guide/notice
    locale
    deviceType
    appVersion

=================
####Copyright 2015 @Bttendance Inc.
