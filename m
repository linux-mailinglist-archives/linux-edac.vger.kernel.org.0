Return-Path: <linux-edac+bounces-1084-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9148CAEB6
	for <lists+linux-edac@lfdr.de>; Tue, 21 May 2024 14:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B6801F23019
	for <lists+linux-edac@lfdr.de>; Tue, 21 May 2024 12:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7A878C71;
	Tue, 21 May 2024 12:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ijPibRkh"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D657711D;
	Tue, 21 May 2024 12:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716296094; cv=fail; b=jv2AglKDFd2S1QSONUEQcl8FcpNmffB1oYYWwLhDWM7r0tjEaowTh1Arr5/ar7hOqxgXjUG74C8VHo3XS8H5ub1NSbQdRybja01HN6Ifx1PZ2AAPxho9L7eNEtu409Vcjgfjk/qIAiR5CKtPG4l92sDlA92Y22uPxkziCUhiapk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716296094; c=relaxed/simple;
	bh=OYBS6gfB/QyC+92Y38sf/uxpK+d7gibzAcp4gK+vucI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lHXsUnKqwh6yapC2fAg3sZTnroKH4sWeqL3jlz81tUtpXIznQJfdXFY7CQD26XzCz1K1Tf0hT/OFhNVrdz2449oroDzKSeD6KcRRc/RWE8vZP6f1BuQ7ltSeOpvyg8XXr7+In16Ax+0fcDTDyMULO/C/3qLZJtzO7xh2t+3upnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ijPibRkh; arc=fail smtp.client-ip=40.107.101.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXfR2bOEnos9eSODd+gS0+aQFBxT/ZBhgZ/TO3U6Q4L7fFeMA6hOLsp9+xff4m02UsERwdBoKDoyaTkFlKUjgz4061P2gVbtegGfr8NivIaLWr1s0K5ydnYiLm1LNw0lon78DFERE5pND1YJ+5BTKzVmtA6kg7tc1KJAB+PIVkICOuMYWV49cckb9fn7PDpn0GymFxiriMleiE1lCTPEXYj/hUr3cw8KQW4ISoZQZXyBeonNhixiKsyH8unEDYgOGz6gJySlXNMMdGwjCpGBceExSQ7HR7mHxN0WZ0PIyWmSSuEXommROMZPkzfBKGTjCVDpr2FpeW8HucQsPVnATQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHFZIca5cfC/32AFE/+NiYxa7b4NRfDWOy2eFIUxong=;
 b=iCc2Hat8LmnNi3BWB2NxPi4WlxDH9DNKnGbd8gEU8bO0cRkkHS3pgZDMERHnMQbuGlMDrZ/8JC3I70TLMIiTvJm/Ozjo/zNn61crUx5JDtIheWLDHIc12adFZ1+9gNYAs93I5kjfOch8LTvf1VwuV2FTFQBlcJ30spI3mWE9iUg2v32D/682np57kxKaqOzXKeBWv0JhmUJQkkYuPqH2AlDheLhDIxTj9LBv3qvWM+yI5zGi0FoxUwKDceuHc/+usb4VCrQYUIL9TNI8+CiwwliRKbjj2SowM0seKrjmjt6Nr94Lkel1dhOyZh6rrz161n9289js9sI2QFSbWAZfqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHFZIca5cfC/32AFE/+NiYxa7b4NRfDWOy2eFIUxong=;
 b=ijPibRkh3sW/i4vhX87Yu+6lKSiq1VJEoOLidtPNyp4lf9+k8n1TOdQtRdxMVvahk19k+yAzKMlPa97WAgCZb1rVeE+5ziNnXNQLVMHboA88SiiXuUL1iXBTlUlktIv3XO/JO7n5JlLCtmexQVn+1G3MyRcUfoAPVpDbcNd6ea8=
Received: from PH8PR20CA0012.namprd20.prod.outlook.com (2603:10b6:510:23c::10)
 by SA1PR12MB8162.namprd12.prod.outlook.com (2603:10b6:806:33a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Tue, 21 May
 2024 12:54:50 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::45) by PH8PR20CA0012.outlook.office365.com
 (2603:10b6:510:23c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.37 via Frontend
 Transport; Tue, 21 May 2024 12:54:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024 12:54:49 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 21 May
 2024 07:54:45 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH 3/3] x86/mce: Use mce_prep_record() helpers for apei_smca_report_x86_error()
