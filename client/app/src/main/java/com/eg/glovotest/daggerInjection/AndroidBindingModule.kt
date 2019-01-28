package com.eg.glovotest.daggerInjection

import com.eg.glovotest.ui.activities.MainActivity
import dagger.Module
import dagger.android.ContributesAndroidInjector

@Module
abstract class AndroidBindingModule {

    @ContributesAndroidInjector
    internal abstract fun contributesMainActivity(): MainActivity

}


