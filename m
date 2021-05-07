Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFED4376A68
	for <lists+linux-edac@lfdr.de>; Fri,  7 May 2021 21:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhEGTE0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 May 2021 15:04:26 -0400
Received: from mail-dm6nam12on2089.outbound.protection.outlook.com ([40.107.243.89]:47105
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229974AbhEGTEG (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 May 2021 15:04:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcfDV6awkmkMe3riGabMbD0rVRRCJUoPFJZSiORL13AydkTPxDTWUgRHP/LGFKjmNucqfDzmHsu+QSwrIbF3AWd81p1ueW2poAWgbc//GTsmZ8nswsgAaYEjbg0MGpjoMzHO5AY+1KOw0cUHSQImDm8+XSQU5be9+bpuFeIBela0afFjEsg5iSwHjA8uhGRp7Ut1HLfTRUoud6WlZcPunL/3eIwO4bxs2Ap4sP/P1fRJP22BKkWVseyhQ/acn/IwyMgtT19TgeiupymFApVJhf+/oDnyQCXqrnbdSv6/s7gZO0CihfxgngARXFTJBisbbWifDxOTnm+i3PLijiXjFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTr+MFu4VJMH4jAq6oc8vtkeBcqpi41NHAu5uHEtAXc=;
 b=XREXP1MZRHEcG3igM/PkeGzI0Mkp5a3aOS0Y1ysVYqvemmRrWcM8fDwAVHIoLZRXWOzyXehNePgzxT6uw1E52uQH2Iob3bTpo7OJzHd35DCmLiLxf/VHSE8gwB8s3XvHmT5Q41W5wtzD0DmRFhZBs9TVPvfVSPx0yhsayyS/Ex4t9UiSEbGpckx9m3Wyi1MUrfC2cZNNq+FuwfFZhb0h72M8UCRaL0L4GdK0fqn4QzkfhVGwnGOt1f+Z1VM3A7+6GqsaTI0EyZpBcJGcfLg6FmIEo5eNonXCyqu9GMWaCfXriczzBy9PeZoGO+EosjlYqvfhfB1nJAQnqjTJC0wRqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTr+MFu4VJMH4jAq6oc8vtkeBcqpi41NHAu5uHEtAXc=;
 b=bXoySGhV0ZrEQms4VRvrZQ/v39TXU+eKSLfiRswdS2i+cDnFSi23gewxhsiLYI1dh4/F8yd2nsSs6lh3hH/yXEhOLjskU4hFQXLGgctOMTacPGaql0Zuz8OCpys0WtWrZ+ljGEinfXwjtftuKgTq4XFyQ+55oO/QC7c3cu6M2Wk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1620.namprd12.prod.outlook.com (2603:10b6:405:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Fri, 7 May
 2021 19:02:14 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211%6]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 19:02:14 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 21/25] x86/MCE/AMD: Define function to get CS Fabric ID
Date:   Fri,  7 May 2021 15:01:36 -0400
Message-Id: <20210507190140.18854-22-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210507190140.18854-1-Yazen.Ghannam@amd.com>
References: <20210507190140.18854-1-Yazen.Ghannam@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.25.250]
X-ClientProxiedBy: BN6PR21CA0010.namprd21.prod.outlook.com
 (2603:10b6:404:8e::20) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:404:8e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.3 via Frontend Transport; Fri, 7 May 2021 19:02:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a6bff6b-52f8-46e8-c680-08d9118aa093
