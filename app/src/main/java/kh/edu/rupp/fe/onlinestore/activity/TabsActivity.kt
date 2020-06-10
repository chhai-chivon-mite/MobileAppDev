package kh.edu.rupp.fe.onlinestore.activity

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import com.google.android.material.bottomnavigation.BottomNavigationItemView
import kh.edu.rupp.fe.onlinestore.R
import kh.edu.rupp.fe.onlinestore.fragment.CategoriesFragment
import kh.edu.rupp.fe.onlinestore.fragment.ProductsFragment
import kh.edu.rupp.fe.onlinestore.fragment.ProfileFragment
import kh.edu.rupp.fe.onlinestore.fragment.SettingsFragment
import kotlinx.android.synthetic.main.activity_tabs.*

class TabsActivity: AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContentView(R.layout.activity_tabs)

        setSupportActionBar(toolbar)

        // Show ProductsFragment as default
        showFragment(ProductsFragment())

        // Handle event when user clicks on Bottom Nav items
        bottomNav.setOnNavigationItemSelectedListener {

            when (it.itemId) {
                R.id.mnu_products -> {
                    supportActionBar!!.setTitle(R.string.products)
                    showFragment(ProductsFragment())
                }
                R.id.mnu_categories -> {
                    supportActionBar!!.setTitle(R.string.categories)
                    showFragment(CategoriesFragment())
                }
                R.id.mnu_profile -> {
                    supportActionBar!!.setTitle(R.string.profile)
                    showFragment(ProfileFragment())
                }
                else -> {
                    supportActionBar!!.setTitle(R.string.settings)
                    showFragment(SettingsFragment())
                }
            }

            true
        }

    }

    private fun showFragment(fragment: Fragment){
        val fragmentTransaction = supportFragmentManager.beginTransaction()
        fragmentTransaction.replace(R.id.lytFragmentContainer, fragment)
        fragmentTransaction.commit()
    }

}