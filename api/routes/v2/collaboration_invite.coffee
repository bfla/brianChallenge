
ApiV2CollaborationInviteRoute () ->

  @create (work) =>
    collaboration = new Collaboration.new(work)
    if @userOwnsDoc(collaboration.work)
      if collaborator.invite() # should return true
        util.log 'log it'
        res.send 201 # Created!
      else
        util.log 'log it'
        res.send 300 # Failure
    else
      util.log 'whatever needs logging'
      res.send 401 # Unauthorized

MyTests () =>
  describe 'POST collaborator_invite'
    describe 'if request is valid'
      describe 'should respond with status ___'
      describe 'should respond with valid JSON'
      describe 'should log it...'
      # etc...
    describe 'if user is not authorized'
      describe 'should respond 401'
      describe 'should not create the invite'
    # etc...


