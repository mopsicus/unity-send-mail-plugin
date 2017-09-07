package com.mycompany.mail;

import android.content.Intent;
import android.net.Uri;

import com.unity3d.player.UnityPlayer;

/**
 * Created by mopsicus.ru on 07.09.17.
 */

public class Plugin {
    public static void sendMail(String email, String subject, String body, String translate) {
        Intent emailIntent = new Intent(Intent.ACTION_SENDTO, Uri.parse("mailto:" + email));
        emailIntent.putExtra(Intent.EXTRA_SUBJECT, subject);
        emailIntent.putExtra(Intent.EXTRA_TEXT, body);
        UnityPlayer.currentActivity.startActivity(Intent.createChooser(emailIntent, translate));
    }
}
