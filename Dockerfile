FROM rocker/tidyverse:latest

RUN install2.r --error \
    --deps TRUE \
    renv

COPY src ./opt/src

COPY ./entry_point.sh /opt/
RUN chmod +x /opt/entry_point.sh

COPY ./requirements.txt /opt/

RUN mkdir -p /opt/tmp && chmod 1777 /opt/tmp
ENV TMPDIR /opt/tmp
ENV TEMP /opt/tmp
ENV TMP /opt/tmp

WORKDIR /opt/src

RUN R -e "devtools::install_version('jsonlite', version='1.8.7', repos='https://cloud.r-project.org/')"
RUN R -e "devtools::install_version('fastDummies', version='1.7.3', repos='https://cloud.r-project.org/')"
RUN R -e "devtools::install_version('automl', version='1.3.2', repos='https://cloud.r-project.org/')"
RUN R -e "devtools::install_version('dplyr', version='1.1.3', repos='https://cloud.r-project.org/')"
RUN R -e "devtools::install_version('magrittr', version='2.0.3', repos='https://cloud.r-project.org/')"


USER 1000

ENTRYPOINT ["/opt/entry_point.sh"]
