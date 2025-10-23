#pragma once

#include <QObject>

class Calculator : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString display READ display NOTIFY displayChanged)

public:
    explicit Calculator(QObject *parent = nullptr);

    QString display() const;

    Q_INVOKABLE void input(const QString &text);
    Q_INVOKABLE void clear();
    Q_INVOKABLE void calculate();

signals:
    void displayChanged();

private:
    QString m_expression;
    QString m_display;

    void updateDisplay(const QString &value);
};
