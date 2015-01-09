Collaboration () -> # We might want to subclass this somehow... But to keep it simple, I won't do that here...

  _new = (inviter, collaborator, work) =>
    # Create a new collaboration but don't save any data to the database yet.  Return true if it works.
    collaborator = new Work.getById(collaborator) # The person who was invited.
    inviter = new Work.getById(inviter)
    work = new Work.getById(work)

  _invite = (inviter, collaborator, work) =>
    collab = new(inviter, collaborator, work) # Create a new Collaborator Object
    # What I'm doing here is maybe not ideal... since I'm coupling this concern to other objects.
    Notifiers.new(collaboration.collaborator._id) # notify the person who was invited
    Mailers.CollaboratorEmail.send(collaboration.collaborator._id) #Send an email to the person who was invited

  _create = (inviter, collaborator, work) =>
    # Save the collaboration to the database and return true if successful.
    collab = new(inviter, collaborator, work)
    collab.save()
  
  @save = () =>
    async.waterfall [
      async.parallel [
        # This is a bad implementation... 
        # But the idea is to use only the models to save to the database and keep each model independent
        work: (cb) -> return false unless work.addCollaborator(inviter, collaborator, work)
        user: (cb) -> return false unless user.addAsCollaborator(workId)
      ], (results) ->
        if results[0]
          err = new Error('The user failed to save.')
          cb err, false
        else if results[1]
          err = new Error('The work failed to save.')
          cb err, false
        else
          cb null, true
    ]

  @destroy = (userId, workId) ->
    # Destroy the collaboration completely

  @show = (someParams) =>
    # Optionally, we could have a show method, which says what data to display/publish

  # Since we would be doing a lot of concerns that look exactly this way, 
  # we might just abstract it into a Concern object that has the new, create, and delete methods by default...
  # Or maybe we could just make the concern a Model object, even though it doesn't actually save to the database...



# There should be tests for each of these!

CollaborationTests () ->
  describe 'new method should create new collaboration and return correct status'
    # ...
    describe 'if it was created, it should return true'
    # ...
    describe 'if it was not created, it should return false'
    # ...

  describe 'create should create collaboration and return correct status'
    # ...
  describe 'destroy method should destroy collaboration and return true and return correct status'
    # ...