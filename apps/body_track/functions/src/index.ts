import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import * as moment from 'moment';
admin.initializeApp();

const db = admin.firestore();
const fcm = admin.messaging();

interface IToken {
    uid: string
    token: string
}

interface IPref {
    uid: string
    start: number
}

export const sendNotificationsHttp = functions.https.onRequest(async (req, res) => {
    await sendNotifications();

    res.end();
});


export const sendNotificationsScheduler = functions.pubsub.schedule('0 * * * *').onRun(async () => {
    await sendNotifications();

    return null;
});

const sendNotifications = async () => {
    const tokens: IToken[] = [];
    const prefs: IPref[] = [];

    await db.collection('tokens').get().then((snapshot) => {
        snapshot.forEach((document) => {
            tokens.push({
                uid: document.id,
                token: document.get('token'),
            });
        });
    });

    await db.collection('preferences').get().then((snapshot) => {
        snapshot.forEach((document) => {
            prefs.push({
                uid: document.id,
                start: document.get('start')?.toDate(),
            });
        });
    });

    tokens.forEach((token) => {
        prefs.forEach((pref) => {
            if (token.uid === pref.uid) {
                const current = moment(`2000 1 1 ${(new Date).getHours()}:00:00`);
                const start = (new Date(pref.start));
                let payload: admin.messaging.MessagingPayload | undefined = undefined;

                console.log(start, current, current.isoWeekday());

                if (start.getHours() === current.hour() && current.isoWeekday() === 7) {
                    payload = {
                        notification: {
                            title: 'Good Morning!',
                            body: 'Remember to weigh and measure yourself',
                        },
                    };
                } else if (start.getHours() === current.hour()) {
                    payload = {
                        notification: {
                            title: 'Good Morning!',
                            body: 'Remember to weigh yourself',
                        },
                    };
                }

                if (payload) {
                    fcm.sendToDevice(token.token, payload);
                }
            }
        });
    });
};
