powerdns-sqlite3-gui
================

powerdns-sqlite3��WebGUI��PowerDNS-Admin���p�b�P�[�W���܂����B

���ύX�_

�EPowerDNS-Admin���ǉ��A����ɔ����W����Web�T�[�o�[�@�\��8080�|�[�g�œ��삷��悤�C���B

�E���ϐ��ɁuRECURSOR�v��ǉ��B����ɂ��ݒ�O�h���C���̊O���₢���킹����w��ł��܂��B


###Usage:

git clone https://github.com/gittrname/powerdns-sqlite3-gui.git

docker build -t powerdns-sqlite3-gui powerdns-sqlite3-gui

docker run -d --name pdns -p 53:53/udp -p 53:53/tcp -p 80:80 -p 8080:8080 -v /your/shared/volume:/data -e "WEBPASSWD=password" -e "RECURSOR=8.8.8.8" powerdns-sqlite3-gui:latest
