Return-Path: <linux-edac+bounces-3381-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5383A6ACB5
	for <lists+linux-edac@lfdr.de>; Thu, 20 Mar 2025 19:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BF267B1098
	for <lists+linux-edac@lfdr.de>; Thu, 20 Mar 2025 18:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32101227E8F;
	Thu, 20 Mar 2025 18:05:38 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11808227B83;
	Thu, 20 Mar 2025 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493938; cv=none; b=Z4cs60hyWNSVBazxxZ4WkJy4frEzMAFAeZVUgCZ5LvXPjY9+7OWZHtS7dw+qWmy6yrnXX8XkIqwFLjYVV4n1BRglvaqxMexqoe2aaOjUrXhYzehlWeMYxc+NV/Ibk6nSLUvPbyzA9wyHbHs6ZsQCectQ1rPAFbLRo02DErE9M3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493938; c=relaxed/simple;
	bh=SD+DdQiarUAS24vNkjCi+X85etZk11V+cPYKINi+TOE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vFGwKJ/dZTECKgGXe/SFfaa+NQEevFKHsVY14xqMcyFV8Eyio8o7M77L8GFs21EiXQXIJrBUuhNCL4A/SFp2ukY0dQx9xTIhWaonSLQEnrCRawGlWmUJVgbGD3Qy/BQby7ztGg9AeUgIGHHCqwSewtlTApNJco1jDIqMrxi2UtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZJYK32CMbz6L58c;
	Fri, 21 Mar 2025 02:00:39 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id CBD7314050D;
	Fri, 21 Mar 2025 02:05:33 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.156.145) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Mar 2025 19:05:31 +0100
From: <shiju.jose@huawei.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <david@redhat.com>, <Vilas.Sridharan@amd.com>
CC: <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
	<tony.luck@intel.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<mchehab@kernel.org>, <leo.duran@amd.com>, <Yazen.Ghannam@amd.com>,
	<rientjes@google.com>, <jiaqiyan@google.com>, <Jon.Grimm@amd.com>,
	<dave.hansen@linux.intel.com>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
	<erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
	<gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <yazen.ghannam@amd.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <roberto.sassu@huawei.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 2/8] EDAC: Update documentation for the CXL memory patrol scrub control feature
Date: Thu, 20 Mar 2025 18:04:39 +0000
Message-ID: <20250320180450.539-3-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250320180450.539-1-shiju.jose@huawei.com>
References: <20250320180450.539-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Update the Documentation/edac/scrub.rst to include descriptions and
policies for CXL memory device-based and CXL region-based patrol scrub
control.

Note: This may require inputs from CXL memory experts regarding
region-based scrubbing policies.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 Documentation/edac/scrub.rst | 47 ++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/edac/scrub.rst b/Documentation/edac/scrub.rst
index daab929cdba1..d1c02bd90090 100644
--- a/Documentation/edac/scrub.rst
+++ b/Documentation/edac/scrub.rst
@@ -264,3 +264,51 @@ Sysfs files are documented in
 `Documentation/ABI/testing/sysfs-edac-scrub`
 
 `Documentation/ABI/testing/sysfs-edac-ecs`
+
+Examples
+--------
+
+The usage takes the form shown in these examples:
+
+1. CXL memory device patrol scrubber
+
+1.1 Device based scrubbing
+
+CXL memory is exposed to memory management subsystem and ultimately userspace
+via CXL devices.
+
+For cases where hardware interleave controls do not directly map to regions of
+Physical Address space, perhaps due to interleave the approach described in 
+1.2 Region based scrubbing section, which is specific to CXL regions should be
+followed. In those cases settings on the presented interface may interact with
+direct control via a device instance specific interface and care must be taken.
+
+Sysfs files for scrubbing are documented in
+`Documentation/ABI/testing/sysfs-edac-scrub`
+
+1.2. Region based scrubbing
+
+CXL memory is exposed to memory management subsystem and ultimately userspace
+via CXL regions. CXL Regions represent mapped memory capacity in system
+physical address space. These can incorporate one or more parts of multiple CXL
+memory devices with traffic interleaved across them. The user may want to control
+the scrub rate via this more abstract region instead of having to figure out the
+constituent devices and program them separately. The scrub rate for each device
+covers the whole device. Thus if multiple regions use parts of that device then
+requests for scrubbing of other regions may result in a higher scrub rate than
+requested for this specific region.
+
+1. When user sets scrub rate for a memory region, the scrub rate for all the CXL
+   memory devices interleaved under that region is updated with the same scrub
+   rate.
+
+2. When user sets scrub rate for a memory device, only the scrub rate for that
+   memory devices is updated though device may be part of a memory region and
+   does not change scrub rate of other memory devices of that memory region.
+
+3. Scrub rate of a CXL memory device may be set via EDAC device or region scrub
+   interface simultaneously. Care must be taken to prevent a race condition, or
+   only region-based setting may be allowed.
+
+Sysfs files for scrubbing are documented in
+`Documentation/ABI/testing/sysfs-edac-scrub`
-- 
2.43.0


