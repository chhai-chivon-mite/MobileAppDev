package kh.edu.rupp.fe.onlinestore.fragment

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.LinearLayoutManager
import com.android.volley.toolbox.StringRequest
import com.android.volley.toolbox.Volley
import com.google.gson.Gson
import kh.edu.rupp.fe.onlinestore.R
import kh.edu.rupp.fe.onlinestore.adapter.MailsAdapter
import kh.edu.rupp.fe.onlinestore.model.Mail
import kotlinx.android.synthetic.main.fragment_products.*

class ProductsFragment : Fragment() {


    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {

        return inflater.inflate(R.layout.fragment_products, container, false)

    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        // LayoutManager
        val layoutManager = LinearLayoutManager(activity)

        recyclerView.layoutManager = layoutManager

        loadMails()
    }

    private fun loadMails() {
        showLoading(true)

        val queue = Volley.newRequestQueue(activity)

        val url = "http://10.0.2.2/rupp/index.php"

        val request = StringRequest(url, {
            showLoading(false)
            val gson = Gson()
            val mails = gson.fromJson<Array<Mail>>(it, Array<Mail>::class.java)
            val adapter = MailsAdapter(mails)
            recyclerView.adapter = adapter
        }, {
            showLoading(false)
            Toast.makeText(activity, "Load data error.", Toast.LENGTH_LONG).show()
        })

        queue.add(request)
    }

    private fun showLoading(state: Boolean) {
        if (state) {
            progressBar.visibility = View.VISIBLE
            recyclerView.visibility = View.INVISIBLE
        } else {
            progressBar.visibility = View.INVISIBLE
            recyclerView.visibility = View.VISIBLE
        }
    }

}

