import * as functions from 'firebase-functions'
import * as express from 'express'
import { addEntry, getAllEntries, updateEntry, deleteEntry,getEntryByEmailParam,getEntryByEmailQueryString } from './entryController'

const api = express()

api.get('/', (req, res) => res.status(200).send('Hey there!'))

api.get('/entry', getEntryByEmailQueryString)
api.get('/entry/:email', getEntryByEmailParam)
api.get('/entries', getAllEntries)
api.post('/entries', addEntry)
api.patch('/entries/:entryId', updateEntry)
api.delete('/entries/:entryId', deleteEntry)

exports.api = functions.https.onRequest(api)