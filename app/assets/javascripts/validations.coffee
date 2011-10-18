ns = window.Validator = window.Validator || {}

integer_regex = /^(\+|-)?[0-9,]+$/
decimal_regex = /^(\+|-)?[0-9,]+(\.\d*)?$/


ns.required = (params) ->
  if params.val == ""
    params.inputWrap.find("span.inline-error-message").css('display', 'inline')
    params.inputWrap.addClass("live-error")
  else
    params.inputWrap.find("span.inline-error-message").hide()
    params.inputWrap.removeClass("live-error").removeClass("field_with_errors")

ns.numeric = (params) ->
  decimal = params.inputWrap.hasClass("decimal")
  integer = params.inputWrap.hasClass("integer")
  min = params.elem.attr("min") #currently unused
  max = params.elem.attr("max") #currently unused
  if decimal
    if params.val.match(decimal_regex)
      params.inputWrap.find("span.inline-error-message").hide()
      params.inputWrap.removeClass("live-error").removeClass("field_with_errors")
    else
      params.inputWrap.find("span.inline-error-message").css('display', 'inline')
      params.inputWrap.addClass("live-error")
  else if integer
    if params.val.match(integer_regex)
      params.inputWrap.find("span.inline-error-message").hide()
      params.inputWrap.removeClass("live-error").removeClass("field_with_errors")
    else
      params.inputWrap.find("span.inline-error-message").css('display', 'inline')
      params.inputWrap.addClass("live-error")

ns.validate = ->
  validationParams = {}
  validationParams.elem      = $(this)
  validationParams.inputWrap = validationParams.elem.closest(".input")
  validationParams.val       = $.trim(validationParams.elem.val())
  validationParams.required  = validationParams.inputWrap.hasClass('required')
  validationParams.numeric   = validationParams.inputWrap.hasClass('numeric' )
  validationParams.type      = validationParams.elem.attr("type")

  unless validationParams.elem.hasClass("no-validate")
    if validationParams.required
      if validationParams.numeric
        ns.numeric(validationParams)
      else
        ns.required(validationParams)

ns.validateAll = ->
  $("input, textarea, select").each(ns.validate)
  return $(".input.live-error").length < 1

ns.initErrorMessages = ->
  $("span.input.required").each (ind, elem) ->
    if $(elem).find("span.inline-error-message").size() == 0
       message = $('<span class="inline-error-message" style="display: inline">can\'t be blank</span>').hide();
       $(elem).append(message);
    else
      $(elem).find("span.inline-error-message").css('display', 'inline').addClass("required")
  $("span.input.numeric:not(.select)").each (ind, elem) ->
    if $(elem).find("span.inline-error-message").size() == 0
      message = $('<span class="inline-error-message" style="display:inline">is not a number</span>').hide();
      $(elem).append(message);
    else
      $(elem).find("span.inline-error-message").css('display', 'inline').addClass("numeric")
$ ->
  ns.initErrorMessages()
  $('input, textarea, select').live('focusout', ns.validate)
  $('input, textarea, select').live("change",   ns.validate)
  $('input, textarea, select').live("keyup",    ns.validate)
