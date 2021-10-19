Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C51434228
	for <lists+linux-edac@lfdr.de>; Wed, 20 Oct 2021 01:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhJSXjZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 19 Oct 2021 19:39:25 -0400
Received: from mail-mw2nam10on2071.outbound.protection.outlook.com ([40.107.94.71]:33310
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229668AbhJSXjW (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 19 Oct 2021 19:39:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwhsPbzqtIwWzYLn1n7+TnI+ryCBFrEYggGpudYatqVnMLiZbywIuLsZDTXiz6du8vwljWPvja208I+LPkpoXee/1VoXbybwUaMeyZtp3/RC03BUF/g5SfxeZaC8eMN5OtktbHugBGqOvrLCwIJs1QtJdYIk7zvQx8ELCiUxeSJO7QfPXTqFT9xeLNpDM6nXUYpi5kuURx6gpqTdTWoj9rua+LIWIIhH9ouQZpjx2f+y8JMEP+Um98WnDGq9inFnoTDIBK/zBAOe7WRWcPhV63ClnCNP7p06N5XXP8gF7Ss66digvYDfyZPYaS5u8Iv5teO0ze7+uoVqNaD/FCdxrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CXJRzD2/CSxXzMMsswy8apTDBXsl3luGd3usmANxe0=;
 b=E6KSCI038nsXic7jG4mJpDiRxU7uTRlbGu78CEu9UuVEipCv9fSjTJ2HxYEAyYkvj309gUr1D1G8DQkrOdvxAGuhxuITimm3Bv0B4UCebTvOMq7v0LlwbRevsgikHHGX2PwKBlv31Mu/NoZcmysZHftrV5wxyqP1RGXJ9Bo7IKJ1e2HEXtlbnIRjit/7wUOJVgjqS1q/3GgHFofXnq2ma+fm3hr6GvSkwcX9J7Qt0iedLZB5ABVZWLBN493NzKD4N58ZWy3l6lyKD81foJblrlsPekwCkOwqwo+FDTLTnCAbxac5g/RrLobjYDnVatrGGnX7bNd31OABejUTx5l+eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CXJRzD2/CSxXzMMsswy8apTDBXsl3luGd3usmANxe0=;
 b=ZrMLfgmlK7sH7c7sLEYq1gSaicKckJEwg13v+02pxtT1+vItUwGE9rAcIiYArELrraaHGEN1p0pS48cvF76Ge16WRC5AebfmkMYtjs77hExRg1yRbra3kuN2Q3AaC8grVju9rsPrWx0HvVFHgSnZI78gYH9Y5Eyd5W4eaJALdhk=
Received: from DM6PR17CA0036.namprd17.prod.outlook.com (2603:10b6:5:1b3::49)
 by DM6PR12MB3594.namprd12.prod.outlook.com (2603:10b6:5:11f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 23:37:05 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::e5) by DM6PR17CA0036.outlook.office365.com
 (2603:10b6:5:1b3::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Tue, 19 Oct 2021 23:37:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 23:37:05 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 18:37:04 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tony Luck <tony.luck@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        <yazen.ghannam@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v2 2/5] x86/mce/inject: Warn the user on a not set valid bit in MCA_STATUS
Date:   Tue, 19 Oct 2021 18:36:38 -0500
Message-ID: <20211019233641.140275-3-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 80a549fb-a272-42c6-2ae9-08d993595c3f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3594:
X-Microsoft-Antispam-PRVS: <DM6PR12MB35941A3B3910A7C97636715390BD9@DM6PR12MB3594.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ykbMmHFN2QUAxHsO5Axzeoox00DXFs0nAH8ezxUPe1rJQAVqrPwXYDjVfTAV0uhuf8n8Uv/r2jVXqGdnvf1ZbRtgKo/6BiHgvIfn3vS9tQTe/bGCbnpQhXHcoNqbsywUV60hYQwL9by5MHKNx8zNUiaOcQr2Ye4OCQww1Y00JitE4yX+gJtOa5I8J+2a3tsPdfxBfNqnPfRVNYGJA+u5JM7dSkcspHlYtxkEvj0BOS6pGN5SD8wMm0vRVF9OY63ybeKtNPAzKTm+YoZas2oIGmE0YAXgg2OaRw8RNxoJMHuICSR0TGH/4CJUyb2foZDZBQbDL9zCSkJxGGihbom9SlX33CrJWbf86bBDjEWx0gykouiIhYy0Vx2N2JfTK7+lYMIAmNFyDW8mXl/EVavbChujhxYnJDHfBEmVyXLRB4PHhuYzgH0KCazpmeD2DHCgv1HMRzf4AnGZY2d0Mp+F1mn9yzuibpU/R5KC0WhybnNT1hHLFpAWtI3soRnCs9sbO6Dck8WF0CU9EoPgnpZ8lSQG4c3f0vtZBF1apG5r0iQC05aGKCtA9hgG1Xvu0lyxnJX5hb8f+Z9EBjMp8+nMiXDcyZ974m/uFLL7CiFB8jf0xEs/P3lyQw4U/lfnC3/hDrjljfBHJFnP1WpBZxfAtSpxMDSTS5t3Jv5gGoSpRHh3U6EOky5M57/ukC45ewXas0Ise+RDfwsM5I2fIYqT0S5/fQIIPCmgh2FnESKodk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(2906002)(6666004)(356005)(7696005)(47076005)(82310400003)(4326008)(8936002)(86362001)(5660300002)(508600001)(81166007)(36860700001)(1076003)(54906003)(110136005)(16526019)(8676002)(186003)(4744005)(316002)(336012)(70206006)(83380400001)(36756003)(70586007)(426003)(26005)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 23:37:05.6013
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a549fb-a272-42c6-2ae9-08d993595c3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3594
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

MCA handlers check the valid bit in each status register (MCA_STATUS[Val])
and will likely ignore signatures if the valid bit is not set.

Warn the user if the valid bit is not set before doing error injection.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
v2:
	Added a warning statement instead of setting the valid bit.
---
 arch/x86/kernel/cpu/mce/inject.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 601efd104bb4..a993dc3d0333 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -487,6 +487,9 @@ static void do_inject(void)
 
 	i_mce.tsc = rdtsc_ordered();
 
+	if (!(i_mce.status & MCI_STATUS_VAL))
+		pr_warn("Handlers might ignore signatures with Val=0 in MCA_STATUS\n");
+
 	if (i_mce.misc)
 		i_mce.status |= MCI_STATUS_MISCV;
 
-- 
2.17.1

