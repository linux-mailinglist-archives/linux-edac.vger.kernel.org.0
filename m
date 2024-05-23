Return-Path: <linux-edac+bounces-1090-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 528488CD7E6
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 17:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C691F2112A
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 15:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02DE1862A;
	Thu, 23 May 2024 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wzDXg9J0"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308BE1170F;
	Thu, 23 May 2024 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479824; cv=fail; b=D5bMbgNKcEcmp/5QUVwaEErGXFs7ZbFClZn4v85SPBV7h/hBfGfCMrma5F3HDrdvyj48sxd5eMkS/pnHgqirB1YAe626BDtb/cf/k1GkfiYeaufaUjTx+XcfMl/w2evVHeJe0qp7IZ+p+Tcykrb/qNQXOH0Q60WCzg+8fAgCNL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479824; c=relaxed/simple;
	bh=Ol5cKvAfXZVsFyWPOWVZXBdxCfxWAxYnkUdq7QljSWI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SQOZnjfOdlc/zls/mq+avOB/P1zfBsvDaZU3QwaeppZMyAwYo7ivwJIN2RqbYyAzdcpmQY0nqK4asklwy8ufKerANm7CPtr87SbenPyrQBlp1Vug7Thze+hXsAZiUVu/eSAMKN2yHGE0i9A2wlU0iTbf8XNN5lxS1593LBudPwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wzDXg9J0; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZC7HXDn7AWcOeD1ps96HRRaVFErxcvDlCWn0w/2cXFZ7v3uuNj96GhREYCf1ZUCRJkhNhIxeOdo2qpOJrFU/FYdUJgrPBvqPEuYaRBx6xf4qWkoZepHqe1aCa4f1xslK7Ddc9lTmZH2j5EPyjrIE4oiPYSQSwAOw/buy6DM9Hpa0JtlOaOMsYXz78+Pe7WcqtyeU7/d3kh2PdzZF/RZxDiXQy7g9osJuDKY7RFh3ijAd2CQnK3TAzKiYoscIq4G8Qd3LhMev7fmdnGtI4jjqqYHfnPhnQdmIlLEnmGMBU6OZvLh381iJVwPcZZNDGOjJb4g/27PiDcvwYDzsxf8dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4MrfluXJZwuvO715nTyLi7jxjStQprgr/SvCKWA94Q=;
 b=JOt0rcCNGwo/qMsQ3VmITb8sAafCZ54ZeOn748E+mEKSK8VI13dSp+Fh3HJbn0a+yS0jCKMDfdIS9fi67+zuB51thMklPUpcd421oKemDJJ5BlKriTp19bqehEY2bgfxnSFfL0AThdkkhDUNzTHKkYm6ulByM3CD6M/GorXJFI5LIs99P2S2rtVZeQjlTOrJAza2dtmTVwz5gyPPJLyYdnOasY0lsCa+rAT6P+391Fk8plq3hXt2+lsI01JaB6tT45h1i2t5W0+xkqgYJxExE3M3quoTy3GQNKvWaXzNVN0/eWgsacNL1mUf8Xrl2hWKYXvJ4qjg0qT9WQA8o8bgvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4MrfluXJZwuvO715nTyLi7jxjStQprgr/SvCKWA94Q=;
 b=wzDXg9J0bsWJ69Wlj0IE+iMavjvUDuTpNaqq6GMm47uBjuQ3X1qvxWOhKVPbWMokVBXOekMqKY+/b4lw2Ng5xicpedG87/89JRRAgVIgisgdFIpLGbwAhZvBor8JDSwvafiUz/SoapY3JPkYvovpdHCMnsRcwQTO+SQnVMYfHn0=
Received: from BN0PR08CA0007.namprd08.prod.outlook.com (2603:10b6:408:142::32)
 by SN7PR12MB8769.namprd12.prod.outlook.com (2603:10b6:806:34b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 15:56:57 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:142:cafe::6d) by BN0PR08CA0007.outlook.office365.com
 (2603:10b6:408:142::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Thu, 23 May 2024 15:56:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 15:56:57 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 10:56:56 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH 2/9] x86/mce: Remove unused variable and return value in machine_check_poll()
