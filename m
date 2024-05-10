Return-Path: <linux-edac+bounces-1037-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEF58C2389
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2024 13:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E80D1C2341A
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2024 11:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E260F17BB36;
	Fri, 10 May 2024 11:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dNWsPyeP"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A9417BB26;
	Fri, 10 May 2024 11:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340521; cv=none; b=Lp96+kBQb4qDIWcratEIxDZYft/4eWLPdbKdszwEPwmqyqqQmcn2a+C6C+J7pLtTBGj1hNeRW6tJ6BrLtIf+hhJMw2hW80Wvm5YdiyCLxjRlz2Ud/eDTFBvr3qnTQ/SxGOWt4+7Y3W3EsCYKj8CvAj5W0JA0FJ4rCnq3yhq5caE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340521; c=relaxed/simple;
	bh=2dyaSdCRFFl0BBVbWiZAlxE7d7+OMrdvZ8KswIJe0H0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J82v7baAEKMe8Ou+xNi7nPPG3dCckz+UzdlJxdody9IPRRVojDA1MTXgart8HFE2xien1Ub1C/iygCg1kQWOXot2i/AuJ3q5IFzEyJyFoZHkYUsYXd5DwpBf0+zBLmBCmMgMVXOym2FtD+QYvTvi/ii9GnfdD49OW9OhIMHq5MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dNWsPyeP; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715340519; x=1746876519;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=2dyaSdCRFFl0BBVbWiZAlxE7d7+OMrdvZ8KswIJe0H0=;
  b=dNWsPyePQM0EEypP+Fbsnjx6qMIEIgWhvI72yxeeBkGMiSpJMmxPSb87
   J/w2CQmwApwjFhKJQB0zdMetrcFbxCjEoGTKUCUvj0bc04ph9DOpq9ww+
   ALKBdTgacCp7iLfr9RAJwigBPa2GV6AkSKyL6oBrEVzDzYSjF6RWggxo3
   f5KX9fuF2L2TJsZWsox01phlRz62gg9aZ/IRSlwG3T5DZyQ5rocRgihCu
   hJ3Vl1DElwDla77ScXc+tIZEDNI7owN8x/quaonzfj0h8nyI6OlGemCmc
   oX1JjD+uFX6KC1RtoLcxDd3SWkq8e756mTKqYB70fYwgRb0NHbUFQXwjM
   g==;
X-CSE-ConnectionGUID: WWPQtJkhTvuNCiCacyDkQg==
X-CSE-MsgGUID: cppT4+9vSo+k2Sl5ypypBA==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="21913205"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="21913205"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 04:28:39 -0700
X-CSE-ConnectionGUID: K96jQTfZQ4iemDGfyXp+eQ==
X-CSE-MsgGUID: NjYBx7ETTs6dazXo7CTAsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="30138446"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.191])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 04:28:36 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [RFC PATCH v2 2/3] ACPI: extlog: Trace CPER PCI Express Error Section
Date: Fri, 10 May 2024 13:21:46 +0200
Message-ID: <20240510112740.667445-3-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240510112740.667445-1-fabio.m.de.francesco@linux.intel.com>
References: <20240510112740.667445-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, extlog_print() (ELOG) only reports CPER PCIe section (UEFI
v2.10, Appendix N.2.7) to the kernel log via print_extlog_rcd(). Instead,
the similar ghes_do_proc() (GHES) prints to kernel log and calls
pci_print_aer() to report via the ftrace infrastructure.

Add support to report the CPER PCIe Error section also via the ftrace
infrastructure by calling pci_print_aer() to make ELOG act consistently
with GHES.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/acpi/acpi_extlog.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 4e62d7235d33..fb7b0c73f86a 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -131,6 +131,36 @@ static int print_extlog_rcd(const char *pfx,
 	return 1;
 }
 
+static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
+			      int severity)
+{
+#ifdef CONFIG_ACPI_APEI_PCIEAER
+	struct aer_capability_regs *aer;
+	struct pci_dev *pdev;
+	unsigned int devfn;
+	unsigned int bus;
+	int aer_severity;
+	int domain;
+
+	if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
+	    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO) {
+		aer_severity = cper_severity_to_aer(severity);
+		aer = (struct aer_capability_regs *)pcie_err->aer_info;
+		domain = pcie_err->device_id.segment;
+		bus = pcie_err->device_id.bus;
+		devfn = PCI_DEVFN(pcie_err->device_id.device,
+				  pcie_err->device_id.function);
+		pdev = pci_get_domain_bus_and_slot(domain, bus, devfn);
+		if (!pdev) {
+			pr_err("no pci_dev for %04x:%02x:%02x.%x\n",
+			       domain, bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
+			return;
+		}
+		pci_print_aer(pdev, aer_severity, aer);
+	}
+#endif
+}
+
 static int extlog_print(struct notifier_block *nb, unsigned long val,
 			void *data)
 {
@@ -182,6 +212,10 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 			if (gdata->error_data_length >= sizeof(*mem))
 				trace_extlog_mem_event(mem, err_seq, fru_id, fru_text,
 						       (u8)gdata->error_severity);
+		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
+			struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
+
+			extlog_print_pcie(pcie_err, gdata->error_severity);
 		} else {
 			void *err = acpi_hest_get_payload(gdata);
 
@@ -331,3 +365,4 @@ module_exit(extlog_exit);
 MODULE_AUTHOR("Chen, Gong <gong.chen@intel.com>");
 MODULE_DESCRIPTION("Extended MCA Error Log Driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(CXL);
-- 
2.45.0


