exports = exports ? window

exports.ModalLogic = class ModalLogic
  constructor: ->
    that = @
    $('a[data-remote][modal]').on 'ajax:complete', (jq_event, xhr) ->
      response = JSON.parse(xhr.responseText)

      if response?      
        if response.close?
          window.location = if response.redirect_location? then response.redirect_location else window.location
        else
          that.createOrUpdateModalContent(response)
      else
        that.createOrUpdateModalContent
          title: 'Error'
          body: 'There was an error.  Please reload the page and try again'

  processResponse: (jq_event, xhr) ->
    that = @
    response = JSON.parse(xhr.responseText)

    if response?      
      if response.close?
        window.location = if response.redirect_location? then response.redirect_location else window.location
      else
        that.createOrUpdateModalContent(response)
    else
      that.createOrUpdateModalContent
        title: 'Error'
        body: 'There was an error.  Please reload the page and try again'

  createOrUpdateModalContent: (context) =>
    html = HandlebarsTemplates['modal/crud']( modal: context )
    $modal = $('.modal.modal-logic')

    if $modal.length > 0
      $modal.modal('hide').replaceWith html
    else
      $('body').append html

    that = @
    $('form[data-remote][modal]').on 'ajax:complete', (jq_event, xhr) ->
      that.processResponse(jq_event, xhr)

    @showModal()

  showModal: =>
    $('.modal.modal-logic').modal('show')

