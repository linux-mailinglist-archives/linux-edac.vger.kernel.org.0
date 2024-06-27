Return-Path: <linux-edac+bounces-1398-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 763C191A3F5
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 12:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30CFE2815B0
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 10:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C916B13E028;
	Thu, 27 Jun 2024 10:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJZ7Np3M"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AD813DBB6;
	Thu, 27 Jun 2024 10:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719484575; cv=none; b=m8Us/s7Af61YulBNcNvpittXx6dPQPsBqEbyKTQPuGSUuTVg/y4+jf14GP1FIJQZ6HDlLiWytr9soMB+KphSURGrKBqjrvAlR5rjn5IekyRwiUFbrLLhkT1P4TuiKn/ArmWsBAAuk6hVAH140i0o+kqlUStF4EBDJDWdtI436Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719484575; c=relaxed/simple;
	bh=JWDF3uYI/wZ37tgeaDZgy9qmXzyOCRUzF9V3nIAkQKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXTsZalNGXrDLA65udnKhtZYwGQtjNbyPSfrM8ilPsX3M0jrHjDCMItbpvMTg4SIB6TcPnrKTO160wAwgMJJhsXcOv5M+F/mzjD10PFeu82PevX3mHF36gs+BAByngb6Ewjqh4DjI3e+cT7Q5Xpy8lljZ9vztyQa7kDr7+2qF8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJZ7Np3M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F865C32789;
	Thu, 27 Jun 2024 10:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719484575;
	bh=JWDF3uYI/wZ37tgeaDZgy9qmXzyOCRUzF9V3nIAkQKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uJZ7Np3MLnyawTgfjF8v41W+H1RjEjosQxBse3c9+6t09ruo1+OTU0vOeoyz2co3N
	 eHin7DRerKiH6hLxJWwfpsVQgd3LaAvhMC6xbYMyrGBeY8p21CQ2WLHyqZ8W6JRkiX
	 KqdSE1c+CfI+YMonLQ+CTho74TKipgA/EuZiK3a/Qkc/x3UnPlpUlTFQQuI4oxKHiB
	 UzW8AyYyRKLXHDw/hyzwAmfDHBzMx4EYilpqJ3mglr/yi/MUNFuNzmKtEy1YUjIU0m
	 eKvw1sOSW2w9bEtDNAb+Ml6VeL/aMKUP2R6EVIIhOgVIvzzuUIP/1DAaxgwGyVHVAY
	 QSkbo3C8vLT5w==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab@kernel.org>)
	id 1sMmU9-0000000BC8x-0azC;
	Thu, 27 Jun 2024 12:36:13 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Daniel Ferguson <danielf@os.amperecomputing.com>,
	"Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Shiju Jose" <shiju.jose@huawei.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	James Morse <james.morse@arm.com>,
	Len Brown <lenb@kernel.org>,
	Shengwei Luo <luoshengwei@huawei.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH v2 1/2] RAS: ACPI: APEI: add conditional compilation to ARM error report functions
Date: Thu, 27 Jun 2024 12:36:07 +0200
Message-ID: <f520f2529bb27d452a2dee762b6968939df42f45.1719484498.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719484498.git.mchehab+huawei@kernel.org>
References: <cover.1719484498.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

From: Daniel Ferguson <danielf@os.amperecomputing.com>

This prevents the unnecessary inclusion of ARM specific RAS error
handling routines in non-ARM platforms.

[mchehab: avoid unneeded ifdefs and fix coding style issues]
Signed-off-by: Daniel Ferguson <danielf@os.amperecomputing.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/acpi/apei/ghes.c | 13 ++++++-------
 drivers/ras/ras.c        |  2 ++
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 623cc0cb4a65..2589a3536d91 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -529,11 +529,12 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 }
 
 static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
-				       int sev, bool sync)
+				     int sev, bool sync)
 {
+	bool queued = false;
+#if defined(CONFIG_ARM) || defined (CONFIG_ARM64)
 	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
 	int flags = sync ? MF_ACTION_REQUIRED : 0;
-	bool queued = false;
 	int sec_sev, i;
 	char *p;
 
@@ -570,7 +571,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 				    error_type);
 		p += err_info->length;
 	}
-
+#endif
 	return queued;
 }
 
@@ -773,11 +774,9 @@ static bool ghes_do_proc(struct ghes *ghes,
 
 			arch_apei_report_mem_error(sev, mem_err);
 			queued = ghes_handle_memory_failure(gdata, sev, sync);
-		}
-		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
+		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			ghes_handle_aer(gdata);
-		}
-		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
+		} else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
 			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
 		} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
 			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index a6e4792a1b2e..5d94ab79c8c3 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -54,7 +54,9 @@ void log_non_standard_event(const guid_t *sec_type, const guid_t *fru_id,
 
 void log_arm_hw_error(struct cper_sec_proc_arm *err)
 {
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
 	trace_arm_event(err);
+#endif
 }
 
 static int __init ras_init(void)
-- 
2.45.2


