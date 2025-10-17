# inspired by https://github.com/davetang/learning_docker/blob/main/rstudio/Dockerfile
# https://github.com/rocker-org/rocker-versioned2/blob/master/dockerfiles/rstudio_4.4.3.Dockerfile

# docker build -t rstudio .

FROM rocker/rstudio:4.3.2

# rocker/rstudio:4.3.2  
    # cat /etc/os-release
    # Ubuntu 22.04.4 LTS jammy 
    # for r devtools https://github.com/r-lib/devtools/issues/2472
# options(repos = c(CRAN = 'https://packagemanager.posit.co/cran/2023-12-21'))
# install.packages("pak")
# writeLines(pak::pkg_system_requirements("devtools", "ubuntu", "22.04"))
# writeLines(pak::pkg_system_requirements("lme4", "ubuntu", "22.04"))
# writeLines(pak::pkg_system_requirements("car", "ubuntu", "22.04"))
# writeLines(pak::pkg_system_requirements("effects", "ubuntu", "22.04"))
# 
# the last two install: fc-list | grep "Times New Roman" to /usr/share/fonts/truetype/msttcorefonts/
# Pre-accept the EULA for the Microsoft Core Fonts installer
RUN apt-get update && \
    echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections && \
    apt-get install -y --no-install-recommends \
        libx11-dev\
        git\
        libcurl4-openssl-dev\
        libssl-dev\
        make\
        cmake\
        libgit2-dev\
        zlib1g-dev\
        pandoc\
        libfreetype6-dev\
        libjpeg-dev\
        libpng-dev\
        libtiff-dev\
        libwebp-dev\
        libicu-dev\
        libfontconfig1-dev\
        libfribidi-dev\
        libharfbuzz-dev\
        libxml2-dev \
        ttf-mscorefonts-installer \
        && fc-cache -fv \
        && apt-get clean all && \
        apt-get purge && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# https://packagemanager.posit.co/cran/__linux__/jammy/2023-12-21 is set for the amd64 platform, 
# https://packagemanager.posit.co/cran/2023-12-21 is set for the arm64 platform as the default CRAN mirror.
RUN Rscript -e 'options(repos = c(CRAN = "https://packagemanager.posit.co/cran/2023-12-21"))' \
            -e 'install.packages("devtools")' \
            -e 'Sys.setenv(XML_CONFIG="/usr/bin/xml2-config")' \
            -e 'install.packages("XML",type="source")' \
            -e 'devtools::install_github("jerryzhujian9/ezR")' \
            -e 'remove.packages("Rttf2pt1")' \
            -e 'remotes::install_version("Rttf2pt1", version="1.3.8")' \
            -e 'library(extrafont)' \
            -e 'options(warn=1)' \
            -e 'font_import(prompt = FALSE)' \
            -e 'fonts()'

# Copy the .Rprofile file to the rstudio user's home directory
# The --chown flag ensures the user 'rstudio' owns the file, preventing permission issues.
COPY --chown=rstudio:rstudio Rprofile.R /home/rstudio/.Rprofile
COPY --chown=rstudio:rstudio rstudio-prefs.json /home/rstudio/.config/rstudio/rstudio-prefs.json
