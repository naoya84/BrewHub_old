package jp.hasshi.api.repository

import jp.hasshi.api.domain.entity.ReportEntity
import org.springframework.data.repository.CrudRepository

interface ReportRepository : CrudRepository<ReportEntity, Long>
