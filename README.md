Демо проект на go.
NOTE: Умыщенно взят viper который за собой тянет много пакетов.
Цель - максимально ускорить сборку проекта в docker.

Требуется активировтаь в докере следующую опцию
```json
{ "features": { "buildkit": true } }
```
Подробней по ссылке https://docs.docker.com/develop/develop-images/build_enhancements/#to-enable-buildkit-builds
