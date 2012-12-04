window.edra = 
  routes: 
    list: {}
    add: (ops) ->
      for k,v of ops
        @list[k] = v
    getAll: -> @list
    
  models:
    list: {}
    add: (name,f) ->
      @list[name] = f
    run: ->
      for name,f of @list
        console.debug "Setting up #{name}"
        f()
        
window.testEdra = ->
  edra.routes.add(a: "42")
  console.debug edra.routes.list