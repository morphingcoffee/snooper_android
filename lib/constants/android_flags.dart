/// [ApplicationFlags] provide constants to be (bitwise) AND-ed
/// with underlying flag value of [Flags].
///
/// Full list available at:
/// https://developer.android.com/reference/android/content/pm/ApplicationInfo
class ApplicationFlags {
  /// If set, this application is installed in the device's system image.
  static const system = 1 << 0;

  /// true if this application would like to allow debugging of its
  /// code, even when installed on a non-development system.
  static const debuggable = 1 << 1;

  /// true if this application has code associated with it.
  static const hasCode = 1 << 2;

  /// true if this application is persistent.
  static const persistent = 1 << 3;

  /// true if this application holds the FACTORY_TEST permission and the
  /// device is running in factory test mode.
  static const factoryTest = 1 << 4;

  /// default value for the corresponding ActivityInfo flag.
  static const allowTaskReparenting = 1 << 5;

  /// default value for the corresponding ActivityInfo flag.
  static const allowClearUserData = 1 << 6;

  /// this is set if this application has been
  /// installed as an update to a built-in system application.
  static const updatedSystemApp = 1 << 7;

  /// this is set if the application has specified testOnly to be true
  static const testOnly = 1 << 8;

  /// true when the application's window can be
  /// reduced in size for smaller screens.
  static const supportsSmallScreens = 1 << 9;

  /// true when the application's window can be
  /// displayed on normal screens.
  static const supportsNormalScreens = 1 << 10;

  /// true when the application's window can be
  /// increased in size for larger screens.
  static const supportsLargeScreens = 1 << 11;

  /// true when the application knows how to adjust
  /// its UI for different screen sizes.
  static const resizeableForScreens = 1 << 12;

  /// true when the application knows how to
  /// accommodate different screen densities.
  static const supportsScreenDensities = 1 << 13;

  /// true if this application would like to request
  /// the VM to operate under the safe mode.
  static const vmSafeMode = 1 << 14;

  /// false if the application does not wish to permit
  /// any OS-driven backups of its data
  static const allowBackup = 1 << 15;

  /// false if the application must be kept in memory following
  /// a full-system restore operation; true otherwise.
  /// Ordinarily, during a full system restore operation each application is
  /// shut down following execution of its agent's onRestore() method.
  /// Setting this attribute to false prevents this.
  /// If [allowBackup] is set to false or no backupAgent is specified, this flag
  /// will be ignored.
  static const killAfterRestore = 1 << 16;

  /// Set to true if the application's backup agent claims to be able to handle
  /// restore data even "from the future,"
  /// By default this attribute is false and the Backup Manager will ensure that
  /// data from "future" versions of the application are never supplied during a
  /// restore operation.
  /// If [allowBackup] is set to false or no backupAgent is specified,
  /// this flag will be ignored.
  static const restoreAnyVersion = 1 << 17;

  /// true if the application is currently installed on
  /// external/removable/unprotected storage.
  /// Such applications may not be available if their storage is not currently
  /// mounted. When the storage it is on is not available, it will look like
  /// the application has been uninstalled (its .apk is no longer available)
  /// but its persistent data is not removed.
  static const externalStorage = 1 << 18;

  /// true when the application's window can be increased in size for
  /// extra large screens.
  static const supportsXLargeScreens = 1 << 19;

  /// true when the application has requested a
  /// large heap for its processes.
  static const largeHeap = 1 << 20;

  /// true if this application's package is in
  /// the stopped state.
  static const stopped = 1 << 21;

  /// true  when the application is willing to support
  /// RTL (right to left). All activities will inherit this value.
  /// Default value is false (no support for RTL).
  static const supportsRTL = 1 << 22;

  /// true if the application is currently
  /// installed for the calling user.
  static const installed = 1 << 23;

  /// true if the application only has its
  /// data installed; the application package itself does not currently
  /// exist on the device.
  static const isDataOnly = 1 << 24;

  /// true if the application was declared to be a
  /// game, or false if it is a non-game application.
  static const isGame = 1 << 25;

  /// true if the application asks that only full-data streaming backups of
  /// its data be performed even though it defines a BackupAgent, which normally
  /// indicates that the app will manage its backed-up data via incremental
  /// key/value updates.
  static const fullBackupOnly = 1 << 26;

  /// true if the application may use cleartext network traffic
  /// (e.g., HTTP rather than HTTPS; WebSockets rather than WebSockets Secure;
  /// XMPP, IMAP, STMP without STARTTLS or TLS).
  ///
  /// If false, the app declares that it does not intend to use
  /// cleartext network traffic, in which case platform components
  /// (e.g., HTTP stacks, DownloadManager, MediaPlayer) will refuse app's
  /// requests to use cleartext traffic.
  ///
  /// Third-party libraries are encouraged to honor this flag as well.
  /// NOTE: WebView honors this flag for applications
  /// targeting API level 26 and up.
  /// This flag is ignored on Android N and above if an Android Network Security Config is
  /// present.
  static const usesCleartextTraffic = 1 << 27;

  /// When set installer extracts native libs from .apk files.
  static const extractNativeLibs = 1 << 28;

  /// true when the application's rendering
  /// should be hardware accelerated.
  static const hardwareAccelerated = 1 << 29;

  /// true if this application's package is in
  /// the suspended state.
  static const suspended = 1 << 30;

  /// true if code from this application will need to be
  /// loaded into other applications' processes. On devices that support multiple
  /// instruction sets, this implies the code might be loaded into a process that's
  /// using any of the devices supported instruction sets.
  static const multiarch = 1 << 31;
}
