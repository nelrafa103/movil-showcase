package com.example.pre_parcial.services;

import com.example.pre_parcial.models.Product;
import com.example.pre_parcial.models.ProductList;

import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Path;

public interface ClientInterface {


    @GET("products")
    Call<ProductList> findAll();

    @GET("products/search?q={param}")
    Call<ProductList> find(@Path("param") int param);

    @GET("products/{id}")
    Call<Product> findOne(@Path("id") int id);


}
