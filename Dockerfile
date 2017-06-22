FROM jplimce/gov.nasa.jpl.imce.ontologies.processor:0.1.3

# Environment Variables
ENV IMCE=/imce \
    WORKFLOW=$IMCE/workflow/workflow
# Add ontologies
ADD ./ontologies $IMCE/ontologies

# Add target
RUN ln -s /imce/target /imce/workflow/target

# Run workflow
RUN /bin/bash -c "cd $WORKFLOW/; source ./env.sh; make bootstrap"
RUN /bin/bash -c "cd $WORKFLOW/; source ./env.sh; make dependencies" 
RUN /bin/bash -c "cd $WORKFLOW/; source ./env.sh; make loadprod"