Date: Thu, 23 May 2024 10:56:34 -0500
Message-ID: <20240523155641.2805411-3-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523155641.2805411-1-yazen.ghannam@amd.com>
References: <20240523155641.2805411-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|SN7PR12MB8769:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f85c2d2-1890-40a6-96ed-08dc7b40f983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|82310400017|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S6O4IccZTXf1Sb94INst/8QopDxlT0/KZHyVvBxGreakKTQVbokWvmrXjcr5?=
 =?us-ascii?Q?WoJHyZ7j7+M3jR8ooCWxxy0kJOkXKqnRn4cIQu/vg19fOOKra+PcBt1ibim+?=
 =?us-ascii?Q?i8C62AIxnq9mZl2DjuBAgJGLr6VR0reziUyJgxfX8MxqYDCjNUg1cSBbQto1?=
 =?us-ascii?Q?d0/KSmZsalgXLjQpc/0iekhQ6TnaqZYfQX4l9AdDybNeRouKJfqQHjmI8HsZ?=
 =?us-ascii?Q?1afrdRW4WwbpVJzvlmMbqnUfqEsBVWAbYUXnWSRL2wmNbsdLbOUjUStU3sQQ?=
 =?us-ascii?Q?dbJTF6Bly7wm3SQyGDaWU5t09rpcLt53kuH5ULv/jsCcaA6oZRfbPblU4s4b?=
 =?us-ascii?Q?66KabgLcS1oG6RUpLFeO/n2yVoAYhz9QVwO1wK6tdi4vCpPybBxqbEe9rWSO?=
 =?us-ascii?Q?qe4JJy/m3feQg49JgWWUGEO+efDzLDcLB0nLz2NEuFA1/iBzjFPQj4S5njk5?=
 =?us-ascii?Q?OACvTsfoKHiOWHuknZ5RJG45v+5uUSOJnRv2urN/C2E3yAhJyh5zFHsHVxjU?=
 =?us-ascii?Q?SdlJS82VJTT+aeFFVpDA0Ne9ibYEcNSjGn8stbl/HU1ZCsWL6dRXZShfpxHS?=
 =?us-ascii?Q?5/QtVlVhbeyhPOp19y/J60kzfI0eh4tUb8HoFFmNNdX1TdjHVbTB5YdviFe8?=
 =?us-ascii?Q?SGPUtMekE0gBr/ltSnyS1eFGZ0bpxz6JyUHIFsux3zZkh12DKk8zdQs6MWbE?=
 =?us-ascii?Q?hIHwuLqXkLaqRawcHeV0I7BT06pf7mBSEKZGJFSPbdqQdIMKOoRWWcidgPFb?=
 =?us-ascii?Q?jTehvlO6yJySWXNdf+0VlyNfMRDpAj9bI/rU2lANP4kW2QMvlvMtvFamQHJB?=
 =?us-ascii?Q?hoS/OTQ2KXeOnCMlowGXYZcJE9+7KaqqZ4Pbac5gV0XxZ2wpj4wWbi44NF5x?=
 =?us-ascii?Q?3QA0sjWD3uDM4uCBgCdmcv5M2Dlk9D4Q32LDU74hhmZx4mNTZqzxpvHhgpep?=
 =?us-ascii?Q?bAY+BWFUIHtyq7fxeowoxsNkk9q7Yp7sGKZZbE47cVhpVMhnMx64J0tApdZP?=
 =?us-ascii?Q?e2Md9G94S4XDXjhsYnsKIV8WJf9witAIDa/Sh4TwsgRgr52NG6dqgOF9AGso?=
 =?us-ascii?Q?Nis6ol4/tp/RkAwjf0OEQs28n9HbvUzoUPldAn8lUC9JGh4NNFi2RAsx1UNe?=
 =?us-ascii?Q?f1YBvOl/Lm3iqCZJSt9tuJX5zErTdnWV/+yl0s0+eASrbXZZhtyr3OzDB4Ff?=
 =?us-ascii?Q?DOLLGrD0AYmp0ferGoDLB2PKpscn/JaKSnLJebq7Gd+qobpi+NrYFZQV01bY?=
 =?us-ascii?Q?nFYpmM7eP8182+UFzXlfIylqCt/7fQU9xum6PermUM6a9luEpibBaak4X9Fh?=
 =?us-ascii?Q?4goq3iUiMuiyK3FgpbIPOZLE97nf6YOkrpL5CuZPX5Ajs8LlazB2wzOAVNG9?=
 =?us-ascii?Q?yZyIc1GN2XqV/IE5BnG3Hx5Au9GM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400017)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 15:56:57.3573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f85c2d2-1890-40a6-96ed-08dc7b40f983
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8769

The recent CMCI storm handling rework removed the last case that checks
the return value of machine_check_poll().

Therefore the "error_seen" variable is no longer used, so remove it.

Fixes: 3ed57b41a412 ("x86/mce: Remove old CMCI storm mitigation code")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h     | 3 ++-
 arch/x86/kernel/cpu/mce/core.c | 7 +------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index de3118305838..bc3813c94c79 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -259,7 +259,8 @@ enum mcp_flags {
 	MCP_DONTLOG	= BIT(2),	/* only clear, don't log */
 	MCP_QUEUE_LOG	= BIT(3),	/* only queue to genpool */
 };
-bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b);
+
+void machine_check_poll(enum mcp_flags flags, mce_banks_t *b);
 
 int mce_notify_irq(void);
 
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index b5cc557cfc37..287108de210e 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -677,10 +677,9 @@ DEFINE_PER_CPU(unsigned, mce_poll_count);
  * is already totally * confused. In this case it's likely it will
  * not fully execute the machine check handler either.
  */
-bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
+void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 {
 	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
-	bool error_seen = false;
 	struct mce m;
 	int i;
 
@@ -754,8 +753,6 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		continue;
 
 log_it:
-		error_seen = true;
-
 		if (flags & MCP_DONTLOG)
 			goto clear_it;
 
@@ -787,8 +784,6 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 	 */
 
 	sync_core();
-
-	return error_seen;
 }
 EXPORT_SYMBOL_GPL(machine_check_poll);
 
-- 
2.34.1


