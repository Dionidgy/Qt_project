import QtQuick 2.6
import QtQuick.Controls 2.2

Item {
    property alias label: label.text
    property var value
    property bool valid: value
    property alias notValidText: textField.placeholderText

    height: textField.height

    Column {
        width: parent.width

        Label {
            id: label
            visible: valid
        }
        TextField {
            id: textField
            text: valid ? "%1".arg(value) : ""
            readOnly: true
            width: parent.width
        }
    }
}
