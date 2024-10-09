Return-Path: <linux-edac+bounces-1972-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B077996A61
	for <lists+linux-edac@lfdr.de>; Wed,  9 Oct 2024 14:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171BA1F2569F
	for <lists+linux-edac@lfdr.de>; Wed,  9 Oct 2024 12:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E7B19995D;
	Wed,  9 Oct 2024 12:43:15 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCD819925D;
	Wed,  9 Oct 2024 12:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477795; cv=none; b=UK1ii5qEYs0QTJZU6H7u/BP89pZBWmjQJO+SBvxFMjVdlb4bisbGaLojFGxcXm0H9Jw/y4t/h/Kw7J7wgzYB/jc1OyC14Z/9PppcenMHMpG9Rgzg9W8T8zFnz3Atnl6tTMqNc8+GLpIKeUaR+k0sV5KbGojDcHQWzdKE2oAF6f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477795; c=relaxed/simple;
	bh=n8ZrTMeEK5T2FCH/z1sV9DvU+y6t9ARXL10uoj6S1XA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VBIw+d8L8yu5KHFVeVtkKqWxzYHQNi5iJhbQS9LmxTFf0EmA0fNDOaMr37vkTlQNiRUVXl/oZqswyU/i5669hVJR3hKy+/0oFWjKR2zeES2NY4C1KUv2isfPuCquqSvzmTTDNgUMfW7iirSLudrBp+PAF0h+75uGTWHbL1AW8CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XNsx96SJvz6GD5Y;
	Wed,  9 Oct 2024 20:42:53 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id A2322140A90;
	Wed,  9 Oct 2024 20:43:11 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.152.209) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 14:43:09 +0200
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
CC: <bp@alien8.de>, <tony.luck@intel.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <mchehab@kernel.org>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <david@redhat.com>, <Vilas.Sridharan@amd.com>,
	<leo.duran@amd.com>, <Yazen.Ghannam@amd.com>, <rientjes@google.com>,
	<jiaqiyan@google.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <jthoughton@google.com>,
	<somasundaram.a@hpe.com>, <erdemaktas@google.com>, <pgonda@google.com>,
	<duenwen@google.com>, <gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <yazen.ghannam@amd.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <roberto.sassu@huawei.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v13 04/18] cxl: move cxl headers to new include/cxl/ directory
Date: Wed, 9 Oct 2024 13:41:05 +0100
Message-ID: <20241009124120.1124-5-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20241009124120.1124-1-shiju.jose@huawei.com>
References: <20241009124120.1124-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Dave Jiang <dave.jiang@intel.com>

Group all cxl related kernel headers into include/cxl/ directory.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 MAINTAINERS                                | 3 +--
 drivers/acpi/apei/einj-cxl.c               | 2 +-
 drivers/acpi/apei/ghes.c                   | 2 +-
 drivers/cxl/core/port.c                    | 2 +-
 drivers/cxl/cxlmem.h                       | 2 +-
 include/{linux/einj-cxl.h => cxl/einj.h}   | 0
 include/{linux/cxl-event.h => cxl/event.h} | 0
 7 files changed, 5 insertions(+), 6 deletions(-)
 rename include/{linux/einj-cxl.h => cxl/einj.h} (100%)
 rename include/{linux/cxl-event.h => cxl/event.h} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc40a9d9b8cd..ae17d28c5f73 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5620,8 +5620,7 @@ L:	linux-cxl@vger.kernel.org
 S:	Maintained
 F:	Documentation/driver-api/cxl
 F:	drivers/cxl/
-F:	include/linux/einj-cxl.h
-F:	include/linux/cxl-event.h
+F:	include/cxl/
 F:	include/uapi/linux/cxl_mem.h
 F:	tools/testing/cxl/
 
diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
index 8b8be0c90709..4f81a119ec08 100644
--- a/drivers/acpi/apei/einj-cxl.c
+++ b/drivers/acpi/apei/einj-cxl.c
@@ -7,9 +7,9 @@
  *
  * Author: Ben Cheatham <benjamin.cheatham@amd.com>
  */
-#include <linux/einj-cxl.h>
 #include <linux/seq_file.h>
 #include <linux/pci.h>
+#include <cxl/einj.h>
 
 #include "apei-internal.h"
 
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 623cc0cb4a65..ada93cfde9ba 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -27,7 +27,6 @@
 #include <linux/timer.h>
 #include <linux/cper.h>
 #include <linux/cleanup.h>
-#include <linux/cxl-event.h>
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
 #include <linux/ratelimit.h>
@@ -50,6 +49,7 @@
 #include <acpi/apei.h>
 #include <asm/fixmap.h>
 #include <asm/tlbflush.h>
+#include <cxl/event.h>
 #include <ras/ras_event.h>
 
 #include "apei-internal.h"
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1d5007e3795a..e0b28a6730c1 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -3,7 +3,6 @@
 #include <linux/platform_device.h>
 #include <linux/memregion.h>
 #include <linux/workqueue.h>
-#include <linux/einj-cxl.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/module.h>
@@ -11,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/idr.h>
 #include <linux/node.h>
+#include <cxl/einj.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
 #include <cxl.h>
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index afb53d058d62..a81a8982bf93 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -6,8 +6,8 @@
 #include <linux/cdev.h>
 #include <linux/uuid.h>
 #include <linux/rcuwait.h>
-#include <linux/cxl-event.h>
 #include <linux/node.h>
+#include <cxl/event.h>
 #include "cxl.h"
 
 /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
diff --git a/include/linux/einj-cxl.h b/include/cxl/einj.h
similarity index 100%
rename from include/linux/einj-cxl.h
rename to include/cxl/einj.h
diff --git a/include/linux/cxl-event.h b/include/cxl/event.h
similarity index 100%
rename from include/linux/cxl-event.h
rename to include/cxl/event.h
-- 
2.34.1


