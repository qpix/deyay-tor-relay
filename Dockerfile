FROM fedora:latest

RUN yum update -y
RUN yum install -y tor

ENV torrc "/etc/tor/torrc"

# Remove comments and empty lines.
RUN egrep --invert-match '^(#|$)' ${torrc} > ${torrc}.tmp
RUN mv ${torrc}.tmp ${torrc}

# Add non-exit relay configuration.
RUN echo "ORPort 9001" >> ${torrc}
RUN echo "Nickname DeYay" >> ${torrc}
RUN echo "ContactInfo Christian Aberg <christian.aberg@live.com>" >> ${torrc}
RUN echo "ExitRelay 0" >> ${torrc}
RUN echo "IPv6Exit 0" >> ${torrc}
RUN echo "ExitPolicy reject *:*" >> ${torrc}

# Running tor.
CMD runuser --user toranon --group toranon -- tor
