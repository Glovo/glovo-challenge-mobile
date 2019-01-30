package com.eg.glovotest.ui.adapter


import android.content.Context
import android.support.v7.widget.RecyclerView
import android.support.v7.widget.RecyclerView.ViewHolder
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import android.widget.TextView
import com.eg.glovotest.R
import com.eg.glovotest.entities.City
import com.eg.glovotest.entities.Country
import com.eg.glovotest.ui.fragments.CityPickerFragment
import kotlinx.android.synthetic.main.item_country.view.*

class ListOfCitiesRecyclerViewAdapter(
    private val listOfCountries: ArrayList<Any>,
    private val mListener: CityPickerFragment.OnCityListFragmentInteractionListener?
) : RecyclerView.Adapter<ListOfCitiesRecyclerViewAdapter.CityPickerViewHolder>() {


    companion object {
        private const val TYPE_COUNTRY = 0
        private const val TYPE_CITY = 1
    }

    override fun getItemViewType(position: Int): Int {
        return when (listOfCountries[position]) {
            is Country -> TYPE_COUNTRY
            is City -> TYPE_CITY
            else -> -1 // We dont add anything
        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CityPickerViewHolder {
        val view = LayoutInflater.from(parent.context)
            .inflate(R.layout.item_country, parent, false)
        return when (viewType) {
            TYPE_COUNTRY -> CountryViewHolder(view)
            else -> CityViewHolder(view)
        }
    }

    override fun onBindViewHolder(holder: CityPickerViewHolder, position: Int) {
        holder.bindInfo(listOfCountries[position])
    }

    override fun getItemCount(): Int = listOfCountries.size

    abstract class CityPickerViewHolder(view : View) : ViewHolder(view) {
        abstract fun bindInfo(countryCity : Any)
    }

    inner class CountryViewHolder(view: View) : CityPickerViewHolder(view) {

        private val countryTitle: TextView = view.vCountryTitle

        override fun bindInfo(country: Any) {
            countryTitle.text = (country as Country).name
        }
    }

    inner class CityViewHolder(val view: View) : CityPickerViewHolder(view) {

        private val cityTitle: TextView = view.vCountryTitle

        override fun bindInfo(city: Any) {
            cityTitle.text = (city as City).name
            cityTitle.setBackgroundColor(view.resources.getColor(R.color.colorPrimaryLight))
            cityTitle.setOnClickListener {
                mListener?.onCityPicked(city) }
        }
    }
}
