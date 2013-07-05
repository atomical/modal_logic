class ModalLogic
  constructor: ->
    that = @
    $('a[data-remote][modal],form[data-remote][modal]').live 'ajax:complete', (jq_event, xhr) ->
      response = JSON.parse(xhr.responseText)
      if response.close?
        if response.redirect_location?
          window.location = response.redirect_location
        else
          window.location = window.location
      else if ! response.html?
        that.createOrUpdateModalContent
          title: 'Error'
          html: 'There was an error.  Please reload the page and try again'
      else
        that.createOrUpdateModalContent(response)
  createOrUpdateModalContent: (context) =>
    modal = $('.modal.modal-logic')
    if modal.length is 0
      html = @renderTemplate
        title: context.title
        body: context.html     
      $('body').append html
    else
      modal.find('.modal-body').empty().append context.html
      modal.find('.modal-header > .modal-title').empty().append context.title

    @showModal()

  showModal: =>
    $('.modal.modal-logic').modal('show')

  renderTemplate: (context) =>
    """
      <div class="modal modal-logic hide fade">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
          <h3 class='modal-title'>#{context.title}</h3>
        </div>
        <div class="modal-body">
          #{context.body}
        </div>
      </div>
    """
