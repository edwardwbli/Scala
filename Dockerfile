FROM frolvlad/alpine-oraclejdk8:slim

ENV SCALA_VERSION=2.12.0-M5 \
    SCALA_HOME=/usr/share/scala \
    SCALA_PROJECT=/home/scala

ADD ./ "${SCALA_PROJECT}"

# NOTE: bash is used by scala/scalac scripts, and it cannot be easily replaced with ash.
RUN apk add --no-cache bash wget ca-certificates curl zsh git nano && \
    cd "/tmp" && \
    wget "https://downloads.typesafe.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz" && \
    tar xzf "scala-${SCALA_VERSION}.tgz" && \
    mkdir "${SCALA_HOME}" && \
    rm "/tmp/scala-${SCALA_VERSION}/bin/"*.bat && \
    mv "/tmp/scala-${SCALA_VERSION}/bin" "/tmp/scala-${SCALA_VERSION}/lib" "${SCALA_HOME}" && \
    ln -s "${SCALA_HOME}/bin/"* "/usr/bin/" && \
    rm -rf "/tmp/"*

RUN cd "${SCALA_PROJECT}" && \
    wget -O sbt-launch.jar https://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt-launch/0.13.12/sbt-launch.jar?_ga=1.169679329.115251517.1477186777 && \
    ./sbt

#install.sh is copy from https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
#and comment "set -e", as build will always fail due to return code not = 1.
#TODO will try to investigate it
RUN chmod 775 /home/scala/install.sh

RUN /home/scala/install.sh


CMD ["zsh"]
