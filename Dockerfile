FROM jupyter/pyspark-notebook

# Install Java (required for Hive & Spark)
USER root
RUN apt-get update && apt-get install -y openjdk-8-jdk-headless

# Set environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV SPARK_HOME=/usr/local/spark
ENV PATH="$SPARK_HOME/bin:$PATH"

# Install Apache Hive
RUN wget https://downloads.apache.org/hive/hive-3.1.3/apache-hive-3.1.3-bin.tar.gz && \
    tar -xvzf apache-hive-3.1.3-bin.tar.gz && \
    mv apache-hive-3.1.3-bin /usr/local/hive && \
    rm apache-hive-3.1.3-bin.tar.gz

ENV HIVE_HOME=/usr/local/hive
ENV PATH="$HIVE_HOME/bin:$PATH"

# Initialize Hive metastore
RUN schematool -dbType derby -initSchema

USER $NB_UID
