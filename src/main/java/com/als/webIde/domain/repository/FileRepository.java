package com.als.webIde.domain.repository;

import com.als.webIde.domain.entity.Container;
import com.als.webIde.domain.entity.File;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FileRepository extends JpaRepository<File, Long> {
    List<File> findByContainerPk(Long containerPk);
}