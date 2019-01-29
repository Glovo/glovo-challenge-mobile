package com.eg.glovotest.network.repositories

import android.arch.lifecycle.LiveData
import javax.inject.Singleton
import com.eg.glovotest.network.entities.City
import com.eg.glovotest.network.entities.CityDetails
import com.eg.glovotest.network.entities.Country
import com.eg.glovotest.network.services.GlovoService


@Singleton
class GlovoDataRepositoryImp(val glovoService: GlovoService) : GlovoDataRepository {

    override fun getCountries(): LiveData<List<Country>> {
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }

    override fun getCities(): LiveData<List<City>> {
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }

    override fun getCityDetail(cityId: String): LiveData<CityDetails> {
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }
    
}

