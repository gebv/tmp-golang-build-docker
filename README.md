Демо проект на go иллюстрирующий разные опции сборки проекта в докере.

NOTE: Умышленно взят viper который за собой тянет много пакетов.

Цель - максимально ускорить сборку проекта в docker.

**Вывод - кешировать /root/.cache/go-build помимо $GOPATH/pkg/mod**

Три кейса
* без кеширования
* используя эксперементальную опцию `--mount=type=cache,target=/root/.cache/go-build`
* вручную закешированный `/root/.cache/go-build`

# Быстрый старт

Запустить все три кейса
```bash
make demo
```

В логе будет интересовать время на каждый кейс
```
$ make demo
make test 2>&1 | grep -C 2 real
#20 naming to docker.io/gebv/tmp-golang-build-docker:build-experimental done
#20 DONE 0.1s
        6.48 real         0.09 user         0.07 sys
docker run --rm -it gebv/tmp-golang-build-docker:build-experimental
2020/06/30 13:08:07 Flag value 2020-06-30T13:08:00 build-experimental
--
--
#18 naming to docker.io/gebv/tmp-golang-build-docker:build done
#18 DONE 0.1s
        8.95 real         0.07 user         0.05 sys
docker run --rm -it gebv/tmp-golang-build-docker:build
2020/06/30 13:08:16 Flag value 2020-06-30T13:08:07 build
--
--
#19 naming to docker.io/gebv/tmp-golang-build-docker:build-manual-cache done
#19 DONE 0.1s
        3.54 real         0.06 user         0.04 sys
docker run --rm -it gebv/tmp-golang-build-docker:build-manual-cache
2020/06/30 13:08:21 Flag value 2020-06-30T13:08:17 build
$
```

Видимо что с эксперементальной опцией `--mount=type=cache,target=/root/.cache/go-build`
> 6.48 real         0.09 user         0.07 sys

без кешей для go build
> 8.95 real         0.07 user         0.05 sys

вручную закешированный `/root/.cache/go-build`
> 3.54 real         0.06 user         0.04 sys

# Эксперементальная опция для Dockerfile

Для кейса с `--mount=type=cache,target=/root/.cache/go-build` требуется активировтаь в докере следующую опцию
```json
{ "features": { "buildkit": true } }
```
Подробней по ссылке https://docs.docker.com/develop/develop-images/build_enhancements/#to-enable-buildkit-builds
