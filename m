Return-Path: <linux-edac+bounces-1038-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7EC8C238C
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2024 13:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EEF31F2599A
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2024 11:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B5217EBA7;
	Fri, 10 May 2024 11:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dvnzRQwN"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AE917EB8C;
	Fri, 10 May 2024 11:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340524; cv=none; b=Iab7hf7f6mLAZz0rNUP0oIfTMrxAXG0cSa6ZTcorSZT68STLnwUJzq6kAJP8ymQA84+alsndiOZmwVAU91NM8Q6YIlsJKP7qbIY5lpYdnVFyFZ61+/7SlgqWBSQqhMup4pOT2F+qKjwGGyzyX4mSmQtZPspj3OjK1bAP9g3FUx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340524; c=relaxed/simple;
	bh=YjRIFyy5x+XNHBrFPdcWuNaJba67+I+b0UephR4q89w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MsgZdvMU/KWidEqOPXkS7NE4dtVaEvpODk2tOfCBHGr2u7bAcvVIoTsV2iIt0wcBU0/5566qZccO+vlYTRytBIt8hcCJvOt8V0tD441r3yBBjkp7dHWdWMBHeO+i61nOjWlqkq/PHQmxYj+l7j7fqf27j+qt1RDdMHr9lXkbUOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dvnzRQwN; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715340523; x=1746876523;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=YjRIFyy5x+XNHBrFPdcWuNaJba67+I+b0UephR4q89w=;
  b=dvnzRQwN5T7Et5rL3sFJOu6tWGiK72TURfAT7L20H1H9fXvN6cHoqW7j
   5GLaWURSZ/KSkHBtve71o4hOX98ZK93W8wzcvnzjH7EM0Vz1nciwZu/oH
   f1KHWyZfVGyWiB90Qg76C2WkHAVPp7RhBUZfNWjka9JBbbyomv0kNzCUZ
   WHtSv0kk0ZfNCX3wOvh75KAoKBrN+szwikpv6QYDrazgjd/Z9Zifz9r1p
   2lAAN6bybGjp4s/faJ5TaThiekwC+WyreSyGb4+VEB71O91Onco9iwDkN
   QrMRqpmM1nbXfqW+R41UuTrXJEUjkTeG1DzCKH/ACZX8dJpe0kxVRPBGF
   w==;
X-CSE-ConnectionGUID: ObYN1OZHQiK0YI0zHHvzng==
X-CSE-MsgGUID: qAURdJuLR06/ElWUIdeOfw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="21913210"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="21913210"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 04:28:42 -0700
X-CSE-ConnectionGUID: 3xFHPiSyR0Oz6j6r6yQdww==
X-CSE-MsgGUID: kwgn+PjsRPGlvdoAX2nhJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="30138449"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.191])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 04:28:39 -0700
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
Subject: [RFC PATCH v2 3/3] ACPI: extlog: Make print_extlog_rcd() log unconditionally
Date: Fri, 10 May 2024 13:21:47 +0200
Message-ID: <20240510112740.667445-4-fabio.m.de.francesco@linux.intel.com>
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

Make extlog_print_rcd() log unconditionally to report errors even if
userspace is not consuming trace events. Remove ras_userspace_consumers()
because it is not anymore used.

This change makes extlog_print() (ELOG) log consistently with ghes_proc()
(GHES).

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/acpi/acpi_extlog.c | 6 +-----
 drivers/ras/debugfs.c      | 6 ------
 include/linux/ras.h        | 2 --
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index fb7b0c73f86a..41ee66306234 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -189,10 +189,7 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 
 	tmp = (struct acpi_hest_generic_status *)elog_buf;
 
-	if (!ras_userspace_consumers()) {
-		print_extlog_rcd(NULL, tmp, cpu);
-		goto out;
-	}
+	print_extlog_rcd(NULL, tmp, cpu);
 
 	/* log event via trace */
 	err_seq++;
@@ -225,7 +222,6 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 		}
 	}
 
-out:
 	mce->kflags |= MCE_HANDLED_EXTLOG;
 	return NOTIFY_OK;
 }
diff --git a/drivers/ras/debugfs.c b/drivers/ras/debugfs.c
index 42afd3de68b2..6633844acdd6 100644
--- a/drivers/ras/debugfs.c
+++ b/drivers/ras/debugfs.c
@@ -13,12 +13,6 @@ struct dentry *ras_get_debugfs_root(void)
 }
 EXPORT_SYMBOL_GPL(ras_get_debugfs_root);
 
-int ras_userspace_consumers(void)
-{
-	return atomic_read(&trace_count);
-}
-EXPORT_SYMBOL_GPL(ras_userspace_consumers);
-
 static int trace_show(struct seq_file *m, void *v)
 {
 	return 0;
diff --git a/include/linux/ras.h b/include/linux/ras.h
index a64182bc72ad..98840f16b697 100644
--- a/include/linux/ras.h
+++ b/include/linux/ras.h
@@ -7,11 +7,9 @@
 #include <linux/cper.h>
 
 #ifdef CONFIG_DEBUG_FS
-int ras_userspace_consumers(void);
 void ras_debugfs_init(void);
 int ras_add_daemon_trace(void);
 #else
-static inline int ras_userspace_consumers(void) { return 0; }
 static inline void ras_debugfs_init(void) { }
 static inline int ras_add_daemon_trace(void) { return 0; }
 #endif
-- 
2.45.0


