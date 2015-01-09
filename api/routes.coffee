

# Why version the API?  
# So that we can have a stable endpoints for clients that we don't control or don't want to break  
# like... widgets, partners' apps/integrations, iOS apps, etc.

# Technically, an invite to be a collaborator is not the same as a collaboration ...
# So to keep things RESTful and simple, let's give it it's own route...
app.post "/api/v2/collaboration_invite", acl.middleware(1), controllers.collaboration.create

# The collaboration itself gets its own route(s)
# In this case, I think the POST route is really the only one we need...
app.get "/api/v2/collaborations", acl.middleware(1), controllers.collaboration.show
app.post "/api/v2/collaborations", acl.middleware(1), controllers.collaboration.create
app.delete "/api/v2/collaborations", acl.middleware(1), controllers.collaboration.delete

# Or it might even be a good idea to do something like...
'api.seelio/v2/collaborations' 
# This way, if we eventually want to separate the backend, 
# then we can easily have seelio.com point to one server and api.seelio.com point to a different server...
