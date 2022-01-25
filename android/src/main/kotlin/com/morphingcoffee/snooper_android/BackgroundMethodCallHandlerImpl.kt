package com.morphingcoffee.snooper_android

import android.content.Context
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.os.Build
import androidx.annotation.NonNull
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream
import java.security.cert.CertificateException
import java.security.cert.CertificateFactory
import java.security.cert.X509Certificate

/**
 * Implementation of the [MethodChannel.MethodCallHandler] for the plugin.
 * Note that it's expected to be run in a background thread, so execution on UI Thread has to be
 * made explicit.
 */
class BackgroundMethodCallHandlerImpl(private val context: Context) :
    MethodChannel.MethodCallHandler {

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        when (call.method) {
            "getPlatformVersion" -> {
                result.success("Android ${Build.VERSION.RELEASE}")
            }
            "getPackagesSimple" -> {
                getPackagesSimple(result)
            }
            "getPackagesDetailed" -> {
                getPackagesDetailed(result)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    //region impl

    private fun getPackagesSimple(@NonNull result: MethodChannel.Result) {
        val packageInfoMaps = mutableListOf<Map<String, Any?>>()
        val pm: PackageManager = context.packageManager

        // Get a list of installed apps
        val packages: List<ApplicationInfo> =
            pm.getInstalledApplications(PackageManager.GET_META_DATA)

        // Gather further info about every package
        for (applicationInfo: ApplicationInfo in packages) {
            val infoMap: MutableMap<String, Any?> = mutableMapOf(
                "name" to pm.getApplicationLabel(applicationInfo).toString(),
                "packageName" to applicationInfo.packageName,
                "uid" to applicationInfo.uid,
            )

            // Add info to the result collection
            packageInfoMaps.add(infoMap)
        }

        result.success(packageInfoMaps)
    }

    private fun getPackagesDetailed(@NonNull result: MethodChannel.Result) {
        val packageInfoMaps = mutableListOf<Map<String, Any?>>()
        val pm: PackageManager = context.packageManager

        // Get a list of installed apps
        val packages: List<ApplicationInfo> =
            pm.getInstalledApplications(PackageManager.GET_META_DATA)


        // Gather further info about every package
        for (applicationInfo: ApplicationInfo in packages) {
            val packageInfo = pm.getPackageInfo(
                applicationInfo.packageName,
                allPackageManagerFlags(),
            )

            val infoMap: MutableMap<String, Any?> = mutableMapOf(
                "name" to pm.getApplicationLabel(applicationInfo).toString(),
                "packageName" to applicationInfo.packageName,
                "uid" to applicationInfo.uid,

                "description" to applicationInfo.loadDescription(pm)?.toString(),
                "processName" to applicationInfo.processName,
                "dataDir" to applicationInfo.dataDir,

                "backupAgentName" to applicationInfo.backupAgentName,
                "nativeLibraryDir" to applicationInfo.nativeLibraryDir,
                "taskAffinity" to applicationInfo.taskAffinity,

                "className" to applicationInfo.className,
                "permission" to applicationInfo.permission,
                "publicSourceDir" to applicationInfo.publicSourceDir,


                "enabled" to applicationInfo.enabled,
                "sharedLibraryFiles" to applicationInfo.sharedLibraryFiles?.asList(),
                "flags" to applicationInfo.flags,

                "firstInstallTime" to packageInfo.firstInstallTime,
                "lastUpdateTime" to packageInfo.lastUpdateTime,

                "iconBytes" to iconFrom(pm, applicationInfo)
            )

            if (Build.VERSION.SDK_INT >= 24) {
                infoMap["minSdkVersion"] = applicationInfo.minSdkVersion
                infoMap["deviceProtectedDataDir"] = applicationInfo.deviceProtectedDataDir
            }

            if (Build.VERSION.SDK_INT >= 26) {
                infoMap["storageUuid"] = applicationInfo.storageUuid?.toString()
                infoMap["splitNames"] = applicationInfo.splitNames?.toList()
            }

            if (Build.VERSION.SDK_INT >= 28) {
                val signatures = pm.getPackageInfo(
                    applicationInfo.packageName,
                    PackageManager.GET_PERMISSIONS or PackageManager.GET_SIGNING_CERTIFICATES
                ).signingInfo.apkContentsSigners

                signatures.forEach {
                    try {
                        val certFactory: CertificateFactory =
                            CertificateFactory.getInstance("X509")
                        val x509Cert: X509Certificate =
                            certFactory.generateCertificate(
                                it.toByteArray().inputStream()
                            ) as X509Certificate

                        // TODO append to a list for multiple signature support?
                        infoMap["apkSigningCertificates"] = listOf(
                            mapOf(
                                "subjectDN" to x509Cert.subjectDN.toString(),
                                "issuerDN" to x509Cert.issuerDN.toString(),
                                "serialNumber" to x509Cert.serialNumber,
                            ),
                        )
                    } catch (e: CertificateException) {
                        e.printStackTrace();
                    }
                }

            }

            if (Build.VERSION.SDK_INT >= 30) {
                infoMap["installInitiatingPackageName"] =
                    pm.getInstallSourceInfo(applicationInfo.packageName).initiatingPackageName
            }

            // Add info to the result collection
            packageInfoMaps.add(infoMap)
        }

        result.success(packageInfoMaps)
    }

    private fun iconFrom(pm: PackageManager, appInfo: ApplicationInfo): ByteArray? {
        val icon: Drawable = appInfo.loadIcon(pm)
        val bitmap: Bitmap

        if (icon is BitmapDrawable) {
            // This block is supposed to be slightly more efficient than universal impl
            bitmap = icon.bitmap
        } else {
            // Universal impl for any Drawable
            bitmap = Bitmap.createBitmap(
                icon.intrinsicWidth,
                icon.intrinsicHeight,
                Bitmap.Config.ARGB_8888
            )
            val canvas = Canvas(bitmap)
            icon.setBounds(0, 0, canvas.width, canvas.height)
            icon.draw(canvas)
        }

        // Convert bmp to ByteArray
        val byteArrayOutputStream = ByteArrayOutputStream()
        bitmap?.compress(
            Bitmap.CompressFormat.PNG,
            100,
            byteArrayOutputStream
        )
        val byteArray: ByteArray = byteArrayOutputStream.toByteArray()

        return if (byteArray.isNotEmpty()) byteArray else null
    }

    private fun allPackageManagerFlags(): Int {
        var flags = 0

        flags =
            flags or PackageManager.GET_ACTIVITIES or PackageManager.GET_PROVIDERS or PackageManager.GET_RECEIVERS or PackageManager.GET_SERVICES or PackageManager.GET_PERMISSIONS or PackageManager.GET_META_DATA or PackageManager.GET_SHARED_LIBRARY_FILES

        if (Build.VERSION.SDK_INT >= 28) {
            flags = flags or PackageManager.GET_SIGNING_CERTIFICATES
        }

        return flags
    }


}