FROM registry.fedoraproject.org/fedora:30
LABEL name="chrony"

RUN dnf install -y --nodocs --setopt=install_weak_deps=False \
		gnutls-devel nettle-devel libcap-devel libseccomp-devel \
		bison git-core gcc make rubygem-asciidoctor && \
	dnf -y clean all

RUN git clone https://git.tuxfamily.org/chrony/chrony.git

RUN cd chrony && \
	./configure --enable-debug --enable-scfilter --prefix=/usr && \
	make -j1 && \
	make install

RUN mkdir /etc/chrony

COPY chrony.conf /etc
COPY server.crt server.key /etc/chrony/

USER 0
CMD ["/usr/sbin/chronyd", "-x", "-u", "nobody", "-d", "-d", "-F", "1"]



