using UnityEngine;
using System.Collections;
using System.Runtime.InteropServices;

public class Mail : MonoBehaviour {

	#if UNITY_IOS
		[DllImport ("__Internal")]
		private static extern void mailSendMail (string email, string subject, string body);
	#endif

	// Показываем всплывающее сообщение
	public static void SendMail (string email, string subject, string body) {
		#if UNITY_ANDROID
			string translate = "Send via...";
			using (var plugin = new AndroidJavaClass("com.mycompany.mail.Plugin")) {
				plugin.CallStatic("sendMail", email, subject, body, translate);
			}
		#elif UNITY_IOS
			mailSendMail (email, subject, body);
		#endif
	}


	void OnMailFinished (string result) {
		switch (result) {
		case "-1":
			// no mail accounts
			break;
		case "2":
			// sending fail
			break;
		default:
			break;
		}
	}
		

}
