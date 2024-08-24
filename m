Return-Path: <linux-edac+bounces-1732-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD1D95DDC4
	for <lists+linux-edac@lfdr.de>; Sat, 24 Aug 2024 14:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2236F1F2238D
	for <lists+linux-edac@lfdr.de>; Sat, 24 Aug 2024 12:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFCF1714B4;
	Sat, 24 Aug 2024 12:09:21 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115D21714A4
	for <linux-edac@vger.kernel.org>; Sat, 24 Aug 2024 12:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724501361; cv=none; b=I7618q4p9/xQd4KdHxG3sGYyL1SCIW4lFqv5y+Q69Rnc5pSZNvRY812B/jsRwkntLFDN6Pp61E/8wuoOlxn4MDN9bA33M23aNpqNbK0k2GGMSQsh2bqAnMv00qJEmaCDnqGv90IFa0HNJv2Ff/bbW0kDaKO0ufvjK2I86jxHDC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724501361; c=relaxed/simple;
	bh=OmUyNQy11+Cum09GGtO+EZx+hvMhgUcIEmwmmZIw6J4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GwfGqewGQ5+SurkRvJ4YyHiWTYnCHwhsmqfYkzuFBW8Kz4CeB+2mANcHYYbieclqPMRN6TzPVDUNzkZ2ll/fwZL4hx6BGXNyVhJmZAV671TaQT56jN0GLz88vALbJoDVuJaMpVyZybLqUFegiuiNTVpXxTRrfFkig6jktwuSrpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WrbHs01YDz1HFnf;
	Sat, 24 Aug 2024 20:06:00 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id 669791A0188;
	Sat, 24 Aug 2024 20:09:16 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sat, 24 Aug 2024 20:09:15 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <james.morse@arm.com>,
	<mchehab@kernel.org>, <rric@kernel.org>
CC: <linux-edac@vger.kernel.org>
Subject: [PATCH -next] drivers/edac: Remove obsoleted declarations for edac_sysfs_pci_setup()/_teardown()
Date: Sat, 24 Aug 2024 20:09:15 +0800
Message-ID: <20240824120915.2519517-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200011.china.huawei.com (7.221.188.251)

The edac_sysfs_pci_setup()/_teardown() have been removed
since commit 91b99041c1d5 ("drivers/edac: updated PCI monitoring"),
and now they are useless, so remove them.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 drivers/edac/edac_module.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/edac/edac_module.h b/drivers/edac/edac_module.h
index 47593afdc234..71c9bf54ed4b 100644
--- a/drivers/edac/edac_module.h
+++ b/drivers/edac/edac_module.h
@@ -102,8 +102,6 @@ static inline void edac_debugfs_create_x32(const char *name, umode_t mode,
 #ifdef	CONFIG_PCI
 extern void edac_pci_do_parity_check(void);
 extern void edac_pci_clear_parity_errors(void);
-extern int edac_sysfs_pci_setup(void);
-extern void edac_sysfs_pci_teardown(void);
 extern int edac_pci_get_check_errors(void);
 extern int edac_pci_get_poll_msec(void);
 extern void edac_pci_remove_sysfs(struct edac_pci_ctl_info *pci);
@@ -114,8 +112,6 @@ extern void edac_pci_handle_npe(struct edac_pci_ctl_info *pci,
 /* pre-process these away */
 #define edac_pci_do_parity_check()
 #define edac_pci_clear_parity_errors()
-#define edac_sysfs_pci_setup()  (0)
-#define edac_sysfs_pci_teardown()
 #define edac_pci_get_check_errors()
 #define edac_pci_get_poll_msec()
 #define edac_pci_handle_pe()
-- 
2.25.1


