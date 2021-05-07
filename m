Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0727376A59
	for <lists+linux-edac@lfdr.de>; Fri,  7 May 2021 21:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhEGTD0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 May 2021 15:03:26 -0400
Received: from mail-co1nam11on2081.outbound.protection.outlook.com ([40.107.220.81]:18843
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229742AbhEGTDS (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 May 2021 15:03:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ndu723dX65CTFZJVMD+XG+8mJu1OGbyi++z2OPQU2tKRirIHqEB/7/YcFXNYomOeCor0STrG+0cFc2t9+h0O9M7Q0VfnaSMo7arN/3Oxf8CmacoKLUytZOXnCGXQUdU3DL0Ynxdq25E1tN+CQE85ELC997OvAn9O8jwhrY/JglWXqTmJ3LBX08JFOdJrBry8MPoj92dQEBCWOaUIyr+jnBqpTlDt1ylvziK9Elegb+cm4V76Y+pTtOWKwFMMbhfGrhT0+XZ/89xPPnccz+3PnCMPkLOd3qdlSscx1i9PRNzvB/Ui65fWBYVtBakaXX9ddNlczLEH03lE3tgEZhpajw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03vlxunkdisypuKFtALxrxhOjQEl9+XwM6Xs4RGEE3M=;
 b=AiWrMUm2U8EpmzgR0rXILrBpr669NUoj7MEXLbxNMuQ4CQLqWWHWx0hQga16Yx/VMvMNrOP8hqIbeTWqbGCMZJmJ1kZ9B4r0lpaciEYbf7H8I3zdsaDeytAADq3hchbpsaChiVAaz+yFRxGw8VpPMSDkH1X7oD8IHplUeOP84q2ADapQOdnf/KbaadKgKK4ojjyt7yiUVM+dq2pieJGAktDnLe7JR5JYPfRl1iwn+h4hUB/2DcXHOV9tKIVd44KIa8a7uFfSx5+P7Kr7ZrsIdQ2nSMBANO6E/iupXBQN0URQBdJ7UBcuSEIWenDX8LiNrxv88OuaLYvFbw0c//JiVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03vlxunkdisypuKFtALxrxhOjQEl9+XwM6Xs4RGEE3M=;
 b=QDe0bY4OFF2NObrst55jA/r9+4wFFT0KERqbY8s+Il/1ir8PamzK9mfnITFQlfFwrbG+TarjF7vBuX/kj52m3swCEPy8SYgyz0DpGcO1p1YeioEUMHyG40BWOrL5ThiPvsz8SC7qq9hsHJq/49uVSBelozF8JEU5ouhvgptFHAc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1748.namprd12.prod.outlook.com (2603:10b6:404:105::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Fri, 7 May
 2021 19:02:13 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211%6]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 19:02:13 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 20/25] x86/MCE/AMD: Define function to insert CS ID into address
Date:   Fri,  7 May 2021 15:01:35 -0400
Message-Id: <20210507190140.18854-21-Yazen.Ghannam@amd.com>
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
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:404:8e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.3 via Frontend Transport; Fri, 7 May 2021 19:02:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc6b33fd-1ad9-419c-1937-08d9118a9fdb
X-MS-TrafficTypeDiagnostic: BN6PR12MB1748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1748319C83F5A13BAD576801F8579@BN6PR12MB1748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yF8mN5Ph1yp8hYVl81t9T413O+7S8UngSNcBy87G+xwHsVLhbuQERQQR/Th3c8yFDZrt6q/p0wfd4BPs7r4G2Z4PVXu8wBAga25d6bS3sOHc8RhqICT7wBVS/ALheJdJBdiO7comZuGkqG1SMsL8bFwT2eEyUVeLv+OuGpK+ML8Ob19e2FTQadW509GK1JI8ARdJlF6JrNxJ0tJ8hy+xPBIt7ec+K/Qhba68QhOgoklkmE6a2b76yKNyAz2ph45dB5Toio3wM27XDAXzPcfxhDBs6rywGzazkBW4SPC9lBFTdd8Hun7N19Kh3/yIjoXtbjOstU19HDCENSpjjy0M7UrcAemGuNCKdgjpEKWno7iDogJltYI9IpwIbuyUferF7bm+jBo4t2VF5r4pUBk4fpY9gQMyg3Yzsd/ESzbjo32gpe5lmoo7tvl/gZn38w6muEO4PwQn1T0K5bcyqNaaQ/SJH+wjuJuv2nhKCg1giaZOMRnv42Exk7JQgHlr/lmX6zvtOoWXEYl1zx74aI6TtZQ8VMvsvrI3o2ZoV9fKcSLJyudkW0gZm0jIQk+AZq8J1IvEXzEzo37x3ln/Eleps7dIstNdXALP01/gfPM0u790uTGWIaKhFqCdF16o2Sv2xgEKsvPFlcDYsaAfWNLnOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(1076003)(6486002)(186003)(38350700002)(38100700002)(2616005)(86362001)(36756003)(956004)(66476007)(66946007)(66556008)(8676002)(16526019)(8936002)(6916009)(83380400001)(26005)(4326008)(5660300002)(7696005)(6666004)(52116002)(478600001)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2cTK0n+8gv2DJXWp//2x2clpvBdP6Sgo+/mnvLnHFu0EgyR5nmqQ+OC/dh9G?=
 =?us-ascii?Q?GamuN4ZAawTKiqMpXj5RPW7M+n/8EvxpjgXXdxCDgiQFSOBXtEj9Sc2Zhl/a?=
 =?us-ascii?Q?VRJohvbzznOvxwRv4ooJ3nOZWgULTpG9gtwiIvGh1iG1VMikl9ye5mCXRi+/?=
 =?us-ascii?Q?CLw9lzJETVeDuq49d0qLhD+lq9CSPJ8RenDD3IddtgIDV99l59b+VEM+Hewi?=
 =?us-ascii?Q?h+DIwvdWhIAd6ZLWaGGuWK6cv+Qb4SmEZZP0gBZPuaeY+kUs1YxcOxDVQGKF?=
 =?us-ascii?Q?mKQTR4ixtVVvULT1UOE3hSQLZRHRZy/OJY7D7cFyrWW7Q+IkCPRGAVUvMUFH?=
 =?us-ascii?Q?EqYzqkZPqg8SuPQLr23oCh12E3hvuRYrOcT8SM4x+icNy1wvLLTZ6ASOjevj?=
 =?us-ascii?Q?0T76aBeZCCG0Dl718xtJKKAOcxWtVwqbNlrI6fsg5XZBvcSatuGuvD5Cx65w?=
 =?us-ascii?Q?GURACnJwAwiPiEy2hqpn2EG0I/30aNc7zPkeohojlV0i4s1o/84LoGlDsKgR?=
 =?us-ascii?Q?By7kqCmzz/1ZJ3XTYMXyiHrYqeuTyXBP5n4jbX2pMnGhyflquM+eXO7htkVN?=
 =?us-ascii?Q?kCqiDDRsRbm781ccKaqUKelXlcKTDrzrXj6JXRDfYNSodzS15J5KhcNCctbu?=
 =?us-ascii?Q?yBPhLZegc981cAJ0c4Icmf615tkdBkH4dPIVou5dAHcUTCv07oI/YLS/qftW?=
 =?us-ascii?Q?vVGg3icXblCDwmR7uEEwsetCGxoJfUBQ9AKLwKSeq8U7T4OEXO5vN881m+it?=
 =?us-ascii?Q?ips/v6Z0gv2L82z79KBi5HlFmkN8wYm/roz3oyQYVh9cqGiMhw45egnMSfcS?=
 =?us-ascii?Q?6WfErc0SAOYNZeb4aEqcFVK5Eq564/yaeGKoFQ2Rn6IIJ5t4FUriPwTzD/z4?=
 =?us-ascii?Q?sy53NPJ8WOOwbNNEYx7RKBeOEnqribvTonfp6ojlMIRu9JK+u5bzND0qUqkz?=
 =?us-ascii?Q?tgR9wMBFZxdjhhLk9RdffnNr8TVENgNIkkN0ltzRonRQmtK1FilIJVhTwks7?=
 =?us-ascii?Q?4hQpiG87kxKQasNYUOzxdkDBHscwLRRQYFNAe844BE2rG7IhxvgVpdyIzueH?=
 =?us-ascii?Q?ua1wzyzED5zX3bPntoXsyBUTZGRRS3HizcMrXGL0T/HGYgnQ0LgK3WAihLwz?=
 =?us-ascii?Q?ShyL2Vnbo4NeT4aEriS8ek2DUdX5S6uhOOPKQEd1rHl9AKNtzBLb0fG0LWsN?=
 =?us-ascii?Q?hadWdmJLev8rx8InwfAZ+H8dBJHtxvWzN9BXTZzS3/I1AAg4KbADinnBGlEo?=
 =?us-ascii?Q?rR0VqX+DrhLT2Pybt/KCDhM0rB22a1sDmVBIPfuP1XeOx1mT4aGlRmzv0v9X?=
 =?us-ascii?Q?Sn5g0W5+Dc37MhWnbTRXQ5jY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc6b33fd-1ad9-419c-1937-08d9118a9fdb
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 19:02:13.7559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fHl7TQlELmUAqJRIQkNO/lY/SNlOiKeV0jHBQXZ1qRWknhgiHttV+Wp4PpHKc/T5EaUo/UqSXrqbNtcsFzY8ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1748
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Move the code that inserts the CS ID into the address into a separate
helper function. This will be expanded for future DF versions.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index ae49cef4792f..b017e4613d8f 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -937,10 +937,13 @@ static int calculate_cs_id(struct addr_ctx *ctx)
 	return 0;
 }
 
