package com.ruhuna.backendv2.utils;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.ruhuna.backendv2.model.Property;
import lombok.var;

import java.io.IOException;
import java.nio.file.FileSystems;
import java.nio.file.Path;

public class QRCodeGenerator {
    public static void generateQRCode(Property property) throws WriterException, IOException {
        String qrCodePath = "D:\\QRCode\\";
        String qrCodeName = qrCodePath+property.getPropertyName()+property.getId()+"-QRCODE.png";
        var qrCodeWriter = new QRCodeWriter();
        BitMatrix bitMatrix = qrCodeWriter.encode(
                "ID: "+property.getId()+ "\n"+
                        "PropertyName: "+property.getPropertyName()+ "\n"+
                        "PropertyLocation: "+property.getPropertyLocation()+ "\n" ,BarcodeFormat.QR_CODE, 400, 400);
        Path path = FileSystems.getDefault().getPath(qrCodeName);
        MatrixToImageWriter.writeToPath(bitMatrix, "PNG", path);

    }
}
