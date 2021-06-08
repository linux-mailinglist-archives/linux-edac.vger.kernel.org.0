Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E963A3A0697
	for <lists+linux-edac@lfdr.de>; Wed,  9 Jun 2021 00:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbhFHWMn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 8 Jun 2021 18:12:43 -0400
Received: from mail-dm6nam08on2089.outbound.protection.outlook.com ([40.107.102.89]:9538
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230460AbhFHWMm (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 8 Jun 2021 18:12:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNPMeNAfQ32/upx1tFCvERK6Z+cDpkNTTrlqam0U/cCFFR8iXpIYEaf2zPn6TyclWo0alT/crOhjYan4aPzq43qASr4WEMIjJDmdg2yOMHN0bRslks59C8Fi2uzpOKCoA3VlvIWRMyYzhP1NIX7VIEkXIRb2yPDCVf9GJLiJ5Jxz+8YbDsRj0zyKw55q51dqY4FNXYEJYSpX01CzshDysdcsUtRWksv9V2Obrh0ptOCV5T3uFHSfCAQHp1bBTC0GBt5uESaight38aa/E1EuiCqD/dk2oBP/KtznqStsCZfNyuKgR/7KrlfOFv01zEZ/qqv3U+OB70r+uZ0kBXD/iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAmN3DEnYzMwvottv+mnMYNkei9P0Zx3eDV/VcIMHf4=;
 b=OZVKlib3bNoT/bpz8V2BoSoAG7pQWQPu1MovR00G7buaWu+KEiFEH2XO/Zpx8O1ucsgSHwI4fegAZzuEBmYw3Wv6fTw5RRtIde1FNvF3bLd8tmrZlMa4w50RY6SNRn8JB2xmXVYFup6M5Gaqm1otm3EJ/5QzGxII6qoyFpy4lpKytkTiTyhbNeWSb7H+Y2FXF4yoX3sdvUyFAc1sD/6emFjOBrEXeer9G+g+BBENzlMuHwFaNArgda/0zCPgDymkv+6g0O7jcPO6D5Hpr3XjUCDYGx7zc+PpI34yD41UMgBW3E1Nc0SMDml8VyBGfwmIn6a8FMvLiF0WeG0/fEZyTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAmN3DEnYzMwvottv+mnMYNkei9P0Zx3eDV/VcIMHf4=;
 b=BhuQDFMGldeD4yJVBU8DqRhXruxzT6IqV2MJLqfmQetzMKL0n2LG9b5InBz/Pj/hA4NDGmBWsZiZgFBZ2uiZIhfVDUHE4MQIEsY4xe1UNAlOPOJ3me4Aq9/aLPSMbuI7uIUmIT59ogTooPjSWosrwYqmrszfH1LdsYEPajMWRbI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SN6PR12MB2686.namprd12.prod.outlook.com (2603:10b6:805:72::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 22:10:43 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::b50a:9f23:d6f4:408d]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::b50a:9f23:d6f4:408d%4]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 22:10:42 +0000
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Muralidhara M K <muralimk@amd.com>,
        Akshay Gupta <Akshay.Gupta@amd.com>,
        Youquan Song <youquan.song@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH 1/2] x86/mce: Define function to extract ErrorAddr from MCA_ADDR
