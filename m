Return-Path: <linux-edac+bounces-3971-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1E9ABF4A9
	for <lists+linux-edac@lfdr.de>; Wed, 21 May 2025 14:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2E01BC19A1
	for <lists+linux-edac@lfdr.de>; Wed, 21 May 2025 12:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828A4267B04;
	Wed, 21 May 2025 12:48:25 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E172673BF;
	Wed, 21 May 2025 12:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747831705; cv=none; b=JQvZMyx7XESawhcrbmsWpbWTQGATApr4rTXwYvDAif8TBjpMZEt9rmXlrwYlzDN3J/aKmgTp7n52pcOo4tmQhi6kSbQNrhI6SWrmPm+NNoX1qwQ3DLblbMGyKc+3DNUaPz6+tJUzv7O0g9dlBUWyQiedxE6ObogatQYsPyNSe0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747831705; c=relaxed/simple;
	bh=qzisjKXsGWchxCsqNBF46vg5peSw/jqaxWH0IkhSG9A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U8U1qcr87L3UA0Gc8IwJsy37z38oKBs/Xt5Ou8gb2frq/0qFzJFXIRmKCw50mgA6tA8w0jS85cCXBPtCcz+xUKfjxBsqiZAQu3KduX3j7TnRIzc7rOaWUKJs4sRSeMJggH2o286fOAJqrFKpgzuZ0bDN+oKX/1Pbwnpv8Fn5Z5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b2WR307SQz6GD7p;
	Wed, 21 May 2025 20:47:27 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 165F61404F4;
	Wed, 21 May 2025 20:48:20 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.151.26) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 May 2025 14:48:18 +0200
From: <shiju.jose@huawei.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>
CC: <linux-edac@vger.kernel.org>, <linux-doc@vger.kernel.org>, <bp@alien8.de>,
	<tony.luck@intel.com>, <lenb@kernel.org>, <Yazen.Ghannam@amd.com>,
	<mchehab@kernel.org>, <nifan.cxl@gmail.com>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v6 1/8] EDAC: Update documentation for the CXL memory patrol scrub control feature
Date: Wed, 21 May 2025 13:47:39 +0100
Message-ID: <20250521124749.817-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250521124749.817-1-shiju.jose@huawei.com>
References: <20250521124749.817-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Update the Documentation/edac/scrub.rst to include use cases and
policies for CXL memory device-based, CXL region-based patrol scrub
control and CXL Error Check Scrub (ECS).

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 Documentation/edac/scrub.rst | 76 ++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/Documentation/edac/scrub.rst b/Documentation/edac/scrub.rst
index daab929cdba1..2cfa74fa1ffd 100644
--- a/Documentation/edac/scrub.rst
+++ b/Documentation/edac/scrub.rst
@@ -264,3 +264,79 @@ Sysfs files are documented in
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
+The following are the use cases identified why we might increase the scrub rate.
+
+- Scrubbing is needed at device granularity because a device is showing
+  unexpectedly high errors.
+
+- Scrubbing may apply to memory that isn't online at all yet. Likely this
+  is a system wide default setting on boot.
+
+- Scrubbing at a higher rate because the monitor software has determined that
+  more reliability is necessary for a particular data set. This is called
+  Differentiated Reliability.
+
+1.1. Device based scrubbing
+
+CXL memory is exposed to memory management subsystem and ultimately userspace
+via CXL devices. Device-based scrubbing is used for the first use case
+described in "Section 1 CXL Memory Patrol Scrub".
+
+When combining control via the device interfaces and region interfaces,
+"see Section 1.2 Region based scrubbing".
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
+Region-based scrubbing is used for the third use case described in
+"Section 1 CXL Memory Patrol Scrub".
+
+Userspace must follow below set of rules on how to set the scrub rates for any
+mixture of requirements.
+
+1. Taking each region in turn from lowest desired scrub rate to highest and set
+   their scrub rates. Later regions may override the scrub rate on individual
+   devices (and hence potentially whole regions).
+
+2. Take each device for which enhanced scrubbing is required (higher rate) and
+   set those scrub rates. This will override the scrub rates of individual devices,
+   setting them to the maximum rate required for any of the regions they help back,
+   unless a specific rate is already defined.
+
+Sysfs files for scrubbing are documented in
+`Documentation/ABI/testing/sysfs-edac-scrub`
+
+2. CXL memory Error Check Scrub (ECS)
+
+The Error Check Scrub (ECS) feature enables a memory device to perform error
+checking and correction (ECC) and count single-bit errors. The associated
+memory controller sets the ECS mode with a trigger sent to the memory
+device. CXL ECS control allows the host, thus the userspace, to change the
+attributes for error count mode, threshold number of errors per segment
+(indicating how many segments have at least that number of errors) for
+reporting errors, and reset the ECS counter. Thus the responsibility for
+initiating Error Check Scrub on a memory device may lie with the memory
+controller or platform when unexpectedly high error rates are detected.
+
+Sysfs files for scrubbing are documented in
+`Documentation/ABI/testing/sysfs-edac-ecs`
-- 
2.43.0


