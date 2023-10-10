package com.example.pre_parcial;

import androidx.appcompat.app.AppCompatActivity;
import androidx.cardview.widget.CardView;
import androidx.lifecycle.ViewModelProvider;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.content.Intent;
import android.content.res.Configuration;
import android.os.Bundle;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.example.pre_parcial.adapter.ProductAdapter;
import com.example.pre_parcial.databinding.ActivityMainBinding;
import com.example.pre_parcial.models.Product;
import com.example.pre_parcial.models.ProductList;
import com.example.pre_parcial.services.Client;
import com.example.pre_parcial.services.ClientInterface;

import java.util.ArrayList;
import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class MainActivity extends AppCompatActivity {


    private ActivityMainBinding binding;
    private ViewModel viewmodel;
    private ArrayList<Product> listProducts = new ArrayList<Product>();


    @Override
    protected void onCreate(Bundle savedInstanceState) {


        super.onCreate(savedInstanceState);

        binding = ActivityMainBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());


        ClientInterface api = Client.getClient().create(ClientInterface.class);





        api.findAll().enqueue(new Callback<ProductList>() {
            @Override
            public void onResponse(Call<ProductList> call, Response<ProductList> response) {
            //    System.out.println(response.body().getProducts());


                listProducts = response.body().getProducts();
                System.out.println(listProducts.get(0).getTitle());


                RecyclerView recyclerView = binding.recycler;

                int spanCount = 1;

                if (MainActivity.this.getResources().getConfiguration().orientation == Configuration.ORIENTATION_LANDSCAPE) {
                    spanCount = 4;
                }
                //System.out.println(listProducts);

                recyclerView.setHasFixedSize(true);
                //recyclerView.setLayoutManager(new LinearLayoutManager(getApplicationContext()));
                recyclerView.setLayoutManager(new GridLayoutManager(getApplicationContext(), spanCount));

                final ProductAdapter adapter = new ProductAdapter(listProducts);

                System.out.println(adapter.getItemCount());
                recyclerView.setAdapter(adapter);




                //   call.cancel();
            }



            @Override
            public void onFailure(Call<ProductList> call, Throwable t) {
                //   Log.w("onFailure", t.getLocalizedMessage());
                System.out.println("Error");
                call.cancel();
            }
        });





    }

    public void redirect(View view) {
        int id = 0;
        Intent intent = new Intent(this,MainActivity3.class);
        LinearLayout cardView = (LinearLayout) view.getParent();
        TextView textView =  cardView.findViewById(R.id.id);
        Integer string = Integer.getInteger((String) textView.getText()) ;
        intent.putExtra("id",string);
        startActivity(intent);

    }

}