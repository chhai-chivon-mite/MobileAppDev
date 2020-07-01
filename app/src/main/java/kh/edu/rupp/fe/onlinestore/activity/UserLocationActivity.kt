package kh.edu.rupp.fe.onlinestore.activity

import android.Manifest
import android.app.Activity
import android.content.Intent
import android.content.pm.PackageManager
import android.location.Geocoder
import android.os.Bundle
import android.os.Looper
import android.util.Log
import android.view.View
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import com.google.android.gms.location.*
import com.google.android.gms.maps.CameraUpdate
import com.google.android.gms.maps.CameraUpdateFactory
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.model.LatLng
import com.google.android.gms.maps.model.MarkerOptions
import com.google.android.libraries.places.api.model.Place
import com.google.android.libraries.places.widget.Autocomplete
import com.google.android.libraries.places.widget.AutocompleteActivity
import com.google.android.libraries.places.widget.model.AutocompleteActivityMode
import kh.edu.rupp.fe.onlinestore.R
import kotlinx.android.synthetic.main.activity_user_location.*

class UserLocationActivity : AppCompatActivity() {

    private val locationPermissionRequestCode = 1
    private val placePickerRequestCode = 2

    private lateinit var fusedLocationProviderClient: FusedLocationProviderClient

    private var googleMap: GoogleMap? = null

    private var userTitle = ""
    private var userLat = Double.NaN
    private var userLng = Double.NaN

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContentView(R.layout.activity_user_location)

        // Initialize location provider client
        fusedLocationProviderClient = LocationServices.getFusedLocationProviderClient(this)

        // Check whether user allowed location permission
        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED) {
            // Get last known location
            loadLastKnownLocationAndRequestUpdate()
        } else {
            // Request user to allow location permission
            requestLocationPermission()
        }

        // Map
        mapView.onCreate(savedInstanceState)
        mapView.getMapAsync {
            Log.d("iteapp", "Map is ready!")
            googleMap = it
            zoomMapToCurrentPositionAndAddMarker()
            enableLongClickOnMap()
        }
    }

    override fun onStart() {
        super.onStart()

        mapView.onStart()
    }

    override fun onStop() {
        super.onStop()

        mapView.onStop()
    }

    override fun onDestroy() {
        super.onDestroy()

        mapView.onDestroy()
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if(requestCode == placePickerRequestCode){
            if(resultCode == Activity.RESULT_OK){
                val place = Autocomplete.getPlaceFromIntent(data!!)
                Log.d("iteapp", "Name: ${place.name}, Lat: ${place.latLng!!.latitude}")
                userLat = place.latLng!!.latitude
                userLng = place.latLng!!.longitude
                userTitle = place.name!!
                updateLatLngUi()
                zoomMapToCurrentPositionAndAddMarker()
                addMarker()
            } else if(resultCode == AutocompleteActivity.RESULT_ERROR){
                val status = Autocomplete.getStatusFromIntent(data!!)
                Log.d("iteapp", "Place error: ${status.statusMessage}")
            }
        }
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)

        if(requestCode == locationPermissionRequestCode){
            if(grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED){
                loadLastKnownLocationAndRequestUpdate()
            } else {
                Toast.makeText(this, "Our app can't access you location.", Toast.LENGTH_LONG).show()
            }
        }
    }

    fun onChoosePlaceClick(view: View){
        // Option 1
        //val intent = Intent(this, PlacePickerActivity::class.java)
        //startActivity(intent)

        // Option 2
        val fields = listOf(Place.Field.ID, Place.Field.NAME, Place.Field.LAT_LNG)
        val intent = Autocomplete.IntentBuilder(AutocompleteActivityMode.OVERLAY, fields).build(this)
        startActivityForResult(intent, placePickerRequestCode)

    }

    private fun requestLocationPermission(){
        val permissions = arrayOf(Manifest.permission.ACCESS_FINE_LOCATION)
        ActivityCompat.requestPermissions(this, permissions, locationPermissionRequestCode)
    }

    private fun loadLastKnownLocationAndRequestUpdate(){
        // Load last known location
        fusedLocationProviderClient.lastLocation.addOnCompleteListener {
            if (it.isSuccessful) {
                if (it.result != null) {
                    Log.d("iteapp", "Last known location is found")
                    userLat = it.result!!.latitude
                    userLng = it.result!!.longitude
                    updateLatLngUi()
                    zoomMapToCurrentPositionAndAddMarker()
                } else {
                    Toast.makeText(this, "Last known location not found.", Toast.LENGTH_LONG).show()
                }
            } else {
                Toast.makeText(this, "Loading last known location error.", Toast.LENGTH_LONG).show()
                Log.d("iteapp", "Loading last known location error: " + it.exception!!.message)
            }
        }

        // Request update last known location
        val locationRequest = LocationRequest()
        locationRequest.interval = 10000
        locationRequest.priority = LocationRequest.PRIORITY_HIGH_ACCURACY

        val callback = object : LocationCallback(){
            override fun onLocationResult(result: LocationResult?) {
                super.onLocationResult(result)

                if(result != null){
                    Log.d("iteapp", "Last known location is updated")
                    userLat = result.lastLocation.latitude
                    userLng = result.lastLocation.longitude
                    updateLatLngUi()
                    zoomMapToCurrentPositionAndAddMarker()
                }

                // Stop location update
                fusedLocationProviderClient.removeLocationUpdates(this)
            }
        }

        fusedLocationProviderClient.requestLocationUpdates(locationRequest, callback, Looper.getMainLooper())
    }

    private fun updateLatLngUi(){
        txtLatitude.text = "Latitude: $userLat"
        txtLongitude.text = "Longitude: $userLng"
    }

    private fun zoomMapToCurrentPositionAndAddMarker(){
        if(googleMap != null && !userLat.isNaN()){
            Log.d("iteapp", "Start moving camera...")
            val latLng = LatLng(userLat, userLng)
            val cameraUpdate = CameraUpdateFactory.newLatLngZoom(latLng, 16F)
            googleMap!!.animateCamera(cameraUpdate)
        }
    }

    private fun addMarker(){
        // Add marker
        val latLng = LatLng(userLat, userLng)
        val markerOptions = MarkerOptions()
        markerOptions.title(userTitle)
        markerOptions.position(latLng)
        googleMap!!.addMarker(markerOptions)
    }

    private fun enableLongClickOnMap(){
        googleMap!!.setOnMapLongClickListener {
            userLat = it.latitude
            userLng = it.longitude
            updateLatLngUi()
            addMarker()
            reverseGeocoding()
        }
    }

    private fun reverseGeocoding(){
        val geocoder = Geocoder(this)
        val result = geocoder.getFromLocation(userLat, userLng, 1)
        if(result.isEmpty()){
            Toast.makeText(this, "Address not found.", Toast.LENGTH_LONG).show()
        } else {
            val address = result[0]
            txtAddress.text = address.getAddressLine(0)
            Log.d("iteapp", "Address: ${address.toString()}")
        }
    }

}