X-MS-TrafficTypeDiagnostic: BN6PR12MB1620:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1620E7F57156A491C0807699F8579@BN6PR12MB1620.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dqNp8UhEj3ASkU6nvYxWOc6LBfVvxZA+9lepGi/JqUFRd7n7Y/eQOHjEDIRCUER04+Lv7x6GovdIjM7qZDaeB7nPRhFH8awMDTZGJCmcB09GkUVJhBkz7UO6Pnx2TbbkFIlwCD0/rDNd2onnQnB5COYQ376AyhMGWyJc98cyaBg9uHOnYufJjnQrRBBeWgd1Y0ctqyuwucbi/btkfDkrRyIJc3dmpkgnW0+vG6zF9RbwFmz2yKBFuRusiF7pcgqtPHJpYavcMvIupT0NTzqa4lNT0QqcSshaO4AkNWuxD+pDXoCarQfjeDR5qQNGWCKafnQLZC8S2dODNH+HwP6xTyzRAJ67oL7ePpxnzaxg5g86ahn6h7dTmxM4OV0/6X3S4Y7fcAG8MIN6L2N3UYGzbLyhlzCnLS8MBc7681K01txM8OE5abKlKNfgQKEfGWLoxo8k4wCA5Gv+apqRsBhQ2eVoJGvnuxoyY3IwL5GeOUB2KHaj3fk1WygiTZSHJsiVBxcT3fKEZgXch/IrFsOTOPHKEY9wnzdYaLGcoKXODXhYbl/rvy0sAytcfuLisQA6OUy2tfag0fTZZrOVo6E+rqfyjBQR4tbdgaF+bErpKFdeOQ+8TKjBHn9GmzjqEbg8NxNhr+mc8ndR0o/OXuvcKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(4326008)(6666004)(38350700002)(38100700002)(66556008)(2906002)(26005)(6486002)(66476007)(1076003)(16526019)(86362001)(6916009)(66946007)(2616005)(956004)(186003)(5660300002)(36756003)(478600001)(316002)(52116002)(7696005)(8676002)(83380400001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1OjUBzZPuAObOMW48ImYqk9tvHF4je+ur7ID0C1CJuIUCzr8D44E7SWnd3HU?=
 =?us-ascii?Q?3MfBy6BIaYT+W46MjlEI3id3QbLXANtBnKbxu6Nzd5ACHKcYrDuUuZU5bfDx?=
 =?us-ascii?Q?KJqjT0QqZB1EGxGdWEkPWFzYr5R+OJt7mBsbHydgNdFS/3V4QK/UAArLW4np?=
 =?us-ascii?Q?1CrY7p2XgPYfkoREWJOudnWo/7NZztYhO/a9IqnBiUeLnyoKkG95cZQBJuCS?=
 =?us-ascii?Q?xHueOit3PSh7VYv81oCUlmlCxSYW0VR69DxADxTmCjNMWMYDZWGcb1eCrrE6?=
 =?us-ascii?Q?Z0HnKzjXgnFKHElS5B+29bss4+feMVf9mBYp7gA5SPk5bpkttS/ntTsfkoXQ?=
 =?us-ascii?Q?/AIoT7p8DGyzSayz53/iVxxXHLWkDVJfnvmvFZLYCbOkb9Di7y1lwp6SK1qU?=
 =?us-ascii?Q?d7l7FM8YNQCi6ql9xaNP7DC/taglKytHFNGPTS92b3IPVVDkgnGZm+157xt5?=
 =?us-ascii?Q?n+hMegnvMIHRFqO5ABhBuT5y+CEoOW40XFZmEXKAEDOpzRCa1hrYqdNaiSl4?=
 =?us-ascii?Q?s0bj7yDCk0NAFJ9uTONdBngcMT4Ju+kdefqxDTL9hEAmqU/iocHA+ieFFJPK?=
 =?us-ascii?Q?higQ0r4iZI06PmZ1zUHYEGI8o4gUJU2xI2g6EKgV0cT6VDrCy8O/HaGFmZeF?=
 =?us-ascii?Q?W86we2ny5oc1zaLVcs281YKhvfV5FxgF0+y2rVHkyUbbbDBBU7KHjEJF6lhJ?=
 =?us-ascii?Q?5vFcyQ95MKZf/6djNLlnXieKtK31GGSKELnF6RoZ7M3DVzPjf5kaRrgMA7a7?=
 =?us-ascii?Q?9pp49g/1sg1Jhtq7DGSNT5pTEbENmdVCMPhuaVnG66trb1b8OVP8DXfj1TCm?=
 =?us-ascii?Q?TQtzHiBfqSD3biiw0y7A1VxsvxrXjRiOjiz3x0RmzwY6luKiRwoUZZmW7+T3?=
 =?us-ascii?Q?lYFsM2fbJ4gDdxYL2Ifo4OR9iWFP2MObiM29Oqeeb3QQ+TSPufKm+nWUznOe?=
 =?us-ascii?Q?2Kv+pPKTTn3bvs8Tl4bJgIX7Sz5XZ/lO7+3qIH4hEnfF0VqMS7le7JhfDQb/?=
 =?us-ascii?Q?yXkSRw7mDp37xsfNQQX0EnuQecLJ4h+6puh6tz8C+4UdNJPRt6eM+cWLSeR+?=
 =?us-ascii?Q?x0dqitKRzOuc/Dba6MiGcEicxm0c3oPMjLuVUfSLhhOFWcT9aLgRQQlKsJwI?=
 =?us-ascii?Q?slNy+IZIVkVAB8ZdDVknPhWzHl7EKEv7jXd4FnyN1J9anWOCgaPrd1G6Z9TN?=
 =?us-ascii?Q?EZC9eWAVwtBPq+zX+MdAgtO5FObwJl5YoHO6bzK5d3HLASrlyggiyFQwXHWX?=
 =?us-ascii?Q?pJOjnmJ1J6YD4zLCIjzsLjBc7x/ElpKSTykhHHCsb9YkK8IgxXgi5j5xUzCm?=
 =?us-ascii?Q?lMNVWyER8eTTScp+UlabdEUz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6bff6b-52f8-46e8-c680-08d9118aa093
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 19:02:14.9292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JdPCpOlR8RPKOvSV5WrHAVGbKiJ5lfew+Gbj42lcbVwHgHzXa5ou7YcHSzM8DJmI+jFJdhwGNJQ/eY5jl0aqww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1620
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Move code that gets the CS Fabric ID into a separate helper function.
This will be expanded for future DF versions.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index b017e4613d8f..6980c5c62f49 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -733,6 +733,7 @@ struct addr_ctx {
 	u8 intlv_num_dies;
 	u8 intlv_num_sockets;
 	u8 cs_id;
+	u8 cs_fabric_id;
 	bool hash_enabled;
 };
 
@@ -892,23 +893,34 @@ static void make_space_for_cs_id(struct addr_ctx *ctx)
 	}
 }
 
