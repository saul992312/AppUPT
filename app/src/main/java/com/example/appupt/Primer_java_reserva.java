package com.example.appupt;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

public class Primer_java_reserva extends AppCompatActivity {
    private static  final int PICK_FILE = 1;
    private String tipoArchivo = " ";

    @Override
    protected void onCreate(Bundle savedInstanceState){
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main_primera_pantalla_reserva);

        Button vigencia = findViewById(R.id.vigencia);
        Button certificado = findViewById(R.id.certificado);
        Button credencial = findViewById(R.id.credencial);
        Button carta = findViewById(R.id.carta);
        Button guardar = findViewById(R.id.guardar);

        vigencia.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                tipoArchivo = "VIGENCIA";
                abrirSelector();
            }
        });

        certificado.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                tipoArchivo = "CERTIFICADO";
                abrirSelector();
            }
        });

        credencial.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                tipoArchivo  = "CREDENCIAL";
                abrirSelector();
            }
        });

        carta.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                tipoArchivo = "CARTA";
                abrirSelector();
            }
        });
    }

    private void abrirSelector(){
        Intent intent = new Intent(Intent.ACTION_GET_CONTENT);
    }
}
