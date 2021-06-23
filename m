Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588DC3B212A
	for <lists+linux-edac@lfdr.de>; Wed, 23 Jun 2021 21:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhFWTZh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Jun 2021 15:25:37 -0400
Received: from mail-co1nam11on2042.outbound.protection.outlook.com ([40.107.220.42]:24416
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230429AbhFWTZT (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Jun 2021 15:25:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ge3kd3vu+es7SBac4u47PZW/XqrkUSGLg0hwxjQDJ1pRPspPfIiqBkYDlLWhR/odODNecaA/EMuwblte1yBPnbXNqFim15/3mssZ2ioJnOB77UQBqTZblD5hjC3CQu+uvbDwVWSMPVTOeAnY/uSF+yl/aVkunSMHIEwpW+9UkAJoHdfMF6Y4BWb46rFOCXYntYQ1OZC8d9IPtZAlXNywTNHf7p7K7RIfBoEaYZHDs1/E2p8nLXRHBaT8JteGivLMj79zOwEUbkM5g7Y1ExzDkWS4MS6vLpzMJITLWp9TVTmcdpzY1QjoC2baRnJliJ6vV1tsQGQixaK6iQOcSO9iBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjad2UG55flGgjZNBKzUSXfE2WyHL57UDVBNfEZ68NI=;
 b=U7gS/i3tO91vk2L/TbAY8JZjKxUgER4LjMzAUFJz3cRMXNUcO6AkbZeme+MNp76eHX59wrO2pMEIn280UUFv2tKy+QJL32Q5jqT45e+MTyrc4GDc9qCOWg4vbFF4Ae9OA8vHZ+fbosPxFGHcx/4yKhNvh7fEcZgBsB/E1fYo9VuBaMJSPgnCJB5gBSdMH/qoCcfD9BIq0ovTI9/ct4b7V2eZlQ2SInlpJTUFcs7J1AT5sJw8B27wiBhQEA2z0Z5TUWmM4JRfWG5DQDFoUDUwjiM5OMA6+PPHoJ/EAZmamhc8lxVPHZbdBraBSPC4ZsXHKeccupPTztzfhx4L7Iqdng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjad2UG55flGgjZNBKzUSXfE2WyHL57UDVBNfEZ68NI=;
 b=fsFcOVcb736VGcSCzT5MJCAZvx9tzTftEC+AoKJ277hFKOqgG+F1nTXr5m6qRT9bzsskaG6NMuRTWkbV0MS3r4HDOZRShPdTFp0g1XxhCcyKPeVcAno1opl8Q+00AvRUl94rlj3T4KNg1/DrWLb5W31pggZbpqPG+ftwbhq0Rwg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3218.namprd12.prod.outlook.com (2603:10b6:408:6b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 23 Jun
 2021 19:21:36 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4242.025; Wed, 23 Jun 2021
 19:21:36 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, Smita.KoralahalliChannabasappa@amd.com,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 31/31] EDAC/amd64: Add glossary of acronyms for address translation
Date:   Wed, 23 Jun 2021 19:20:02 +0000
Message-Id: <20210623192002.3671647-32-yazen.ghannam@amd.com>
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
Received: from yaz-ethanolx.amd.com (165.204.184.1) by BLAPR03CA0107.namprd03.prod.outlook.com (2603:10b6:208:32a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Wed, 23 Jun 2021 19:21:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f51535a8-96f4-440f-aa79-08d9367c0c56
X-MS-TrafficTypeDiagnostic: BN8PR12MB3218:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3218D48FAE962BD5C9915334F8089@BN8PR12MB3218.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LigxjejSmZ8Ciw3Kc59bQidH8WqXV51eZDkfL47ZGv8WD3eLlcTAhSq6raBo4HUcKoXq4jkPkiSjN5Ix0eoZJwUE5d6ZCPbJrw9RLjpR0EeDoKLQiTWyJG/ePn/E5I2xmpkYFeaTpC1R83oLuZ1q8UQRClBrBuUYpoCUyRABr21Akf/ulelmDbXxP+a0kgu+v+0A9seSxVtBt/ndI89/6eb3x6fO5A+jLsiuiLAbsRzd7Huo2SO0fa0tEX5dsif7H0u3i5T5ccJd4qIfc8krdvF0CXzg5zOSAiqdYJnY2t6ceBqfpI4Txa6m/oKGmDxVv0dZJcyI7rBkUePH9xXxRM1K09tOqzM3ubZorSi2/gWWb4zPpr+hUAYIB35w7gp8yFbIBjtaWcljBhJ7f88OYCUxvW5/z/INItI2nAHRrGwDAJ88ujFgopnZrSiJVVLoXQ6obEclK+Qfaq2Ml2kYfBCEcaWp2pYdJNhybxsiW1Nbz6HmwXhCLD4WDXfUaiU+4gzURLcXARe934IVzyd1K8mItpP2OdUeTvGUtY/8yhsS5gy+p7czcH99BHLj6zyTzxkXlTF7Z7zOxCTPwvyGrGYF0It4KD6tPWv52kdY1CX43kbqBBbVqNLD5O7Nn/c3cDuIuhaxUdM1Imc1z5BJ6zA16KyiwfybvKnUp3yZi2lr1dK4YVhS71T87ZhycwrzNDSNIBvcMAC82rcv0rtBgRqb4R8C95PRCaYTtfwNcxzWYe+gYpOMH3CLd/F0VRpw33RUeWhQMdPl61PjQKyIlqg4qmmLSJAsmEw+XeeEJWmJ45Ckair5doiekYztPYAOAlQOrdo56270rV5UbsqNiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(316002)(6486002)(6666004)(26005)(16526019)(38100700002)(38350700002)(956004)(44832011)(2616005)(4744005)(86362001)(2906002)(186003)(1076003)(6916009)(966005)(83380400001)(478600001)(66946007)(5660300002)(7696005)(8676002)(8936002)(36756003)(52116002)(4326008)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?osK/36CeRJn8Y0j4TZ35c1FtFUzhJA2lF89OLHTs1M5KlvVjh0wutzzZOjix?=
 =?us-ascii?Q?DWyfi2n6EDp+BlAkRkGMTUK7BCdtJSbdBw8xHCjFPA+4Ne2MP/T66omnceo1?=
 =?us-ascii?Q?hDZe3jMoikVVnm5HlK5nSjXQ2tXODKTmdHt/xsWw8B5Lyw6bu2TgQgCLjFxz?=
 =?us-ascii?Q?aOUeJEwSCPH4Sd3IE9R6kw9buyw3Yqsf8MoUFvJfd1L/y/flHa3I7yWiJ23F?=
 =?us-ascii?Q?cZncHdLGFDxs9hUmLp76JsjVviq3OuYrDWG72UgVrrDeHPf+KPvA1xm5+T71?=
 =?us-ascii?Q?NQsCEx6rvetpSwNco58SxHZn1FvRK7kYdbGXdhitQEJaSOh27DMDqdigskO6?=
 =?us-ascii?Q?QgvaNmyOApgRMQ1MlwDNfzTIoJWoE0InHdh+x8gPY+mPN92+97ztRH96wymn?=
 =?us-ascii?Q?D/Sgqh9cQD55zu9JtjpL+kfszG5xMT4Xn46J16+iBpLmo8FrHbHeNYni4IlR?=
 =?us-ascii?Q?lScUD1NTgnxA6IE+DytCg+nTTOa6ncM50qDPutWf1S9utJIudeVBGS9rmMNo?=
 =?us-ascii?Q?0Vy5TSpO568aZLCAqj8I1uCjlwIECUlJ4ZQDDtw6f5Z+1fEXTlq3L6ErD26j?=
 =?us-ascii?Q?l6oD6Pi+X8eUYRqa47kuGh7cEqecwzLBYuChxLSzXRPkaqXea8Ej7vmHHmw9?=
 =?us-ascii?Q?lHIQJVkPwITr+CIaJC0Jae/SnsGOsemvvJP4rmLuM/sDGLqKMQwoJtts8gJp?=
 =?us-ascii?Q?r+BnLf+8ZixSOQnLm8GnWe3LcIKYOY6WYemdpT91ChrZdAQt/CIELtp59mpx?=
 =?us-ascii?Q?zmBjNVWLfl9GlGebPMyN3yTXnSL4nYt5d50pA0SE9pLQ6+8PICm0RVL4EWcw?=
 =?us-ascii?Q?QUgxlMGAxxVgmPHVG/NcWoasxJD8bvZ+M0V7TCLFv49bksYkvIAuzGRZKQLe?=
 =?us-ascii?Q?yrzO0epjoFuN/O0hW+JdbEEsl0UkOJk/isf0VPTeu272/jslLYedilUBAHJj?=
 =?us-ascii?Q?eRk4grp+fnmXWel1rj6ase82A5zCsqu7x4RBO2niLPSXIFTWQG+tvGx04/7z?=
 =?us-ascii?Q?JhXQ44Vm0aUXuWYFc6L5GTXd6j99rK4psd0ghSCJa7nHNkvckRZnv53maHRP?=
 =?us-ascii?Q?Y73VxDJymyDt5j/XlX916WrHNRvCaPcs4/T41iMVaRSATmH+E3K/LxABV4iP?=
 =?us-ascii?Q?XmWanfnTEGEG2Zh4WbTpJsrFauNOQJqYYMKDY/M98I8kPlWxepL9gkGhFBJi?=
 =?us-ascii?Q?nmtMc1Dgql80rqK82NT07PmBF9xRoVuUNamA/413cazemDPFFhi0dKCRJUN9?=
 =?us-ascii?Q?iXVRGdWq6e6DR6N9ScDynFuVbLgagl/xECFM2v4yFQavLFJXomT8mGRXfF69?=
 =?us-ascii?Q?kXiybYWdDQF8Ve7KghH3zhY7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f51535a8-96f4-440f-aa79-08d9367c0c56
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 19:21:06.2815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: krqMsGIbqgmAVtkJZDpa2dBDHm/c1rrtx5W7v4L74TP+jxTcd79rKZTFPUDfGb6eVASQhZ+huLGFvAlv/f1fyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3218
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add a short glossary of the acronyms used for address translation. Some
terms may be seen with other AMD code, and some are only used within the
translation code.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/YJqwpKBsKL1QKR5z@zn.tnic

v1->v2:
* New in v2.

 drivers/edac/amd64_edac.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 882ac3fbc832..d8557716d65e 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -993,6 +993,15 @@ static int sys_addr_to_csrow(struct mem_ctl_info *mci, u64 sys_addr)
 	return csrow;
 }
 
+/*
+ * Glossary of acronyms used in address translation for Zen-based systems
+ *
+ * COD		=	Cluster-on-Die
+ * CS		=	Coherent Slave
+ * DF		=	Data Fabric
+ * UMC		=	Unified Memory Controller
+ */
+
 /* Protect the PCI config register pairs used for DF indirect access. */
 static DEFINE_MUTEX(df_indirect_mutex);
 
-- 
2.25.1

