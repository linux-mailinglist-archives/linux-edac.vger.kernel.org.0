Return-Path: <linux-edac+bounces-5596-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D931CF7AB5
	for <lists+linux-edac@lfdr.de>; Tue, 06 Jan 2026 11:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10EEB301FB48
	for <lists+linux-edac@lfdr.de>; Tue,  6 Jan 2026 10:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD1730E0CB;
	Tue,  6 Jan 2026 10:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jifghc1E"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA2414D29B;
	Tue,  6 Jan 2026 10:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767693710; cv=none; b=C4j/bJdfq2i/astb0yUnJELpo3HeHoXQZPiqh+n4ABD4uE9pDx5dxdiB2WgsU1IbX3XjiAJbaPlNIahd7kyWQ7ynftjr8pSwOT/YoUfyQldISqDrzilMIf7XGSm47k6VTW0wUGpLfQrLJV0viDYs7YtU6P5kc/7cghdSTkgqOcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767693710; c=relaxed/simple;
	bh=1wXFtyZXq5x9ZLro1IVko165j2oBCEiBirVTi+4hPv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RmRL17lVKiZlANo+2YeoLVU0Uw7xUU1kXAOmsbXA7U8dwtQjQirUVJhXW5RZV/dk/+ecpzCgEtIktq0v1TYt5XrYfwT/XGx1HsDxpD6JVhQZBNH3DNNWZANZ2pOP5jdAFz5bbFK9cf+i1Ylcd+/QcXRcRdbDfHOcfpowLFEXFoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jifghc1E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFEFC16AAE;
	Tue,  6 Jan 2026 10:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767693709;
	bh=1wXFtyZXq5x9ZLro1IVko165j2oBCEiBirVTi+4hPv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jifghc1EBWrX4DiGQsHXzrGHbVdw6yVrkBFsTJBMGKh4U20Z1Y7mJGlbG+fRRi8jB
	 hcUdJi2tWbjHUwYGyfhijDN8GYN1EnklsGzFBPDkL9lR0khYHJVeRyzhMpHLcWnvEU
	 TNjeVUQRZq7xKNPLZHY3dguEaIMESYGEKWxYkM10OAP+cu2poqRDK2BoKu7p4vkpZD
	 eCOnoY0CDTKnKd3wJyk8bI+1VDK2/Wsjp5JuZ1am58WlJv6SQ3MvFhY1e+PCaqiFNh
	 kWEqWviF9DfYEcl6eFl2+e8awIfZRVStVcXowsklU/C7ajNW1FMtDxVMOgIz1t0XBA
	 NacrL6wuzKO8Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.99)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vd3sp-000000008ZI-45D9;
	Tue, 06 Jan 2026 11:01:47 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Borislav Petkov <bp@alien8.de>,
	Breno Leitao <leitao@debian.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Jason Tian <jason@os.amperecomputing.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Len Brown <lenb@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v4 1/4] apei/ghes: ARM processor Error: don't go past allocated memory
Date: Tue,  6 Jan 2026 11:01:35 +0100
Message-ID: <d93b8fb237ac1bb1d8cef4f4f48660dc1b32b673.1767693532.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1767693532.git.mchehab+huawei@kernel.org>
References: <cover.1767693532.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

If the BIOS generates a very small ARM Processor Error, or
an incomplete one, the current logic will fail to deferrence

	err->section_length
and
	ctx_info->size

Add checks to avoid that. With such changes, such GHESv2
records won't cause OOPSes like this:

[    1.492129] Internal error: Oops: 0000000096000005 [#1]  SMP
[    1.495449] Modules linked in:
[    1.495820] CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted 6.18.0-rc1-00017-gabadcc3553dd-dirty #18 PREEMPT
[    1.496125] Hardware name: QEMU QEMU Virtual Machine, BIOS unknown 02/02/2022
[    1.496433] Workqueue: kacpi_notify acpi_os_execute_deferred
[    1.496967] pstate: 814000c5 (Nzcv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[    1.497199] pc : log_arm_hw_error+0x5c/0x200
[    1.497380] lr : ghes_handle_arm_hw_error+0x94/0x220

0xffff8000811c5324 is in log_arm_hw_error (../drivers/ras/ras.c:75).
70		err_info = (struct cper_arm_err_info *)(err + 1);
71		ctx_info = (struct cper_arm_ctx_info *)(err_info + err->err_info_num);
72		ctx_err = (u8 *)ctx_info;
73
74		for (n = 0; n < err->context_info_num; n++) {
75			sz = sizeof(struct cper_arm_ctx_info) + ctx_info->size;
76			ctx_info = (struct cper_arm_ctx_info *)((long)ctx_info + sz);
77			ctx_len += sz;
78		}
79

and similar ones while trying to access section_length on an
error dump with too small size.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/acpi/apei/ghes.c | 32 ++++++++++++++++++++++++++++----
 drivers/ras/ras.c        |  6 +++++-
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 0dc767392a6c..fc3f8aed99d5 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -552,21 +552,45 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 {
 	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
 	int flags = sync ? MF_ACTION_REQUIRED : 0;
+	int length = gdata->error_data_length;
 	char error_type[120];
 	bool queued = false;
 	int sec_sev, i;
 	char *p;
 
 	sec_sev = ghes_severity(gdata->error_severity);
-	log_arm_hw_error(err, sec_sev);
+	if (length >= sizeof(*err)) {
+		log_arm_hw_error(err, sec_sev);
+	} else {
+		pr_warn(FW_BUG "arm error length: %d\n", length);
+		pr_warn(FW_BUG "length is too small\n");
+		pr_warn(FW_BUG "firmware-generated error record is incorrect\n");
+		return false;
+	}
+
 	if (sev != GHES_SEV_RECOVERABLE || sec_sev != GHES_SEV_RECOVERABLE)
 		return false;
 
 	p = (char *)(err + 1);
+	length -= sizeof(err);
+
 	for (i = 0; i < err->err_info_num; i++) {
-		struct cper_arm_err_info *err_info = (struct cper_arm_err_info *)p;
-		bool is_cache = err_info->type & CPER_ARM_CACHE_ERROR;
-		bool has_pa = (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR);
+		struct cper_arm_err_info *err_info;
+		bool is_cache, has_pa;
+
+		/* Ensure we have enough data for the error info header */
+		if (length < sizeof(*err_info))
+			break;
+
+		err_info = (struct cper_arm_err_info *)p;
+
+		/* Validate the claimed length before using it */
+		length -= err_info->length;
+		if (length < 0)
+			break;
+
+		is_cache = err_info->type & CPER_ARM_CACHE_ERROR;
+		has_pa = (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR);
 
 		/*
 		 * The field (err_info->error_info & BIT(26)) is fixed to set to
diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index 2a5b5a9fdcb3..03df3db62334 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -72,7 +72,11 @@ void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev)
 	ctx_err = (u8 *)ctx_info;
 
 	for (n = 0; n < err->context_info_num; n++) {
-		sz = sizeof(struct cper_arm_ctx_info) + ctx_info->size;
+		sz = sizeof(struct cper_arm_ctx_info);
+
+		if (sz + (long)ctx_info - (long)err >= err->section_length)
+			sz += ctx_info->size;
+
 		ctx_info = (struct cper_arm_ctx_info *)((long)ctx_info + sz);
 		ctx_len += sz;
 	}
-- 
2.52.0


