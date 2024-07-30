Return-Path: <linux-edac+bounces-1585-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEAD941554
	for <lists+linux-edac@lfdr.de>; Tue, 30 Jul 2024 17:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05DB828332C
	for <lists+linux-edac@lfdr.de>; Tue, 30 Jul 2024 15:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74D21A2C26;
	Tue, 30 Jul 2024 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nCYNPeai"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432BF29A2;
	Tue, 30 Jul 2024 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722352764; cv=fail; b=V/nQ8uOUFR3/TSwxtg9QTCkZd/WxPdJ7Ma9UiKfl+VVLE6j0yBlRAXFZrMAEu2PuL0TlQJ6KrK/jCxTocFEvtm1YCy4d+9BCPUcNP7fucLPaTxs5/AZ8s++LcZprNItrulql0rpZRSjXZgvwVq1bffXX0m2Ys3DxQ4U/MzbG1Ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722352764; c=relaxed/simple;
	bh=kBYEECle8dvM+nHiTRzdd6vrU1ZJOMeUYl90SJexNDw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fWSU69inlr1DtlTjppdHBE0aPhiNDZoaSQihNbqWkmfmfrrOIEefM36KSd96SE1FEbH5vLoI4/Pst4sVj0ufmrDO2W8H+KiVnd1f4n6gp3TPBVUcbhiVt1iKzH4rMu1PWrIzl6nXiEOVwKiIDdrpx6Gsmamu9vb/2G9VgJfh54k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nCYNPeai; arc=fail smtp.client-ip=40.107.220.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F17827Es+AEe5osPDFTNjDQjRGb5ONzqQkEqLuWFeD3zAFPbi7M/QeLT9V6jzC0faPf2+80mjsW5qVpJSd5wWSv2Hqw9SVlKxnMWHIsEkRD39zZZ3MFz2dj9Li45I9NocDQlcgIBJTf8umgNUbqbdglORDVNOLPUD3931YCW7ignjriYSXUgn+43/JmVTQf+cica9CsW/oT7X3Gqmzg59H26luqDscxpsiriECnyyQYlCllXWgcIvXw6f3VuxT/7b2j2xFiBo80+deC1zxwaPRjfZPTtt46q6iG33BlPxJhMg9PhCXmonV3gAney3ck9szyfDwaT5OkXKH45cJvTqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwdFtOO+LQJ3njBiu07QWiS6zBg66JKrcDzCMiKNUJ4=;
 b=PAXG42qUK+baAlYQiQkQHEw9hbOf6xgeZ8HEceUnllDYxH/zdGQU635j6NxYsiA0SzOPIwi+mvp21pqJE7VhzPQs7mRwqbXlCHJ/VS35xZw//ELXFGjKSxPoKtmk4in/Ryhu9mpj+d//IHC5uOzyvxTltF7wNzkUF83VjXsGohpYnnaEpb6I0g4b9aiyB8Tkj0ydZH5aGFMTFBzI5OromztKeVNkm4xFlzovkLcNdnZM5z8ItbVZ68ON/CGh8ShXk9fo2/e6p7z7Rp8j15c/WNL1hZRKv18+BVYgNCiiTdxdIm1ciPvNELktxNHc2RPEorsTEH2YCcpkxlPNsbcDQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwdFtOO+LQJ3njBiu07QWiS6zBg66JKrcDzCMiKNUJ4=;
 b=nCYNPeaiE00Mdp3RvRCXd+dwv3BFNNVw35SmKTYVpIGTjTkW/B34t3/s1WL0eFuhVInUHXVVM6CTd4re0ZGbZ7mkM++dGf1wToRzzyestcRNBFcZVodFapC2fP1gvg+aRa+CiNERyNoGyFQEev3LRtX+GwiLmuXoHeu+Co7DYUM=
