#include "calculator.h"
#include <QJSEngine>
#include <QJSValue>

Calculator::Calculator(QObject *parent)
    : QObject(parent)
{
    updateDisplay("0");
}

QString Calculator::display() const
{
    return m_display;
}

void Calculator::input(const QString &text)
{
    if (m_display == "0")
        m_display.clear();

    m_expression += text;
    updateDisplay(m_expression);
}

void Calculator::clear()
{
    m_expression.clear();
    updateDisplay("0");
}

void Calculator::calculate()
{
    QJSEngine engine;
    QJSValue result = engine.evaluate(m_expression);

    if (result.isError()) {
        updateDisplay("Error");
        m_expression.clear();
        return;
    }

    QString value = result.toString();
    updateDisplay(value);
    m_expression = value;
}

void Calculator::updateDisplay(const QString &value)
{
    if (m_display == value)
        return;
    m_display = value;
    emit displayChanged();
}
