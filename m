Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9D94082C4
	for <lists+linux-edac@lfdr.de>; Mon, 13 Sep 2021 04:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236871AbhIMCPe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 12 Sep 2021 22:15:34 -0400
Received: from mail-bn7nam10on2069.outbound.protection.outlook.com ([40.107.92.69]:32000
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231810AbhIMCPd (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 12 Sep 2021 22:15:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tti52AM55LrA9fgHhzPRDt1ZpU87mDPRd+9iZc/ZyP7VDkahyr1H0XgmzWgdPOLIFF9LqtG+MCksL5JPBtLwGHaQwWHbJUW2640miTtuVfR8FwEoWcJY6XaxupaEB4QYuJF+d6ht3dJMhgsI6R+N7oYskk+4YUje7kqVi47756K6NHhO4BmKjsbeDifhla1b60R+ZpEd5tF5rQdbMb8nYubSUiUT2sbCnHHkKLag2JqwYYEADT1vR6NcYFm0X3et+NGRLLyh9Mn2djmcNEZQ0UIhhF6aCzsfER19+oSygt/469T6Ldj4qvzgi6OcssV1p/kz2dUFZjSoKKhyWeGgnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=STZOnQWXhHYWGZRWOHlholaKmHLOikoweSxyI3eUbc8=;
 b=IUIOtH71k0xqs6zyERPDaHsQ1R5NM0bFs5eoRBtMN3TGJeOUtDdJ4q64hckHP4tCtqIeOvahItXk1zrHOVtSSubqUDtaB9iKOYuhXPSst0J9xjkcdsk5rKJV29vMcvn9BgXEq8ei+lxBeUtPoyvu0CTT3LuWIFFt2ZxHvYChz/Ht4ePIg46kOg8SoeQcc1AHAxo1iV9DUdS/PC8qFu3L6/dvr1nDdViLfxXQK2UJOpFeimUFOwYnMvcSXtyMGx/UeaEAB0R5Goz1vDf2CnFfDcqB53VwVCdfcvil0abjDiZKHhzbHUTsWUR8nzjIe9hO8APXFPaTCZM5srcJNoS6Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STZOnQWXhHYWGZRWOHlholaKmHLOikoweSxyI3eUbc8=;
 b=nTz8I2a2ue0cdvpVzNI8W8iNH1oE9ZpEg2NHTURp4EHMXJNH2HYTaF8O4ykpYEwwB0NcjFvACThrOEau3DHJl+Jr+zhXzvRe76aDXe3WDXVl2aPFoDHCtaUYxjC27SnFljf/hLjL8HVOwrZAoctic+dZcDZb+GyEsWXFyvWcDPs=
Received: from CO1PR15CA0091.namprd15.prod.outlook.com (2603:10b6:101:21::11)
 by BN8PR12MB3585.namprd12.prod.outlook.com (2603:10b6:408:49::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Mon, 13 Sep
 2021 02:14:13 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::dd) by CO1PR15CA0091.outlook.office365.com
 (2603:10b6:101:21::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Mon, 13 Sep 2021 02:14:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 02:14:13 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 12 Sep
 2021 21:14:11 -0500
From:   Mukul Joshi <mukul.joshi@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
        <amd-gfx@lists.freedesktop.org>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCHv2 1/2] x86/MCE/AMD: Export smca_get_bank_type symbol
Date:   Sun, 12 Sep 2021 22:13:10 -0400
Message-ID: <20210913021311.12896-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210511152538.148084-2-nchatrad@amd.com>
References: <20210511152538.148084-2-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2c7a044-b21c-40eb-7d2f-08d9765c2e4a
X-MS-TrafficTypeDiagnostic: BN8PR12MB3585:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3585542B28E1AD9A3C615AF4EED99@BN8PR12MB3585.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +iOANvXewJiMJXBKpTd+WIGHGNYcXR6lQyy4UNpet/VNHUemLawpAGc6uFL1Bv+Nrv85+RcZxoz3WssaBZgJA2apfy4xfkmxkATFsoZ4lWehRP5zH5VUlQXPNgig3B752V7OnYs+odIHJlM7NV/El+/jffZ6sgqQFrvTF2tC5qQe/ck/VbtUDU9lQVkS6lL+7HMtSnDHCutbIgiux9Zs6MwJFbgZKQ33g2TSvdS3TXrFfWkIpKVbTeQlhDXZInuHHOipvKttdBicsOjo+G4QzqTwJEm4X0NVllamvxbo1kVlpMiLhjO3myUqqY61WZR4xcgKl306Ov6OwO89JjQz+YHno5C7neF7ucZej8Ta71gwgAw+oGTZmQExI/Lt8h+Kn8IiBfvYWz3UN1pMkxKl6BPouvZNL0knR1FSokcYIRZO8Ea0b1Q2YVcwgtaxQlEn/BK5oHXu+wDoDKkt8l9ZzCsL3blm0GU+pioAu/VAj9voWm8xBpxn1Fy/bCz3vNSjFgDQmdu6uQ8zkz2ccqyG8nIIs4EzrS9+fGeH7WbY8nL2gM2BlYv60y2rlfF27tII0x+cwHP+DKQd17zZ3M0x6m3mBNqDdVVNyOvCc3c+EFGEaH+18LIUI79gzeiwhEAXi9JvuyD5eDUQM885uNgp/zD+5D1N9yg/QaLy7elcRK8+UCVvs7y3VfKjimW5dRzy+3v5P4QFfbRrdky6s2ITgINMW2Psz4sn+xZwDNvZqTM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(36840700001)(46966006)(86362001)(478600001)(1076003)(70206006)(316002)(82310400003)(36860700001)(36756003)(70586007)(5660300002)(2906002)(8936002)(110136005)(336012)(47076005)(81166007)(54906003)(26005)(186003)(16526019)(82740400003)(44832011)(7696005)(426003)(2616005)(8676002)(83380400001)(4326008)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 02:14:13.3589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c7a044-b21c-40eb-7d2f-08d9765c2e4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3585
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Export smca_get_bank_type for use in the AMD GPU
driver to determine MCA bank while handling correctable
and uncorrectable errors in GPU UMC.

v1->v2:
- Drop the function is_smca_umc_v2().
- Drop the patch to introduce a new MCE priority (MCE_PRIO_ACEL)
  for GPU/accelarator cards.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 arch/x86/include/asm/mce.h    | 2 +-
 arch/x86/kernel/cpu/mce/amd.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index fc3d36f1f9d0..d90d3ccb583a 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -358,7 +358,7 @@ extern int mce_threshold_remove_device(unsigned int cpu);
 
 void mce_amd_feature_init(struct cpuinfo_x86 *c);
 int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr);
-
+enum smca_bank_types smca_get_bank_type(unsigned int bank);
 #else
 
 static inline int mce_threshold_create_device(unsigned int cpu)		{ return 0; };
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 67a337672ee4..c9272c53026e 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -123,7 +123,7 @@ const char *smca_get_long_name(enum smca_bank_types t)
 }
 EXPORT_SYMBOL_GPL(smca_get_long_name);
 
-static enum smca_bank_types smca_get_bank_type(unsigned int bank)
+enum smca_bank_types smca_get_bank_type(unsigned int bank)
 {
 	struct smca_bank *b;
 
@@ -136,6 +136,7 @@ static enum smca_bank_types smca_get_bank_type(unsigned int bank)
 
 	return b->hwid->bank_type;
 }
+EXPORT_SYMBOL_GPL(smca_get_bank_type);
 
 static struct smca_hwid smca_hwid_mcatypes[] = {
 	/* { bank_type, hwid_mcatype } */
-- 
2.17.1

