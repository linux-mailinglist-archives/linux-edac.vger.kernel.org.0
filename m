Return-Path: <linux-edac+bounces-3235-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBA3A49940
	for <lists+linux-edac@lfdr.de>; Fri, 28 Feb 2025 13:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4240B7AA33C
	for <lists+linux-edac@lfdr.de>; Fri, 28 Feb 2025 12:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F4126B0A1;
	Fri, 28 Feb 2025 12:28:26 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670A226AABD;
	Fri, 28 Feb 2025 12:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740745706; cv=none; b=kgUb0rf43RZcc4apoQLpm8yxCH6XabrZFB0KM3BZfgsz7EWBVQoOvOgZ4npZiRA5wG2SyJfGFJn0pJqNyn8sVU+JGtabNHfVpKrpA+YKJ1g+EoN45H4tlKUnvHA34LQpNDJrV9N4+uwv7fQQtoNaPNLPgV4K+Kcay6CdY4+7Ghg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740745706; c=relaxed/simple;
	bh=0qFL0sytWBWcrEpmLaGjEzzLskUNbPALwhiXDblVL/o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W+KtbHVEW5U16Vcs+Di8h3uxy5Fn0CRpLN/9x8Hm3fD695WaJFmkmKZreVRKthYZElVh2sdepns3GNFDclKb44edgBNMT9BE01CyolPNSxm0axA44DsHOaGgCjJtHCLfJEJ57yjUi1gTXD7ufx9hIOJwCOKwY7FfXljQkdtBGXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z46qV3dmmz67n0t;
	Fri, 28 Feb 2025 20:25:26 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 19B271400D4;
	Fri, 28 Feb 2025 20:28:16 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.152.77) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Feb 2025 13:28:13 +0100
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<rafael@kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<lenb@kernel.org>, <mchehab@kernel.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <j.williams@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
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
Subject: [PATCH linux-next 0/2] ACPI: Add support for ACPI RAS2 feature table
Date: Fri, 28 Feb 2025 12:27:48 +0000
Message-ID: <20250228122752.2062-1-shiju.jose@huawei.com>
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

Add support for ACPI RAS2 feature table (RAS2) defined in the ACPI 6.5
specification, section 5.2.21 and RAS2 HW based memory scrubbing feature.

ACPI RAS2 patches were part of the EDAC series [1].

1. https://lore.kernel.org/linux-cxl/20250212143654.1893-1-shiju.jose@huawei.com/ 

Shiju Jose (2):
  ACPI:RAS2: Add ACPI RAS2 driver
  ras: mem: Add memory ACPI RAS2 driver

 Documentation/edac/scrub.rst |  73 ++++++
 drivers/acpi/Kconfig         |  11 +
 drivers/acpi/Makefile        |   1 +
 drivers/acpi/ras2.c          | 417 +++++++++++++++++++++++++++++++++++
 drivers/ras/Kconfig          |  11 +
 drivers/ras/Makefile         |   1 +
 drivers/ras/acpi_ras2.c      | 383 ++++++++++++++++++++++++++++++++
 include/acpi/ras2_acpi.h     |  47 ++++
 8 files changed, 944 insertions(+)
 create mode 100755 drivers/acpi/ras2.c
 create mode 100644 drivers/ras/acpi_ras2.c
 create mode 100644 include/acpi/ras2_acpi.h

-- 
2.43.0


