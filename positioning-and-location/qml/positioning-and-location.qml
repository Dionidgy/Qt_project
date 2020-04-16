import QtQuick 2.6
import QtQuick.Controls 2.2

ApplicationWindow {
    title: qsTr("Positioning and location")
    width: 360; height: 640
    visible: true

    StackView {
        id: stackView
        initialItem: Qt.resolvedUrl("pages/MapPage.qml")
        // ToDo: set MapPage as initial page
        anchors.fill: parent
    }
}
