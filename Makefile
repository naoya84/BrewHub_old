.PHONY: gen-api-schema
gen-api-schema:
	@(cd ./api && \
		./gradlew clean && \
		./gradlew generateOpenApiDocs && \
		./gradlew openApiGenerateAll && \
	  rm -rf ../openapi && \
	  cp -r ./build/openapi ..)

.PHONY: backend-pre-commit
backend-pre-commit:
	cd api && ./gradlew ktlintFormat test

.PHONY: ios-pre-commit
ios-pre-commit:
	#cd ios && fastlane lint_fix && fastlane lint && fastlane test