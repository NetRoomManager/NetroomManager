package com.itbank.component;

import org.springframework.stereotype.Component;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.UnknownHostException;

@Component
public class AddressComponent {
    public String getLocalMacAddress() {
        String result = "";
        InetAddress ip;

        try {
            ip = InetAddress.getLocalHost();

            NetworkInterface network = NetworkInterface.getByInetAddress(ip);
            byte[] mac = network.getHardwareAddress();

            String ipValue = ip.getHostAddress();
            System.out.println("ipv4 확인 : " + ipValue);

            String ipValue2 = ip.getHostName();
            System.out.println("이름 확인 : " + ipValue2);

            return ipValue;

        } catch (UnknownHostException e) {
            System.err.println(e.getMessage());
        } catch (SocketException e){
            System.out.println(e.getMessage());
        }

        return null;
    }
}
