import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Window
import QtQuick.Dialogs

ApplicationWindow {

    QtObject {
        id: internal
    }

    id: root
    title: qsTr("Login")
    visible: true
    minimumHeight: 560
    minimumWidth: 420
    maximumHeight: 560
    maximumWidth: 420
    color: "transparent"
    flags: Qt.FramelessWindowHint | Qt.Window
    Rectangle {
        color: "transparent"
        anchors.fill: parent
        width: parent.width
        height: parent.height
        clip: true
        Image {
            source: "../images/LoginBg.png"
            anchors.fill: parent
            smooth: true
        }
        Rectangle {
            id: titleBar
            width: parent.width
            height: 67
            color: "transparent"
            MouseArea {
                anchors.fill: parent
                property real lastMouseX: 0
                property real lastMouseY: 0
                onPressed: {
                    lastMouseX = mouseX
                    lastMouseY = mouseY
                }
                onMouseXChanged: root.x += (mouseX - lastMouseX)
                onMouseYChanged: root.y += (mouseY - lastMouseY)
            }

            Image {
                source: "../images/CloseBtn.png"
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 40
                anchors.topMargin: 25
                anchors.right: parent.right
                width: 30
                height: 30
                Button {
                    width: parent.width
                    height: parent.height
                    onClicked: Qt.quit()
                    background: Rectangle {
                        color: "transparent"
                    }
                    HoverHandler {
                        acceptedDevices: PointerDevice.Mouse
                        cursorShape: Qt.PointingHandCursor
                    }
                }
            }
        }
        // Main
        TextField {
            id: nameField
            width: 270
            text: qsTr("")
            selectByMouse: true
            placeholderText: qsTr("Your Name...")
            verticalAlignment: Text.AlignVCenter
            anchors.topMargin: 60
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: titleBar.bottom
            font.pointSize: 15
            placeholderTextColor: "#f3f3f3"
            color: "#f3f3f3"
            font.family: "Akira Expanded"
        }

        TextField {
            id: passField
            width: 270
            text: qsTr("")
            selectByMouse: true
            placeholderText: qsTr("Your Password...")
            placeholderTextColor: "#f3f3f3"
            color: "#f3f3f3"
            verticalAlignment: Text.AlignVCenter
            anchors.topMargin: 40
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: nameField.bottom
            font.pointSize: 14
            font.family: "Akira Expanded"
            echoMode: TextInput.Password
        }

        CheckBox {
            id: rememberAcc
            text: qsTr("<font color=\"#f3f3f3\">Remember me</font>")
            anchors.top: passField.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 10
            anchors.topMargin: 12
            font.family: "Akira Expanded"
        }

        Image {
            id: loginBtn
            source: "../images/LoginBtn.png"
            anchors.top: rememberAcc.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: 230
            height: 120
            anchors.topMargin: 12
            Button {
                width: parent.width - 18
                height: parent.height - 18
                onClicked: backend.cLogin(nameField.text, passField.text)
                background: Rectangle {
                    color: "transparent"
                }
                HoverHandler {
                    acceptedDevices: PointerDevice.Mouse
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }
    }

    Dialog {
        id: centeredDialog
        x: (root.width - width) / 2
        y: (root.height - height) / 2
        height: 140
        width: 300
        focus: true
        modal: true

        property alias text: messageText.text

        Label {
            id: messageText

            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter

            anchors.fill: parent
        }

        standardButtons: Dialog.Ok
    }

    Connections{
        target: backend
        property string username: ""
        function onSignalUser(myUser) {username = myUser}
        function onSignalIn(boolValue) {
            if (boolValue) {
                var component = Qt.createComponent("../qml/main.qml");
                var win = component.createObject();
                win.textUsername = username;
                visible = false;
                win.show();
            } else {
                centeredDialog.title = qsTr("Error!")
                centeredDialog.text = qsTr("Incorrect Username or password")
                centeredDialog.visible = true
            }
        }
    }
}