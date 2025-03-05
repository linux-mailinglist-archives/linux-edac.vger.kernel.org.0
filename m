Return-Path: <linux-edac+bounces-3271-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D30DA50807
	for <lists+linux-edac@lfdr.de>; Wed,  5 Mar 2025 19:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 639E61894072
	for <lists+linux-edac@lfdr.de>; Wed,  5 Mar 2025 18:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89ADB250BFB;
	Wed,  5 Mar 2025 18:02:59 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245481C6FF9;
	Wed,  5 Mar 2025 18:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197779; cv=none; b=jh1+wOz7WdYchZJU4ZTf/esYRluifnKCBkzwGRN1YOsjUVGf9V/oG2G7oVcPGTWRzPnLocW0s+nSz2QghoYV0XXNFq2RL5Cgk8HQnwLe2U+6x7Kl5ObPs6yLjs0izpmILqL2XqeXqpRAOsm7newsfrlzJk0Xc+ZJ6TVAolDqXu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197779; c=relaxed/simple;
	bh=1GMSArG03C7iHnBvKa7KTRSKeZrEaZU/jlO0kyc68LM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fNmq+2RkHJ6z3HmQW3fd2U/WHeeTAJNiEsBYtsgB9TLkO/04g99uVd2DYuLx+alICw/LdIgV/mYTWi2LG82hQF2yvF5v//M1fR4Pmb0q7ZNPNVOoNjXxEJQGZf+79ZpM0tq8ZMUZHayQ1GRZ2pZiQcHV6rBx0OUlptv39xz5KbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z7Kzp1nrpz6L57s;
	Thu,  6 Mar 2025 01:58:46 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 39DE61409EA;
	Thu,  6 Mar 2025 02:02:53 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.145.140) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Mar 2025 19:02:51 +0100
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<bp@alien8.de>, <tony.luck@intel.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <mchehab@kernel.org>, <leo.duran@amd.com>,
	<Yazen.Ghannam@amd.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <david@redhat.com>, <Vilas.Sridharan@amd.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <rientjes@google.com>,
	<jiaqiyan@google.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <jthoughton@google.com>,
	<somasundaram.a@hpe.com>, <erdemaktas@google.com>, <pgonda@google.com>,
	<duenwen@google.com>, <gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <yazen.ghannam@amd.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <roberto.sassu@huawei.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 0/3] ACPI: Add support for ACPI RAS2 feature table
Date: Wed, 5 Mar 2025 18:02:21 +0000
Message-ID: <20250305180225.1226-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Add support for ACPI RAS2 feature table (RAS2) defined in the
ACPI 6.5 specification, section 5.2.21 and RAS2 HW based memory
scrubbing feature.

ACPI RAS2 patches were part of the EDAC series [1].

The code is based on ras.git: edac-cxl branch [2].

1. https://lore.kernel.org/linux-cxl/20250212143654.1893-1-shiju.jose@huawei.com/ 
2. https://web.git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git/log/?h=edac-cxl

Changes
=======
v1 -> v2:
1.  Changes for feedbacks from Borislav.
    - Shorten ACPI RAS2 structures and variables names in "include/acpi/actbl2.h".
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
	  
3. Rename file include/acpi/acpi_ras2.h to include/acpi/ras2.h
	  
Shiju Jose (3):
  ACPI: ACPI 6.5: RAS2: Shorten RAS2 table structure and variable names
  ACPI:RAS2: Add ACPI RAS2 driver
  ras: mem: Add memory ACPI RAS2 driver

 Documentation/edac/scrub.rst |  73 ++++++
 drivers/acpi/Kconfig         |  11 +
 drivers/acpi/Makefile        |   1 +
 drivers/acpi/bus.c           |   3 +
 drivers/acpi/ras2.c          | 416 +++++++++++++++++++++++++++++++++++
 drivers/ras/Kconfig          |  11 +
 drivers/ras/Makefile         |   1 +
 drivers/ras/acpi_ras2.c      | 391 ++++++++++++++++++++++++++++++++
 include/acpi/actbl2.h        |  38 ++--
 include/acpi/ras2.h          |  54 +++++
 10 files changed, 980 insertions(+), 19 deletions(-)
 create mode 100755 drivers/acpi/ras2.c
 create mode 100644 drivers/ras/acpi_ras2.c
 create mode 100644 include/acpi/ras2.h

-- 
2.43.0


