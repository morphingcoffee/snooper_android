package com.morphingcoffee.snooper_android

import android.content.Context
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.hardware.Sensor
import android.hardware.SensorManager
import android.os.Build
import androidx.annotation.NonNull
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.*
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

    // Coroutine scope for executing tasks asynchronously, to avoid blocking current (background) thread
    private val scope = CoroutineScope(Dispatchers.Default)

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        scope.launch {
            when (call.method) {
                "getPackagesSimple" -> {
                    getPackagesSimple(result)
                }
                "getPackagesDetailed" -> {
                    getPackagesDetailed(result)
                }
                "getSensors" -> {
                    getSensors(result)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    //region simple package retrieval impl

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

    // endregion

    //region detailed package retrieval impl

    /**
     * The package metadata (e.g. icon) fetching is not parallelized in this impl because running
     * those tasks asynchronously resulted in *intermittent* binder errors, such as:
     * `E/JavaBinder: !!! FAILED BINDER TRANSACTION !!!  (parcel size = 168)`
     */
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

            // Add Package Services
            val services = packageInfo.services
            infoMap["services"] = services?.map {
                mapOf<String, Any?>(
                    "name" to it.name,
                    "flags" to it.flags,
                    "exported" to it.exported,
                    "enabled" to it.enabled,
                )
            }

            // Add Package Activities
            val activities = packageInfo.activities
            infoMap["activities"] = activities?.map {
                mapOf<String, Any?>(
                    "name" to it.name,
                    "flags" to it.flags,
                    "exported" to it.exported,
                    "enabled" to it.enabled,
                    "targetActivity" to it.targetActivity,
                    "parentActivityName" to it.parentActivityName,
                    "screenOrientation" to it.screenOrientation,
                    "taskAffinity" to it.taskAffinity,
                    "launchMode" to it.launchMode,
                )
            }

            if (Build.VERSION.SDK_INT >= 24) {
                infoMap["minSdkVersion"] = applicationInfo.minSdkVersion
                infoMap["deviceProtectedDataDir"] = applicationInfo.deviceProtectedDataDir
            }

            if (Build.VERSION.SDK_INT >= 26) {
                infoMap["storageUuid"] = applicationInfo.storageUuid?.toString()
                infoMap["splitNames"] = applicationInfo.splitNames?.toList()
            }

            if (Build.VERSION.SDK_INT >= 28) {
                // Populate APK Signers
                val signatures = packageInfo.signingInfo.apkContentsSigners
                val signatureInfos = mutableListOf<Map<String, Any?>>()
                signatures.forEach {
                    try {
                        val certFactory: CertificateFactory =
                            CertificateFactory.getInstance("X509")
                        val x509Cert: X509Certificate =
                            certFactory.generateCertificate(
                                it.toByteArray().inputStream()
                            ) as X509Certificate

                        val signatureInfo = mapOf(
                            "subjectDN" to x509Cert.subjectDN.name,
                            "issuerDN" to x509Cert.issuerDN.name,
                            "serialNumber" to x509Cert.serialNumber.toString(),
                            "notBefore" to x509Cert.notBefore.time,
                            "notAfter" to x509Cert.notAfter.time,
                            "sigAlgName" to x509Cert.sigAlgName,
                            "version" to x509Cert.version,
                            "publicKeyAlgName" to x509Cert.publicKey.algorithm,
                            "publicKey" to x509Cert.publicKey.encoded,
                            "signature" to x509Cert.encoded,
                        )

                        signatureInfos.add(signatureInfo)
                    } catch (e: CertificateException) {
                        e.printStackTrace()
                    }
                }
                infoMap["signatures"] = signatureInfos
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

    //endregion

    // region sensors retrieval impl

    private fun getSensors(@NonNull result: MethodChannel.Result) {
        val sensorManager = context.getSystemService(Context.SENSOR_SERVICE) as SensorManager?
        val sensors: List<Sensor> = sensorManager?.getSensorList(Sensor.TYPE_ALL) ?: listOf()
        val sensorMaps: List<MutableMap<String, Any?>> = sensors.map {
            val sensorMap: MutableMap<String, Any?> = mutableMapOf(
                "name" to it.name,
                "type" to it.type,
                "stringType" to it.stringType,
                "isWakeUpSensor" to it.isWakeUpSensor,
                "reportingMode" to it.reportingMode,
                "vendor" to it.vendor,
                "version" to it.version,
                "maximumRange" to it.maximumRange,
                "resolution" to it.resolution,
                "maxDelay" to it.maxDelay,
                "minDelay" to it.minDelay,
                "power" to it.power,
            )

            if (Build.VERSION.SDK_INT >= 24) {
                sensorMap["isDynamicSensor"] = it.isDynamicSensor
                sensorMap["isAdditionalInfoSupported"] = it.isAdditionalInfoSupported
            }

            if (Build.VERSION.SDK_INT >= 31) {
                sensorMap["highestDirectReportRateLevel"] = it.highestDirectReportRateLevel
            }

            sensorMap
        }

        result.success(sensorMaps)
    }

    // endregion

}