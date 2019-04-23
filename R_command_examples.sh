RUN R -e 'install.packages(c( \
    "uuid",  \
    "reshape2",  \
    "bigrquery",  \
    "googleCloudStorageR",  \
    "tidyverse"), \
    repos="http://cran.mtu.edu")' \
 && R -e 'devtools::install_github("DataBiosphere/Ronaldo")' \
 && R -e 'devtools::install_github("IRkernel/IRkernel")' \
 && R -e 'IRkernel::installspec(user=FALSE)' 
