.PHONY: docker patch apk

ANDROID_REPO := tailscale-android/
PATCHFILES := custom_server.patch
DOCKER_TAG := tailscale-android

docker:
	docker build -t $(DOCKER_TAG) $(ANDROID_REPO)

$(PATCHFILES):
	sed 's|\$$TAILSCALE_SERVER|'"$$TAILSCALE_SERVER"'|' < $@.tpl > $@
	# envsubst not in tailscale-android container
	#envsubst '$$TAILSCALE_SERVER' < $@.tpl > $@
	patch -d $(ANDROID_REPO) -p1 < $@

patch: $(PATCHFILES)

apk:
	make -C $(ANDROID_REPO) tailscale-debug.apk

clean:
	rm -f $(PATCHFILES)
	git -C $(ANDROID_REPO) reset --hard
	git -C $(ANDROID_REPO) clean -dfx
