using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Demo : MonoBehaviour {

	public InputField Email;
	public InputField Subject;
	public InputField Body;

	public void SendMail () {
		Mail.SendMail (Email.text, Subject.text, Body.text);
	}

}
