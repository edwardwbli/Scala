#Install SBT

1. Download sbt from http://www.scala-sbt.org/0.13/docs/zh-cn/Manual-Installation.html
2. build script and run
```bash
#!/bin/bash
SBT_OPTS="-Xms512M -Xmx1536M -Xss1M -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=256M"
java $SBT_OPTS -jar /home/scala/sbt-launch.jar "$@"
```
