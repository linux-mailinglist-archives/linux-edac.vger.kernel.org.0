Return-Path: <linux-edac+bounces-45-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA237F0278
	for <lists+linux-edac@lfdr.de>; Sat, 18 Nov 2023 20:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EF401C20971
	for <lists+linux-edac@lfdr.de>; Sat, 18 Nov 2023 19:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4734D1DDE2;
	Sat, 18 Nov 2023 19:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fX8CZ9jL"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6117D4B;
	Sat, 18 Nov 2023 11:33:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlYeaMSroy6wjdn9FKkzgvIXpSc+Ym++u8/S3YPHCQuxkL/V7pmLJXXHWAW25syrgrMCY0H/1wjHZxzhFVGIIovDLu1e7wBKWJ9w4Re72Zv4rLg2jaLyYc8Bqfxqt2NHVcK8SzKPgVLBzOxkcHYuCi2NcvyTI+alAMaSYjdrBUXPTolI7ZWB2NN5Euh9wGqLJGYLwVi0jmxbd2rpO6LYsSSQMlaMsW1ynX+ds7xfbiaDHCwpQCL4B5XsoR+uL4CR+5qOul9KTo5Zzv9ai6Cz6Fuf/E7foFklSI7CCmkBMmPCabqeIOagysbWLh/DcWePd89s8eq2sxNpvoIfN3kKhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSysNK9bxq+1r8PuCDAFHlfaip/E9WMakSALPxh8KxU=;
 b=KPBeh5GMNBGq/CLx3QiQD/33U6PCl1XgeALf6vgJVdWyC3XIovYrcKqUj2YG2EYCdLJNwYstv+7WBnbFvNUXOxnx8q+BAowwAnbxGjH2+3Gj8TE9mTem91O5knm0IWJ3TeuiqgBIQ3nf0t81m4XcAhuo+GW6Nx2n5FhMGg0A7S+ebIHX5cN0Zq8CGeZHRx6FHtcVhb0xm+9D0/Wl0hgM/qyWrQ4mtv3s2OdkW06sP70f1f1QCnPulnjbYEP0oKq9togybLiQ1fFiE7XlwRfKiaBc/BqGVu7MQmVhfmsjti/Ca6Y2cYjEXZyC9HnZKyl28M5/Wty7gR3CsaWegLAzdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSysNK9bxq+1r8PuCDAFHlfaip/E9WMakSALPxh8KxU=;
 b=fX8CZ9jLdkB2B9kiRr0QMw2hM+Ri/Lq+BrPgiJ0tsuRltYut4T1HaeHoI/4ytKpg+eV5pBpaa7KqdQOtTM0N/wNwfCKpWwxoH/QPKxx1YTh8Ho2nMXF4A7smjozyPiTCbsgQXfhxJCbjbWWavlRrnrYC7n10q8ewTOyVGe2yRSQ=
Received: from BLAP220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::21)
 by IA1PR12MB6164.namprd12.prod.outlook.com (2603:10b6:208:3e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25; Sat, 18 Nov
 2023 19:33:09 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::51) by BLAP220CA0016.outlook.office365.com
 (2603:10b6:208:32c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23 via Frontend
 Transport; Sat, 18 Nov 2023 19:33:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Sat, 18 Nov 2023 19:33:09 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 18 Nov
 2023 13:33:05 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<Avadhut.Naik@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<amd-gfx@lists.freedesktop.org>, <linux-trace-kernel@vger.kernel.org>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>
Subject: [PATCH 10/20] x86/mce/amd: Prep DFR handler before enabling banks
Date: Sat, 18 Nov 2023 13:32:38 -0600
Message-ID: <20231118193248.1296798-11-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118193248.1296798-1-yazen.ghannam@amd.com>
References: <20231118193248.1296798-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|IA1PR12MB6164:EE_
X-MS-Office365-Filtering-Correlation-Id: d977341a-2984-4263-00c3-08dbe86d3265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pv+MTdiopyx8WHoP8uL86uy3QAg3ov70CTVXQJChnhLus5LVqK8j+Xy7oHmwSkgk1Vu/hwYFQkMEskVrkXuWKa9+l6GAfSk+208rQ61jIQCI1GDGT/dGmEGt/se788zDohww0Taz8bkhnnN5aIWT98gILbuUnCevC/ofup8ikUbPZv0T1JFNhM53kC99KZ5907eD5P0Z7umr4Gnucp84jmx+RIkfFuX6yeghRGnp2DBlmswfEgk0RBfuk0XqCTjUsfUGzLcYMNxW33DqRynaTdqbouQ+T5dVbykhUr9mChdP7wecmqAocYQfGMC/277MxZklTcLAfwupH/pld+1XGOmY1e37H/PrcoEeuX2ojVeowVwbdrYmvfrWebPitu2LDvfJdIgu6yZ6S1pC0jd0va3vSeFNBPygEv/2Wbdmds3yPHxsWIUUDTH5sJTwpwcjdlyE8urt+wzZgdfUdEsna5asyyzItQbQDh0mhTFcopwZqwnHPo3wN0JbUpUb1uZzil1ChOs5y4rKhAOch0Eue7h1BAlfytXGIkVTDwqvKLzwzPIihEDGXArtaM0oFtoy9JIzYSDkoN1eia89H5RNC2F38fZhHAy68bkVuSZd4wySabmqGWQQSpWsXqOk5mHhWssk9KL/DrQ5Ve6kBHLih0GKW0D010KoHvgOTjOchX27LX9KOfdOPV+qd0LyXwnyxECDGwb8k6OVA/289vvWkl9jk0T87ZkIe1BsgS2gsIMcPLEDmM45YY0TEUIF9bOdjKPENvt7narBwwfz88NEyw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799012)(46966006)(36840700001)(40470700004)(40460700003)(5660300002)(44832011)(2906002)(15650500001)(356005)(81166007)(82740400003)(86362001)(36756003)(336012)(426003)(83380400001)(1076003)(26005)(16526019)(2616005)(7696005)(36860700001)(478600001)(6666004)(47076005)(41300700001)(8676002)(8936002)(4326008)(70586007)(70206006)(316002)(6916009)(54906003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 19:33:09.7147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d977341a-2984-4263-00c3-08dbe86d3265
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6164

Scalable MCA systems use the per-bank MCA_CONFIG register to enable
deferred error interrupts. This is done as part of SMCA configuration.

Currently, the deferred error interrupt handler is set up after SMCA
configuration.

Move the deferred error interrupt handler set up before SMCA
configuration. This ensures the kernel is ready to receive the
interrupts before the hardware is configured to send them.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index c8c92e048f56..4fddc5c8ae0e 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -595,6 +595,9 @@ static void deferred_error_interrupt_enable(struct cpuinfo_x86 *c)
 	u32 low = 0, high = 0;
 	int def_offset = -1, def_new;
 
+	if (!mce_flags.succor)
+		return;
+
 	if (rdmsr_safe(MSR_CU_DEF_ERR, &low, &high))
 		return;
 
@@ -774,6 +777,7 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 	u32 low = 0, high = 0, address = 0;
 	int offset = -1;
 
+	deferred_error_interrupt_enable(c);
 
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
 		if (mce_flags.smca)
@@ -800,9 +804,6 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 			offset = prepare_threshold_block(bank, block, address, offset, high);
 		}
 	}
-
-	if (mce_flags.succor)
-		deferred_error_interrupt_enable(c);
 }
 
 /*
-- 
2.34.1


