ApplicationController.extend
  ApiV2CollaborationController () ->
    # To check permissions we could do something like this or do it in the router...
    before(@create)
    before(@post)

    # GET
    @get () =>
      collaboration = new Collaboration.show(params)
      @collaboration.show
    
    # POST
    @create () =>
      collaboration = new Collaboration.new(params)

    # DELETE
    @destroy () =>
      collaboration = new Collaboration.destroy(params)
      @collaboration.delete()


# We should test all the endpoints for the API
CollaborationControllerTests () ->
  describe 'Collaboration'
    describe 'GET request'
      describe 'if the user is authorized and request is valid'
          describe 'should return a correct JSON object exists'
          describe 'should return status ____'
      describe 'if the user is not authorized'
        describe 'return status ___'
      describe 'if the collaboration does not exist'
        describe 'should return status ____'

    describe 'POST request'
      describe 'if the user is authorized and POST is valid'
        describe 'should add the user as a collaborator to the work doc'
        describe 'should add the work to the user\'s works'
        describe 'should return status ____'
        describe 'should email other collaborators'
        # etc...
      describe 'if the is not authorized it'
        describe 'should not post'
        describe 'should return status ____'

    describe 'DELETE request'
      describe 'should delete the collaborator if the user is authorized'
      describe 'should NOT delete if the requester unless the user is authorized'
      describe 'should return ____ if the collaboration does not exist'