========HIGHLIGHTS============

This is a very rough draft, but the basic ideas are these...

The 'concerns' pattern: 
- I abstracted 'Collaborations' into its own object (in Rails, pseudo-models like this are called 'concerns') 
- A concern is like a model but it does not persist in the database.
- It can access multiple models or change the way a model's data is presented/published.
- It contains all the business logic for the collaborations.
- It interacts with the works and users models but only through their external interfaces
- It has a corresponding route/controller (whatever Express prefers to call it.)
- I also could've made CollaborationInvites it's own separate concern.  
- In this case, I think the invitations and the actual collaborations are similar enough to be a single concern.
- The Concern doesn't care what's in the models. It only accesses them via functions. 
- As long as the model's access-point functions perform as expected, changing the models won't break the concern or the route or anything else.
- If we want, we could even pull this into a separate app on it's own server. We would just rewrite the model's functions to return data from calls to another server.

Testing Concerns:
- Make sure the external interfaces all do what's expected. 
- Everything else is probably less important to test...

Testing models:
- At a minimum, we should probably test the major functions: new(), create(), destroy(), update()

Routes file:
- I versioned the API (api.seelio.com/v2/ or seelio.com/api/v2)
- Versioning ensures that the API is stable for external clients (iOS apps, widgets, partner integrations, whatever)
- Collaborations and collaborationInvites are separate things, so they each get their own separate POST route.
- This results in more routes, but it keeps each route simple and modular.

The Route:
- The route is only for routing.
- All it does it access the concern and call the appropriate functions on the concern.
- No business logic!

Route tests:
- All of the endpoints should be tested for things like... Do they return the correct HTTP status and data?
- When something break, the test suite should tell us so that we don't need to guess about it!

Permissions:
There are different ways to handle it... Haven't given much thought to which is best...
- It could go in the routes file as middleware
- It could go in the route module
- It could go into some sort of controller layer

Client:
- Holds the backbone models/collections/routes/views (+template, css, etc)

Shared library (code for both client and :
- Validations

Flaws
- I haven't figured a good system for two-phase-commits...