Date: Tue, 21 May 2024 07:54:34 -0500
Message-ID: <20240521125434.1555845-4-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240521125434.1555845-1-yazen.ghannam@amd.com>
References: <20240521125434.1555845-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|SA1PR12MB8162:EE_
X-MS-Office365-Filtering-Correlation-Id: d5db1949-e4fc-4d12-7104-08dc79953359
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P+8N0zJrdIacxuY1HzQwWLKmzWJ9kz0e8VgMiQaGd/9A1OiCrr2bOs/Du8dQ?=
 =?us-ascii?Q?RfwEKdyh3MgNLrbJKP02O9HGc04rwNlfw849CcZ3DACl4dhWSeZEp4eDNLJc?=
 =?us-ascii?Q?BVqyU7ZbLyyAU/xkGASKXPg+mvq+BV2A1r7pkJtgsH3ukm1qPPdtTMYvPO8D?=
 =?us-ascii?Q?uN6GvFYb/tGXFg8EY3Qgumd+wRgljTgpUG4LZGL3yteIG9Ffr+6XpZxxIC1G?=
 =?us-ascii?Q?fkSodd8VyC0xnaJ6B+x28hYmEmLsQ7ogQdCcZlPB/LwevbEePrepuziMuD13?=
 =?us-ascii?Q?nZCkezr6eS+YElRrqnXQ0/mJkZ9LtoK+ecM8x5AYu33cuQWX9Wp4y3VtoPqq?=
 =?us-ascii?Q?T9lO8YCzGA8BPRDCfJ0JdAL+YdUe8tVleUR0c2vM+4qcstS2vCFn92A9MEZH?=
 =?us-ascii?Q?3N6WM3irA/s/WcYJrV/XFoO3x2iRLdeEYx6N+0xp8tOCMphfTI0UlunuQeV9?=
 =?us-ascii?Q?IZgGGNxvEUEphvjEf5jhkg8PRK0+aFfqttkdi3X6K1ehI+B5rx6WT3/YHHoq?=
 =?us-ascii?Q?m1keZ6vGbDrkrVt1BLwQzOZ2Oz7AI/xr84OruXW2EppFrnTz+jyDXiw/cOb2?=
 =?us-ascii?Q?taOdHa2pqsUr8njiAARRbk+rgkoM8LCXCiMd4eenzGPNJSb4b2Z8ne9JeWVL?=
 =?us-ascii?Q?9hsrls5mvqNgf4Nr19bHlUJ1JlzSJVBVueC+mxEZgpJCsEni3TzKIolqnSAj?=
 =?us-ascii?Q?YIzeZ/p+evrhQkG/7vlTzuAK5/A7W7f+3/O7mEdmFGp7JR/cKYQD1Fs1cXfz?=
 =?us-ascii?Q?s2uVAHZvnH+oUMuFx7wZoimMs0krAhvfE3WwGnIC856K6wvjtLN4JW0TKxTt?=
 =?us-ascii?Q?/zVWq9qDowvgrjWfiZl+KXH/OZhJqJEMe2exU2r+Y1EJemZSwRwhfpQfUpov?=
 =?us-ascii?Q?aEDC9YsTdSF4lTr0WwEwgCxSOBhjHzPFJvgCN7Fnd3Wndvu//GuTLopASUHD?=
 =?us-ascii?Q?mCvSr1egRcngnkUelxSuSwYXbKuL6pYDrY6VN+I+nMMR5xIggSl1lQvGFoNq?=
 =?us-ascii?Q?GrfQH6oS9GVE933wI6o39LtdKUqNOucoAwQO6yi5/la2BTOSfbRxl2gQdQTt?=
 =?us-ascii?Q?D1sJohQgZB7AUVr8MWYU3HPWNvkIOVQd5EaDbcFV/e8RuzHXQTqOp7hjEjJr?=
 =?us-ascii?Q?5kQt46aCNx7pXHG/a+uVthAHfrQkppq1br/aGcrgHyNM5LM4qG8O8l9AqcPg?=
 =?us-ascii?Q?heUuCLassvZZdqzKADNiWqxLZXcwkqZTsDmH4ehgoSQDkOiqIm3Jt/BZWFDe?=
 =?us-ascii?Q?7K5Ymhf/lY2NXROo5Cj9Q/Ug5EFDRi30i4ZDhYf+IqCYtu4HdRhLaoIooZsw?=
 =?us-ascii?Q?O/Lei0GmefxwNtmIfTAFT4kQjvNKP5FAa+nLg28borNScEBRw3JSCF71y1Mz?=
 =?us-ascii?Q?pBIQH8jKacqNDZImF0bpHZTwpgvT?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 12:54:49.7261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5db1949-e4fc-4d12-7104-08dc79953359
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8162

Current AMD systems can report MCA errors using the ACPI Boot Error
Record Table (BERT). The BERT entries for MCA errors will be an x86
Common Platform Error Record (CPER) with an MSR register context that
matches the MCAX/SMCA register space.

However, the BERT will not necessarily be processed on the CPU that
reported the MCA errors. Therefore, the correct CPU number needs to be
determined and the information saved in struct mce.

The CPU number is determined by searching all possible CPUs for a Local
APIC ID matching the value in the x86 CPER.

Use the newly defined mce_prep_record_*() helpers to get the correct
data.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/apei.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 8f509c8a4e98..0cbadfaf2400 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -97,20 +97,17 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 	if (ctx_info->reg_arr_size < 48)
 		return -EINVAL;
 
-	mce_prep_record(&m);
-
-	m.extcpu = -1;
-	m.socketid = -1;
-
 	for_each_possible_cpu(cpu) {
-		if (cpu_data(cpu).topo.initial_apicid == lapic_id) {
-			m.extcpu = cpu;
-			m.socketid = cpu_data(m.extcpu).topo.pkg_id;
+		if (cpu_data(cpu).topo.initial_apicid == lapic_id)
 			break;
-		}
 	}
 
-	m.apicid = lapic_id;
+	if (!cpu_possible(cpu))
+		return -EINVAL;
+
+	mce_prep_record_common(&m);
+	mce_prep_record_per_cpu(cpu, &m);
+
 	m.bank = (ctx_info->msr_addr >> 4) & 0xFF;
 	m.status = *i_mce;
 	m.addr = *(i_mce + 1);
-- 
2.34.1


