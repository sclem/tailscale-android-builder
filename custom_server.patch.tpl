diff --git a/cmd/tailscale/backend.go b/cmd/tailscale/backend.go
index 966689d..d258147 100644
--- a/cmd/tailscale/backend.go
+++ b/cmd/tailscale/backend.go
@@ -136,8 +136,11 @@ func newBackend(dataDir string, jvm *jni.JVM, appCtx jni.Object, store *stateSto
 
 func (b *backend) Start(notify func(n ipn.Notify)) error {
 	b.backend.SetNotifyCallback(notify)
+	prefs := ipn.NewPrefs()
+	prefs.ControlURL = "$TAILSCALE_SERVER"
 	return b.backend.Start(ipn.Options{
-		StateKey: "ipn-android",
+		StateKey:    "ipn-android",
+		UpdatePrefs: prefs,
 	})
 }
 
