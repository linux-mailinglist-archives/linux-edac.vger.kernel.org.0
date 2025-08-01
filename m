Return-Path: <linux-edac+bounces-4496-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49049B18675
	for <lists+linux-edac@lfdr.de>; Fri,  1 Aug 2025 19:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64FDB17A110
	for <lists+linux-edac@lfdr.de>; Fri,  1 Aug 2025 17:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20431DF725;
	Fri,  1 Aug 2025 17:21:07 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87281D63E6;
	Fri,  1 Aug 2025 17:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754068867; cv=none; b=Yu/9OyeKMxim5Q+054PphP1ujhZHe399PoEbnwVXGrRCMHBxVkwDlpm34Y4tM+hEBL4j+eMvldgIBEe5S3apH0aDacaW3+0tpJG7L1z09H1AHe+jc1BjHLnJTFod2o5WAgle9vsMyfSDXektni+PW1qcbJ7GqqmhwBkU+VkpgkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754068867; c=relaxed/simple;
	bh=BYoxU2iEiU/cjSbw+PHIwybDoaaGFByv5x2kW04JfXo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FEbvxyVe9V6upKwuukeO56SRcynqNOnoBYQnn+okgGOpCIxboqoQE4kVtYkSXYl7xvbRdXceDWR/fEJhFe4BFrMxin1Vfy9WupPvmPbGkkbFWSQqWcDnFB0vwMZFT2N3S3/hE0w3GPFC/egerfI+bAPC+SKvcvhQ/lTURm4qarU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4btt372pgDz6L56C;
	Sat,  2 Aug 2025 01:18:59 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 1B2DD1400D4;
	Sat,  2 Aug 2025 01:21:02 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.32.206) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Aug 2025 19:20:59 +0200
From: <shiju.jose@huawei.com>
To: <rafael@kernel.org>, <bp@alien8.de>, <akpm@linux-foundation.org>,
	<rppt@kernel.org>, <dferguson@amperecomputing.com>,
	<linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-doc@vger.kernel.org>, <tony.luck@intel.com>,
	<lenb@kernel.org>, <leo.duran@amd.com>, <Yazen.Ghannam@amd.com>,
	<mchehab@kernel.org>
CC: <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>,
	<rientjes@google.com>, <jiaqiyan@google.com>, <Jon.Grimm@amd.com>,
	<dave.hansen@linux.intel.com>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
	<erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
	<gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<wbs@os.amperecomputing.com>, <nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <roberto.sassu@huawei.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<shiju.jose@huawei.com>
Subject: [PATCH v10 0/3] ACPI: Add support for ACPI RAS2 feature table
Date: Fri, 1 Aug 2025 18:20:26 +0100
Message-ID: <20250801172040.2175-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

1. Add node_to_range lookup facility to numa_memblks, which is
   required for the ACPI RAS2 memory features.
   
2. Add support for ACPI RAS2 feature table (RAS2) defined in the
   ACPI 6.5 specification, section 5.2.21 and RAS2 HW based memory
   scrubbing feature.

ACPI RAS2 patches were part of the EDAC series [1].

The code is based on linux.git v6.16-rc7 [2].

1. https://lore.kernel.org/linux-cxl/20250212143654.1893-1-shiju.jose@huawei.com/
2. https://github.com/torvalds/linux.git

Changes
=======
v9 -> v10:
1. Use pcc_chan->shmem instead of 
   acpi_os_ioremap(pcc_chan->shmem_base_addr,...) as it was
   acpi_os_ioremap internally by the PCC driver to pcc_chan->shmem.
   
2. Changes required for the Ampere Computing system where uses a single
   PCC channel for RAS2 memory features across all NUMA domains. Based on the
   requirements from by Daniel on V9
   https://lore.kernel.org/all/547ed8fb-d6b7-4b6b-a38b-bf13223971b1@os.amperecomputing.com/
   and discussion with Jonathan.
2.1 Add node_to_range lookup facility to numa_memblks. This is to retrieve the lowest
    physical continuous memory range of the memory associated with a NUMA domain.
2.2. Set requested addr range to the memory region's base addr and size
   while send RAS2 cmd GET_PATROL_PARAMETER 
   in functions ras2_update_patrol_scrub_params_cache() &
   ras2_get_patrol_scrub_running().
2.3. Split struct ras2_mem_ctx into struct ras2_mem_ctx_hdr and struct ras2_pxm_domain
   to support cases, uses a single PCC channel for RAS2 scrubbers across all NUMA
   domains and PCC channel per RAS2 scrub instance. Provided ACPI spec define single
   memory scrub per NUMA domain.
2.4. EDAC feature sysfs folder for RAS2 changed from "acpi_ras_memX" to  "acpi_ras_mem_idX"
   because memory scrub instances across all NUMA domains would present under
   "acpi_ras_mem_id0" when a system uses a single PCC channel for RAS2 scrubbers across
   all NUMA domains etc.
2.5. Removed Acked-by: Rafael from patch [2], because of the several above changes from v9.

