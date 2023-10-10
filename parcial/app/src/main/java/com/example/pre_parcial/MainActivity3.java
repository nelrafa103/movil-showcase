package com.example.pre_parcial;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.widget.ImageView;
import android.widget.TextView;

import com.example.pre_parcial.models.Product;
import com.example.pre_parcial.services.Client;
import com.example.pre_parcial.services.ClientInterface;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;



public class MainActivity3 extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main3);


        ClientInterface api = Client.getClient().create(ClientInterface.class);


        Intent intent = getIntent();
        int numero = intent.getIntExtra("id",1);

        api.findOne(numero).enqueue(new Callback<Product>() {
            @Override
            public void onResponse(Call<Product> call, Response<Product> response) {
               // Log.w("onResponse", response.body()..toString());

                TextView nombre = findViewById(R.id.title_detail);
                TextView apellido = findViewById(R.id.des_detail);
                TextView correo = findViewById(R.id.price_detail);
                TextView brand = findViewById(R.id.brand_detail);

                nombre.setText(response.body().getTitle());
                apellido.setText(response.body().getDescription());
                brand.setText(response.body().getBrand());
                correo.setText((Float.toString(response.body().getPrice())));




            }

            @Override
            public void onFailure(Call<Product> call, Throwable t) {
                Log.w("onFailure", t.getLocalizedMessage());
                call.cancel();
            }
        });
    }
}