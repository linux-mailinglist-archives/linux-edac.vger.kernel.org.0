Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9762837AAA8
	for <lists+linux-edac@lfdr.de>; Tue, 11 May 2021 17:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhEKP1b (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 11 May 2021 11:27:31 -0400
Received: from mail-eopbgr760085.outbound.protection.outlook.com ([40.107.76.85]:28000
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231950AbhEKP1a (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 11 May 2021 11:27:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4tnRIJyeZ11+R2cBNRO5FGrXHbEGnjGI4+xjbq/24PzeAW20rx7RWBn4o6HT0mnJXwXD0aeXBCA/wBJMvQQqs3coJ9d2pefleQKKoYHwYVyPSEIAyD7Im6F2hXUb024LYYKa1k0nJlNZBbOdr6sQbbrqhTpAnGynHvM3TCEroYoB3QKHnRvH/Cf4KXfYIjWOuUqJtdUX3sVx4YJzAnsLANGPDcj1HKKsdHqqmK0Lefi/g9KfoSgg+x4SetUPuwxVr38/Qj3qVBvK7GXCmqUFaUPsQjxjRmgNQN9ksR17CtDhUrvboDTu9YHlJvx7aVJKk+tTOX8FBln5azp9skCLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n13QHWFd4cXBsdN4n/Zwor2nh2BRbP9K1UEwCNHpk1I=;
 b=CYZPF7hdrGqLun/Ot72DZTFoxw/xgFrXzjW6sXlSTFSPpvop/aHeymPamdEi4Kq7UTYTFWds8i2EMlnDtgA+05FjbeNdZJKc4htYrtbNVSvXE8kBLKhlhrNwg3CBFWQuzIWaK95WeeiD+5eZs+JEEA7tkb7e9RCa3C/90KQjmBBgvlcsLjSYjEy4h4m245Lp1EImSTQ4PK7h5/R53TqV5CO2bhvtyzluTp8S5higDdYWiJB13OYpKsojrCXrfgG5vO5PCe6sCD98dNt7ARgTcPL8mEhAymoRTaWJsQfM7TJjiwLK7ctJ27isc8Q0jy3YiJYDU/rdj8uXfI+rLw+ddw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n13QHWFd4cXBsdN4n/Zwor2nh2BRbP9K1UEwCNHpk1I=;
 b=rN9pJIfeWTH1fPfqTMlWxC93m5Yv6Ywz+M0umSO12lpMhyd4vpIRywQ8Pm4Z8j1xk8BL+xbvD56Z4cexaefNua9lRXET0oHVSj+T0o4t/TAFFF8pl5BrfG0XP+k5uIdeSBWS5ei1h71KOC+tC7Uf3XRSGZmhKhg470OsKF6try4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10)
 by DM6PR12MB4402.namprd12.prod.outlook.com (2603:10b6:5:2a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 11 May
 2021 15:26:23 +0000
Received: from DM6PR12MB4388.namprd12.prod.outlook.com
 ([fe80::9030:4dbb:df11:c961]) by DM6PR12MB4388.namprd12.prod.outlook.com
 ([fe80::9030:4dbb:df11:c961%5]) with mapi id 15.20.4108.032; Tue, 11 May 2021
 15:26:23 +0000
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     linux-edac@vger.kernel.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCH 3/3] x86/mce: Add MCE priority for Accelerator devices
Date:   Tue, 11 May 2021 20:55:38 +0530
Message-Id: <20210511152538.148084-3-nchatrad@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210511152538.148084-1-nchatrad@amd.com>
References: <20210511152538.148084-1-nchatrad@amd.com>
Content-Type: text/plain
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MA1PR0101CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::14) To DM6PR12MB4388.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from milan-ETHANOL-X.amd.com (165.204.156.251) by MA1PR0101CA0004.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Tue, 11 May 2021 15:26:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a100149-e4f5-4c1c-23ea-08d914912245
X-MS-TrafficTypeDiagnostic: DM6PR12MB4402:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4402D991FAEF142436C56116E8539@DM6PR12MB4402.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k8bGy4C9oeLwNYhxws0jeajF8mn9PX5LKz1QVEI4HA/eev0T03phJLykcpHji8SDJEwNJjBU7D9nbxU5TCuQ1iHYeBiha/sonM5n17Mw5FiWvJWK/+fWRkmDe9IieF+dDhYT1p7ppOMTp30Mj1g6nynMjBRh4gi54lgBKsxZAFTzvlol52/C45y/MvwBi4pzn7sKGUk4w0yotIAd/D5L+5bUubjlVTPGzbjcO34ma3X9kIHlP1jTlFqkx7FwuiQ5n1peBY1SHs6UFCOsBTApdD7749KngVV1AdM40jIOjn/oDlVo2IcnL/X4QtpiyZz0BBlTXD98aCRywmiKCz0U0TR4ec2v0gQOojuliScNfW+dyT/OCyKrRVL96Ps95t42a+n9mnw9dYlIxndJ0vBp/waDiMxX0IVMbzNfRWdZ0fzabkdGaVvy81xXsM7UHrFNDyYsBPrri00nWe1dAy9OSDxDk//OFrR65TZ7IcrDCKPp2rK/dClsZV3sirk9sHPsz4Pq8Ii6T7T5sIabBjyo1MwR4MxCUHVzMAGjujhaGBYXlekaR/6X9yNpxPXw1uwG9JLfV0+9JVjrfHN3kzKg5Ou01Sz+snbOgAfuwNExxxX0Z9TMNzy1mvgCVzI4oIBhNUXfgev0vkcSuYGrOpmsa7KCgEXph7FBpsuIUBIa+M0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(2616005)(66946007)(4326008)(1076003)(316002)(83380400001)(2906002)(6486002)(52116002)(7696005)(6666004)(16526019)(186003)(8936002)(8676002)(478600001)(26005)(4744005)(956004)(5660300002)(36756003)(38100700002)(66476007)(38350700002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?WkY465O/woPVEwQ0rzx1V5sIdQ1UL8/Iig7yeyORLynhGj7VtlvqAv7BrQei?=
 =?us-ascii?Q?dHUPJzlkrhqEI7qMbuOlT18EYbOyL0q3gmlbMb+5uJZM0k6MQGTWYHiyLP8L?=
 =?us-ascii?Q?to0ClDX9ND1uF+Do17z90djIzgXs0Ax8omCJJvbdR5+3m0OYli88kJbMnjSw?=
 =?us-ascii?Q?4EtYfPssGAPd5Vt9Ytijg8gKVix5DmB1YkNY4+L9Xs9HKlTwCevtYFwQgROq?=
 =?us-ascii?Q?OYjPh6fpF8zaK7IIOyhmxeaFGmZmaNIOU84FjNT/lz/di5BiNjnC4ZM7TBWV?=
 =?us-ascii?Q?9ALXOnMb8Dosa2RRjIovijjdugcjOzZA4IWgkLr9EYFGjqoiWTxI5+p1jUDU?=
 =?us-ascii?Q?Nnzjfnx5ADTz0VSkqoFV9gh7mbGOYRXB38lF3iblXTiWjzJbSlP0gNIR1UV0?=
 =?us-ascii?Q?W6Ujca/4FHX2Apz/CeAA2i1wBKRN/ES3GczZcRwYxXUXKifyFOeSNrPtySK2?=
 =?us-ascii?Q?qBE9VLQUXkuJDUwWX4jXspNqop2htiHrQ8vXL+sAluKcNz4XifF/CBrUY7Gj?=
 =?us-ascii?Q?Z5FZHo3VtY6Cn+Mth0feGPj1FNhjMJ9ZlArP1neHWskzfe3d2OisRrkO71Kx?=
 =?us-ascii?Q?NxEeoKE0FfGlyHLmcSrA361XHdE2cfc3XbMVdbk5VogIvLLyZAytaxpCzRnT?=
 =?us-ascii?Q?TGvU3CQuw6FBn3GtYuvAZJ/rutUgNE63DBNZUVps8ri5FLk4ZH31qj/uGd4q?=
 =?us-ascii?Q?pWI24hdQURzlEe60xkSgVufOGFZ8v3Xar1bmiYaoETHET0OOl4Z3eD9fh0oC?=
 =?us-ascii?Q?CKVVFZK+CXMgQ0hY4I5U1x6n2FegJTN9yn5F+g9txGMJZKhsIRU5zDy+vPgT?=
 =?us-ascii?Q?JH0Hj9PRmXBXHn2NwwbLDuaDFjBYZfCluUIjgfLhUetRDMA6gAJJoEUfGhEP?=
 =?us-ascii?Q?Bm0fCYd/yeM63uKaz0b4HbJlebPP9yg1iIj0MndVtmAz0XV/7EbwtmT9hOIO?=
 =?us-ascii?Q?DrLCu52nUe502DEo3omGFJ6GHsvB7FKUx3WdkHWsgAztmhYfMSyG3vqqiE6A?=
 =?us-ascii?Q?6iw+Xrzx2Bihw1q0xmu8C0B+ocwt6QQZ4gSmyK7efQpJPOrVnYDIEzR0ILLZ?=
 =?us-ascii?Q?1qslhBa8KNFZ+IrWV0Db+pJk7aQ9zK+3zqnugsdJjQbG0M6rKi6MOJBBbe9c?=
 =?us-ascii?Q?bRyD9fx2hxzNMjxepG3o31WC11zHbxL9PIM0vsylxPcuNj/uGpvozkSyzH9/?=
 =?us-ascii?Q?dLVrJ/xgpjWqJ+x6qF4CKk1UCyTA82ZDue+X7U8p8+DZ6Hr2fIJfYqG/dDz2?=
 =?us-ascii?Q?89RbxBkTJZbLWY8QJQacqL9pZXEWoZvRyPi+EBntk+C8RPzbnzGnsKq9FClN?=
 =?us-ascii?Q?A8gkA4C2YNVVF9iBUtjKz4iu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a100149-e4f5-4c1c-23ea-08d914912245
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 15:26:23.1298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ge79aHlKdLc+sXKtjvDLb6YK0YkETab85NQNuE9sC8MXgbguMxKvpEstTkEq/kpBOxdfC3JiGq2HPAIXSQaCPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4402
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Mukul Joshi <mukul.joshi@amd.com>

Create a new MCE priority for accelerator devices on the
notifier chain. On some future AMD platforms, GPU devices
will process MCE errors and work as error detection
devices.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: John Clements <John.Clements@amd.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 8cbe7221a253..849f10a8602d 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -173,6 +173,7 @@ enum mce_notifier_prios {
 	MCE_PRIO_LOWEST,
 	MCE_PRIO_MCELOG,
 	MCE_PRIO_EDAC,
+	MCE_PRIO_ACCEL,
 	MCE_PRIO_NFIT,
 	MCE_PRIO_EXTLOG,
 	MCE_PRIO_UC,
-- 
2.17.1

