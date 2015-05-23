#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQmlEngine>
#include <QDir>
#include <QDebug>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQuickView view;

    QDir dir("./Output");
       if (!dir.exists())
       {
           qDebug()<<QString("Output path does not exist. Create path:").append(dir.absolutePath());
           dir.mkpath(".");
       }


    view.setResizeMode(QQuickView::SizeRootObjectToView);
    QObject::connect(view.engine(), SIGNAL(quit()), qApp, SLOT(quit()));
    view.setSource(QUrl("qrc:///main.qml"));
    view.resize(800, 600);
    view.show();
    return app.exec();
}

