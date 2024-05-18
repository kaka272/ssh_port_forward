
docker pull probezy/cpolar
docker run -d -p 9004:1314 kaka272/unisoc:ss0.1
cmd="cpolar authtoken YTg3YjIxYWUtMjdmOS00NTM0LTlkNmEtZTU0YzVjYmFlNGY0"
docker run -id --network host --name cpolar probezy/cpolar bash -c "${cmd} ; cpolar tcp 9004"
