mkdir occlum_workspace && cd occlum_workspace
occlum init && rm -rf image
copy_bom -f ../hello.yaml --root image --include-dir /opt/occlum/etc/template
occlum build
