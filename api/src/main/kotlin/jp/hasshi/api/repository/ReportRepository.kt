package jp.hasshi.api

import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.CrudRepository

interface ReportRepository: CrudRepository<ReportEntity, Long> {
}