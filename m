Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A10743422A
	for <lists+linux-edac@lfdr.de>; Wed, 20 Oct 2021 01:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhJSXja (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 19 Oct 2021 19:39:30 -0400
Received: from mail-bn8nam12on2063.outbound.protection.outlook.com ([40.107.237.63]:37922
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229814AbhJSXjY (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 19 Oct 2021 19:39:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RScuSZfE5hANaO02WJvjch4q2xNABRaOsJ85sIxkCw8iE+yflUWkmJdiHc27H1JllFeD//Dby8RGyYwd5LulmLM+lwVHrxtNoGa+kYMKwfmme50sECUcz5QoAhxtHPerdByzhpIRqPMpZPs3co+5M7m6+ca6v4wIgIFApjY2F7Kl4FwF+FACwPYlZ4foTEuBCaoVqniUZGmECle00XGEjvkGwSqGGJhZU+7CchmDL8E4NVLbEwdfTru0onYWNTNhlYe/mb9jL0MZUDq7BmPXsxPALEgszlyQzB9fYhujQTPrmThpOmwHCcKsw6AxjYGJ58zTZLsI/O7/999VU/fmVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCHTXX1fvyjLnEG4TzbQaPhjeXeIDEkN9wTYuj6NUVE=;
 b=YdEVQLimqQnq2rirGts5/N7xN9yZHTE1niRESOSZzgPIhFxpvtw/rdi8iATkSynBE0VeNgQvP0eYeVMTXecoYDja14iZjsKhQP/XsKDNpfgd8LLBNZYO5lEKiMG2LUejCOS+sXbWP+EL8mnbcc4Bvn0G6lH2V6eumZzMqGD+vUAOwWK0tXR3SYOt+bHamntNtf9sQLoRtQlRuByUXD+3ojxVqDDceBaLb3bM2iooXOFC5o42sEwPtUxPyULNwv6dnj4DF3UfCRj/XgrZnJh7HxNmk4+ebntMfltYjtA8LuwoPS8phKVmR+ubFh64G7fOlhKyoT3lwD7D6bCqmH2p5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCHTXX1fvyjLnEG4TzbQaPhjeXeIDEkN9wTYuj6NUVE=;
 b=Aj0aNf5psHpOzie9CkB0gus5Qp+SJpxZg8WBQSMXT06/YzkNJp6H1Ql7atv2t1BRiRv6+8bmJtKHaCCsNK/60M6zGzBBLGaFUU/sM1qHcLjmZoNNyQFqLvaYUXH60lX3pDhqm4xD2wCeRkRDk+DyhT+a7AItbKLHVKaXXJ7Od14=
Received: from DM6PR17CA0035.namprd17.prod.outlook.com (2603:10b6:5:1b3::48)
 by SN6PR12MB2752.namprd12.prod.outlook.com (2603:10b6:805:78::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 23:37:04 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::2) by DM6PR17CA0035.outlook.office365.com
 (2603:10b6:5:1b3::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Tue, 19 Oct 2021 23:37:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 23:37:04 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 18:37:02 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tony Luck <tony.luck@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        <yazen.ghannam@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v2 1/5] x86/mce/inject: Check if a bank is unpopulated before error injection
Date:   Tue, 19 Oct 2021 18:36:37 -0500
Message-ID: <20211019233641.140275-2-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211019233641.140275-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20211019233641.140275-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4727575-f85a-4baa-305d-08d993595b37
X-MS-TrafficTypeDiagnostic: SN6PR12MB2752:
X-Microsoft-Antispam-PRVS: <SN6PR12MB27524A7CF932E3225E14BD9290BD9@SN6PR12MB2752.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VEdcpGNxeiOlZry/zJM7pLWjvri5oxJVEBewKu04iC4vLn64jkUTzSuetFJZRtrDhuut8qZTellAvgzQf2yRNVb8HpeyfJdDTQ5vRHyVvCqZKKpJPDaLUlH5tf2esxFlfpxN90n+R+9uXEbHPL5CdPf1Dp+SAN/FgVv7dyqB26cVHAKE8CLZXSi0ZkfSGVI4E4a7SqIIkOGRk/9ieMMU6S8CsK1vEsBI/ZxLH5CgUMs0Z6vYDxgc7jt9qEojg7BeZAV8aCj0biVVgp4kgci22ssBv3843ErT2zNpnrjZdjLrnhVHrVyOiA8fEAFjxB8nDpfsqpCoZWC3qzXh5SJsgOUUmoIscQZQOukGCp8KLhU6W/NctiSXGXQpVY1A0YHlYyw6TwJ7T88eb3wbjwIkinH1DwAdiOr0R8D9Qp+r9+1C8hsKkJHTlG0HcgD3S6ObGTUzRiMubsLzEqOelnPRzhL3vcDW8wHA/Wd9ic6BONcy525jfl1yR3BE4HDZrS+CpM92756JSMbHtQcex7fItQ0+EeVsEsrFQfOOA9d85cTqgPXvv5oribHASoidyeWCjl5+CNhNrJ2ZjGESSwQ2e69/HVFxV5Xi+o/f0dAk0AAjOFQvTfRDcKMLtJnzFkHvnHrSbwSFiKRUZD1jLSAzhGd45cKiaGO49CB5eXyz7o+lUCOwDYisxixmrgK52I8068xTOcqiec2R1eMnq6+BJGFxWe58UbGtyW2n02EVBEs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(81166007)(316002)(1076003)(36756003)(83380400001)(47076005)(2906002)(110136005)(54906003)(7696005)(8676002)(70586007)(356005)(70206006)(5660300002)(36860700001)(426003)(336012)(16526019)(186003)(8936002)(15650500001)(86362001)(2616005)(26005)(6666004)(4326008)(82310400003)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 23:37:04.0152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4727575-f85a-4baa-305d-08d993595b37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2752
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The MCA_IPID register uniquely identifies a bank's type on Scalable MCA
(SMCA) systems. When an MCA bank is not populated, the MCA_IPID register
will read as zero and writes to it will be ignored.

On a "hw" error injection check the value of this register before trying
to inject the error.

Do not impose any limitation on a "sw" injection and allow the user to
test out all the decoding paths without relying on the available hardware,
as its purpose is to just test the code.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
v2:
	simulate -> inject.
	Corrected according to kernel commenting style.
	boot_cpu_has() -> cpu_feature_enabled().
	Error simulation not possible: Bank %llu unpopulated ->
	Cannot set IPID - bank %llu unpopulated.
	Used user provided IPID value on sw injection without checking
	underlying hardware and defined it under inj_ipid_set().
---
 arch/x86/kernel/cpu/mce/inject.c | 39 +++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 0bfc14041bbb..601efd104bb4 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -74,7 +74,6 @@ MCE_INJECT_SET(status);
 MCE_INJECT_SET(misc);
 MCE_INJECT_SET(addr);
 MCE_INJECT_SET(synd);
-MCE_INJECT_SET(ipid);
 
 #define MCE_INJECT_GET(reg)						\
 static int inj_##reg##_get(void *data, u64 *val)			\
@@ -89,13 +88,11 @@ MCE_INJECT_GET(status);
 MCE_INJECT_GET(misc);
 MCE_INJECT_GET(addr);
 MCE_INJECT_GET(synd);
-MCE_INJECT_GET(ipid);
 
 DEFINE_SIMPLE_ATTRIBUTE(status_fops, inj_status_get, inj_status_set, "%llx\n");
 DEFINE_SIMPLE_ATTRIBUTE(misc_fops, inj_misc_get, inj_misc_set, "%llx\n");
 DEFINE_SIMPLE_ATTRIBUTE(addr_fops, inj_addr_get, inj_addr_set, "%llx\n");
 DEFINE_SIMPLE_ATTRIBUTE(synd_fops, inj_synd_get, inj_synd_set, "%llx\n");
-DEFINE_SIMPLE_ATTRIBUTE(ipid_fops, inj_ipid_get, inj_ipid_set, "%llx\n");
 
 static void setup_inj_struct(struct mce *m)
 {
@@ -577,6 +574,25 @@ static int inj_bank_set(void *data, u64 val)
 	}
 
 	m->bank = val;
+
+	/*
+	 * Read IPID value to determine if a bank is unpopulated on the target
+	 * CPU.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_SMCA)) {
+
+		/* Check for user provided IPID value on a sw injection. */
+		if (!m->ipid) {
+			rdmsrl_on_cpu(m->extcpu, MSR_AMD64_SMCA_MCx_IPID(val),
+				      &m->ipid);
+			if (!m->ipid) {
+				pr_err("Cannot set IPID - bank %llu unpopulated\n",
+					val);
+				return -ENODEV;
+			}
+		}
+	}
+
 	do_inject();
 
 	/* Reset injection struct */
@@ -589,6 +605,23 @@ MCE_INJECT_GET(bank);
 
 DEFINE_SIMPLE_ATTRIBUTE(bank_fops, inj_bank_get, inj_bank_set, "%llu\n");
 
+/* Use the user provided IPID value on a sw injection. */
+static int inj_ipid_set(void *data, u64 val)
+{
+	struct mce *m = (struct mce *)data;
+
+	if (cpu_feature_enabled(X86_FEATURE_SMCA)) {
+		if (val && inj_type == SW_INJ)
+			m->ipid = val;
+	}
+
+	return 0;
+}
+
+MCE_INJECT_GET(ipid);
+
+DEFINE_SIMPLE_ATTRIBUTE(ipid_fops, inj_ipid_get, inj_ipid_set, "%llx\n");
+
 static const char readme_msg[] =
 "Description of the files and their usages:\n"
 "\n"
-- 
2.17.1

