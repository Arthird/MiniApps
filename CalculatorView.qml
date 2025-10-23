//CalculatorView.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import MiniApps

Page {
    id: page
    title: "Calculator"

    ColumnLayout {
        id: root
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        // Экземпляр логики калькулятора
        Calculator {
            id: calc
        }

        // Экран вывода
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height * 0.15
            color: "#222"
            radius: 8

            Text {
                id: display
                text: calc.display
                anchors.fill: parent
                anchors.margins: 10
                color: "white"
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: Math.max(16, parent.height * 0.3)
                elide: Text.ElideLeft
                wrapMode: Text.NoWrap
            }
        }

        // Кнопки
        GridLayout {
            id: grid
            columns: 4
            Layout.fillWidth: true
            Layout.fillHeight: true
            rowSpacing: 8
            columnSpacing: 8

            Repeater {
                model: [
                    "7","8","9","/",
                    "4","5","6","*",
                    "1","2","3","-",
                    "0",".","=","+"
                ]

                delegate: Button {
                    text: modelData
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    font.pixelSize: Math.max(14, grid.height / 12)
                    onClicked: {
                        if (text === "=")
                            calc.calculate()
                        else
                            calc.input(text)
                    }
                }
            }
        }

        // Кнопка очистки
        Button {
            text: "C"
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height * 0.12
            background: Rectangle {
                color: "#b33"
                radius: 8
            }
            font.pixelSize: Math.max(16, parent.height * 0.05)
            onClicked: calc.clear()
        }
    }
}
