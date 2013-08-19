class PeopleApp.EditPersonSocialApps extends Backbone.View
  template: JST['templates/person_social_apps/edit']
  className: "row-fluid"

  initialize: ->
    _.bindAll this, "render"

  events:
    "click .js-new-person-social-app-save" : "create"
    "click .js-person-social-app-remove" : "destroy"

  render: ->
    edit = $(@el)
    person_social_apps = @options.person_social_apps
    edit.html @template(person_social_apps: person_social_apps)

    self = @
    $(@el).find(".js-new-person-social-apps-app").autocomplete
      source: api_version + "social_apps/search"
      minLength: 2
      messages:
        noResults: ''
        results: ->
          ''
      select: (event, ui) ->
        $(self.el).find(".js-new-person-social-apps-id").val(ui.item.id)

    this

  create: (e) ->
    console.log "create"
    self = @
    app_id = $(@el).find(".js-new-person-social-apps-id").val()
    profile_link = $(@el).find(".js-new-person-social-apps-link").val()
    if app_id != "" && profile_link != ""
      person_social_app = new PeopleApp.PersonSocialApp()
      person_social_app.save ({ person_social_app: { social_app_id: app_id, person_id: window.person_id, profile_link: profile_link } }),
        success: ->
          $(".notifications").html("Social app link added. It will be active after moderation.").show().fadeOut(10000)
          $(self.el).find(".js-new-person-social-apps-app-id").val("").removeClass("error")
          $(self.el).find(".js-new-person-social-apps-app").val("").removeClass("error")
          $(self.el).find(".js-new-person-social-apps-link").val("").removeClass("error")
    else
      $(@el).find("input").each (i, input) ->
        if $(input).val() == ""
          $(input).addClass("error")
        else
          $(input).removeClass("error")

  destroy: (e) ->
    container = $(e.target).parents(".span12").first()
    id = $(e.target).attr("data-id")
    $.ajax api_version + "person_social_apps/" + id,
      method: "DELETE"
      success: =>
        container.remove()
        $(".notifications").html("Social app link removed.").show().fadeOut(10000)