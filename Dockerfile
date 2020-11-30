FROM registry.fedoraproject.org/fedora:30
LABEL name="chrony"

RUN dnf install -y --nodocs --setopt=install_weak_deps=False \
                gnutls-devel nettle-devel libcap-devel libseccomp-devel \
                bison git-core gcc make rubygem-asciidoctor && \
        dnf -y clean all

RUN git clone https://github.com/mlichvar/chrony.git

RUN cd chrony && \
        ./configure --enable-debug --enable-scfilter --prefix=/usr && \
        make -j1 && \
        make install

RUN mkdir /etc/chrony

COPY trust.pem /etc/pki/ca-trust/source/anchors/trust.pem
RUN update-ca-trust

COPY chrony.conf /etc
COPY server.crt server.key /etc/chrony/

RUN chmod 640 /etc/chrony/server.key /etc/chrony/server.crt
RUN chown -R root /etc/chrony/server.key /etc/chrony/server.crt

USER 0
CMD ["/usr/sbin/chronyd", "-x", "-d", "-d", "-F", "1"]

