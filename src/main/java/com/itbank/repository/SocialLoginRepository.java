package com.itbank.repository;

import com.itbank.model.SocialLogin;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface SocialLoginRepository extends JpaRepository<SocialLogin, Long> {

    Optional<SocialLogin> findByProviderId(String providerId);

    Optional<SocialLogin> findByProviderAndProviderId(String registrationId, String providerId);
}