-static int denormalize_addr(struct addr_ctx *ctx)
+static void insert_cs_id(struct addr_ctx *ctx)
 {
-	u8 num_intlv_bits;
+	ctx->ret_addr |= (ctx->cs_id << ctx->intlv_addr_bit);
+}
 
+static int denormalize_addr(struct addr_ctx *ctx)
+{
 	/* Return early if no interleaving. */
 	if (ctx->intlv_mode == NONE)
 		return 0;
@@ -957,20 +960,7 @@ static int denormalize_addr(struct addr_ctx *ctx)
 	if (calculate_cs_id(ctx))
 		return -EINVAL;
 
-	if (num_intlv_bits > 0) {
-		u64 temp_addr_i;
-
-		/*
-		 * The pre-interleaved address consists of XXXXXXIIIYYYYY
-		 * where III is the ID for this CS, and XXXXXXYYYYY are the
-		 * address bits from the post-interleaved address.
-		 * "num_intlv_bits" has been calculated to tell us how many "I"
-		 * bits there are. "intlv_addr_bit" tells us how many "Y" bits
-		 * there are (where "I" starts).
-		 */
-		temp_addr_i = (ctx->cs_id << ctx->intlv_addr_bit);
-		ctx->ret_addr |= temp_addr_i;
-	}
+	insert_cs_id(ctx);
 
 	return 0;
 }
-- 
2.25.1

