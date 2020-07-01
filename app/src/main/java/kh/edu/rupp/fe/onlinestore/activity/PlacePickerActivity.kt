package kh.edu.rupp.fe.onlinestore.activity

import android.os.Bundle
import android.util.Log
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.google.android.gms.common.api.Status
import com.google.android.libraries.places.api.Places
import com.google.android.libraries.places.api.model.Place
import com.google.android.libraries.places.widget.AutocompleteSupportFragment
import com.google.android.libraries.places.widget.listener.PlaceSelectionListener
import kh.edu.rupp.fe.onlinestore.R

class PlacePickerActivity: AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContentView(R.layout.activity_place_picker)

        val autoCompleteFragment = supportFragmentManager.findFragmentById(R.id.frmPlacePicker) as AutocompleteSupportFragment
        val fields = listOf(Place.Field.ID, Place.Field.NAME, Place.Field.LAT_LNG)
        autoCompleteFragment.setPlaceFields(fields)
        autoCompleteFragment.setOnPlaceSelectedListener(object: PlaceSelectionListener{
            override fun onPlaceSelected(place: Place) {
                Log.d("iteapp", place.name)
            }

            override fun onError(status: Status) {
                Log.d("iteapp", "Error: " + status.statusMessage)
            }
        })


    }

}