import bottle

@bottle.get("/")
def osnovna_stran():
    return bottle.template('osnovna_stran.tpl')

bottle.run(reloader=True, debug=True)