from connection.connection import connect,connection_insert,connection_select,connection_update

def getUserAll():
    dataBase = connect()
    cursorObject = dataBase.cursor()
    try:
        stmt = ("SELECT "
                    "a.idUser,a.codigo_uni,a.password,a.idProfile,b.primer_nombre,b.segundo_nombre,b.apellido_paterno,b.apellido_materno,b.email,b.fecha_nacimiento,c.idCharacteristic,c.botellasAcumuladas,c.botellasCanje,c.valesAcumulados "
                "FROM "
                    "user a,"
                    "profile b,"
                    "characteristic c "
                "WHERE "
                    "a.idProfile=b.idProfile and "
                    "a.idUser=c.idUser "
                "ORDER BY "
                    "a.codigo_uni ASC")
        myresult = connection_select(cursorObject,stmt)
        cursorObject.close()
        dataBase.close()
        return myresult
    except:
        cursorObject.close()
        dataBase.close()
        return { 'flag' : 0 ,'error':'getUserAll'}