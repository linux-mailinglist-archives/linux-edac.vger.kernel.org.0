Return-Path: <linux-edac+bounces-1362-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B999158C4
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2024 23:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65056B24957
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2024 21:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1211A2554;
	Mon, 24 Jun 2024 21:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HQD85O3B"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F451A08DB;
	Mon, 24 Jun 2024 21:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719264027; cv=fail; b=Q8ECJLVFWiYIJ1k/F01xKzg6HbHyjltAgyAYhj9ZN+QQ7FKDgtIgJg3gD4Hi2bW2RjVXV0KiBBEHW510khD+9nQvp6PhJHAyUZPOsUcwfM3YIdqrg9UlR3uVTKtwO4FpAOzKcsqu9EQdv0RNHLWLlTqF+Fy2R2JNo6FlfuyBAHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719264027; c=relaxed/simple;
	bh=y0DcNs3641478hzFBbyC9w3EQ8VS1kbaKb1QjtyWEI4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cz7SgIlLtjhMUiXsiKYqgqCASy4ocH8834N2XQY8zU33cZJ/BJNJKDbWsxGRsQ4GChN8wTkPbtn8a39tPOQTlsITIcRGcc6ny+XggoZrlvTt9J5B+lL1D3zwys7IdAmtwajd0wqeqX4ZsdqEFPVM4vGHNMaRWnULV+GCrUKdOLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HQD85O3B; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzskQBWFYyrY0TEPSTSuE+dw2hOawj/A4PNLYqKHRLHYfT9NseIPeCwmHlyDRdB5Unk6TsEKxmUOyRZDtwLo01s1F/o0PQrUJkCQxj435j+F4HxmbYSBoanBxGFxzL8Wlsw+xQLfALcIQPxBVUNx6D141v0a3XpnNkCbGlozSA9ENk3r3+gEAyp2Z9p1659jBVYW1xTdCGcLf03C4eWfXiMnaVFomZsP8UcbUs5csvdFgqzw+tC14Uq3vjII4q0W9cSAU8mDGdpSU+PqmTOS1K20yUYHjAf29SVTWb7kVZysrUOGEXFkwBT0R707te2UiKXER0Uv7SquwfBzs0Td7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Da9izkowNYjJIUFKfw+3kLUmzQgLHTgXIEp8hPaAKhs=;
 b=QElfWKoCU5CoM9VCtvta0kLqUJ5e3SUFLUNiapoP3fr0+zMd4oMOl7P1RvMXumY2WcRM7DH8Ht/CFBmIGy7Nt8IENgUlVqtsRBoab+TQhCxD+fC74sY61QG9VRjlRImILMMSsYe+P7xjey8bbFEPnCU6CbvAy8ZAzEOKS+zqP3rWzhZAv4fsKQd9Yp1Ri2oSknRBmmUotmEoxuXtIGPIcxKRKVsv1STTGzmXA/gZTfjokRY8d/fQp+IiCdLgYFdjw7fTOKJlXGxWKkezzmPlvvuDyZBMTc4xnyXBkUt7H1z2QoeL99UflKKi34j6pNn0WvDLdOVFeR5h2NlpaQnIGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Da9izkowNYjJIUFKfw+3kLUmzQgLHTgXIEp8hPaAKhs=;
 b=HQD85O3BeOhMMmX6bKszoLdts1UY9X4+ryLDXLx8jLVD2zerXT6XJN3vG9enK8VqdV9wz9L07o4NiqAzEArJvYVYZo7nhZMagiNSgP3a+eviGEkKinjQ0ViFSZnA8Suy7k4pNfvku8f+YQWv12E9Y1w5qJLta9saXnnpPwX9XZk=
Received: from SA0PR11CA0086.namprd11.prod.outlook.com (2603:10b6:806:d2::31)
 by IA0PR12MB8205.namprd12.prod.outlook.com (2603:10b6:208:400::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 21:20:22 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::36) by SA0PR11CA0086.outlook.office365.com
 (2603:10b6:806:d2::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 21:20:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 21:20:22 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 16:20:20 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v2 5/5] x86/mce: Use mce_prep_record() helpers for apei_smca_report_x86_error()