Date:   Tue,  8 Jun 2021 17:10:11 -0500
Message-Id: <20210608221012.223696-2-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210608221012.223696-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20210608221012.223696-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain
X-Originating-IP: [165.204.184.1]
X-ClientProxiedBy: BN6PR17CA0021.namprd17.prod.outlook.com
 (2603:10b6:404:65::31) To SN6PR12MB2685.namprd12.prod.outlook.com
 (2603:10b6:805:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx50f7host.amd.com (165.204.184.1) by BN6PR17CA0021.namprd17.prod.outlook.com (2603:10b6:404:65::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23 via Frontend Transport; Tue, 8 Jun 2021 22:10:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fab5c75-fa05-46a3-4d7f-08d92aca41da
X-MS-TrafficTypeDiagnostic: SN6PR12MB2686:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB26868B63656E10C010EACC2F90379@SN6PR12MB2686.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2BguEPg0z6NA74Rx8uYEp3TL16q0p9KYlwC7SufWbTzTJhUmukLw9hK8y0mp+bWu7R9vpTH4IfmWfL28KFg2fAaHB/QWvlyMwxYkaGFxeTbYXjk4vdzxwwzxX775eu312b37p3YssLdgGLQvL/44oWP05NKOhCC+oJzOEJmjvNC73B5BAnaFiDXFsavo6KsjJi59K4eILU7Z0HhVUR3RYrlwj5aTZubhsf7zRwKjAo+B9QtIiDReWELWHzSvMQtsVpTm++u3RdKmZ7JhH/0wfpIpKKdn7F7wFUcLNL1Z//zz43sr6rUmXYumUqdUcGlPXDLPpgFs6jtoYVF/Qu4h881mJLw4q/zKkfr6ZfpCf7KzwNszzaYaOWz+62MAmUPEwokYpMpw2pZ03Mx9Dyq8IsvmGmwU8PQq3ThvxcQrYrp8zhkTxn69rXSSIeEuBVuRPYHBrDF+MXUd8DRv8SQ2FPFCxpZWtjMYN4b0l5Y2FmoEVgxXBvfW9XMP6fN8+oaBGL0UVHD27Qz1CM08nsM+XNAxMdUo6n/YVe/VdosIlYfBzgYoJtVTOLLMibeRU5Lzl/kjJNhq+9BGggVAMCdCac3vNZqtHZqZsek3V19H2LfGbv3UZD4JZyw2T+gAumeSc/7oWQNjuh3utvWtfS5TA23gL99XH4MdPdbe/Q0X14Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39850400004)(396003)(376002)(366004)(956004)(2616005)(8676002)(4326008)(54906003)(316002)(8936002)(2906002)(66556008)(7416002)(1076003)(478600001)(26005)(16526019)(186003)(66946007)(86362001)(6486002)(6666004)(36756003)(38100700002)(38350700002)(5660300002)(83380400001)(7696005)(52116002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i6Ml5pHGd3gpFymkGny0umS3R/t3XHALem6eDhGYkAbiB3P7Z3LuLfH2Iyat?=
 =?us-ascii?Q?VV5U70zyj4wWGLFABhJSPQPO/J5TxuKk+DF0nd/97w9S/KI+WBnL8Irn/AV/?=
 =?us-ascii?Q?DEvVaWRvwrSIfVKaFqDoSMZP6Cp9ShIWJ57xOyIua+DZPrtJ+Dp+g841ogj+?=
 =?us-ascii?Q?t/NXepJfBIZa6bM17cQkdvHjd9uS9tt63tJxnXBHq5TUGTWvfzYtdmslqKjD?=
 =?us-ascii?Q?vF59tBXmWgOrUCMe8w+5kUChJKN8UnzgaXgZZ087LZVTabqnk5eCPREsF/J7?=
 =?us-ascii?Q?g/vZYnkRhOwrIxopeCCmEwjvNG+P6QNEwx+kW0SeDjFqvm7qOVFIkculEwEL?=
 =?us-ascii?Q?pWh8R+zk68DMt4f1IfJmd6mHQ5XFDGp7jM8o/tIkhYerq4KG/UsYX+wY7/Yy?=
 =?us-ascii?Q?8e8oRcG80IysPS06JveUUIqfVyaS7Q7u2RebrWhUPPi2LbDhSCdpDez7q3SH?=
 =?us-ascii?Q?OgTvTTZvX/jOVKAm9dTNTHkiB0xDmcJw7jVHAlbuDkTj6hFlQjTUpcUFz/cd?=
 =?us-ascii?Q?8g1hWe42W951jXO81sm8WlJKT3tC3QvI7sPrJmT/XNRtSv3isCNq+8P5Ltqq?=
 =?us-ascii?Q?t5E2Wl9MCAcN6y0mXDzOvrgbj/IE08tytiF12/aVcTzTk8NCbtkzFd4TamsS?=
 =?us-ascii?Q?vHwfYCOa9uAGKBcwsS4X5/O5zczSyTx7Kbm077gx+PRbxPnapeqrBeqDTKwH?=
 =?us-ascii?Q?X1aU1Tm63JBHDixfVpsPWcPKFfX1vCZOjm+OOCVxiveBI3bl8UOrj4K1d6YM?=
 =?us-ascii?Q?1bKGQlf8m20rgFDlHFn67bean9ngv9sFvxLTSoqr3vzXeY2I0eCDNne5dbSC?=
 =?us-ascii?Q?cL7/fXl/08h1UvQE80x/ggl0TsmpidtFQF5uD3bimmmfSjc1HpX1YMQ/oLxo?=
 =?us-ascii?Q?mqd1vK2vNo7UXN7ASFw72TmsM3hPKR2RaNSKgA+8PJ5egdrisTuviV+CoMXk?=
 =?us-ascii?Q?EQkD56KGvdBBSVBOY3d1BUV3uOiwd7fF4RLbtmU7T5ge7YmE7YlHdBzNH9F2?=
 =?us-ascii?Q?Lg9TXU+l96TieUy0L7vqhtEP5vo2S2r3DsqDJVH3d2jZeeo/cWjiClWogzPA?=
 =?us-ascii?Q?5TtcNvM9PW/sn1yXkt0BmTNpX0rqgQzekpcy7FMDOT65V9bpiZojSIjmkF6g?=
 =?us-ascii?Q?/LjMZKKEpeamE6XtwppQDzyykC1+zDI+CGu/6pnafhtSLZduy1VHaNOosXqU?=
 =?us-ascii?Q?ajWgFismflOmqnFHU6V9ifFIKBVuiJvBp4O4G3kQ0WSLGGFzUM7Q4/Q09kte?=
 =?us-ascii?Q?jpjDx8drggq13xMmkb0tctF6JZHZFbiWkZ+rKd9DeLk0IURkdGzXzRHnofyP?=
 =?us-ascii?Q?X+S3aeZKbEan8sqcGtudvz2U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fab5c75-fa05-46a3-4d7f-08d92aca41da
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 22:10:42.8680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLF48o+ByO0XeuH/eoT+qalpg+RpGYpUIVDGARms6Hb8WO2lOIy6ilik2VDeLiWbtNVp8VdQ5NgFwPx2apDi8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2686
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move MCA_ADDR[ErrorAddr] extraction into a separate helper function. This
will be further refactored in the next patch.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 arch/x86/include/asm/mce.h     |  2 ++
 arch/x86/kernel/cpu/mce/amd.c  | 14 +++++++++-----
 arch/x86/kernel/cpu/mce/core.c |  7 ++-----
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 0607ec4f5091..0a1c7224a582 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -357,6 +357,7 @@ extern int mce_threshold_remove_device(unsigned int cpu);
 
 void mce_amd_feature_init(struct cpuinfo_x86 *c);
 int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr);
+void smca_extract_err_addr(struct mce *m);
 
 #else
 
@@ -366,6 +367,7 @@ static inline bool amd_mce_is_memory_error(struct mce *m)		{ return false; };
 static inline void mce_amd_feature_init(struct cpuinfo_x86 *c)		{ }
 static inline int
 umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)	{ return -EINVAL; };
