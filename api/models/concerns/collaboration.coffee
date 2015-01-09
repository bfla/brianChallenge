# All of the business logic unique to collaborators and their invites should go here...
# This object is like a model, but it doesn't persist in the database.
# It never interacts with the database directly.  Only through models!

# If we wanted to do it even more modularly, it might be smart to put CollaborationInvites in a separate object...
# But since the invites are so closely related to Collaborations, I included them in here...

Collaboration () -> # We might want to subclass this somehow... But to keep it simple, I won't do that here...

  @new = (inviter, collaborator, work) =>
    # Create a new collaboration model but don't save it.  Return true if it works.
    @collaborator = new Work.getById(collaborator)
    @inviter = new Work.getById(inviter)
    @work = new Work.getById(work)

  @invite = (inviter, collaborator, work) =>
    @new(inviter, collaborator, work)
    # Do whatever needs doing

  @create = (inviter, collaborator, work) =>
    # Save the collaboration to the database and return true if successful.
    @new(inviter, collaborator, work)
  
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