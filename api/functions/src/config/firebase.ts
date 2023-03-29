import * as admin from 'firebase-admin'
import * as functions from 'firebase-functions'

admin.initializeApp({
  credential: admin.credential.cert({
    privateKey: functions.config().private.key.replace(/\\n/g, '\n'),
    projectId: functions.config().project.id,
    clientEmail: functions.config().client.email
  }),
  databaseURL: 'https://flutterdevcamp-e1211.firebaseio.com'
})

const db = admin.firestore()
db.settings({ ignoreUndefinedProperties: true })
export { admin, db }