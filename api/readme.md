# Steps to setup api for cloud firestore database

``` command
npm install -g firebase-tools
```

## log in and init firebase project

``` command
firebase login
firebase init
```

``` command
cd functions
npm install --save express body-parser firebase-functions-helper
```

## Accessing our service account config

``` command
firebase functions:config:set private.key="YOUR API KEY" project.id="YOUR CLIENT ID" client.email="YOUR CLIENT EMAIL"
```

Deploy

``` command
firebase deploy
```
