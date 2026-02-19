package com.example.gestacao

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews
import android.content.SharedPreferences
import android.util.Log
import org.json.JSONObject

class DailyMessageWidgetNaturezaProvider : AppWidgetProvider() {

    private val TAG = "WidgetNatureza"

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        Log.d(TAG, "onUpdate called with ${appWidgetIds.size} widgets")
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
        }
    }

    override fun onEnabled(context: Context) {
        super.onEnabled(context)
        Log.d(TAG, "Widget enabled")
    }

    override fun onDisabled(context: Context) {
        super.onDisabled(context)
        Log.d(TAG, "Widget disabled")
    }

    companion object {
        fun updateAppWidget(
            context: Context,
            appWidgetManager: AppWidgetManager,
            appWidgetId: Int
        ) {
            val TAG = "WidgetNatureza"
            Log.d(TAG, "Updating widget $appWidgetId")
            
            val views = RemoteViews(context.packageName, R.layout.widget_natureza_layout)

            // Read cached message from SharedPreferences
            val prefs: SharedPreferences = context.getSharedPreferences(
                "FlutterSharedPreferences", Context.MODE_PRIVATE
            )
            val cachedJson = prefs.getString("flutter.cached_daily_message", null)
            
            Log.d(TAG, "Cached JSON: $cachedJson")

            var emoji = "🍃"
            var message = "Abra o app para ver sua mensagem do dia!"
            
            if (cachedJson != null) {
                try {
                    val json = JSONObject(cachedJson)
                    emoji = json.optString("emoji", "🍃")
                    message = json.optString("message", "Abra o app!")
                    Log.d(TAG, "Widget updated: emoji=$emoji")
                } catch (e: Exception) {
                    Log.e(TAG, "Error parsing JSON", e)
                }
            } else {
                Log.d(TAG, "No cached data found")
            }
            
            // Update views
            views.setTextViewText(R.id.widget_emoji, emoji)
            views.setTextViewText(R.id.widget_message, message)

            // Click to open app
            val intent = context.packageManager.getLaunchIntentForPackage(context.packageName)
            if (intent != null) {
                val pendingIntent = android.app.PendingIntent.getActivity(
                    context, 0, intent,
                    android.app.PendingIntent.FLAG_IMMUTABLE or android.app.PendingIntent.FLAG_UPDATE_CURRENT
                )
                views.setOnClickPendingIntent(R.id.widget_root, pendingIntent)
            }

            appWidgetManager.updateAppWidget(appWidgetId, views)
            Log.d(TAG, "Widget $appWidgetId updated successfully")
        }
    }
}
