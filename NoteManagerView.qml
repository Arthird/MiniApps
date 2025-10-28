// NoteManagerView.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import MiniApps

Page {
    id: notePage
    title: "Notes"

    // Создаем экземпляр нашей C++ логики
    NoteManager {
        id: noteManager
    }

    ListView {
        id: listView
        anchors.fill: parent
        anchors.topMargin: notePage.header ? notePage.header.height : 0
        clip: true
        spacing: 20

        model: noteManager.notes

        delegate: ItemDelegate {
            width: parent.width
            padding: 10

            // Динамическая высота делегата
            height: noteField.implicitHeight + 10

            RowLayout {
                width: parent.width
                anchors.verticalCenter: undefined // убираем, чтобы не "сжимало"
                spacing: 10

                // Текстовое поле
                TextArea {
                    id: noteField
                    text: modelData
                    Layout.fillWidth: true
                    placeholderText: "Type your note..."
                    wrapMode: TextEdit.Wrap
                    implicitHeight: contentHeight + 20  // адаптируем под содержимое

                    onFocusChanged: {
                        if (!focus && text !== modelData) {
                            noteManager.editNote(index, text)

                        }
                    }
                }

                // Кнопка удаления
                Button {
                    text: "X"
                    flat: true
                    onClicked: noteManager.deleteNote(index)

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


        ScrollIndicator.vertical: ScrollIndicator { }
    }

    footer: Button {
        text: "Add New Note"
        width: parent.width // Растягиваем на всю ширину

        onClicked: {
            noteManager.addNote()
            // Прокручиваем список в самый конец, чтобы увидеть новую заметку
            listView.positionViewAtEnd()
        }
    }
}
