import QtQuick 2.6
import Sailfish.Silica 1.0
import "../assets"
// ToDo: import WebSockets
import QtWebSockets 1.0

Page {
    property bool loggedIn: false
    // ToDo: try your own echo server
    property url serverUrl: "wss://echo.websocket.org"
    // ToDo: add user name property

    WebSocket {
        id: webSocket
        // ToDo: set url
        url: serverUrl
        active: true
        onTextMessageReceived: {
            // ToDo: implement handler
            chatView.postIncomingText(message)
            // ToDo: implement handshakeResponse and text types handlers
        }
        onStatusChanged: {
            if (webSocket.status === WebSocket.Error) {
                console.log("Error: %1".arg(webSocket.errorString));
            } else if (webSocket.status === WebSocket.Open) {
                chatView.postInfo(qsTr("Socket opened"));
                // ToDo: send handshake here
                loggedIn = true;
            } else if (webSocket.status === WebSocket.Closed) {
                chatView.postInfo(qsTr("Socket closed"));
                loggedIn = false;
            }
            chatView.scrollToBottom();
        }
    }
    SilicaFlickable {
        anchors.fill: parent

        Column {
            width: parent.width
            height: parent.height

            ChatView {
                id: chatView
                width: parent.width
                height: parent.height - inputArea.height
                clip: true
                header: PageHeader { title: qsTr("WebSockets Client") }
            }
            Rectangle {
                id: inputArea
                width: parent.width
                height: childrenRect.height
                color: Theme.rgba(Theme.highlightBackgroundColor, Theme.highlightBackgroundOpacity)

                TextField {
                    width: parent.width
                    enabled: loggedIn
                    placeholderText: qsTr("Input message")
                    label: qsTr("Message")
                    EnterKey.enabled: text.length > 0
                    EnterKey.iconSource: "image://theme/icon-m-sms"
                    EnterKey.onClicked: {
                        // ToDo: send to WebSocket
                        webSocket.sendTextMessage(text);
                        // ToDo: send text with message type
                        chatView.postOutgoingText(text, qsTr("Me"));
                        chatView.scrollToBottom();
                        text = "";
                    }
                }
            }
        }
    }
}
