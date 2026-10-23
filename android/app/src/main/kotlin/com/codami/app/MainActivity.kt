package com.codami.app

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.ContentValues
import android.content.Intent
import android.media.AudioAttributes
import android.media.Ringtone
import android.media.RingtoneManager
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.os.Environment
import android.provider.MediaStore
import android.provider.OpenableColumns
import android.view.WindowManager
import com.android.installreferrer.api.InstallReferrerClient
import com.android.installreferrer.api.InstallReferrerStateListener
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private var pendingResult: MethodChannel.Result? = null
    private var preview: Ringtone? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Draw into the camera notch area instead of a black strip when the status bar is hidden.
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            window.attributes = window.attributes.apply {
                layoutInDisplayCutoutMode =
                    WindowManager.LayoutParams.LAYOUT_IN_DISPLAY_CUTOUT_MODE_SHORT_EDGES
            }
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                "codami_alerts",
                "Lost and found alerts",
                NotificationManager.IMPORTANCE_HIGH,
            ).apply {
                description = "Pets lost or found in your city"
            }
            getSystemService(NotificationManager::class.java)
                .createNotificationChannel(channel)
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "codami/notification_sounds")
            .setMethodCallHandler(::onSoundCall)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "codami/install_referrer")
            .setMethodCallHandler { call, result ->
                if (call.method == "get") readInstallReferrer(result) else result.notImplemented()
            }
    }

    // The text after "referrer=" in the Play Store link this app was installed from.
    private fun readInstallReferrer(result: MethodChannel.Result) {
        val client = InstallReferrerClient.newBuilder(this).build()
        var answered = false
        fun answer(value: String?) {
            if (answered) return
            answered = true
            runOnUiThread { result.success(value) }
            try {
                client.endConnection()
            } catch (_: Exception) {
            }
        }
        try {
            client.startConnection(object : InstallReferrerStateListener {
                override fun onInstallReferrerSetupFinished(code: Int) {
                    answer(
                        if (code == InstallReferrerClient.InstallReferrerResponse.OK) {
                            try {
                                client.installReferrer.installReferrer
                            } catch (_: Exception) {
                                null
                            }
                        } else {
                            null
                        },
                    )
                }

                override fun onInstallReferrerServiceDisconnected() = answer(null)
            })
        } catch (_: Exception) {
            answer(null)
        }
    }

    override fun onDestroy() {
        preview?.stop()
        super.onDestroy()
    }

    private fun onSoundCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "capabilities" -> result.success(
                mapOf(
                    "channels" to (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O),
                    "systemSounds" to true,
                    "files" to (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q),
                ),
            )
            "createChannel" -> {
                createChannel(
                    call.argument<String>("id")!!,
                    call.argument<String>("name")!!,
                    call.argument<String>("kind")!!,
                    call.argument<String>("value"),
                )
                result.success(null)
            }
            "deleteChannel" -> {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    getSystemService(NotificationManager::class.java)
                        .deleteNotificationChannel(call.argument<String>("id")!!)
                }
                result.success(null)
            }
            "pickSystemSound" -> startPicker(result, REQUEST_RINGTONE) {
                Intent(RingtoneManager.ACTION_RINGTONE_PICKER).apply {
                    putExtra(RingtoneManager.EXTRA_RINGTONE_TYPE, RingtoneManager.TYPE_ALL)
                    putExtra(RingtoneManager.EXTRA_RINGTONE_SHOW_DEFAULT, false)
                    putExtra(RingtoneManager.EXTRA_RINGTONE_SHOW_SILENT, false)
                    call.argument<String>("current")?.let {
                        putExtra(RingtoneManager.EXTRA_RINGTONE_EXISTING_URI, Uri.parse(it))
                    }
                }
            }
            "pickAudioFile" -> startPicker(result, REQUEST_FILE) {
                Intent(Intent.ACTION_OPEN_DOCUMENT).apply {
                    addCategory(Intent.CATEGORY_OPENABLE)
                    type = "audio/*"
                }
            }
            "deleteFile" -> {
                try {
                    contentResolver.delete(Uri.parse(call.argument<String>("uri")!!), null, null)
                } catch (_: Exception) {
                }
                result.success(null)
            }
            "play" -> {
                preview?.stop()
                val uri = soundUri(call.argument<String>("kind")!!, call.argument<String>("value"))
                preview = uri?.let { RingtoneManager.getRingtone(this, it) }?.apply { play() }
                result.success(null)
            }
            "stop" -> {
                preview?.stop()
                preview = null
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }

    private fun soundUri(kind: String, value: String?): Uri? = when (kind) {
        "silent" -> null
        "bundled" -> Uri.parse("android.resource://$packageName/raw/$value")
        "uri" -> value?.let(Uri::parse)
        else -> RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION)
    }

    private fun createChannel(id: String, name: String, kind: String, value: String?) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) return
        val channel = NotificationChannel(id, name, NotificationManager.IMPORTANCE_HIGH)
        if (kind != "default") {
            val attributes = AudioAttributes.Builder()
                .setUsage(AudioAttributes.USAGE_NOTIFICATION)
                .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                .build()
            channel.setSound(soundUri(kind, value), attributes)
        }
        getSystemService(NotificationManager::class.java).createNotificationChannel(channel)
    }

    private fun startPicker(result: MethodChannel.Result, request: Int, intent: () -> Intent) {
        if (pendingResult != null) {
            result.error("busy", "A picker is already open", null)
            return
        }
        pendingResult = result
        try {
            startActivityForResult(intent(), request)
        } catch (e: Exception) {
            pendingResult = null
            result.error("unavailable", e.message, null)
        }
    }

    @Deprecated("FlutterActivity is not a ComponentActivity")
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode != REQUEST_RINGTONE && requestCode != REQUEST_FILE) return
        val result = pendingResult ?: return
        pendingResult = null
        if (resultCode != RESULT_OK || data == null) {
            result.success(null)
            return
        }
        try {
            result.success(
                if (requestCode == REQUEST_RINGTONE) pickedRingtone(data) else importAudio(data.data),
            )
        } catch (e: Exception) {
            result.error("failed", e.message, null)
        }
    }

    private fun pickedRingtone(data: Intent): Map<String, String>? {
        @Suppress("DEPRECATION")
        val uri = data.getParcelableExtra<Uri>(RingtoneManager.EXTRA_RINGTONE_PICKED_URI)
            ?: return null
        val title = RingtoneManager.getRingtone(this, uri)?.getTitle(this) ?: ""
        return mapOf("uri" to uri.toString(), "title" to title)
    }

    // The system plays channel sounds itself, so a picked file is copied into
    // the shared Notifications folder where it can read it.
    private fun importAudio(source: Uri?): Map<String, String>? {
        if (source == null || Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) return null
        val title = displayName(source)
        val mime = contentResolver.getType(source) ?: "audio/mpeg"
        val values = ContentValues().apply {
            put(MediaStore.Audio.Media.DISPLAY_NAME, "codami_${System.currentTimeMillis()}_$title")
            put(MediaStore.Audio.Media.TITLE, title.substringBeforeLast('.'))
            put(MediaStore.Audio.Media.MIME_TYPE, mime)
            put(MediaStore.Audio.Media.RELATIVE_PATH, "${Environment.DIRECTORY_NOTIFICATIONS}/CodaMi")
            put(MediaStore.Audio.Media.IS_NOTIFICATION, 1)
            put(MediaStore.Audio.Media.IS_PENDING, 1)
        }
        val target = contentResolver.insert(MediaStore.Audio.Media.EXTERNAL_CONTENT_URI, values)
            ?: return null
        try {
            contentResolver.openInputStream(source).use { input ->
                contentResolver.openOutputStream(target).use { output ->
                    input!!.copyTo(output!!)
                }
            }
            contentResolver.update(
                target,
                ContentValues().apply { put(MediaStore.Audio.Media.IS_PENDING, 0) },
                null,
                null,
            )
        } catch (e: Exception) {
            contentResolver.delete(target, null, null)
            throw e
        }
        return mapOf("uri" to target.toString(), "title" to title.substringBeforeLast('.'))
    }

    private fun displayName(uri: Uri): String {
        contentResolver.query(uri, arrayOf(OpenableColumns.DISPLAY_NAME), null, null, null)
            ?.use { if (it.moveToFirst()) return it.getString(0) }
        return "sound"
    }

    companion object {
        private const val REQUEST_RINGTONE = 7101
        private const val REQUEST_FILE = 7102
    }
}
