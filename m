Return-Path: <linux-edac+bounces-3911-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E456DAB8576
	for <lists+linux-edac@lfdr.de>; Thu, 15 May 2025 14:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C1241BC201E
	for <lists+linux-edac@lfdr.de>; Thu, 15 May 2025 12:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEC2298C0A;
	Thu, 15 May 2025 11:59:58 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3462989B3;
	Thu, 15 May 2025 11:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747310398; cv=none; b=HenvhiaZ20d5eTzO1R+9aB3+YUBiP5ypccbd5QaJi2Xjg9GNezTEpa40H5GMNk1d9EFqA3o0Ptx6EaluiMI+vSHrTB/p9YWnb9t+saOLXxP8GGEovNQHi83cDdH4JuRRszl6rEGVsaafw4Q7fFfbf6srWA5GcpFtH6PGUobiAEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747310398; c=relaxed/simple;
	bh=YNHnzGmgk0PCfEVqTp1gWJH+faF1xkt1JTCR+ezCrAk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pnyq/S8f3dSvyBVsqrc6nQY/7vTeqTCJDFcNjPoxOReWhybhlFacX3NsMlEkwUn83mU+U32mqxLtphIjiffLSPzy0k5J8HYDXwDCg2ZWks/gZfz0XwOun9cT+LNd71UGj5FbrHx0bYTyBq9jZcwiQipr0GK4eyn+lzlP/xeSQcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZypYN4bkFz6M56p;
	Thu, 15 May 2025 19:55:04 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id D6072140447;
	Thu, 15 May 2025 19:59:47 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.152.208) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 May 2025 13:59:46 +0200
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
Subject: [PATCH v5 0/8] cxl: support CXL memory RAS features
Date: Thu, 15 May 2025 12:59:16 +0100
Message-ID: <20250515115927.772-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Support for CXL memory EDAC features: patrol scrub, ECS, soft-PPR and
memory sparing.

Detailed history of the complete EDAC series with CXL EDAC patches[1].

The code is based on [2] v6.15-rc4.

1. https://lore.kernel.org/linux-cxl/20250212143654.1893-1-shiju.jose@huawei.com/
2. https://github.com/torvalds/linux.git

Userspace code for CXL memory repair features [3] and
sample boot-script for CXL memory repair [4].

[3]: https://lore.kernel.org/lkml/20250207143028.1865-1-shiju.jose@huawei.com/
[4]: https://lore.kernel.org/lkml/20250207143028.1865-5-shiju.jose@huawei.com/

Changes
=======
v4 -> v5:
1. Fixed a compilation warning introduced by v3->v4, reported by Dave Jiang on v4. 
   drivers/cxl/core/edac.c: In function ‘cxl_mem_perform_sparing’:
   drivers/cxl/core/edac.c:1335:29: warning: the comparison will always evaluate as ‘true’ for the address of ‘validity_flags’ will never be NULL [-Waddress]
 1335 |                         if (!rec->media_hdr.validity_flags)
      |                             ^
   In file included from ./drivers/cxl/cxlmem.h:10,
                 from drivers/cxl/core/edac.c:21:
   ./include/cxl/event.h:35:12: note: ‘validity_flags’ declared here
   35 |         u8 validity_flags[2];
      |            ^~~~~~~~~~~~~~
2. Updated patches for tags given.

v3 -> v4:
1. Feedback from Dave Jiang on v3,
1.1. Changes for comments in EDAC scrub documentation for CXL use cases.
     https://lore.kernel.org/all/2df68c68-f1a8-4327-abc9-d265326c133d@intel.com/
1.2. Changes for comments in CXL memory sparing control feature.
     https://lore.kernel.org/all/4ee3323c-fb27-4fbe-b032-78fd54bc21a0@intel.com/
      
