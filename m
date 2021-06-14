Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3814A3A7123
	for <lists+linux-edac@lfdr.de>; Mon, 14 Jun 2021 23:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbhFNVXu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Jun 2021 17:23:50 -0400
Received: from mail-mw2nam12on2087.outbound.protection.outlook.com ([40.107.244.87]:53473
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234397AbhFNVXt (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 14 Jun 2021 17:23:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzxpDb4PBP/62KtWnFhbtDBlWNwVWgYAYPjWNg5i5fiPuiGObd98sUTr4kDxw5FK7ZaNoVkYd+e8M9BW9m6STo0X0oe25zBAMDuf8hug59ZVNRWIF+b8q/f6sJufS4d1BGeUZhr4Mdevv7d5RXIbhLz8Cq6t/fOj3r7aDXWXxBKfrusTtKyx5mNIjvk3g9pWwCxxCKNBMiVVBYGHyz67nmRJInfcw4iAwdJluie/iYzdjIenyayz6XzDFr/QH4//oiyRv920ziX8cKaU2OpvqXu27J8Lo2MOxfKx0Q4nPcql9cHCOFm/wp/kSfBeil83fXcxcad7HLfui0pzvL3p+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLC7XkH7zKA/gzvQENAfyU0qM1jY9yXmi+1PyGaYn+s=;
 b=iD6W0lKnrmcWNgki8Z4o994im624JTRJslsJHBKNwMKka3+qmZ/UCC+8IZapuSghhWuVxbU9EPG1ojcsfLY1irXc0eeakGuQo8qFc3WIPa04Wl52Y9vSkQExTAqzCKuZDOOpt6f+V/CaA2OW5c5m3zmPBeE+4mCSZd1J+RMvDlQ9FYNyrhVwWOKf5u+bSF/pRpf+WJd5vG4eRUhSq/n0vjGOGW4Bs8BmkNjWF9VOoxcEkcptUVVO79DW/MDQsVug82+RXGZzmD2HZ/w56Dhz9ZQlab3w9pPi+gcshAblCBAFwadZCi0ImXCLZm6Ua1q67hvquLVKY7gXYXq04Rb9Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLC7XkH7zKA/gzvQENAfyU0qM1jY9yXmi+1PyGaYn+s=;
 b=WObb+NlaP7bBwUr1KpfPG13+M+6DEoLWtGyHPKPK6pSYTPSn44GftsWcuL3PNFfu1hmqzFx3gtRnP8kcpPH4DXOVpirP5lqEArYUpcXQKQZCPB8lQArzmIbdn4rPp2mfypVjYOdqkEd2vE/cRghvcRW0tpcSK0jaYTjBNuEFJfw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SA0PR12MB4559.namprd12.prod.outlook.com (2603:10b6:806:9e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Mon, 14 Jun
 2021 21:21:45 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::c8f:eff7:df51:c837]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::c8f:eff7:df51:c837%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 21:21:45 +0000
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org
Cc:     Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>, yazen.ghannam@amd.com,
        Robert Richter <rric@kernel.org>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH] EDAC/mce_amd: Reduce unnecessary spew in dmesg if SMCA feature bit is not exposed
Date:   Mon, 14 Jun 2021 16:21:29 -0500
Message-Id: <20210614212129.227698-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [165.204.184.1]
X-ClientProxiedBy: BN9PR03CA0931.namprd03.prod.outlook.com
 (2603:10b6:408:108::6) To SN6PR12MB2685.namprd12.prod.outlook.com
 (2603:10b6:805:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx50f7host.amd.com (165.204.184.1) by BN9PR03CA0931.namprd03.prod.outlook.com (2603:10b6:408:108::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Mon, 14 Jun 2021 21:21:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d40569d4-bf94-499b-32c1-08d92f7a693c
X-MS-TrafficTypeDiagnostic: SA0PR12MB4559:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB45596A9C44A7861B160EA7AB90319@SA0PR12MB4559.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1BvMmtlpv/zrNbvhU8nKL5wWfE9q30cP8jo4J3sI1zpCo7FuL2UdlkxXg/vBEX+LScJUQBYN8xi3R1zWiyGFeKMHlPdm6QG5okq4/+9eobY9rQZvxcMxKbxNfbmh2OnKQ4iDNFBuQbNVP2zWx0rQMJ1hc23hMpvQquseZKYYxUGo1UJ8c5Qwwii6LakpiQdro6QCOteEDKrdmYVRRB61lzoUfgoTBSu2k+TAoO9Qkq6YKQy8CLFCPGcXI6afqfJZNK8x3afZf/1vECrs46mnw1ptBIyGJkZ5Pi1kg5rVN+V7w/SUNHkuJ65Wf/54vgNRyC9KNAiO3Cd3eGzrsRRn3ZGClTu1sOfch4uBmkD28XZ2TzYttHcpZZyYwZnaOxWIX7kkgPcaFDxnfUHOnGqANG+zXaaixGdIVf4cEFvg8v6aklC9SyBcgQJUx/KwrWOFRVHdEFr4hcUroEcJkfieNU7/92b6H25WjolqSY3fgOsBNkEpaXEiZA5+DmpM4DwldWXjMhqnfooeGkkl7uTYcSANvza2JFAl+jnhipumzNHntqG64w04pWjenC0zajSdbSpzEsex3vkUBWu3DfoCJ3N0NwKPJSlhGXS/fFyIlU2LjwLh5LNq2eu4jq2W+mEvIpZthwOKZNZkgOP8gwVweQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(4326008)(83380400001)(8676002)(86362001)(6666004)(2616005)(956004)(478600001)(316002)(36756003)(5660300002)(66476007)(6486002)(8936002)(26005)(38100700002)(1076003)(52116002)(66946007)(186003)(38350700002)(16526019)(66556008)(54906003)(7696005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cgNdnNALooQbkvhgrCpsOTZe1wgtUb0R8CJxRZGDH7k19G/eTlQR+QxUBN5C?=
 =?us-ascii?Q?PCy28b3hKdD8tRH3ly3CiATLXqVqUmVrvd/bOfwdQ2SlgsRDlWLUXrj+cKFk?=
 =?us-ascii?Q?AfSu/rJ3w+UpcOl1su4Q1zaeEOrjrAkMCOr2Enwl7tGFxUS6ihLgWrBxRN5r?=
 =?us-ascii?Q?TKQtnsmYu2IAy6gPAJCPg4ZwFLIPrg1jejP0jJnskDmCK3AsYxU5pw9xi9S3?=
 =?us-ascii?Q?o2RQI7538p2yvGmUt2KPkKglOsOQ7eAx3FZJFxJYCZoWT4QnwtEMSr1Og8DQ?=
 =?us-ascii?Q?KqIZDCaFYGXbHc+5w/hOxVS3Z//B7eFCaGM92lGRoPRcAaFbZLGXkyIPcI1g?=
 =?us-ascii?Q?ZbsYhAh/yrmDuO6+r9Mki2z/3QHCJtFPtMsEBBRz6ko7XFj5kIzaKuSAynxu?=
 =?us-ascii?Q?F0931eKtJjDZu9Tof8DPk+7w9L/l7fmLodKW9PYEng1UyrwbOAIFGbB8TRp/?=
 =?us-ascii?Q?OJdErJH3LvYXxjHwxe6ocG1CQ5abCFD5poRFvaa1k+Oa2oyojnw5s4CfdQwf?=
 =?us-ascii?Q?2chc0bY8MTEMAX/Emkbbr/ETomMKGfWMIY981qpBWXmZ4HCX9nwojtlHjdas?=
 =?us-ascii?Q?AiZDV0NRTwPfVuRS5haAH3ZLUdh5xJNsONHEEliYBGlkiTekwUKZ2G8zpH4o?=
 =?us-ascii?Q?LwpV++wM0vXJdY1iMEmTHRErUz8qfAS0NJhOBVWhT+YJoVrypH3KzyRIGCQq?=
 =?us-ascii?Q?ZgRDHoKLlQg9cBzKumUZVjPG4Yh6qA3LJH9Kf4e/LNJ0xpF/0/pUr9Uf7ltZ?=
 =?us-ascii?Q?mPwY2EUIjg9hsUcMmGDs0v+WUllpx3Y3+36aOM9Vwvkgp0PtYg2iNTjyc3YD?=
 =?us-ascii?Q?AeGG3dovIu1XU2BCk0N1OSSiPRwYktr6ac91NTTAG71kbN2iU+SWOwLQs6Ym?=
 =?us-ascii?Q?k0KN/3A9oK+sdNfETt431BOhCnWWRBcpRJDDaoiWx6RNctAUm7ZVya9tmQOX?=
 =?us-ascii?Q?FT1aT/RK7yl9D502PhQhocw5kSGS/qLBULl9IvFQASLsIcVZ8VUP5CWihKV8?=
 =?us-ascii?Q?Hvyh6hbJZ04ZCyMt6zM/vygfuQTSHhgVByU2KwgQJQakbQxTKrWTsCjCSWOT?=
 =?us-ascii?Q?J0PSypVGRg3EhMRntT6A7L1lvRygoQmN219xDK37ln1/ZItp/7atbxWMNGy5?=
 =?us-ascii?Q?jBDIFB5i6HKvDtDSN3sN8/8bzUjUpIm06zl6CYJ74NiGWfqaVpDOIYqYIhO4?=
 =?us-ascii?Q?W+ZnEZv/SclAhTGZPuF+M1RMy43gfLo+OsOGssYEjGC3bsSh9bHu4HnZY60m?=
 =?us-ascii?Q?iOMhmXlr0yALAv4MXFvdVT21BpqlbK2mUAa0tvjYigC9k/2cXUjnh9SIhQOo?=
 =?us-ascii?Q?aPg+r5dPx4sM4GuiOYn+hI8K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d40569d4-bf94-499b-32c1-08d92f7a693c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 21:21:44.9263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWqg21vnQjlI2YvPd/S3lLYLJAKkwcwSh+MAtmXJK3c4Jte1MqIuTnr7jXy/hQmLz09RyyVqrqQWc2ZeeM6poA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4559
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The SMCA feature bit is not exposed on the guest.

This causes a lot of noise in dmesg as the warning is printed for each
logical CPU.

$ dmesg |grep -i family

[    0.031000] smpboot: CPU0: AMD EPYC-Milan Processor (family: 0x19, model: 0x1, stepping: 0x1)
[    4.653422] Huh? What family is it: 0x19?!
[    4.720732] Huh? What family is it: 0x19?!
[    6.171028] Huh? What family is it: 0x19?!
[    6.766552] Huh? What family is it: 0x19?!
[    6.811119] Huh? What family is it: 0x19?!
[    6.839855] Huh? What family is it: 0x19?!

Give these messages debug severity and output once as it is mostly useful
for module developers and just noise for users.

Rephrase the statement to make it more meaningful.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/edac/mce_amd.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 5dd905a3f30c..2a9899088389 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1227,13 +1227,9 @@ static int __init mce_amd_init(void)
 		fam_ops.mc2_mce = f16h_mc2_mce;
 		break;
 
-	case 0x17:
-	case 0x18:
-		pr_warn_once("Decoding supported only on Scalable MCA processors.\n");
-		return -EINVAL;
-
 	default:
-		printk(KERN_WARNING "Huh? What family is it: 0x%x?!\n", c->x86);
+		pr_debug_once("MCE decoding is not supported for family: 0x%x\n",
+			      c->x86);
 		return -EINVAL;
 	}
 
-- 
2.17.1

