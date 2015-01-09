#HIGHLIGHTS

<strong> Woops! All of the files and objects that I named `controllers` are really `routes` or `route.modules` </strong>

My pseudo-code is pretty bad but the basic ideas are there...

##The 'concerns' pattern:
- I abstracted `Collaborations` into its own object (in Rails, pseudo-models like this are called 'concerns') 
- I also could've made `CollaborationInvites` into it's own separate concern.  I didn't but maybe I should've.
- A concern is like a model but it does not persist in the database.
- It can access multiple models or change the way a model's data is presented/published.
- It contains all the business logic for the collaborations.
- It interacts with the `Works` and `Users` models but only through their external interfaces
- It usually has a corresponding route module
- The concern doesn't care what's in the models. It only accesses them via functions. 
- As long as the model's access-point functions perform as expected, changing the models won't break the concern or the route or anything else.
- If we want, we could even pull the models into separate apps on their own servers. We would just rewrite the model's functions to return data from calls to another server.

##Testing Concerns:
- Make sure the external interfaces produce the expected outputs. 

##Testing models:
- At a minimum, we should probably test the major functions: `new()`, `create()`, `destroy()`, `update()`

##Versioning routes:
- I versioned the API (`api.seelio.com/v2/` or `seelio.com/api/v2`)
- Versioning ensures that the API is stable for external clients (iOS apps, widgets, partner integrations, whatever)

##RESTful routes:
- `/collaborations` and `/collaborationInvites` are actually separate things, so they each get their own separate `POST` route and their own separete Route file.
- This results in more routes and more route files, but it keeps each route simple and modular and makes it easy to abstract the data into a concern.
- It might be tempting to put these into one Route file... No!  Don't do it!
- Something like `works/:id/collaborationInvites/:user` could also work. But it gets messy if something changes and we need to add collaborations to other types of objects... Or maybe we decide we need to add collaborations to multiple works simultaneously...

##The Route:
- The route is only for routing.
- All it does it access the concern, call the appropriate functions on the concern, and send back the right response.
- No business logic related to the collaboration! We're basically just returning data/errors and HTTP statuses.

##Route tests:
- All of the endpoints should be tested for things like... Do they return the correct HTTP status and data?
- When something breaks, the test suite should tell us so that we don't need to guess about it!
- This sort of testing becomes a lot harder if we start making the routes complex or putting business logic into them.

##Permissions:
There are different ways to handle permissions... Haven't given much thought to which is best...
- It could go in the routes file as middleware
- It could go in the route module
- It could go into some sort of controller layer, although I'm not 100% convinced controllers are a good idea.

##Client Models:
- If needed, we can add a backbone model that represents the Collaboration or CollaborationInvite.
- The model handles the API calls and so forth.

##Shared library (code for both client and server):
- Possibly include concerns here so that Backbone can use them.
- Validations
- Basic permissions - It would be nice if the client could catch cases where the user obviously doesn't have permission
- It might be a convenient to make a client library for the backbone models so that we can just do something like `Collaboration.submit(params)`

##Tradeoffs
- Two-phase-commits to MongoDB...  I'm not sure how that works in this type of framework
- We might end up with lots of route files or concerns that aren't doing a whole lot of real work.
- Concerns might be more useful if they could be Mongoose models but I'm not sure if Mongoose allows for schemas with non-persistent data.
- Concerns can be abstract to think about.  It's not all that easy to distinguish between Collaborations and CollaborationInvites. It takes some getting used to.
- Probably lots of other pros and cons that I haven't thought of yet...
