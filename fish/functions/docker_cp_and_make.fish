function docker_cp_and_make
    set -l container_name $argv[1]
    set -l dir $argv[2]

    docker cp $dir $container_name:/build_svc
    docker exec -w /build_svc/$dir $container_name make
end
