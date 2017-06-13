FROM jplimce/gov.nasa.jpl.imce.ontologies.processor

# Environment Variables
ENV IMCE=/imce \
    WORKFLOW=$IMCE/workflow/workflow
# Add ontologies
ADD ./gov.nasa.jpl.imce.ontologies.public/ontologies $IMCE/ontologies

# Setup
RUN /bin/bash -c "cd $WORKFLOW/; source ./env.sh; make bootstrap"
RUN /bin/bash -c "cd $WORKFLOW/; source ./env.sh; make dependencies" 
RUN /bin/bash -c "cd $WORKFLOW/; source ./env.sh; make loadprod"