v2 -> v3:
1. Feedback from Dan Williams on v2,
   https://lore.kernel.org/linux-mm/20250320180450.539-1-shiju.jose@huawei.com/
  - Modified get_support_feature_info() in fwctl series generic to use in
    cxl/fxctl and cxl/edac and replace cxl_get_feature_entry() in the CXL edac
    series.
  - Add usecase note for CXL ECS in Documentation/edac/scrub.rst.
  - Add info message when device scrub rate set by a region overwritten with a
    local device scrub rate or another region's scrub rate.
  - Replace 'ps' with patrol_scrub in the patrol scrub feature.
  - Replaced usage of intermediate objects struct cxl_memdev_ps_params and
    enum cxl_scrub_param etc for patrol scrub and did same for ECS.
  - Rename CXL_MEMDEV_PS_* macros.
  - Rename scrub_cycle_hrs-> scrub_cycle_hours
  - Add if (!cxl_dev_name)
	return -ENOMEM;  to devm_cxl_memdev_edac_register()
  - Add  devm_cxl_region_edac_register(cxlr) for CXL_PARTMODE_PMEM case.
  - Add separate configurations for CXL scrub, ECS and memory repair
    CXL_EDAC_SCRUB, CXL_EDAC_ECS and CXL_EDAC_MEM_REPAIR.
  - Add 
       if (!capable(CAP_SYS_RAWIO))
             return -EPERM; for set attributes callbacks for CXL scrub, ECS and
    memory repair.  	       
  - In patch "cxl/mbox: Add support for PERFORM_MAINTENANCE mailbox command"
    * cxl_do_maintenance() -> cxl_perform_maintenance() and moved to cxl/core/edac.c 
    * kmalloc() -> kvzalloc()
  - In patch, "cxl: Support for finding memory operation attributes from the current boot"  
    * Moved code from drivers/cxl/core/ras.c to drivers/cxl/core/edac.c
    * Add few logics to releasing the cache to give safety with respect to error storms and burning
    * unlimited memory. 
    * Add estimated memory overhead expense of this feature documented in the Kconfig.
    * Unified various names such as attr, param, attrbs throughout the patches.
    * Moved > struct xarray rec_gen_media and struct xarray rec_dram; out of struct cxl_memdev
      to CXL edac object, but there is required a pointer to this object in struct cxl_memdev
      because the error records are reported and thus stored in the cxl_memdev context not
      in the CXL EDAC context.
      
2. Feedback from Borislav on v2,
  - In include/linux/edac.h 
    Replace EDAC_PPR -> EDAC_REPAIR_PPR
            EDAC_CACHELINE_SPARING -> EDAC_REPAIR_CACHELINE_SPARING etc.

v1 -> v2:
1. Feedback from Dan Williams on v1,
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

2. Feedback from Alison on v1,
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
  EDAC: Update documentation for the CXL memory patrol scrub control
    feature
  cxl: Update prototype of function get_support_feature_info()
  cxl/edac: Add CXL memory device patrol scrub control feature
  cxl/edac: Add CXL memory device ECS control feature
  cxl/edac: Add support for PERFORM_MAINTENANCE command
  cxl/edac: Support for finding memory operation attributes from the
    current boot
  cxl/edac: Add CXL memory device memory sparing control feature
  cxl/edac: Add CXL memory device soft PPR control feature

 Documentation/edac/memory_repair.rst |   31 +
 Documentation/edac/scrub.rst         |   76 +
 drivers/cxl/Kconfig                  |   71 +
 drivers/cxl/core/Makefile            |    1 +
 drivers/cxl/core/core.h              |    2 +
 drivers/cxl/core/edac.c              | 2082 ++++++++++++++++++++++++++
 drivers/cxl/core/features.c          |   17 +-
 drivers/cxl/core/mbox.c              |   11 +-
 drivers/cxl/core/memdev.c            |    1 +
 drivers/cxl/core/region.c            |   10 +
 drivers/cxl/cxl.h                    |   10 +
 drivers/cxl/cxlmem.h                 |   36 +
 drivers/cxl/mem.c                    |    4 +
 drivers/edac/mem_repair.c            |    9 +
 include/linux/edac.h                 |    7 +
 15 files changed, 2356 insertions(+), 12 deletions(-)
 create mode 100644 drivers/cxl/core/edac.c

-- 
2.43.0


