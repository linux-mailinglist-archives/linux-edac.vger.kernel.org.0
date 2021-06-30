Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1037A3B8561
	for <lists+linux-edac@lfdr.de>; Wed, 30 Jun 2021 16:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbhF3OxR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 30 Jun 2021 10:53:17 -0400
Received: from mail-bn8nam11on2080.outbound.protection.outlook.com ([40.107.236.80]:52832
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235541AbhF3OxQ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 30 Jun 2021 10:53:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQ/yUWtYjheaKyVWTD1iNikENnAlzRAUcRSjybVo6/2/hminQ12Wh7aJXaRRkoArs9sf4bAujaXO88rr/4HCAVfnU+UJ969T/ljhR/WGRTrUTDiMU+/DXbAi3ivfTMSK75SPNIQVWe1uisueUXABdjgVR8G4NaJ+GE0HtAsDaIg2lVc9r1B2EmpjqGk5rAnJ1vJ2CQV4i6DEe6a0GNAycCu427JkUqTBK8y+z4srIFKDvxy7RoUI0r9hxhUztyE1xL+e2rgsJF/Z1ckLtpr1Q2gme1LwjVKisdXNOY/GDFYqn/A0O4RyNRqAEPW+7SW1MlLN0X+/ZhV0VMXP0BWZmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJeLQOqMsv6pn7dSm7TaRp/szX5zKVy3mGLECHFdzig=;
 b=P212Vx/0pAXNXRgE7wHATUmHfSQJ+1WmHKXaUQpJ55cFFJD/JjZ8ycVDFX9GtVzGFIWTsRZqW+snrZNxjaTp5bfBBKamYqZPKbFxqlHW/BKcFHO/KEGSFMePcIKJkGjG799wjbqvOglwTzvEfeyAT5Y6OjRsK34ZqTGKX3IQ7d8YhByJuMr80j6qyOAjXzfwCH61agWc9Kbh8Cr2ZsTOTGv7hEybDO35TXdMyiuvhe2CPWbEupfOyKocEsX2Pn/1Rk9aWJIbOj7ZqMvGAxBtW9Y4EEjNFMCI4hADKvao19jcOA1Kqw7TMFK/IjCWnK91OseHwK/jjLcN9E9SeiJRvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJeLQOqMsv6pn7dSm7TaRp/szX5zKVy3mGLECHFdzig=;
 b=oi1MIF5af75068VnSc8R8iJCFHrcAecU1TZk05TfpEs8QOuJ5zgf/8EVRWZgQdAuV4ffDA5+QNiZVizyhwe7yakauseF2rVCnwD1acfsALkCpjlFaSrQF/vHoHeVwYAUdVo362IDXwGe/33+oYW8Zpc4HYKeOee2znoYnYPCYYA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 by BL1PR12MB5045.namprd12.prod.outlook.com (2603:10b6:208:310::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Wed, 30 Jun
 2021 14:50:46 +0000
Received: from BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::8ce:4339:7e20:7022]) by BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::8ce:4339:7e20:7022%5]) with mapi id 15.20.4287.023; Wed, 30 Jun 2021
 14:50:46 +0000
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     linux-edac@vger.kernel.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org
Subject: [PATCH 1/7] x86/amd_nb: Add Aldebaran device to PCI IDs
Date:   Wed, 30 Jun 2021 20:58:22 +0530
Message-Id: <20210630152828.162659-2-nchatrad@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210630152828.162659-1-nchatrad@amd.com>
References: <20210630152828.162659-1-nchatrad@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MAXPR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::24) To BL1PR12MB5286.namprd12.prod.outlook.com
 (2603:10b6:208:31d::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from SLES15.amd.com (165.204.156.251) by MAXPR01CA0082.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 14:50:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 338b5eed-3769-4340-1c03-08d93bd67141
X-MS-TrafficTypeDiagnostic: BL1PR12MB5045:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB504547D8DB3645A2D9CE65F7E8019@BL1PR12MB5045.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q1RBSyCh/3h3LVaC5MZAaFZ8RDehKCUJjZc5QB/Rncwqrdi12nSfRuhH4/ogebY0Axx7Meoas6ljNP/4wx4eT0GQEq0W8wmNHnwKELSKNtxidAyqXs7eITHGDlDQm+n0A8TzIhJy4GJR91PT+tfrl99KLpxf4dhoXEwMBTBdlwb4qwNXma2AAO0qjaVsmNhijB6tjEVAVOLx/S6Roz9F7hjl3zXmOsm7z1bvTadS0QRSU0DnnMPONZxyZysmE76KJC3yC6KW9P41hJfWByCemppSUjCqgFjnY8cy1Sqcf2pXLF4llYQUPrqZT3BdXQoST2+HL4U0of8BkdqTXloPkU4O8hcNYI8lqk8QFLbVTPoPRABjD/lRYVLtl15WgXuqpBl6Ye2zSUZKAZfVrwr0jfEb1rvwS7BlRG3RjRMyTBEO9i7RG/76/ZYj/aXMkfMR7lcZ7wWFhkwC7JD8OHCY66RJqi4OHQwY3pLsw1BInEXbLIrJNQJK2nKBtj39f7WJVYp5ziF0dAzOl9zur03l+Dc+APvxwqmdws2R4Sv5DMZEYbHaoS0diyPOdGq64D0mjBmbR4JNsHQLoT72oDV8d708XGc2cpmLq/02g/UXf7nvl2VoNwNNcmUhZ0e+567gVjBcRetqfdmaSHadkMKUaC3+6QUAk/RKljYSH6HTjgMxImNh7mAaxI/1goUI6W9MFMeGkfWr994oCm0fttQmZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(36756003)(478600001)(6666004)(52116002)(26005)(7696005)(2906002)(6486002)(4744005)(4326008)(66476007)(2616005)(956004)(8676002)(16526019)(186003)(5660300002)(66946007)(66556008)(38100700002)(38350700002)(316002)(8936002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EDZQLq1tALBAtZjxIuDnocRVnTy3uquNmdXNQul4IODHZuuZLifE6DRr/kch?=
 =?us-ascii?Q?xL9yYQbgyNcI2L6Kr9QDkc9dq35gl1XvZuxe5iRZbKrWsJyI/2SFW0iDmcii?=
 =?us-ascii?Q?zVihuzGxR7axpquQr7cBVw7vYQ8ZkE6GSNSl0k+6O7cqQ+0kOMHUHHVoZqkA?=
 =?us-ascii?Q?suULUJXj/hveAq68lBrgbRrKkHAVuf5b1EBmMwuVDIiWyhO7QVvh2svQa/5/?=
 =?us-ascii?Q?LKXekDiYApkFFcAHlnG6gzqq5O9JKwL/Cw93CnNx5GUUNg2Sx8/ZQ4hu1y4Z?=
 =?us-ascii?Q?PFfivAlxS+6lfs5SIOf1yc6cZ9XJDf0/LA6hpfSqX6G4rpu6tB5nYrJXLPQW?=
 =?us-ascii?Q?81S92ylJ+X2JgaSxzBoug1NUD7PtN1+4O61SxUDUrdwlvxCXYj75LU8yJrCr?=
 =?us-ascii?Q?5mjRwAJKpa+l62TrBLfW5KgMy+zs0tXnY767NfVz/J2nEHTW+q0cN4bb2ehz?=
 =?us-ascii?Q?CuTodjYcPU/aOdXfDk0vfhSYIazwNOTy7b6atcNCD4BZer+8BUQTKtB2UnD4?=
 =?us-ascii?Q?TVaKyhRvhO5l8XgbsyLj2D03vtLcfH0ThGYwrx7Ap+4xupFCIjkPw2iyrMml?=
 =?us-ascii?Q?CTVdAOtQDjWaMfqpTrgTVuVaTZHBR+tCW08RsD4w3O4sazOCS7UX9+6Wh8Vr?=
 =?us-ascii?Q?sMIzD4dgGXwwdHuZ8n8BhxsktP4WBCdRw3du0qQTTH75O9minuFayug3vS5S?=
 =?us-ascii?Q?/v9UkEI9fJahx9NSQ929vTwsynZyzltWer7b9IrrZUYP7zgT2jqRlLMvPD38?=
 =?us-ascii?Q?MYEBD76YKuToNlan6ZvbsSgGy871hzHiJdWR03SQVhqUKdB2mlSNCg6KQ3iX?=
 =?us-ascii?Q?YP2+y0PtHUTsf5dB6Qhu1G2+udygpGqbmBkJptf7EyyFU2am4i7mh0NGcWkY?=
 =?us-ascii?Q?IFY5jwfvh0hVOZONPAWB+sbp/rbHyfdzyb5nDKbw61kiL3eYOKGS5yUWIdlB?=
 =?us-ascii?Q?dVVaQO1ucBBSFCchITmAF1eBFjZGE9AOe1hy6iHW6RSe39grwEPW+blU1A4M?=
 =?us-ascii?Q?QJpeMhMElJfH5VtjOiSr2Gp3o50cqNmJtbewwCXkECTGLc5pNZG1Jwz1UK6Y?=
 =?us-ascii?Q?q4lXo8rKaIUxZuYU1f6Amj1iePt7d/q+yyZMsYHxcHyutEMOR3c2YezwofL1?=
 =?us-ascii?Q?pCyIOWze1ioWOu7GClRz0deHHCy4a/J40PwH/nSqwAVz5mb6TlCqnJLNlhak?=
 =?us-ascii?Q?vx6B0WDzrgq7sW8SYUSQPvWUPiQyovEeveYnMyqNdqJzuv4I2jHOJE6uvYMe?=
 =?us-ascii?Q?sWdJhjJr5CWc+uqpn4QK3iYmzY3FAKXOH8HnxxP6AUKfuJWVjK47x77bXXEf?=
 =?us-ascii?Q?QdsYMevof+lw23hZYHK1ghkM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 338b5eed-3769-4340-1c03-08d93bd67141
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 14:50:46.4194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ZIdiM2DMgTYpll0E1n/c5niEB2POlmZtOwdLwRZmluuY6oWKH+RMM+wwpmuhlkSUWb5Bh/Fdf0yyZfe+VHSNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5045
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralimk@amd.com>

Add Aldebaran device to the PCI ID database. Since this device has a
configurable PCIe endpoint, it could be used with different drivers.

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
 include/linux/pci_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 4bac1831de80..d9aae90dfce9 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -554,6 +554,7 @@
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F3 0x1493
 #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F3 0x144b
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
+#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F3	0x14d3
 #define PCI_DEVICE_ID_AMD_19H_DF_F3	0x1653
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
-- 
2.25.1