+static int get_cs_fabric_id(struct addr_ctx *ctx)
+{
+	u32 tmp;
+
+	if (amd_df_indirect_read(ctx->nid, df_regs[FAB_BLK_INST_INFO_3], ctx->umc, &tmp))
+		return -EINVAL;
+
+	ctx->cs_fabric_id = (tmp >> 8) & 0xFF;
+
+	return 0;
+}
+
 static int calculate_cs_id(struct addr_ctx *ctx)
 {
 	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
-	u8 die_id_bit, sock_id_bit, cs_fabric_id, cs_mask = 0;
+	u8 die_id_bit, sock_id_bit, cs_mask = 0;
 	u32 tmp;
 
-	if (amd_df_indirect_read(ctx->nid, df_regs[FAB_BLK_INST_INFO_3], ctx->umc, &tmp))
+	if (get_cs_fabric_id(ctx))
 		return -EINVAL;
 
-	cs_fabric_id = (tmp >> 8) & 0xFF;
 	die_id_bit   = 0;
 
 	/* If interleaved over more than 1 channel: */
 	if (ctx->intlv_num_chan) {
 		die_id_bit = ctx->intlv_num_chan;
 		cs_mask	   = (1 << die_id_bit) - 1;
-		ctx->cs_id = cs_fabric_id & cs_mask;
+		ctx->cs_id = ctx->cs_fabric_id & cs_mask;
 	}
 
 	sock_id_bit = die_id_bit;
@@ -923,7 +935,7 @@ static int calculate_cs_id(struct addr_ctx *ctx)
 		die_id_shift = (tmp >> 24) & 0xF;
 		die_id_mask  = (tmp >> 8) & 0xFF;
 
-		ctx->cs_id |= ((cs_fabric_id & die_id_mask) >> die_id_shift) << die_id_bit;
+		ctx->cs_id |= ((ctx->cs_fabric_id & die_id_mask) >> die_id_shift) << die_id_bit;
 	}
 
 	/* If interleaved over more than 1 socket: */
@@ -931,7 +943,8 @@ static int calculate_cs_id(struct addr_ctx *ctx)
 		socket_id_shift	= (tmp >> 28) & 0xF;
 		socket_id_mask	= (tmp >> 16) & 0xFF;
 
-		ctx->cs_id |= ((cs_fabric_id & socket_id_mask) >> socket_id_shift) << sock_id_bit;
+		ctx->cs_id |= ((ctx->cs_fabric_id & socket_id_mask)
+				>> socket_id_shift) << sock_id_bit;
 	}
 
 	return 0;
-- 
2.25.1

