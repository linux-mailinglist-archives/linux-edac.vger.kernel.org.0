Return-Path: <linux-edac+bounces-1430-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0590E91BAFE
	for <lists+linux-edac@lfdr.de>; Fri, 28 Jun 2024 11:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5C47284C12
	for <lists+linux-edac@lfdr.de>; Fri, 28 Jun 2024 09:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3794F14F9FE;
	Fri, 28 Jun 2024 09:06:20 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5541514F2
	for <linux-edac@vger.kernel.org>; Fri, 28 Jun 2024 09:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565580; cv=none; b=SZCPimpwT9vyWX8uNqCRLJKUL7woVJdVrhrMd59K5VG7Y3N/NK+Ch7vKfzeJn32UbNTF5Nvm8irsdeaUVyT/6FpsFLPGDIWHc/Hh74RZkqUyuzUn3IsorK0Ecd/Ywv9+tNQZLtgKUesNEsxwhohWOe18mdu40vQQwAnsq8vEXRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565580; c=relaxed/simple;
	bh=Kv1mEqR3OwEcDiO6ZJS+UlnXxBZJzkigQnTgxSSeIt0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I0xKhhwQqP324zaRNb4WnVTaZvVHSheRC4Eb4d2oF91mAFLmUy2BpxfrGJ2odk84fmR5MMlCe0FEzZxqhriNDPVhpO+Fbz8SN4c29VE/ZVmX97NcAbuHB+WEjm8VHFr1Mc/WXgA8JKFcM1uFhGioiSK5MX8275Xd+zOaS71ko4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W9Tyl1sfjz6K9Lv;
	Fri, 28 Jun 2024 17:04:31 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id D3E231406AC;
	Fri, 28 Jun 2024 17:06:15 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.147.160) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 10:06:14 +0100
From: <shiju.jose@huawei.com>
To: <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>,
	<linux-edac@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <mchehab+huawei@kernel.org>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
	<shiju.jose@huawei.com>
Subject: [RFC PATCH 2/3 qemu] acpi/ghes: Support GPIO error source
Date: Fri, 28 Jun 2024 10:06:03 +0100
Message-ID: <20240628090605.529-3-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240628090605.529-1-shiju.jose@huawei.com>
References: <20240628090605.529-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Add error notification to GHES v2 using the GPIO source.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 hw/acpi/ghes.c         | 8 ++++++--
 include/hw/acpi/ghes.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index e9511d9b8f..5b8bc6eeb4 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -34,8 +34,8 @@
 /* The max size in bytes for one error block */
 #define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
 
-/* Now only support ARMv8 SEA notification type error source */
-#define ACPI_GHES_ERROR_SOURCE_COUNT        1
+/* Support ARMv8 SEA notification type error source and GPIO interrupt. */
+#define ACPI_GHES_ERROR_SOURCE_COUNT        2
 
 /* Generic Hardware Error Source version 2 */
 #define ACPI_GHES_SOURCE_GENERIC_ERROR_V2   10
@@ -327,6 +327,9 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
          */
         build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_SEA);
         break;
+    case ACPI_HEST_SRC_ID_GPIO:
+        build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_GPIO);
+        break;
     default:
         error_report("Not support this error source");
         abort();
@@ -370,6 +373,7 @@ void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
     /* Error Source Count */
     build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
     build_ghes_v2(table_data, ACPI_HEST_SRC_ID_SEA, linker);
+    build_ghes_v2(table_data, ACPI_HEST_SRC_ID_GPIO, linker);
 
     acpi_table_end(linker, &table);
 }
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 674f6958e9..4f1ab1a73a 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -58,6 +58,7 @@ enum AcpiGhesNotifyType {
 
 enum {
     ACPI_HEST_SRC_ID_SEA = 0,
+    ACPI_HEST_SRC_ID_GPIO = 1,
     /* future ids go here */
     ACPI_HEST_SRC_ID_RESERVED,
 };
-- 
2.34.1


