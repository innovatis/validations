ns = window.Validator = window.Validator || {}

integer_regex = /^(\+|-)?[0-9,]+$/
decimal_regex = /^(\+|-)?[0-9,]+(\.\d*)?$/


ns.required = (params) ->
  if params.val == ""
    params.inputWrap.find("span").show()
    params.inputWrap.addClass("error")
  else
    params.inputWrap.find("span").hide()
    params.inputWrap.removeClass("error").removeClass("field_with_errors")

ns.numeric = (params) ->
  decimal = params.inputWrap.hasClass("decimal")
  integer = params.inputWrap.hasClass("integer")
  min = params.elem.attr("min") #currently unused
  max = params.elem.attr("max") #currently unused
  if decimal
    if params.val.match(decimal_regex)
      params.inputWrap.find("span").hide()
      params.inputWrap.removeClass("error").removeClass("field_with_errors")
    else
      params.inputWrap.find("span").show()
      params.inputWrap.addClass("error")
  else if integer
    if params.val.match(integer_regex)
      params.inputWrap.find("span").hide()
      params.inputWrap.removeClass("error").removeClass("field_with_errors")
    else
      params.inputWrap.find("span").show()
      params.inputWrap.addClass("error")

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
  $("input, textarea").each(ns.validate)
  return $(".input.error").length < 1

ns.initErrorMessages = ->
  $("span.input.required:not(.select)").each (ind, elem) ->
    if $(elem).find("span.error").size() == 0
      $(elem).append('<span class="error required" style="display:none">can\'t be blank</span>')
    else
      $(elem).find("span.error").addClass("required")
  $("span.input.numeric:not(.select)").each (ind, elem) ->
    if $(elem).find("span.error").size() == 0
      $(elem).append('<span class="error numeric" style="display:none">is not a number</span>')
    else
      $(elem).find("span.error").addClass("numeric")
$ ->
  ns.initErrorMessages()
  $('input, textarea').live('focusout', ns.validate)
  $('input, textarea').live('focusin',  ns.validate)
  $('input, textarea').live("change",   ns.validate)
  $('input, textarea').live("keydown",  ns.validate)
  $('input, textarea').live("keyup",    ns.validate)
