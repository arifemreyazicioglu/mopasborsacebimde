import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp(functions.config().firebase);

exports.sendNotificationToTopic = functions.firestore
    .document("Person/{uid}")
    .onUpdate(async (event) => {
        // const title = event.after.get("title");
        const arif: string[] = event.before.get("alarms");
        const arif1: string[] = event.after.get("alarms");
        let content = "";
        if (arif1.length == 0) {
            content = arif[0];
            const message = {
                notification: {
                    title: "Bildiriminiz var!",
                    body: content + " oldu",
                },
                topic: "fcm_test",
            };
            const response = await admin.messaging().send(message);
            console.log(response);
        }
        if (arif.length > arif1.length && arif1.length != 0) {
            for (let i = 0; i < arif.length; i++) {
                for (let j = 0; j < arif1.length; j++) {
                    if (arif[i].includes(arif1[j]) == false) {
                        content = arif[i];
                        break;
                    }
                }
            }
            const message = {
                notification: {
                    title: "Bildiriminiz var!",
                    body: content + " oldu",
                },
                topic: "fcm_test",
            };
            const response = await admin.messaging().send(message);
            console.log(response);
        }
    });