Date: Mon, 24 Jun 2024 16:20:08 -0500
Message-ID: <20240624212008.663832-6-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624212008.663832-1-yazen.ghannam@amd.com>
References: <20240624212008.663832-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|IA0PR12MB8205:EE_
X-MS-Office365-Filtering-Correlation-Id: 640a9d16-2d00-4ce3-2f9d-08dc94937523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|36860700010|1800799021|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GHeagQc1sqbHZ4j1vm+gpDl4If5AXUv1RN0AYukrXE51FIqOzZ+8+BATKwNG?=
 =?us-ascii?Q?/PApw7qawoQnpNZeDSlKCgujGnKpt7QAe16httex3yBaDxZMlCTAucHXrKnu?=
 =?us-ascii?Q?dGCfNYmdM0jHaJtjNPtIAmOtcOyURFGZgHQwrPV+chwOBjTuWnRsBwdsh1L6?=
 =?us-ascii?Q?xvoLtZ00wAG7TAj/p7l0A4MxypDygTl8ZgdQudYrFTHB4gtYuV3J6Kqh6Ebp?=
 =?us-ascii?Q?bhTJ4D6sHtQr7XI4SRaq7aIpDo1l8sxB+BvBu2lP59M0fmD5AKWphMdEDYl2?=
 =?us-ascii?Q?h+p7vvZSW/K/LoECNzqOoVuP1V8Qk5QGYKtNQbG6UUjZB8Wq9ZiTjgekvp8h?=
 =?us-ascii?Q?fRheooFvPpoTCCLKQD8zvCNiQOg6vICgHhF6rws6NtG8pd3FX+Ev3Xm6p4r6?=
 =?us-ascii?Q?HwYv5y2qergfYQpxVSTrN7nAVet3tPztTQ5kA8puQbP6eObQY7dpK6dcyl3G?=
 =?us-ascii?Q?7nZfuw1KidmhNwl2SAfFWHzaripMDZ+W2yYo9UjmLG9m40oZuCkJZwnJQJIh?=
 =?us-ascii?Q?3C/OxKKNWxelVHtDqecaKebm+9Q1w/SouohdqT+35Li5xuOx1FQ1v42nyxDI?=
 =?us-ascii?Q?Zi6FrfBZtUbgu0C4BvoTw6uvt3M8Orvgd0v4KJE99ykSwjoqULrQnxgF0Kxx?=
 =?us-ascii?Q?cOFyFvdyAmc8xiXL7Ew0ytueYQynMG/p4UYdQWgkpIZMeZ4wtEjzRv3TxV0v?=
 =?us-ascii?Q?bTeOmw91JeOdALZqEYMNDqe1l7Nh/Y5KFvpe4ZilEvezrYugXMFqF1j8D9PX?=
 =?us-ascii?Q?eijMlcIKhtqo4YhCxGd+A8EYI6ZLa18F1bS8cyuVmzA6jZOZYLofqg1cLH/I?=
 =?us-ascii?Q?VfoaKfrpnApS0cXkpBHvHEPQfF/fpGR3VNHbkbmsyxOLYOa8SW0d8TWhHfQO?=
 =?us-ascii?Q?v858DJjXuM/HLkQHgZFKAyGu0BKDMuASkxKsWiB4g4wYtnFoy3jHPikgU70N?=
 =?us-ascii?Q?IfzO3JZdYZ1k1ofQtc5rcICKjr8VrrNdELbGQymP3IHk0F3YZlbVO4YNkLHN?=
 =?us-ascii?Q?zDJy53NaBOTVGWSXQ1YhARLGkP0xHbRlrgBKr9ZGyKiAsyKFP0D11YBythDH?=
 =?us-ascii?Q?2N7Gch95nMkZqEjHbZnU8es9Tvhm9Ih8SEkpofqEFamvf5uinmXmCfS8CgLV?=
 =?us-ascii?Q?ERZt+y5wcTpDMGklo1qup1Z8zXTUV4THECNZv0aWWOgh5/TaZ5VOxMknwB0s?=
 =?us-ascii?Q?93BkyR7csj96B/KwcrG0MAJerePq9gZMznj5Sfk89P+dk/A4ZyB0IRpdQ633?=
 =?us-ascii?Q?g3bAzLcT99VvC2NKeic4nlhu0dSwJrJbhuEe/ULoCd3t1m1gGiVelRuTOGYa?=
 =?us-ascii?Q?5LFO+xbtkzT1CaQ9h8B8QN0l7/gHShCUKPl8QRwTw5aTovVwt5Ry1xrfyo2I?=
 =?us-ascii?Q?uHtAp1I=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(36860700010)(1800799021)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 21:20:22.5330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 640a9d16-2d00-4ce3-2f9d-08dc94937523
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8205

Current AMD systems can report MCA errors using the ACPI Boot Error
Record Table (BERT). The BERT entries for MCA errors will be an x86
Common Platform Error Record (CPER) with an MSR register context that
matches the MCAX/SMCA register space.

However, the BERT will not necessarily be processed on the CPU that
reported the MCA errors. Therefore, the correct CPU number needs to be
determined and the information saved in struct mce.

Use the newly defined mce_prep_record_*() helpers to get the correct
data.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20240521125434.1555845-4-yazen.ghannam@amd.com

v1->v2:
* Rebased on new changes from patches 1 and 2.

 arch/x86/kernel/cpu/mce/apei.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 8e8ad63da5b6..7e60db2addec 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -101,12 +101,9 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 	if (ctx_info->reg_arr_size < 48)
 		return -EINVAL;
 
-	mce_prep_record(&m);
-
-	m.extcpu   = cpu;
-	m.socketid = cpu_data(cpu).topo.pkg_id;
+	mce_prep_record_common(&m);
+	mce_prep_record_per_cpu(cpu, &m);
 
-	m.apicid = lapic_id;
 	m.bank = (ctx_info->msr_addr >> 4) & 0xFF;
 	m.status = *i_mce;
 	m.addr = *(i_mce + 1);
-- 
2.34.1


