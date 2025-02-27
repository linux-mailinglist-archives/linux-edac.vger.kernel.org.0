Return-Path: <linux-edac+bounces-3223-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F044A48BAF
	for <lists+linux-edac@lfdr.de>; Thu, 27 Feb 2025 23:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C8A0188BBB5
	for <lists+linux-edac@lfdr.de>; Thu, 27 Feb 2025 22:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAC922B5BC;
	Thu, 27 Feb 2025 22:39:22 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A6C21884A;
	Thu, 27 Feb 2025 22:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740695962; cv=none; b=bPsjoJs50ATHwhgGic4oCl0XE3VrU3ZPJ1V2FEaAHX5Um4f50nbB738mdmYYw/C4Le+mQik25+EOntyjHcPj/7SOXmeT2NtwQQfI3PvNXCHSNCh0UJjDKR6VHBibzYHPhbYPIiYyuah4Kv5JwQX2yXNA8PdVzcQnHW2S9IZQZ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740695962; c=relaxed/simple;
	bh=UyowPfBVfNOfzdNPEUjRU3fb1usW618po+kEbU1iFPs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tMoIg8lHchNwqoiNUXy6aPDXN7nRiILDPRqOczugwvAO6H/T67xEwbV/cEm4Sd6mvAq6kJU/M/W6sSHII25coOtv/I+Kz7z8UC+PvN64MRrLTzLRX0zjySUptr3j4mHvHBz7Mq//54iEdUyJvTIX+61AOUXaUeAxxpkxuJv/4E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z3mRx1qTwz6K9HS;
	Fri, 28 Feb 2025 06:37:17 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id B10AF1400DA;
	Fri, 28 Feb 2025 06:39:16 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.149.240) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Feb 2025 23:39:14 +0100
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
Subject: [PATCH 0/8] cxl: support CXL memory RAS features
Date: Thu, 27 Feb 2025 22:38:07 +0000
Message-ID: <20250227223816.2036-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Support for CXL memory RAS features: patrol scrub, ECS, soft-PPR and
memory sparing.

This CXL series was part of the EDAC series [1].

The code is based on cxl.git: next branch [2] merged with ras.git: edac-cxl
branch [3].

1. https://lore.kernel.org/linux-cxl/20250212143654.1893-1-shiju.jose@huawei.com/
2. https://web.git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=next
3. https://web.git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git/log/?h=edac-cxl

Userspace code for CXL memory repair features [4] and
sample boot-script for CXL memory repair [5].

[4]: https://lore.kernel.org/lkml/20250207143028.1865-1-shiju.jose@huawei.com/
[5]: https://lore.kernel.org/lkml/20250207143028.1865-5-shiju.jose@huawei.com/

Shiju Jose (8):
  cxl: Add helper function to retrieve a feature entry
  cxl/memfeature: Add CXL memory device patrol scrub control feature
  cxl/memfeature: Add CXL memory device ECS control feature
  cxl/mbox: Add support for PERFORM_MAINTENANCE mailbox command
  cxl/region: Add helper function to determine memory is online
  cxl: Support for finding memory operation attributes from the current
    boot
  cxl/memfeature: Add CXL memory device soft PPR control feature
  cxl/memfeature: Add CXL memory device memory sparing control feature

 Documentation/edac/memory_repair.rst |  103 ++
 Documentation/edac/scrub.rst         |   64 +
 drivers/cxl/Kconfig                  |   20 +
 drivers/cxl/core/Makefile            |    1 +
 drivers/cxl/core/core.h              |   11 +
 drivers/cxl/core/features.c          |   20 +
 drivers/cxl/core/mbox.c              |   45 +-
 drivers/cxl/core/memdev.c            |    9 +
 drivers/cxl/core/memfeatures.c       | 1728 ++++++++++++++++++++++++++
 drivers/cxl/core/ras.c               |  151 +++
 drivers/cxl/core/region.c            |   15 +
 drivers/cxl/cxlmem.h                 |   82 ++
 drivers/cxl/mem.c                    |    4 +
 drivers/cxl/pci.c                    |    3 +
 drivers/edac/mem_repair.c            |    9 +
 include/linux/edac.h                 |    7 +
 16 files changed, 2270 insertions(+), 2 deletions(-)
 create mode 100644 drivers/cxl/core/memfeatures.c
 create mode 100644 drivers/cxl/core/ras.c

-- 
2.43.0


