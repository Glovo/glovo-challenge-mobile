package com.eg.glovotest.daggerInjection

import com.eg.glovotest.ui.activities.MainActivity
import com.eg.glovotest.GlovoTestApplication
import dagger.Component
import javax.inject.Singleton

@Singleton
@Component(modules = [AppModule::class, ViewModelModule::class, AndroidBindingModule::class])
interface AppComponent {

    fun inject(glovoTestApplication: GlovoTestApplication)

    fun inject(mainActivity : MainActivity)
}