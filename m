Return-Path: <linux-edac+bounces-3379-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D05A6ACB0
	for <lists+linux-edac@lfdr.de>; Thu, 20 Mar 2025 19:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED4DE1896A5D
	for <lists+linux-edac@lfdr.de>; Thu, 20 Mar 2025 18:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321371EB5D9;
	Thu, 20 Mar 2025 18:05:34 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28592AD20;
	Thu, 20 Mar 2025 18:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493934; cv=none; b=pT6LMTj/kCm5Xb+7V2W8lsU1McLTuU/4Yn1x3oB6EwvD8NXT7qme6C/97+yqGcOd16BvMTCbMCyToxn2B70zf9vonpba4WwXtZDb2G9OJPv8YZVwHNxfm/O911qzCHHlUqWsmoECQlGbo/CSVJH7wUfAk9uL9EsJObGpGnaqpFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493934; c=relaxed/simple;
	bh=0t4PiwsiSc6juoFtUbzI40uzV16dx23LcTpGllWaXdM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aNYeOf076Cc6+aQRjzyhIN9C/x370xtes6Hm12ugA/q3b1x+xZ+yMTYP1syYWgeiL2kRWaX78gOHSy+GI+2jfJx9RxN2xdzEvKkWakVlOpo5CqgvZGd9PeMTqahHXRyhDXhQPtL/X1zufbLUADVWoOERUczc/l45yjH+sb+0ItM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZJYM93p9Wz6K9M6;
	Fri, 21 Mar 2025 02:02:29 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 103481405A0;
	Fri, 21 Mar 2025 02:05:28 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.156.145) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Mar 2025 19:05:25 +0100
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
Subject: [PATCH v2 0/8] cxl: support CXL memory RAS features
Date: Thu, 20 Mar 2025 18:04:37 +0000
Message-ID: <20250320180450.539-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Support for CXL memory RAS features: patrol scrub, ECS, soft-PPR and
memory sparing.

This CXL series was part of the EDAC series [1].

The code is based on cxl.git next branch [2] merged with ras.git edac-cxl
branch [3].

1. https://lore.kernel.org/linux-cxl/20250212143654.1893-1-shiju.jose@huawei.com/
2. https://web.git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=next
3. https://web.git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git/log/?h=edac-cxl

Userspace code for CXL memory repair features [4] and
sample boot-script for CXL memory repair [5].

[4]: https://lore.kernel.org/lkml/20250207143028.1865-1-shiju.jose@huawei.com/
[5]: https://lore.kernel.org/lkml/20250207143028.1865-5-shiju.jose@huawei.com/

Changes
=======
v1 -> v2:
1. Feedbacks from Dan Williams on v1,
   https://lore.kernel.org/linux-mm/20250307091137.00006a0a@huawei.com/T/
  - Fixed lock issues in region scrubbing, added local cxl_acquire()
    and cxl_unlock.
  - Replaced CXL examples using cat and echo from EDAC .rst docs
    with short description and ref to ABI docs. Also corrections
    in existing descriptions as suggested by Dan.
  - Add policy description for the scrub control feature.
    However this may require inputs from CXL experts. 
  - Replaced CONFIG_CXL_RAS_FEATURES with CONFIG_CXL_EDAC_MEM_FEATURES.
  - Few changes to depends part of CONFIG_CXL_EDAC_MEM_FEATURES.
  - Rename drivers/cxl/core/memfeatures.c as drivers/cxl/core/edac.c
  - snprintf() -> kasprintf() in few places.
  
2. Feedbacks from Alison on v1,
  - In cxl_get_feature_entry()(patch 1), return NULL on failures and
    reintroduced checks in cxl_get_feature_entry().
  - Changed logic in for loop in region based scrubbing code.
  - Replace cxl_are_decoders_committed() to cxl_is_memdev_memory_online()
    and add as a local function to drivers/cxl/core/edac.c
  - Changed few multiline comments to single line comments.
  - Removed unnecessary comments from the code.
  - Reduced line length of few macros in ECS and memory repair code.
  - In new files, changed "GPL-2.0-or-later" -> "GPL-2.0-only".
  - Ran clang-format for new files and updated.                                                                                                                                                                       
3. Changes for feedbacks from Jonathan on v1.
  - Changed few multiline comments to single line comments.

Shiju Jose (8):
  cxl: Add helper function to retrieve a feature entry
  EDAC: Update documentation for the CXL memory patrol scrub control
    feature
  cxl/edac: Add CXL memory device patrol scrub control feature
  cxl/edac: Add CXL memory device ECS control feature
  cxl/mbox: Add support for PERFORM_MAINTENANCE mailbox command
  cxl: Support for finding memory operation attributes from the current
    boot
  cxl/memfeature: Add CXL memory device soft PPR control feature
  cxl/memfeature: Add CXL memory device memory sparing control feature

 Documentation/edac/memory_repair.rst |   31 +
 Documentation/edac/scrub.rst         |   47 +
 drivers/cxl/Kconfig                  |   27 +
 drivers/cxl/core/Makefile            |    1 +
 drivers/cxl/core/core.h              |    2 +
 drivers/cxl/core/edac.c              | 1730 ++++++++++++++++++++++++++
 drivers/cxl/core/features.c          |   23 +
 drivers/cxl/core/mbox.c              |   45 +-
 drivers/cxl/core/memdev.c            |    9 +
 drivers/cxl/core/ras.c               |  145 +++
 drivers/cxl/core/region.c            |    5 +
 drivers/cxl/cxlmem.h                 |   73 ++
 drivers/cxl/mem.c                    |    4 +
 drivers/cxl/pci.c                    |    3 +
 drivers/edac/mem_repair.c            |    9 +
 include/linux/edac.h                 |    7 +
 16 files changed, 2159 insertions(+), 2 deletions(-)
 create mode 100644 drivers/cxl/core/edac.c

-- 
2.43.0