Received: from BYAPR05CA0071.namprd05.prod.outlook.com (2603:10b6:a03:74::48)
 by PH8PR12MB7230.namprd12.prod.outlook.com (2603:10b6:510:226::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 15:19:20 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::b3) by BYAPR05CA0071.outlook.office365.com
 (2603:10b6:a03:74::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19 via Frontend
 Transport; Tue, 30 Jul 2024 15:19:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 15:19:20 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 10:19:16 -0500
From: John Allen <john.allen@amd.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <bp@alien8.de>,
	<yazen.ghannam@amd.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, John Allen <john.allen@amd.com>, "Rafael J .
 Wysocki" <rafael.j.wysocki@intel.com>, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v3 1/2] ACPI: PRM: Add PRM handler direct call support
Date: Tue, 30 Jul 2024 15:17:30 +0000
Message-ID: <20240730151731.15363-2-john.allen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730151731.15363-1-john.allen@amd.com>
References: <20240730151731.15363-1-john.allen@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|PH8PR12MB7230:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ce034d-e3fe-41ec-74e0-08dcb0aafc74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ny3Aqe1f8md5B2g1JjuRdn5yjo2XjSzosiOJ5xiR2guFgvhWs799M3XAsX1n?=
 =?us-ascii?Q?Q8vskfJc78AHJjgeOWQE4tR4/f/6/BF8CKiQClX4h8QUwqt1QF6fZJhrEUU5?=
 =?us-ascii?Q?deHKEq8FyIQjDOsgYMeH1SEnRS7se/7aY/2XCUVVwVV94+2xYhxl65akmsB5?=
 =?us-ascii?Q?rDMaO6fLbFOko1zQDzlMzUImzKhuiYR4hgnfL2EdxGrhxLURQ3woC7S7wkgS?=
 =?us-ascii?Q?ssMAuiZizIsFICgPyjQx76k8QqXV1V97KflZItUMcUx4Ic4PimRMouAx4DGv?=
 =?us-ascii?Q?bsCqFdhuZplDrSr0Maw1pmW4widHRCKDCRIIXpn1Y5WYbfOeZCoSndoxF2Uc?=
 =?us-ascii?Q?61lzpN2RgT1jA0pXTWsfCgl/PzujMGoFLLIjuNm1c6jzU/+h6n9TarxDgy8Y?=
 =?us-ascii?Q?gnRBfeB5WtVzphHkcHk5h9vkrWLzLRIozXP53VO84eC/zkkMMj4rXJGxjZWS?=
 =?us-ascii?Q?BvALKkbSw1I7XGaV1hdafr7ZMbURco4DYLMpuoBRcIhcPBFVtIGkqX4HxAvN?=
 =?us-ascii?Q?r0W6B24K20DZbqIsyoOSujonLfCCc5Q8vMcdxZwvXx56T9IDCX4p+ZqFt8rO?=
 =?us-ascii?Q?FYk5rANRJquE448qBJiMmbCsPCJ72JQzGXdub56q4XJ8+jjhH5VhgvSMbzKG?=
 =?us-ascii?Q?kxW5doYJygMn7pRajsSOSmLTdKCBhGlTuIq/LETyI6HOK6YZMLMKab08cbm8?=
 =?us-ascii?Q?L14VnDgs3bqvpGfnQU9j4zVppzfoi2nl0j+nCLkdPsCU6wscehxZsjYThJCi?=
 =?us-ascii?Q?u9BVm6UxND7zCCaFQ8nnU+600CXFRv6X2JhGafbWwuknP+Vq3Xvs+nL7UUbW?=
 =?us-ascii?Q?X2DQEGuDfUSfNo7bXjL4EpX+wT8PyCitW40wHmGhbR/EeXK8IdA1GWYZ8XC5?=
 =?us-ascii?Q?fuxiOaJKHT+kTGC2ojlrRTEHoQHMd+5CR1xOu25QYUEFu3MeQmH2BXh1gr2m?=
 =?us-ascii?Q?Y2u1iSipH/nFiv9f4BhvGtoEe0pIwMQ7hZ7wgTLtpBiJy2hj5K+KA84uGQce?=
 =?us-ascii?Q?bspnQtRnoj7V2IjZWE7SLY3XSrna5NBOZqPl5sgy6gOqsN06+w4mukYxGjrV?=
 =?us-ascii?Q?q4LT+sghU7TBNlehfb0yFelBolLpi2tsxcqJiy1whDOZ44vSorpTHFhmJ2m/?=
 =?us-ascii?Q?5L6wKdvt/HOhM9YzX4LEhzm37NqT3zjBJ2YYKjzoaX5muANnVg6gH5E6sanH?=
 =?us-ascii?Q?OpczT+qiKitvkkptsgb0v9h2fcu8QRt+Ct/iELjWiY2bZZhS3AOkFmBxowZY?=
 =?us-ascii?Q?gVOiP8aDQJHkrp7xJilfDFIi4a89IIy3ZZHacEbHjv7XQBLE6JSqz4uQn4Bd?=
 =?us-ascii?Q?+fBcw1afQXQMZfTqjnVeA56Jx1Pb8bDTU4z55kQh11PYJz6v2uz4u+bOdnZa?=
 =?us-ascii?Q?jK70m4EJYfxYq1ioUREUx+Yuj6O3geNK+lSsYNlhzYMgo8MnfKio1nHWm/ZQ?=
 =?us-ascii?Q?31M9m3GhHxn+LQWnITvd5Fc6a+jQfkp3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 15:19:20.4780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ce034d-e3fe-41ec-74e0-08dcb0aafc74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7230

Platform Runtime Mechanism (PRM) handlers can be invoked from either the
AML interpreter or directly by an OS driver. Implement the direct call
method.

Export the symbol as this will be used by modules such as the AMD
Address Translation Library and likely others in the future.

Signed-off-by: John Allen <john.allen@amd.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
---
v2:
  - Align statements setting fields in context buffer on '='
---
 drivers/acpi/prmt.c  | 24 ++++++++++++++++++++++++
 include/linux/prmt.h |  5 +++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index c78453c74ef5..1cfaa5957ac4 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -214,6 +214,30 @@ static struct prm_handler_info *find_prm_handler(const guid_t *guid)
 #define UPDATE_LOCK_ALREADY_HELD 	4
 #define UPDATE_UNLOCK_WITHOUT_LOCK 	5
 
+int acpi_call_prm_handler(guid_t handler_guid, void *param_buffer)
+{
+	struct prm_handler_info *handler = find_prm_handler(&handler_guid);
+	struct prm_module_info *module = find_prm_module(&handler_guid);
+	struct prm_context_buffer context;
+	efi_status_t status;
+
+	if (!module || !handler)
+		return -ENODEV;
+
+	memset(&context, 0, sizeof(context));
+	ACPI_COPY_NAMESEG(context.signature, "PRMC");
+	context.identifier         = handler->guid;
+	context.static_data_buffer = handler->static_data_buffer_addr;
+	context.mmio_ranges        = module->mmio_info;
+
+	status = efi_call_acpi_prm_handler(handler->handler_addr,
+					   (u64)param_buffer,
+					   &context);
+
+	return efi_status_to_err(status);
+}
+EXPORT_SYMBOL_GPL(acpi_call_prm_handler);
+
 /*
  * This is the PlatformRtMechanism opregion space handler.
  * @function: indicates the read/write. In fact as the PlatformRtMechanism
diff --git a/include/linux/prmt.h b/include/linux/prmt.h
index 24da8364b919..9c094294403f 100644
--- a/include/linux/prmt.h
+++ b/include/linux/prmt.h
@@ -2,6 +2,11 @@
 
 #ifdef CONFIG_ACPI_PRMT
 void init_prmt(void);
+int acpi_call_prm_handler(guid_t handler_guid, void *param_buffer);
 #else
 static inline void init_prmt(void) { }
+static inline int acpi_call_prm_handler(guid_t handler_guid, void *param_buffer)
+{
+	return -EOPNOTSUPP;
+}
 #endif
-- 
2.34.1


