# Counselor Notepad (formerly BOSS) data store API

An API to store notes and track students.  The API allows users to CRUD on student notes.

Link to the live application: [https://spw5235.github.io/boss-project-front-end/](https://spw5235.github.io/boss-project-front-end/).

Link to the front-end repository: [https://github.com/spw5235/boss-project-front-end](https://github.com/spw5235/boss-project-front-end).

## ORM
The relationship of this api is one to many.  That is, one user can have many notes.  For a visualization of this relationship, view the following link: https://goo.gl/S3jndc.

## API end-points

| Verb   |             URI Pattern            |    Controller#Action     |
|--------|------------------------------------|--------------------------|
| POST   |              `/sign-up`            |    `users#signup`        |
| POST   |             `/sign-in`             |    `users#signin`        |
| DELETE |           `/sign-out/:id`          |    `users#signout`       |
| PATCH  |       `/change-password/:id`       |    `users#changepw`      |
| GET    |            `/trackers`             |    `trackers#index`      |
| GET    |          `/trackers/:id`           |    `trackers#show`       |
| POST   |            `/trackers`             |    `trackers#create`     |
| PATCH  |          `/trackers/:id`           |    `trackers#update`     |
| DELETE |          `/trackers/:id`           |    `trackers#destroy`    |


All data returned from API actions is formatted as JSON.

---

## User actions

*Summary:*

### signup

The `create` action expects a *POST* of `credentials` identifying a new user to
 create, e.g. using `getFormFields`:

```html
<form>
  <input name="credentials[email]" type="text" value="an@example.email">
  <input name="credentials[password]" type="password" value="an example password">
  <input name="credentials[password_confirmation]" type="password" value="an example password">
</form>

```

or using `JSON`:

```json
{
  "credentials": {
    "email": "an@example.email",
    "password": "an example password",
    "password_confirmation": "an example password"
  }
}
```

The `password_confirmation` field is optional.

If the request is successful, the response will have an HTTP Status of 201,
 Created, and the body will be JSON containing the `id` and `email` of the new
 user, e.g.:

```json
{
  "user": {
    "id": 1,
    "email": "an@example.email"
  }
}
```

If the request is unsuccessful, the response will have an HTTP Status of 400 Bad
 Request, and the response body will be empty.

### signin

The `signin` action expects a *POST* with `credentials` identifying a previously
 registered user, e.g.:

```html
<form>
  <input name="credentials[email]" type="text" value="an@example.email">
  <input name="credentials[password]" type="password" value="an example password">
</form>
```

or:

```json
{
  "credentials": {
    "email": "an@example.email",
    "password": "an example password"
  }
}
```

If the request is successful, the response will have an HTTP Status of 200 OK,
 and the body will be JSON containing the user's `id`, `email`, and the `token`
 used to authenticate other requests, e.g.:

```json
{
  "user": {
    "id": 1,
    "email": "an@example.email",
    "token": "an example authentication token"
  }
}
```

If the request is unsuccessful, the response will have an HTTP Status of 401
 Unauthorized, and the response body will be empty.

### signout

The `signout` actions is a *DELETE* specifying the `id` of the user to sign out.

If the request is successful the response will have an HTTP status of 204 No
 Content.

If the request is unsuccessful, the response will have a status of 401
 Unauthorized.

### changepw

The `changepw` action expects a PATCH of `passwords` specifying the `old` and
 `new`.

If the request is successful the response will have an HTTP status of 204 No
 Content.

If the request is unsuccessful the reponse will have an HTTP status of 400 Bad
 Request.

---

The `sign-out` and `change-password` requests must include a valid HTTP header
 `Authorization: Token token=<token>` or they will be rejected with a status of
 401 Unauthorized.

## Note actions

All note action requests must include a valid HTTP header `Authorization: Token
 token=<token>` or they will be rejected with a status of 401 Unauthorized.

All notes are associated with a user and the values for first_name, last_name, grade, and comments are all strings.

### index

The `index` action is a *GET* that retrieves all the notes associated with a
 user.
The response body will contain JSON containing an array of notes, e.g.:

```json
{
  "trackers": [
    {
      "id": 1,
      "first_name": "Eric",
      "last_name": "Defeo",
      "grade": "3",
      "comments": "Nam vehicula ultricies elit, fringilla varius eros vulputate id. Duis sem velit, pharetra id neque ac, fringilla convallis purus. Vestibulum accumsan diam ante, non gravida velit commodo ut"
    },
    {
      "id": 2,
      "first_name": "Jeff",
      "last_name": "Keogh",
      "grade": "4",
      "comments": "Nam vehicula ultricies elit, fringilla varius eros vulputate id. Duis sem velit, pharetra id neque ac, fringilla convallis purus. Vestibulum accumsan diam ante, non gravida velit commodo ut"
    }
  ]
}
```

If there are no notes associated with the user, the response body will contain
 an empty notes array, e.g.:

```json
{
  "trackers": [
  ]
}
```

### show

The `show` action is a *GET* specifing the `id` of the note to retrieve.
If the request is successful the status will be 200, OK, and the response body
 will contain JSON for the note requested, e.g.:

```json
{
  "tracker": {
      "id": 1,
      "first_name": "Eric",
      "last_name": "Defeo",
      "grade": "3",
      "comments": "Nam vehicula ultricies elit, fringilla varius eros vulputate id. Duis sem velit, pharetra id neque ac, fringilla convallis purus. Vestibulum accumsan diam ante, non gravida velit commodo ut"
    }
}
```

### create

Below is the html for a sample create form:

```html
<form id="new-note" name="new-note-form">
    <fieldset>
      <p class="field-description">First Name</p>
      <input name="tracker[first_name]" placeholder="First Name" type="text">
      <p class="field-description">Last Name</p>
      <input name="tracker[last_name]" placeholder="Last Name" type="text">
      <p class="field-description">Grade</p>
      <input name="tracker[grade]" placeholder="Grade" type="text">
      <p class="field-description">Note</p>
      <textarea name="tracker[comments]" placeholder="Note"></textarea>
      <br>
      <input class="submit-btn" name="submit" id="create-btn" type="submit" value="Submit">
    </fieldset>
  </form>
```


### update

This `update` action is a *PATCH* specifying the id of the note to retrieve. If the request is successful, the response will have an HTTP Status of 200 OK, and the body will be JSON containing the note, e.g.:

```json
{
  "tracker": {
      "id": 1,
      "first_name": "Eric",
      "last_name": "Defeo",
      "grade": "3",
      "comments": "Nam vehicula ultricies elit, fringilla varius eros vulputate id. Duis sem velit, pharetra id neque ac, fringilla convallis purus. Vestibulum accumsan diam ante, non gravida velit commodo ut"
    }
}
```

Below is the html for a sample update form:

```html
<form id="update-form" name="update-form">
    <fieldset>
      <input name="tracker[id]" id="update-tracker-id" placeholder="Tracker ID" type="text">
      <br>
      <p class="field-description">First Name</p>
      <input name="tracker[first_name]" placeholder="First Name" type="text">
      <br>
      <p class="field-description">Last Name</p>
      <input name="tracker[last_name]" placeholder="Last Name" type="text">
      <br>
      <p class="field-description">Grade</p>
      <input name="tracker[grade]" placeholder="Grade" type="text">
      <br>
      <p class="field-description">Note</p>
      <textarea name="tracker[comments]" placeholder="Comments"></textarea>
      <br>
      <input class="submit-btn" name="submit" type="submit" value="Submit">
    </fieldset>
  </form>
```

### Destroy

The `destroy` action is a *DELETE* specifying the `id` of the note to delete.

If the request is successful the response will have an HTTP status of 204 No Content.

If the request is unsuccessful, the response will have a status of 500.