+static inline void smca_extract_err_addr(struct mce *m)			{ }
 #endif
 
 static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)	{ return mce_amd_feature_init(c); }
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 08831acc1d03..f71435e53cdb 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -899,6 +899,13 @@ bool amd_mce_is_memory_error(struct mce *m)
 	return m->bank == 4 && xec == 0x8;
 }
 
+void smca_extract_err_addr(struct mce *m)
+{
+	u8 lsb = (m->addr >> 56) & 0x3f;
+
+	m->addr &= GENMASK_ULL(55, lsb);
+}
+
 static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 {
 	struct mce m;
@@ -917,11 +924,8 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 		 * Extract [55:<lsb>] where lsb is the least significant
 		 * *valid* bit of the address bits.
 		 */
-		if (mce_flags.smca) {
-			u8 lsb = (m.addr >> 56) & 0x3f;
-
-			m.addr &= GENMASK_ULL(55, lsb);
-		}
+		if (mce_flags.smca)
+			smca_extract_err_addr(&m);
 	}
 
 	if (mce_flags.smca) {
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index bf7fe87a7e88..2c09c1eec50a 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -703,11 +703,8 @@ static void mce_read_aux(struct mce *m, int i)
 		 * Extract [55:<lsb>] where lsb is the least significant
 		 * *valid* bit of the address bits.
 		 */
-		if (mce_flags.smca) {
-			u8 lsb = (m->addr >> 56) & 0x3f;
-
-			m->addr &= GENMASK_ULL(55, lsb);
-		}
+		if (mce_flags.smca)
+			smca_extract_err_addr(m);
 	}
 
 	if (mce_flags.smca) {
-- 
2.17.1

