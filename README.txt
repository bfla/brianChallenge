
Concerns: 
- Collaborations interacts with the works and user models.  
- It's almost exactly like a model but it does not persist in the database
- It contains all the business logic for the collaborations.

Routes:
- I versioned the API so that it's stable for external clients (iOS apps, widgets, partner integrations, whatever)
- I gave collaborator_invites it's own RESTful route and also gave collaborations it's own route.
- In this case it seems like overkill, but I think it's probably a good practice to stick to.

Client:
- 

Shared library:
- I thought it might be a good idea to put some of the collaborators code into a library that can be shared with the client
