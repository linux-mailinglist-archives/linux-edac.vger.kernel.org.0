Return-Path: <linux-edac+bounces-1392-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D45919FF5
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 09:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B7331C2123E
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 07:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB284653C;
	Thu, 27 Jun 2024 07:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxG6ZwVV"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C184445BE4;
	Thu, 27 Jun 2024 07:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719471958; cv=none; b=CQNOWQDKRwqG2X8pjRbsI4EPBOBPSCuk/nBHjECt5FvJYJUmml8i9LWf6GKavE3NdLUYstsbrz2/4acHH16gPrD3shPxLkw9xgDlyZnS3Xb2ZQ/3LR32fcH81FUpIqbH3CFR/MdjHbboqEjoqgey9OvA5dOemzQ4K0sq+eSKqV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719471958; c=relaxed/simple;
	bh=4rql2YjN9VWO+F94zik+a74OAZrmPfALkpcbPIzIMEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkU5vOt3l1V+F6JWDqUQrSPEJA0GnCPfCdQfqr0q3f650AkztXNo/4qxin/bgPTpNXIFPpADujP2Zo3ZSBETaZkLLv8//fpc8shUVgL7aXYbmGF0DbSqE5D7c5y5250Pav4bWFD40PVzSnnFDC67RFvSlE6VvTQVvGOm0jOu4rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxG6ZwVV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48395C4AF07;
	Thu, 27 Jun 2024 07:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719471958;
	bh=4rql2YjN9VWO+F94zik+a74OAZrmPfALkpcbPIzIMEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BxG6ZwVVFE/AOzEvCTHiqzqFplX+A4BI3olLT8SClzzcGsOXKqaY9LuFH14/UcrLQ
	 9AS00YVEzzF6sLxAn7Pb0b4OYx+n3TkA1K/Azo7NSTHEaozDCUcpyqPe7LUzP14wVn
	 Y2NwW5Fpu0TSpYVFeRfRAhNKSjD6eObNqD1P8n2ceW6Q3M2MycMXrgyp1mB4Aw/6m6
	 TjQ2b3bEteoRN4cqGxyzHx4ruLXr0iSyZmxlJwibeOEGambY4Q70GGBb9q9AlRgVnu
	 buqXNLrDyf9+Tfb0vhl/tpZ1eEYWVo063Sdn7ofeddWmmNWxZXU/TsB7TjO+3ssR2U
	 GWGxwIcbiCvpQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab@kernel.org>)
	id 1sMjCe-0000000B02N-0dP1;
	Thu, 27 Jun 2024 09:05:56 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Daniel Ferguson <danielf@os.amperecomputing.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	James Morse <james.morse@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Len Brown <lenb@kernel.org>,
	Shengwei Luo <luoshengwei@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 1/2] RAS: ACPI: APEI: add conditional compilation to ARM error report functions
Date: Thu, 27 Jun 2024 09:01:08 +0200
Message-ID: <95baa46a5e1c88f08e328dbbfbbd01602e092234.1719471257.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719471257.git.mchehab+huawei@kernel.org>
References: <cover.1719471257.git.mchehab+huawei@kernel.org>
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
 drivers/acpi/apei/ghes.c | 11 +++++------
 drivers/ras/ras.c        |  2 ++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 623cc0cb4a65..25f876b8fa4c 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -529,8 +529,9 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 }
 
 static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
-				       int sev, bool sync)
+				     int sev, bool sync)
 {
+#if defined(CONFIG_ARM) || defined (CONFIG_ARM64)
 	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
 	int flags = sync ? MF_ACTION_REQUIRED : 0;
 	bool queued = false;
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


