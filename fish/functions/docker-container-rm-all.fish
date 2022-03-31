function docker-container-rm-all
	docker rm -f (docker ps -a -q)
end
