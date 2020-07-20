Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DE322629A
	for <lists+linux-edac@lfdr.de>; Mon, 20 Jul 2020 16:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgGTOyW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 20 Jul 2020 10:54:22 -0400
Received: from mail-dm6nam11on2060.outbound.protection.outlook.com ([40.107.223.60]:31968
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726506AbgGTOyW (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 20 Jul 2020 10:54:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOx+Mma0ZYFfoEivpZGCgUhu9pScgZPRzp/pbtNZmXIDTzhDiJqxN2r5bs7EHV+n74I915rIU2ILZbuQ+f8MfnLhOqes2TGXbfMTKnsKHWsTGmAFrO74tcznjl2xlFjOHTylCtIvsnUhXdbwoqrbtkErkpSWR+fylZdY40qVWMKtG2AwDP/VpcfkZELRGFwb60AeiXxQE0agknQKUISmHJU7vF1VPnQ9dh7ohI4/zhzh1pOKwe1naftOYJyBu1+CB98P+JEPnNvymGtWdWPStGYnD5vwQp9hQh2pgrFLTnwya/pdJK0fdh6v67UaTkEklyNIo1vSVqMATUV+dx6giA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjU8PpD7hyEeZno32tCNTpe+j9vb6MvJkyN4LKcFvX4=;
 b=Kn9OcNWinuAcdEaQz/Q4kVcspij12VMNdd32bbn+zCvUir0VVT+NdHMQ+d596uJMbGg8D1soIz7cLK2X+2pwP2+19IKNENmJ4U4mveSXHcgG+wj2dwTgMX5zvH/lw103MFBZXaGxI2TYzI5559qF+jacZ3s4YvN1rbpQ097xdqNf7OQo7tqIICPQGIhzFh4SfEdWvLWJeaBKRqfQ5vaxv/0SKs9tAI/zisPrT8tH3xYrk7zjmjJHRI34Eac/fmBVmVmuTWmELMmf9IFi0DOX1vx7qNIdw+cg4hVjPMPV2BHs6ahZc7pbSrl041PFudaHWQYz191mHWk4eHR4flB8MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjU8PpD7hyEeZno32tCNTpe+j9vb6MvJkyN4LKcFvX4=;
 b=jggOOACIrbY9fGKII9cVE7u/rlcGEW+M1OYGPNG7AlAWC5VKwhw91zvGDGchRcyT0UKcGpyUCRBEpwUiZq3BIyBglWLlWSkL4Tv9zdTdxkZaR2xW4dry1Imvt5FoYQwiDR0bNegnHLbl5lCvrUD4lCW/YEaKf2qP58cR94i1rLk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3364.namprd12.prod.outlook.com (2603:10b6:408:40::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Mon, 20 Jul
 2020 14:54:18 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::102c:8939:bf0a:bced]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::102c:8939:bf0a:bced%5]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 14:54:18 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, bp@suse.de, tony.luck@intel.com,
        x86@kernel.org
Subject: [PATCH] x86/MCE/AMD, EDAC/mce_amd: Remove struct smca_hwid.xec_bitmap
Date:   Mon, 20 Jul 2020 14:53:53 +0000
Message-Id: <20200720145353.43924-1-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0103.namprd05.prod.outlook.com
 (2603:10b6:803:42::20) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-ethanolx.amd.com (165.204.78.2) by SN4PR0501CA0103.namprd05.prod.outlook.com (2603:10b6:803:42::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.14 via Frontend Transport; Mon, 20 Jul 2020 14:54:17 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 093dfc0c-0611-49b3-51a5-08d82cbcc6f5
X-MS-TrafficTypeDiagnostic: BN8PR12MB3364:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3364BAA4D01CFA5C8BAA8941F87B0@BN8PR12MB3364.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RbQx5pMk6IGE40bKke/htwdIluA36T36b/hW6fgQkIjEobma3ZpST+5H1d28Lcpot438QlFMqnBv/WesYJQiothJx0YnPhPOMEoNdRrGThCqoKF6PXucb4NKUU0qyh1sz5NydcLLqBkDu2TKgaSn6/WwEmHT9enEwyX64zMeA9+It4r/siFZ3lunRZpdAEnUxtSZ5O1wNceg84foy4JWOe9VlqiQpqEZb9+epFl2KXgbWWJPkf9yc06g/Lb8oikelFNjWgPNBgUOXKaE0Be+i6QFNGcAdJGYu2gOPOkTVeCGQWvvjPEPB6YOCWcT6QL2QeJTAMXTIBdyhRGNFUjTgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(6666004)(66476007)(66556008)(4326008)(8676002)(478600001)(86362001)(2906002)(1076003)(66946007)(6486002)(26005)(316002)(52116002)(7696005)(2616005)(956004)(83380400001)(16526019)(5660300002)(6916009)(186003)(36756003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: t/7y2MTjJcSPeThWIruWFAZzpN5yYhe78FTTT1lxsIHSmrsDV1+i889ddOiNN1V3OfPVsZ1t/bn9L20lfIGcahLMNZYgjy4hba2uYBuPttIk9rJw0Z2BXZ0lph5HQO+BVBqoezjR/VwVVlC9IOakt44A3kImePTyUjMf0PKM8wWfG1DrB7WTKqLzRKkCO/Wyrf9vzpHTibYafE/FEK8MIJlvRarnLgkY0Wr08lUuv1hzNu+XF14dqfWMBj236xWMUfuSkTLzylMSFy+KQdZbWYCziXyRDgHRABFHyN2F543ARRS4dEKNMpi+gaVRepsQQvsdETVyeONtNr2XE2D+BtTOk384E14F+fQC12iyWxcQwghDglotvS0nOWMcTHvWG5cMiIb9agwKtdChdJO9fLWI74jg/ZhHWnfKs7b799xVyoFeeGQfdOuNAF9X0tHMWYP/4rSZC+a+YTB1ygXlarc4EdaPRueagqM8jQm01FA=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 093dfc0c-0611-49b3-51a5-08d82cbcc6f5
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 14:54:17.9463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CItIXMYjhNkrRTavyGcUhV5IexjaSvuV97MbyxD0G8Wyb9C/S1uIn4yAztmmRpAzfX6FfPKYS+wxk3nHilq+mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3364
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

The Extended Error Code Bitmap (xec_bitmap) for a Scalable MCA bank type
was intended to be used by the kernel to filter out invalid error codes
on a system. However, this is unnecessary because the hardware will only
report valid error codes.

Remove the xec_bitmap field and all references to it.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h    |  1 -
 arch/x86/kernel/cpu/mce/amd.c | 44 +++++++++++++++++------------------
 drivers/edac/mce_amd.c        |  4 +---
 3 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 734ffe78a3d6..c18e87aeeccc 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -327,7 +327,6 @@ enum smca_bank_types {
 struct smca_hwid {
 	unsigned int bank_type;	/* Use with smca_bank_types for easy indexing. */
 	u32 hwid_mcatype;	/* (hwid,mcatype) tuple */
-	u32 xec_bitmap;		/* Bitmap of valid ExtErrorCodes; current max is 21. */
 	u8 count;		/* Number of instances. */
 };
 
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 327b85304cdd..a578df70768b 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -132,49 +132,49 @@ static enum smca_bank_types smca_get_bank_type(unsigned int bank)
 }
 
 static struct smca_hwid smca_hwid_mcatypes[] = {
-	/* { bank_type, hwid_mcatype, xec_bitmap } */
+	/* { bank_type, hwid_mcatype } */
 
 	/* Reserved type */
-	{ SMCA_RESERVED, HWID_MCATYPE(0x00, 0x0), 0x0 },
+	{ SMCA_RESERVED, HWID_MCATYPE(0x00, 0x0)	},
 
 	/* ZN Core (HWID=0xB0) MCA types */
-	{ SMCA_LS,	 HWID_MCATYPE(0xB0, 0x0), 0x1FFFFF },
-	{ SMCA_LS_V2,	 HWID_MCATYPE(0xB0, 0x10), 0xFFFFFF },
-	{ SMCA_IF,	 HWID_MCATYPE(0xB0, 0x1), 0x3FFF },
-	{ SMCA_L2_CACHE, HWID_MCATYPE(0xB0, 0x2), 0xF },
-	{ SMCA_DE,	 HWID_MCATYPE(0xB0, 0x3), 0x1FF },
+	{ SMCA_LS,	 HWID_MCATYPE(0xB0, 0x0)	},
+	{ SMCA_LS_V2,	 HWID_MCATYPE(0xB0, 0x10)	},
+	{ SMCA_IF,	 HWID_MCATYPE(0xB0, 0x1)	},
+	{ SMCA_L2_CACHE, HWID_MCATYPE(0xB0, 0x2)	},
+	{ SMCA_DE,	 HWID_MCATYPE(0xB0, 0x3)	},
 	/* HWID 0xB0 MCATYPE 0x4 is Reserved */
-	{ SMCA_EX,	 HWID_MCATYPE(0xB0, 0x5), 0xFFF },
-	{ SMCA_FP,	 HWID_MCATYPE(0xB0, 0x6), 0x7F },
-	{ SMCA_L3_CACHE, HWID_MCATYPE(0xB0, 0x7), 0xFF },
+	{ SMCA_EX,	 HWID_MCATYPE(0xB0, 0x5)	},
+	{ SMCA_FP,	 HWID_MCATYPE(0xB0, 0x6)	},
+	{ SMCA_L3_CACHE, HWID_MCATYPE(0xB0, 0x7)	},
 
 	/* Data Fabric MCA types */
-	{ SMCA_CS,	 HWID_MCATYPE(0x2E, 0x0), 0x1FF },
-	{ SMCA_PIE,	 HWID_MCATYPE(0x2E, 0x1), 0x1F },
-	{ SMCA_CS_V2,	 HWID_MCATYPE(0x2E, 0x2), 0x3FFF },
+	{ SMCA_CS,	 HWID_MCATYPE(0x2E, 0x0)	},
+	{ SMCA_PIE,	 HWID_MCATYPE(0x2E, 0x1)	},
+	{ SMCA_CS_V2,	 HWID_MCATYPE(0x2E, 0x2)	},
 
 	/* Unified Memory Controller MCA type */
-	{ SMCA_UMC,	 HWID_MCATYPE(0x96, 0x0), 0xFF },
+	{ SMCA_UMC,	 HWID_MCATYPE(0x96, 0x0)	},
 
 	/* Parameter Block MCA type */
-	{ SMCA_PB,	 HWID_MCATYPE(0x05, 0x0), 0x1 },
+	{ SMCA_PB,	 HWID_MCATYPE(0x05, 0x0)	},
 
 	/* Platform Security Processor MCA type */
-	{ SMCA_PSP,	 HWID_MCATYPE(0xFF, 0x0), 0x1 },
-	{ SMCA_PSP_V2,	 HWID_MCATYPE(0xFF, 0x1), 0x3FFFF },
+	{ SMCA_PSP,	 HWID_MCATYPE(0xFF, 0x0)	},
+	{ SMCA_PSP_V2,	 HWID_MCATYPE(0xFF, 0x1)	},
 
 	/* System Management Unit MCA type */
-	{ SMCA_SMU,	 HWID_MCATYPE(0x01, 0x0), 0x1 },
-	{ SMCA_SMU_V2,	 HWID_MCATYPE(0x01, 0x1), 0x7FF },
+	{ SMCA_SMU,	 HWID_MCATYPE(0x01, 0x0)	},
+	{ SMCA_SMU_V2,	 HWID_MCATYPE(0x01, 0x1)	},
 
 	/* Microprocessor 5 Unit MCA type */
-	{ SMCA_MP5,	 HWID_MCATYPE(0x01, 0x2), 0x3FF },
+	{ SMCA_MP5,	 HWID_MCATYPE(0x01, 0x2)	},
 
 	/* Northbridge IO Unit MCA type */
-	{ SMCA_NBIO,	 HWID_MCATYPE(0x18, 0x0), 0x1F },
+	{ SMCA_NBIO,	 HWID_MCATYPE(0x18, 0x0)	},
 
 	/* PCI Express Unit MCA type */
-	{ SMCA_PCIE,	 HWID_MCATYPE(0x46, 0x0), 0x1F },
+	{ SMCA_PCIE,	 HWID_MCATYPE(0x46, 0x0)	},
 };
 
 struct smca_bank smca_banks[MAX_NR_BANKS];
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 4fd06a3dc6fe..7f28edb070bd 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -999,10 +999,8 @@ static void decode_smca_error(struct mce *m)
 	pr_emerg(HW_ERR "%s Ext. Error Code: %d", ip_name, xec);
 
 	/* Only print the decode of valid error codes */
-	if (xec < smca_mce_descs[bank_type].num_descs &&
-			(hwid->xec_bitmap & BIT_ULL(xec))) {
+	if (xec < smca_mce_descs[bank_type].num_descs)
 		pr_cont(", %s.\n", smca_mce_descs[bank_type].descs[xec]);
-	}
 
 	if (bank_type == SMCA_UMC && xec == 0 && decode_dram_ecc)
 		decode_dram_ecc(cpu_to_node(m->extcpu), m);
-- 
2.25.1

