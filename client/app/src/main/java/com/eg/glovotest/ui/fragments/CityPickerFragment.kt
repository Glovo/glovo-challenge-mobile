package com.eg.glovotest.ui.fragments

import android.content.Context
import android.os.Bundle
import android.support.v4.app.Fragment
import android.support.v7.widget.LinearLayoutManager
import android.support.v7.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.eg.glovotest.R
import com.eg.glovotest.entities.City
import com.eg.glovotest.entities.CountriesAndCitiesWrapper
import com.eg.glovotest.ui.adapter.ListOfCitiesRecyclerViewAdapter

class CityPickerFragment : Fragment() {

    private var listener: OnCityListFragmentInteractionListener? = null
    private lateinit var listOfCountriesAndCitiesWithCities: CountriesAndCitiesWrapper

    companion object {
        const val ARG_LIST_OF_COUNTRIES = "LIST_OF_COUNTRIES"

        @JvmStatic
        fun newInstance(listOfCountriesAndCitiesWithCities : CountriesAndCitiesWrapper) =
            CityPickerFragment().apply {
                arguments = Bundle().apply {
                    putParcelable(ARG_LIST_OF_COUNTRIES, listOfCountriesAndCitiesWithCities)
                }
            }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        arguments!!.get(ARG_LIST_OF_COUNTRIES).let {
            listOfCountriesAndCitiesWithCities = it as CountriesAndCitiesWrapper
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?)
            : View? {

        val view = inflater.inflate(R.layout.fragment_listofcities_list, container, false)

        // Set the adapter
        if (view is RecyclerView) {
            with(view) {
                layoutManager = LinearLayoutManager(context)
                adapter = ListOfCitiesRecyclerViewAdapter(
                    listOfCountriesAndCitiesWithCities.getPlainListOfCountriesAndCities(),
                    listener
                )
            }
        }
        return view
    }

    override fun onAttach(context: Context) {
        super.onAttach(context)
        if (context is OnCityListFragmentInteractionListener) {
            listener = context
        } else {
            throw RuntimeException(context.toString() + " must implement OnListFragmentInteractionListener")
        }
    }

    override fun onDetach() {
        super.onDetach()
        listener = null
    }

    interface OnCityListFragmentInteractionListener {
        fun onCityPicked(city : City)
    }
}
