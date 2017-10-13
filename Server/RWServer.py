from flask import Flask
import contact_pb2
import RWDict

app = Flask(__name__)

# Helper method to convert a string to a Contact Type
def stringToContactType(string):
    return {
        'SPEAKER' : contact_pb2.Contact.SPEAKER,
        'VOLUNTEER' : contact_pb2.Contact.VOLUNTEER,
        'ATTENDANT' : contact_pb2.Contact.ATTENDANT
    }[string]

# Get current user - treat this as an RWDevCon Attendee using an app
@app.route("/currentUser")
def getCurrentUser():
    contact = contact_pb2.Contact()
    contact.first_name = "Vincent"
    contact.last_name = "Ngo"
    contact.twitter_name = "@vincentngo2"
    contact.email = "vincent@mail.com"
    contact.github_link = "github.com/vincentngo"
    contact.type = contact_pb2.Contact.ATTENDANT
    contact.imageName = "vincentngo.png"
    str = contact.SerializeToString()

    return str

# Get Speakers speaking at the conference. Loop through the predefinied array of contact dictionary, and create a Contact object, adding it to an array and serializing our Speakers object.
@app.route("/speakers")
def getSpeakers():
    contacts = []
    for contactDict in RWDict.speakers:
        contact = contact_pb2.Contact()
        contact.first_name = contactDict['first_name']
        contact.last_name = contactDict['last_name']
        contact.twitter_name = contactDict['twitter_name']
        contact.email = contactDict['email']
        contact.github_link = contactDict['github_link']
        contact.type = stringToContactType(contactDict['type'])
        contact.imageName = contactDict['imageName']
        contacts.append(contact)
    speakers = contact_pb2.Speakers()
    speakers.contacts.extend(contacts)
    return speakers.SerializeToString()

if __name__ == "__main__":
    app.run()
