Return-Path: <linux-edac+bounces-3462-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8317EA78DC6
	for <lists+linux-edac@lfdr.de>; Wed,  2 Apr 2025 14:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C535170D79
	for <lists+linux-edac@lfdr.de>; Wed,  2 Apr 2025 12:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0ACA23817E;
	Wed,  2 Apr 2025 12:03:05 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81282AE72;
	Wed,  2 Apr 2025 12:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743595385; cv=none; b=LavsrlfEh+QTZLvRjVzq9DfbR778Vp4LdPNx0Mpik472+jyx+BQUZYAK1nq8u98jm4R1MORbKtwTpSeRgog+SQntPq4vFVdcRCdDP6FVrHND0kRzh6RXQykYhMSduhEj9+IPvL9M7MtfI0JOue7w4pmjRLDEH/y2nGw8BKyuf+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743595385; c=relaxed/simple;
	bh=Sfwv0NX2N1BPj+mtPyoFabRaA3F0GkFZasoqwT4kZ48=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bTQ7jOcd9zUwDQagCeax0nAMI9x/IRWp+/xh9e7fUEvvycVtn8BwS1ZKserMKnA4XNVGlxJJa//RX/pdDoR1oEnXH+8Y1jD4cyf8QuxbMWRLtPn//mlL8iMYYtrzVxNsfcAgyMXmcD77YqA/uqyQsZ83zHgXMCm5RjAkBeeR/AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZSNh46pmNz6M4fR;
	Wed,  2 Apr 2025 19:59:16 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id B55B314067A;
	Wed,  2 Apr 2025 20:02:55 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.171.80) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 2 Apr 2025 14:02:54 +0200
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-doc@vger.kernel.org>
CC: <bp@alien8.de>, <rafael@kernel.org>, <tony.luck@intel.com>,
	<lenb@kernel.org>, <leo.duran@amd.com>, <Yazen.Ghannam@amd.com>,
	<mchehab@kernel.org>, <jonathan.cameron@huawei.com>, <linux-mm@kvack.org>,
	<linuxarm@huawei.com>, <rientjes@google.com>, <jiaqiyan@google.com>,
	<Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <jthoughton@google.com>,
	<somasundaram.a@hpe.com>, <erdemaktas@google.com>, <pgonda@google.com>,
	<duenwen@google.com>, <gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <shiju.jose@huawei.com>
Subject: [NOT FOR MERGING PATCH v3 1/3] ACPI: ACPI 6.5: RAS2: Rename RAS2 table structure and field names
Date: Wed, 2 Apr 2025 13:02:27 +0100
Message-ID: <20250402120230.596-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250402120230.596-1-shiju.jose@huawei.com>
References: <20250402120230.596-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Rename the RAS2 table structure and field names to shorten them and
avoid long lines in the ACPI RAS2 drivers.

1. struct acpi_ras2_shared_memory to struct acpi_ras2_shmem

2. In struct acpi_ras2_shared_memory: fields,
   - set_capabilities[16] to set_caps[16]
   - num_parameter_blocks to num_param_blks
   - set_capabilities_status to set_caps_status

3. struct acpi_ras2_patrol_scrub_parameter to
   struct acpi_ras2_patrol_scrub_param

4. In struct acpi_ras2_patrol_scrub_parameter: fields,
   - patrol_scrub_command to command
   - requested_address_range to req_addr_range
   - actual_address_range to actl_addr_range

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
Corresponding changes are merged in the acpica:
https://github.com/acpica/acpica/commit/2c8a38f747de9d977491a494faf0dfaf799b777b
---
 include/acpi/actbl2.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 2e917a8f8bca..493174ca87f6 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -2802,15 +2802,15 @@ struct acpi_ras2_pcc_desc {
 
 /* RAS2 Platform Communication Channel Shared Memory Region */
 
-struct acpi_ras2_shared_memory {
+struct acpi_ras2_shmem {
 	u32 signature;
 	u16 command;
 	u16 status;
 	u16 version;
 	u8 features[16];
-	u8 set_capabilities[16];
-	u16 num_parameter_blocks;
-	u32 set_capabilities_status;
+	u8 set_caps[16];
+	u16 num_param_blks;
+	u32 set_caps_status;
 };
 
 /* RAS2 Parameter Block Structure for PATROL_SCRUB */
@@ -2823,11 +2823,11 @@ struct acpi_ras2_parameter_block {
 
 /* RAS2 Parameter Block Structure for PATROL_SCRUB */
 
-struct acpi_ras2_patrol_scrub_parameter {
+struct acpi_ras2_patrol_scrub_param {
 	struct acpi_ras2_parameter_block header;
-	u16 patrol_scrub_command;
-	u64 requested_address_range[2];
-	u64 actual_address_range[2];
+	u16 command;
+	u64 req_addr_range[2];
+	u64 actl_addr_range[2];
 	u32 flags;
 	u32 scrub_params_out;
 	u32 scrub_params_in;
-- 
2.43.0


