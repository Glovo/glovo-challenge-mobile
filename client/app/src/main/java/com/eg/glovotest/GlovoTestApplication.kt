package com.eg.glovotest

import android.app.Activity
import android.app.Application
import com.eg.glovotest.daggerInjection.AppComponent
import com.eg.glovotest.daggerInjection.AppModule
import com.eg.glovotest.daggerInjection.DaggerAppComponent
import dagger.android.DispatchingAndroidInjector
import dagger.android.HasActivityInjector
import javax.inject.Inject

class GlovoTestApplication : Application(), HasActivityInjector {

    @Inject
    lateinit var dispatchingAndroidInjector: DispatchingAndroidInjector<Activity>

    private var app: GlovoTestApplication? = null
    private lateinit var appComponent: AppComponent

    override fun onCreate() {
        super.onCreate()

        app = this
        initGlovoTestComponent()
        appComponent.inject(this)
    }

    private fun initGlovoTestComponent() {
        appComponent = DaggerAppComponent.builder()
                .appModule(AppModule(this))
                .build()
    }

    override fun activityInjector(): DispatchingAndroidInjector<Activity> {
        return dispatchingAndroidInjector
    }
}