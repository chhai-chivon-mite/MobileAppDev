package kh.edu.rupp.fe.onlinestore.fragment

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.Fragment
import kh.edu.rupp.fe.onlinestore.R
import kotlinx.android.synthetic.main.fragment_categories.*

class CategoriesFragment: Fragment() {

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {

        return inflater.inflate(R.layout.fragment_categories, container, false)

    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        txtFragment.setOnClickListener {
            Toast.makeText(activity, "You click me!", Toast.LENGTH_LONG).show()
        }
    }

}

