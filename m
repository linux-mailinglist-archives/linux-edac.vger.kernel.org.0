Return-Path: <linux-edac+bounces-3477-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D303A7E904
	for <lists+linux-edac@lfdr.de>; Mon,  7 Apr 2025 19:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96F2B178265
	for <lists+linux-edac@lfdr.de>; Mon,  7 Apr 2025 17:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D47217663;
	Mon,  7 Apr 2025 17:50:04 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C475A2101BD;
	Mon,  7 Apr 2025 17:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744048204; cv=none; b=aXwBcSmA/twMnb67b8CiENe/ktpJ9B22oNII/jPp5Ip4wAgEwBbWkE4fJhy8Yp8qCaHDreezESHfHhex7ZrpgbCqetY5FBnmNq5nVwRb5BvJQgTjuorVdjFU7OYXYGIkMreM9SCcy2syq+S9G5NV3Dd9OpJLXRXw8Vfz4TnEmx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744048204; c=relaxed/simple;
	bh=P35FgrZSZbVocTMu2+radD/yCL1mDH3YySYIvSGgbqM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ACRmUZ3rGIOZb0vBdb8XOnL3wML59rIjDs5ZA8/3YjGP9OzGY7T0KVeThfVnMEaf5eGFl3YnkAzeQE2QB948i+a50OyxPnAq+CWkTJ38NkDWgUGWmJEHDyBVWDi/IK+wUDax3958+K3gmX9AQ62ADAkJ6EEkJTPS/xivqYJsplE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZWc851Pb8z6M4RC;
	Tue,  8 Apr 2025 01:46:13 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E7DB1400DB;
	Tue,  8 Apr 2025 01:49:59 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.154.56) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Apr 2025 19:49:57 +0200
From: <shiju.jose@huawei.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>
CC: <linux-edac@vger.kernel.org>, <linux-doc@vger.kernel.org>, <bp@alien8.de>,
	<tony.luck@intel.com>, <lenb@kernel.org>, <leo.duran@amd.com>,
	<Yazen.Ghannam@amd.com>, <mchehab@kernel.org>, <nifan.cxl@gmail.com>,
	<linuxarm@huawei.com>, <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v3 1/8] EDAC: Update documentation for the CXL memory patrol scrub control feature
Date: Mon, 7 Apr 2025 18:49:12 +0100
Message-ID: <20250407174920.625-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250407174920.625-1-shiju.jose@huawei.com>
References: <20250407174920.625-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Update the Documentation/edac/scrub.rst to include usecases and
policies for CXL memory device-based, CXL region-based patrol scrub
control and CXL Error Check Scrub (ECS).

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 Documentation/edac/scrub.rst | 75 ++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/Documentation/edac/scrub.rst b/Documentation/edac/scrub.rst
index daab929cdba1..6132853a02fe 100644
--- a/Documentation/edac/scrub.rst
+++ b/Documentation/edac/scrub.rst
@@ -264,3 +264,78 @@ Sysfs files are documented in
 `Documentation/ABI/testing/sysfs-edac-scrub`
 
 `Documentation/ABI/testing/sysfs-edac-ecs`
+
+Examples
+--------
+
+The usage takes the form shown in these examples:
+
+1. CXL memory Patrol Scrub
+
+The following are the usecases identified why we might increase the scrub rate.
+
+- Scrubbing is needed at device granularity because a device is showing
+  unexpectedly high errors, the scrub control needs to be at device
+  granularity
+
+- Scrubbing may apply to memory that isn't online at all yet.Likely this
+  is setting system wide defaults on boot.
+
+- Scrubbing at higher rate because software has decided that we want
+  more reliability for particular data, calling this Differentiated
+  Reliability.  That data sits in a region which may cover part of multiple
+  devices. The region interfaces are about supporting this use case.
+
+1.1. Device based scrubbing
+
+CXL memory is exposed to memory management subsystem and ultimately userspace
+via CXL devices.
+
+When combining control via the device interfaces and region interfaces see
+1.2 Region bases scrubbing.
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
+Userspace must follow below set of rules on how to set the scrub rates for any
+mixture of requirements.
+
+1. Taking each region in turn from lowest desired scrub rate to highest and set
+   their scrub rates. Later regions may override the scrub rate on individual
+   devices (and hence potentially whole regions).
+
+2. Take each device for which enhanced scrubbing is required (higher rate) and
+   set those scrub rates. This will override the scrub rates of individual devices
+   leaving any that are not specifically set to scrub at the maximum rate required
+   for any of the regions they are involved in backing.
+
+Sysfs files for scrubbing are documented in
+`Documentation/ABI/testing/sysfs-edac-scrub`
+
+2. CXL memory Error Check Scrub (ECS)
+
+The Error Check Scrub (ECS) feature enables a memory device to perform error
+checking and correction (ECC) and count single-bit errors. The associated
+memory controller triggers the ECS mode with a trigger sent to the memory
+device. However, CXL ECS control allows the user to change the attributes
+for error count mode and threshold for reporting errors and reset the ECS
+counter only. Thus, the scope of start Error Check Scrub on a memory device
+lies within a memory controller or platform when it is detecting unexpectedly
+high errors. Userspace allows to control the error count mode, threshold
+number of errors for a segment count indicating a number of segments
+having at least a threshold number of errors and reset the ECS counter.
+
+Sysfs files for scrubbing are documented in
+`Documentation/ABI/testing/sysfs-edac-ecs`
-- 
2.43.0


