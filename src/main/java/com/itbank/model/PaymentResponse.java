package com.itbank.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PaymentResponse {
    private String username;
    private boolean success;
    private String imp_uid;
    private String pay_method;
    private String merchant_uid;
    private String name;
    private int paid_amount;    // 가격
    private String currency;    // KRW
    private String pg_provider;
    private String pg_type;
    private String pg_tid;
    private String apply_num;
    private String buyer_name;
    private String buyer_email;
    private String buyer_tel;
    private String buyer_addr;
    private String buyer_postcode;
    private String custom_data;
    private String status;
    private long paid_at;
    private String receipt_url;
    private String card_name;
    private String bank_name;
    private int card_quota;
    private String card_number;
    @Override
    public String toString() {
        return "PaymentResponse{" +
                "success=" + success +
                ", imp_uid='" + imp_uid + '\'' +
                ", pay_method='" + pay_method + '\'' +
                ", merchant_uid='" + merchant_uid + '\'' +
                ", name='" + name + '\'' +
                ", paid_amount=" + paid_amount +
                ", currency='" + currency + '\'' +
                ", pg_provider='" + pg_provider + '\'' +
                ", pg_type='" + pg_type + '\'' +
                ", pg_tid='" + pg_tid + '\'' +
                ", apply_num='" + apply_num + '\'' +
                ", buyer_name='" + buyer_name + '\'' +
                ", buyer_email='" + buyer_email + '\'' +
                ", buyer_tel='" + buyer_tel + '\'' +
                ", buyer_addr='" + buyer_addr + '\'' +
                ", buyer_postcode='" + buyer_postcode + '\'' +
                ", custom_data='" + custom_data + '\'' +
                ", status='" + status + '\'' +
                ", paid_at=" + paid_at +
                ", receipt_url='" + receipt_url + '\'' +
                ", card_name='" + card_name + '\'' +
                ", bank_name='" + bank_name + '\'' +
                ", card_quota=" + card_quota +
                ", card_number='" + card_number + '\'' +
                '}';
    }

}
