import firebase_admin
from firebase_admin import firestore
from firebase_admin import credentials

# Use the private key file of the service account directly.
cred = credentials.Certificate("firebaseKey.json")
app = firebase_admin.initialize_app(cred)
db = firestore.client()

reservationCollection = None
doc = None


def init():
    global reservationCollection
    # Initilize the dataSet
    reservationCollection = db.collection("parking-areas").document('2023-04-16T19:46:16.558062').collection(
        "reservations")


def fetchAllDocs() -> dict[str, str]:
    global doc
    docs = reservationCollection.stream()

    if docs is not None:
        tempDict = {}

        for doc in docs:
            docDict = doc.to_dict()
            # create a dictionary only to hold the doc id and parkingArea
            tempDict[doc.id] = {"parkingArea": docDict["parkingArea"], "isReserved": docDict["isReserved"]}
        print(f"found docs {tempDict}")
        return tempDict
    else:
        return None


def writeFreeSpotsToDocs(parkSpotsDict: dict[int, int]):
    # get the dictionary which ahs doc id and parkingArea
    parkingAreaDict = fetchAllDocs()
    if parkingAreaDict is not None:
        for key, value in parkingAreaDict.items():
            # result = doc_ref.update({u'freeSpots': spots})
            # from index we get the position of the parking spot,from state we get its free or not
            for pos, Freestate in parkSpotsDict.items():
                if value["parkingArea"] == str(pos):
                    if Freestate == 0 and value["isReserved"] == "false":
                        reservationCollection.document(key).update({u'isReserved': "true"})
                        print(f"updated parking area reserved as true in doc {key}")
                    if Freestate == 1 and value["isReserved"] == "true":
                        print(f"updated parking area reserved as false in doc {key}")
                        reservationCollection.document(key).update({u'isReserved': "false"})
                



if __name__ == "__main__":
    init()

