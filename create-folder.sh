base=dist
dirs="rsmgmt rscontrol rsconsole tomcat elasticsearch rscontrol logstash rabbitmq  rsexpert rslog rsmgmt rsremote"; \
for d in $dirs; do \
    mkdir -p $base/$d ; \
done;