.PHONY: docker patch apk

ANDROID_REPO := tailscale-android/
PATCHFILES := custom_server.patch
DOCKER_TAG := tailscale-android

docker:
	docker build -t $(DOCKER_TAG) $(ANDROID_REPO) && \
		docker build -t $(DOCKER_TAG)-builder -f Dockerfile .

$(PATCHFILES):
	envsubst '$$TAILSCALE_SERVER' < $@.tpl > $@
	patch -d $(ANDROID_REPO) -p1 < $@

patch: $(PATCHFILES)

apk:
	make -C $(ANDROID_REPO) tailscale-debug.apk

clean:
	rm -f $(PATCHFILES)
	git -C $(ANDROID_REPO) reset --hard
	git -C $(ANDROID_REPO) clean -dfx