v8 -> v9:
1. Added following changes for feedback from Yazen.
 1.1 In ras2_check_pcc_chan(..) function
    - u32 variables moved to the same line.
    - Updated error log for readw_relaxed_poll_timeout()
    - Added error log for if (status & PCC_STATUS_ERROR), error condition.
    - Removed an impossible condition check.
  1.2. Added guard for ras2_pc_list_lock in ras2_get_pcc_subspace().
        
2. Rebased to linux.git v6.16-rc2 [2].

v7 -> v8:
1. Rebased to linux.git v6.16-rc1 [2].

v6 -> v7:
1. Fix for the issue reported by Daniel,
   In ras2_check_pcc_chan(), add read, clear and check RAS2 set_cap_status outside
   if (status & PCC_STATUS_ERROR) check. 
   https://lore.kernel.org/all/51bcb52c-4132-4daf-8903-29b121c485a1@os.amperecomputing.com/

v5 -> v6:
1. Fix for the issue reported by Daniel, in start scrubbing with correct addr and size
   after firmware return INVALID DATA error for scrub request with invalid addr or size.
   https://lore.kernel.org/all/8cdf7885-31b3-4308-8a7c-f4e427486429@os.amperecomputing.com/
   
v4 -> v5:
1. Fix for the build warnings reported by kernel test robot.
   https://patchwork.kernel.org/project/linux-edac/patch/20250423163511.1412-3-shiju.jose@huawei.com/
2. Removed patch "ACPI: ACPI 6.5: RAS2: Rename RAS2 table structure and field names"
   from the series as the patch was merged to linux-pm.git : branch linux-next
3. Rebased to ras.git: edac-for-next branch merged with linux-pm.git : linux-next branch.
      
v3 -> v4:
1.  Changes for feedbacks from Yazen on v3.
    https://lore.kernel.org/all/20250415210504.GA854098@yaz-khff2.amd.com/

v2 -> v3:
1. Rename RAS2 table structure and field names in 
   include/acpi/actbl2.h limited to only necessary
   for RAS2 scrub feature.
2. Changes for feedbacks from Jonathan on v2.
3. Daniel reported a known behaviour: when readback 'size' attribute after
   setting in, returns 0 before starting scrubbing via 'addr' attribute.
   Changes added to fix this.
4. Daniel reported that firmware cannot update status of demand scrubbing
   via the 'Actual Address Range (OUTPUT)', thus add workaround in the
   kernel to update sysfs 'addr' attribute with the status of demand
   scrubbing.
5. Optimized logic in ras2_check_pcc_chan() function
   (patch - ACPI:RAS2: Add ACPI RAS2 driver).
6. Add PCC channel lock to struct ras2_pcc_subspace and change
   lock in ras2_mem_ctx as a pointer to pcc channel lock to make sure
   writing to PCC subspace shared memory is protected from race conditions.
   
v1 -> v2:
1.  Changes for feedbacks from Borislav.
    - Shorten ACPI RAS2 structures and variables names.
    - Shorten some of the other variables in the RAS2 drivers.
    - Fixed few CamelCases.

2.  Changes for feedbacks from Yazen.
    - Added newline after number of '}' and return statements.
    - Changed return type for "ras2_add_aux_device() to 'int'.
    - Deleted a duplication of acpi_get_table("RAS2",...) in the ras2_acpi_parse_table().
    - Add "FW_WARN" to few error logs in the ras2_acpi_parse_table().
    - Rename ras2_acpi_init() to acpi_ras2_init() and modified to call acpi_ras2_init()
      function from the acpi_init().
    - Moved scrub related variables from the struct ras2_mem_ctx from  patch
      "ACPI:RAS2: Add ACPI RAS2 driver" to "ras: mem: Add memory ACPI RAS2 driver".

Shiju Jose (3):
  mm: Add node_to_range lookup facility to numa_memblks
  ACPI:RAS2: Add ACPI RAS2 driver
  ras: mem: Add memory ACPI RAS2 driver

 Documentation/edac/scrub.rst |  79 ++++++
 drivers/acpi/Kconfig         |  12 +
 drivers/acpi/Makefile        |   1 +
 drivers/acpi/bus.c           |   3 +
 drivers/acpi/ras2.c          | 493 +++++++++++++++++++++++++++++++++++
 drivers/ras/Kconfig          |  11 +
 drivers/ras/Makefile         |   1 +
 drivers/ras/acpi_ras2.c      | 464 +++++++++++++++++++++++++++++++++
 include/acpi/ras2.h          |  99 +++++++
 include/linux/numa.h         |  10 +
 include/linux/numa_memblks.h |   2 +
 mm/numa.c                    |  10 +
 mm/numa_memblks.c            |  23 ++
 13 files changed, 1208 insertions(+)
 create mode 100644 drivers/acpi/ras2.c
 create mode 100644 drivers/ras/acpi_ras2.c
 create mode 100644 include/acpi/ras2.h

-- 
2.43.0


