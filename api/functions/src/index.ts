import * as functions from 'firebase-functions'
import * as express from 'express'
import { addEntry, getAllEntries, updateEntry, deleteEntry,getEntryByEmailParam,getEntryByEmailQueryString } from './entryController'
import { addDevCampUser, deleteDevCampUser, getAllDevCampUsers, getDevCampUserByNameParam, getDevCampUserByNameQueryString, updateDevCampUser } from './devcampController'

const api = express()

api.get('/', (req, res) => res.status(200).send('Hey there!'))

api.get('/entry', getEntryByEmailQueryString)
api.get('/entry/:email', getEntryByEmailParam)
api.get('/entries', getAllEntries)
api.post('/entries', addEntry)
api.patch('/entries/:entryId', updateEntry)
api.delete('/entries/:entryId', deleteEntry)

api.get('/devcampuser', getDevCampUserByNameQueryString)
api.get('/devcampuser/:name', getDevCampUserByNameParam)
api.get('/devcampusers', getAllDevCampUsers)
api.post('/devcampusers', addDevCampUser)
api.patch('/devcampusers/:id', updateDevCampUser)
api.delete('/devcampusers/:id', deleteDevCampUser)

exports.api = functions.https.onRequest(api)