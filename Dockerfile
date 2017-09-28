FROM jplimce/gov.nasa.jpl.imce.ontologies.processor:0.1.4-caesar_demo

# Environment Variables
ENV IMCE=/imce \
    WORKFLOW=$IMCE/workflow/workflow
# Add ontologies
ADD ./ontologies/ontologies $IMCE/ontologies

# Add target
RUN rm -r /imce/workflow/target; ln -s /imce/target /imce/workflow/target

# Run workflow
RUN /bin/bash -c "cd $WORKFLOW/; source ./env.sh; make bootstrap"
RUN /bin/bash -c "cd $WORKFLOW/; source ./env.sh; make dependencies" 
RUN /bin/bash -c "cd $WORKFLOW/; source ./env.sh; cd /imce/workflow/target/run; nohup /imce/workflow/target/fuseki/fuseki-server --port=8898 > /imce/workflow/target/workflow/log/fuseki.log 2>&1 & echo $! > /imce/workflow/target/workflow/log/fuseki.pid; cd /imce/workflow/target/workflow; nice make -j8 -l16 load-production"
