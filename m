Return-Path: <linux-edac+bounces-2197-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 228479ABFC0
	for <lists+linux-edac@lfdr.de>; Wed, 23 Oct 2024 09:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4839D1C209A4
	for <lists+linux-edac@lfdr.de>; Wed, 23 Oct 2024 07:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DA51531F0;
	Wed, 23 Oct 2024 07:06:26 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799CB15252D
	for <linux-edac@vger.kernel.org>; Wed, 23 Oct 2024 07:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729667186; cv=none; b=LMB+jYImIQ7t9fIoysSu0SuWeI5sJ6fPj9+4dChagXzZybNUna6eWhPnSaZMhLLCu/A18zIghRFtmxdmQezSA8XP6g72QE9MgI09V8P0XBLxTwmVhF+/VsQdlQBXDTm8yviezsvoy3O5JQH9ECW3P6X2xEPouPVMgfKU1wcKcWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729667186; c=relaxed/simple;
	bh=zLHTDYb/FkZ5mPAnIR6sPG91cU2p/UiX6zQJvAQzDH4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ACzuagLsCoiD28RDDMLCddXsc2ZAPM/x4MQBgrevOYytCsC/ReWniUjwvI/cLmeCbC5h7m1crdVFUnTa5KeOQuCRXmmtY0LJ9CwMfpwYKMa8QWqP5XcyK/zZQZ391uiExrQmcmNrknCd1foOzJ3L2RFG5I7HWDgABPdlE4NTmOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XYKmm5swWz2FbLq;
	Wed, 23 Oct 2024 15:04:56 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id CA6A41A0188;
	Wed, 23 Oct 2024 15:06:19 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 23 Oct 2024 15:06:19 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Yazen Ghannam <Yazen.Ghannam@amd.com>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] RAS/AMD/FMPM: Fix return value check in setup_debugfs()
Date: Wed, 23 Oct 2024 15:05:08 +0800
Message-ID: <20241023070508.275-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf100006.china.huawei.com (7.185.36.228)

Fix the incorrect return value check for debugfs_create_dir() and
debugfs_create_file(), which returns ERR_PTR(-ERROR) instead of NULL
when it fails. In addition, fmpm_dfs_dir should be set to NULL after
being reclaimed.

Fixes: 7d19eea51757 ("RAS/AMD/FMPM: Add debugfs interface to print record entries")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/ras/amd/fmpm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index 90de737fbc90978..b1cffbde6d319ed 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -956,12 +956,14 @@ static void setup_debugfs(void)
 		return;
 
 	fmpm_dfs_dir = debugfs_create_dir("fmpm", dfs);
-	if (!fmpm_dfs_dir)
+	if (IS_ERR(fmpm_dfs_dir))
 		return;
 
 	fmpm_dfs_entries = debugfs_create_file("entries", 0400, fmpm_dfs_dir, NULL, &fmpm_fops);
-	if (!fmpm_dfs_entries)
+	if (IS_ERR(fmpm_dfs_entries)) {
 		debugfs_remove(fmpm_dfs_dir);
+		fmpm_dfs_dir = NULL;
+	}
 }
 
 static const struct x86_cpu_id fmpm_cpuids[] = {
-- 
2.34.1


