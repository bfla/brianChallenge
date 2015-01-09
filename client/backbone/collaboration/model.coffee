class Seelio.Models.Collaboration extends Backbone.Model
  defaults:
    work: null
    user: null

    inviteCollaborator: (work) ->
      promise = $.Deferred()
      $.ajax
        url: 'api/v2/collaborators'
        data:
          workId: #...
          #...
        success: (res) ->
          promise.resolve(res)
        failure: ->
          err = 'Invite failed to send'
          promise.reject(err)
      return promise