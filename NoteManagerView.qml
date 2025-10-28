// NoteManagerView.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import MiniApps

Page {
    id: notePage
    title: "Notes"

    NoteManager {
        id: noteManager
    }

    ListView {
        id: listView
        anchors.fill: parent
        anchors.topMargin: notePage.header ? notePage.header.height : 0
        anchors.bottomMargin: notePage.footer ? notePage.footer.height : 0

        clip: true
        spacing: 20

        model: noteManager.notes

        delegate: ItemDelegate {
            width: parent.width
            padding: 10
            height: noteField.implicitHeight + 10

            RowLayout {
                width: parent.width
                spacing: 10

                TextArea {
                    id: noteField
                    text: modelData
                    Layout.fillWidth: true
                    placeholderText: "Type your note..."
                    wrapMode: TextEdit.Wrap
                    leftPadding: 6
                    rightPadding: 6
                    topPadding: 6
                    bottomPadding: 6

                    implicitHeight: Math.max(contentHeight + topPadding + bottomPadding + 8, 40)

                    onFocusChanged: {
                        if (!focus && text !== modelData) {
                            noteManager.editNote(index, text)
                        }
                    }
                }
                RowLayout {
                    spacing: 0

                    Button {
                        text: "✓"
                        flat: true
                        onClicked: {
                            noteManager.editNote(index, noteField.text)
                        }

                        contentItem: Text {
                            text: parent.text
                            color: "green"
                            font.bold: true
                            font.pixelSize: 16
                        }
                        background: Rectangle { color: "transparent" }
                    }
                    Button {
                        text: "X"
                        flat: true
                        onClicked: {
                            noteManager.editNote(index, noteField.text)
                            noteManager.deleteNote(index)
                        }

                        contentItem: Text {
                            text: parent.text
                            color: "red"
                            font.bold: true
                            font.pixelSize: 16
                        }
                        background: Rectangle { color: "transparent" }
                    }
                }
            }
        }

        ScrollIndicator.vertical: ScrollIndicator { }
    }

    footer: Button {
            id: addButton
            text: "Add New Note"
            width: parent.width

            onClicked: {
                listView.focus = true;
                noteManager.addNote();
                listView.positionViewAtEnd();
            }
        }
    }
