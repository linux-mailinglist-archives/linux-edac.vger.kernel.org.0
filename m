Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7AB3B20EC
	for <lists+linux-edac@lfdr.de>; Wed, 23 Jun 2021 21:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhFWTXA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Jun 2021 15:23:00 -0400
Received: from mail-bn8nam12on2069.outbound.protection.outlook.com ([40.107.237.69]:51744
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230001AbhFWTW4 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Jun 2021 15:22:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mR2XCJ2AZGK9vH+eY/Z7QbtoWvyyXIn3KuYr12PG/jmiwGPGiyvZypcyZeND4HJ63zqoKuF2fOeLRpqCctXRXvJjYJDV/kOWUHg//e/HFdKxcphanWoL4aaYhwijeGk9Bwb4rG01IzEeGyEYynfAccpeuK4hfoOsMErhCd/8njtQcnwiJJjpZb8F+UyU+h9vbVJu12c79MiUfdsGDhqZZUlxyZP62avjwJ+Qn68/t6vSICH4ulT3zt6BePKjLrKEgmYPxQII+4jQRgLa2HXmwggZN1/sv5WIhv5GIgdKg8VznjnWt37HFiPy0FpfCri+aZQkqkfDxpatYiib7ATa4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKd4ROc5ZNHr8+Zx3H4YoWrv96nwYur3MeUxTo0dL4o=;
 b=DwY66pi/7fo/h7E8+n/H/jt9DyFZyHbmwJ17wKzIsrptgvfiBbUooibbwxi4K8HKXtkTR3xDFpzxq/BrlU1A6c8O1vm5Db4piEVIrVcNz0oWGzFJ/mThgeiHu9C74O9E3QAGxrVL/ZcWdalPtW3Sh9SrZXE9B3P8Oxgwf9rEvsbvglTFXELkzF2uLvvd/9gEMFRZQxXuY+oH0rEbXw867syqXzSW0PIrJqe7NigvuQZRvIXE56eMQCWJO7p0GKF79DQzRDTzwQbPo0UMaXIw8X2Ad+R3wvlC64WhfbY69yHcEAQd3bqYOc4DVheERq+GIW6MZCD2mC8jYXQYZCkSfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKd4ROc5ZNHr8+Zx3H4YoWrv96nwYur3MeUxTo0dL4o=;
 b=RjjWAsnapSBuZdHEN19/eBd08gEKNWEJBLhV2kfDMYTxm6/VqLkJWPcMDrUAvlMAOtuWfqSbBESKTeEL7UUAhy1eBFNRXSrKd98IDd1P7Q8J2TVyHjVpZRznVuRD08FK26IrOA0nfK6eLdaJrozDpzS4i6w8sZNjm5rQ0ZRLzHs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1187.namprd12.prod.outlook.com (2603:10b6:404:1b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 23 Jun
 2021 19:20:37 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4242.025; Wed, 23 Jun 2021
 19:20:36 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, Smita.KoralahalliChannabasappa@amd.com,
        Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org
Subject: [PATCH v2 02/31] x86/amd_nb, EDAC/amd64: Move DF Indirect Read to AMD64 EDAC
Date:   Wed, 23 Jun 2021 19:19:33 +0000
Message-Id: <20210623192002.3671647-3-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210623192002.3671647-1-yazen.ghannam@amd.com>
References: <20210623192002.3671647-1-yazen.ghannam@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.184.1]
X-ClientProxiedBy: BLAPR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:208:32a::22) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-ethanolx.amd.com (165.204.184.1) by BLAPR03CA0107.namprd03.prod.outlook.com (2603:10b6:208:32a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Wed, 23 Jun 2021 19:20:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e14d03bf-5fa1-49c7-da3d-08d9367bfad4
X-MS-TrafficTypeDiagnostic: BN6PR12MB1187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1187D8AB459DE52A5EDD36EFF8089@BN6PR12MB1187.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RKzo+fN8t++iwsUnAZ7i7vhrZc4iW7hrNmhHQtTMIsdCVWxlfkHvBcK+eUpwXt9FWrGXPnyGAtQ39yuXHnv3E5zjIdKJcGN9T92bHaSJfUh4dk4Bwg8Jlipuj8PY6c17ArnYdH+1ua04MRQKEziR3FMX37HaEmD0eqVuYv9FDKM+tSXk6eqYaL8OfnaVW3byv0Ok5IgAYTGeRH0IoLgivvnjdEcyndTQB3S90QCDRGBQgXGXj3aKC6EgSVYDzOHIUMr/Bv91DsrXssHQLAgJELOOfoRC4klCm/esh1pgFMcDKMxn3hC4/MnKOBjPc5OU9ES1yFuqv25AUoey7Utb0vDdD6Nkz3tOK37nzWcnA7Xjw1eNCQdvfQ78ko+bsXZDzMrsAGYDDbc2RP0yqPDaMTwzq7Ho3xzADXcHFdasWARk5q3+b/hoyfv0WfJeZM/WICN5/jtUWvVC/TTjByTRUDqCCXfZsV93kFa8pAoie1rC2u6zAMsbCYg2/tKbWZ+0svFjVuuOBOC1SJaOp3O/rvVP81nc+A1yCD7ZowbKY2jz5/941BT4FnSx2PuDI8TSamvq0l/3a8bH7JwpPZ1taIRAEdulaowPIlNT0WhBdNPb5x4iEhdhJUtkKcg2DN+CuP9uZT+4xEHPKkD/VjTi9ZaORgkSG2ZpVp7OcVYYXLXVAq2tYWR2twZe/56muh67fMTeOVNm+PxWLQC/CmWYaeMoKuD71kX/YKeAnEfZox4P3xjH04/rOar262HE/mWC4tvVAh1GaELbTlYgs5PsbhzHCavOy6jPvtaKCsnpAvh1nz6e+505Ec6rbF8yBJ/6Kio7/ZX4DQJ5COqQAufCUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(966005)(36756003)(38350700002)(38100700002)(44832011)(83380400001)(6916009)(26005)(7696005)(5660300002)(186003)(16526019)(66946007)(6486002)(4326008)(52116002)(8676002)(478600001)(6666004)(1076003)(2906002)(86362001)(66476007)(2616005)(66556008)(8936002)(316002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WQy3b52S+gUaAnNOH/h4F7yWi7D8wNY0ytlzF3W2IdXVRXsryyRlk/dbAL5t?=
 =?us-ascii?Q?ILVAFezeg8bUaem4AXuke7CSQLZ1NbiSfZJ1F9RlP2BNJu4su4C2pyC36uxf?=
 =?us-ascii?Q?HfR63fySLzRRGW7du0kfQg/hIN74Typomn4etrobf7atgRdecKYN/+LXQYoi?=
 =?us-ascii?Q?9vG03wxX/IZJs7+dEIFDlJxmIJFTtZyKqv4CeKqaaaJjDeFROi/LxOBFtTem?=
 =?us-ascii?Q?SseL0TPJtX66Byz3uEo+vupk+zN0ik/jN4MVYEfWoihpeRq2nL1ydr1YkoNX?=
 =?us-ascii?Q?L47NIlGO0VbS0bs+Yytp70cO7hofVxvX6nnG28ynlQlOmaGZxgXEt9y8FRcJ?=
 =?us-ascii?Q?PKXitxI0k8TtZ2CEYF+d0mfoOEN3yuQMu1kToAQQYHy1s2VLuFDEjtwYqZwF?=
 =?us-ascii?Q?ttKaNyJvtt2uuzZyd6Hs/ZnWpVzWO4m9/dsvfXqEE80Q10olUTaaMbkio8g1?=
 =?us-ascii?Q?t6uCQkSNievyk5cVKlNrFE4tFXxUlTyl5mtgTuLE1jo9FEqxtE/dq6EigPzc?=
 =?us-ascii?Q?IKeyGZSHoqBBe9QzGyfcodEsYwP6Up38DtCt9Kxqh4vHRaZAzAcclz7i8hcS?=
 =?us-ascii?Q?VR54AINu+FBWM2h+kO75C+/OeIXF2TyAr+sgzqGaNZHxF5JJAaq82qrs6a8t?=
 =?us-ascii?Q?r/wmudZWsqYgVdJKsCUAnf3Qcf5KW7WNVqa91nKhAzht4jP9aP5LOUYw4unC?=
 =?us-ascii?Q?MfXKI0m8HvwZthe43WrEM5s7wseK+igWORrEr5WmXX5Z4YM8fDQbOzvxZmym?=
 =?us-ascii?Q?uGWdCjR9cWbldOY5I7IGg9p4kdO+vL36jT7nFkhjhony2bBYzOmwbTNSfyTv?=
 =?us-ascii?Q?uOCCuwnATsQ8PXm8dWlkfs8TNihrxj6RxNRDNcvkMaTNYAXP2ZSQ8r3eNaoJ?=
 =?us-ascii?Q?liOGYQrJ9ykOwCjURJgKj3upCYxBW8eyuBdndT8zQ6467F6iXaPaTGjG5aBf?=
 =?us-ascii?Q?WgutcWMAlOkNEV2JpHXh5/zUKmUlSfS8HyQeDKNzPZJKdJCl8+bs8Bdvhtxf?=
 =?us-ascii?Q?7GDPAEjEB/PGNx7RPx4Qc4PQCcPLqgSwtRhoImiTNRtFG5jOpySnaEzeAPpx?=
 =?us-ascii?Q?FOekjB8IZcOl/V49jef0i0zriaTkuZYAGu8NRXtFY6dfiwW6tMwBGLzedea7?=
 =?us-ascii?Q?WJaIgUuo8IDwSXjXT+3Rw4IilR4deg/V2qnopsjXp5G+w387NwOysYBRaVnq?=
 =?us-ascii?Q?CNRxeBKkMUpZO//qi1s4QA+Mpp78D16gH1jI5VGC+ChpTEmjYhFdZjda2vU7?=
 =?us-ascii?Q?mCP2FTn36QGxU5A0jMXNiMxHJc6n7pHYn+1SIkot3qn9RN9dQ5hy7RLtK5jB?=
 =?us-ascii?Q?H29GfIro8qqkSMPAKKHfp2lU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e14d03bf-5fa1-49c7-da3d-08d9367bfad4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 19:20:36.8225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NTdCxOee/ypNsIRmbwJ0opmcbC7Il57OHTrEAiIaAWiFPTSW1P0Ci/MRzKHtWJISYKExeYao2xm3rnBv5jk8PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1187
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The df_indirect_read() function is only used for address translation.
Move this to EDAC along with the translation code.

Cc: <x86@kernel.org>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/YKJoICQzD/o7ZPBp@zn.tnic

v1->v2:
* New in v2.

 arch/x86/include/asm/amd_nb.h |  1 -
 arch/x86/kernel/amd_nb.c      | 50 +----------------------------------
 drivers/edac/amd64_edac.c     | 50 +++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 50 deletions(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index 455066a06f60..00d1a400b7a1 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -24,7 +24,6 @@ extern int amd_set_subcaches(int, unsigned long);
 
 extern int amd_smn_read(u16 node, u32 address, u32 *value);
 extern int amd_smn_write(u16 node, u32 address, u32 value);
-extern int amd_df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32 *lo);
 
 struct amd_l3_cache {
 	unsigned indices;
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 23dda362dc0f..5884dfa619ff 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -27,7 +27,7 @@
 #define PCI_DEVICE_ID_AMD_19H_DF_F4	0x1654
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
 
-/* Protect the PCI config register pairs used for SMN and DF indirect access. */
+/* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
 
 static u32 *flush_words;
@@ -177,54 +177,6 @@ int amd_smn_write(u16 node, u32 address, u32 value)
 }
 EXPORT_SYMBOL_GPL(amd_smn_write);
 
-/*
- * Data Fabric Indirect Access uses FICAA/FICAD.
- *
- * Fabric Indirect Configuration Access Address (FICAA): Constructed based
- * on the device's Instance Id and the PCI function and register offset of
- * the desired register.
- *
- * Fabric Indirect Configuration Access Data (FICAD): There are FICAD LO
- * and FICAD HI registers but so far we only need the LO register.
- */
-int amd_df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32 *lo)
-{
-	struct pci_dev *F4;
-	u32 ficaa;
-	int err = -ENODEV;
-
-	if (node >= amd_northbridges.num)
-		goto out;
-
-	F4 = node_to_amd_nb(node)->link;
-	if (!F4)
-		goto out;
-
-	ficaa  = 1;
-	ficaa |= reg & 0x3FC;
-	ficaa |= (func & 0x7) << 11;
-	ficaa |= instance_id << 16;
-
-	mutex_lock(&smn_mutex);
-
-	err = pci_write_config_dword(F4, 0x5C, ficaa);
-	if (err) {
-		pr_warn("Error writing DF Indirect FICAA, FICAA=0x%x\n", ficaa);
-		goto out_unlock;
-	}
-
-	err = pci_read_config_dword(F4, 0x98, lo);
-	if (err)
-		pr_warn("Error reading DF Indirect FICAD LO, FICAA=0x%x.\n", ficaa);
-
-out_unlock:
-	mutex_unlock(&smn_mutex);
-
-out:
-	return err;
-}
-EXPORT_SYMBOL_GPL(amd_df_indirect_read);
-
 int amd_cache_northbridges(void)
 {
 	const struct pci_device_id *misc_ids = amd_nb_misc_ids;
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 046b98fcc4fe..e9342d7d693f 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -993,6 +993,56 @@ static int sys_addr_to_csrow(struct mem_ctl_info *mci, u64 sys_addr)
 	return csrow;
 }
 
+/* Protect the PCI config register pairs used for DF indirect access. */
+static DEFINE_MUTEX(df_indirect_mutex);
+
+/*
+ * Data Fabric Indirect Access uses FICAA/FICAD.
+ *
+ * Fabric Indirect Configuration Access Address (FICAA): Constructed based
+ * on the device's Instance Id and the PCI function and register offset of
+ * the desired register.
+ *
+ * Fabric Indirect Configuration Access Data (FICAD): There are FICAD LO
+ * and FICAD HI registers but so far we only need the LO register.
+ */
+static int amd_df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32 *lo)
+{
+	struct pci_dev *F4;
+	u32 ficaa;
+	int err = -ENODEV;
+
+	if (node >= amd_nb_num())
+		goto out;
+
+	F4 = node_to_amd_nb(node)->link;
+	if (!F4)
+		goto out;
+
+	ficaa  = 1;
+	ficaa |= reg & 0x3FC;
+	ficaa |= (func & 0x7) << 11;
+	ficaa |= instance_id << 16;
+
+	mutex_lock(&df_indirect_mutex);
+
+	err = pci_write_config_dword(F4, 0x5C, ficaa);
+	if (err) {
+		pr_warn("Error writing DF Indirect FICAA, FICAA=0x%x\n", ficaa);
+		goto out_unlock;
+	}
+
+	err = pci_read_config_dword(F4, 0x98, lo);
+	if (err)
+		pr_warn("Error reading DF Indirect FICAD LO, FICAA=0x%x.\n", ficaa);
+
+out_unlock:
+	mutex_unlock(&df_indirect_mutex);
+
+out:
+	return err;
+}
+
 static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 {
 	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
-- 
2.25.1

