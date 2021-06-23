Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854E33B20FA
	for <lists+linux-edac@lfdr.de>; Wed, 23 Jun 2021 21:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhFWTXO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Jun 2021 15:23:14 -0400
Received: from mail-dm6nam12on2061.outbound.protection.outlook.com ([40.107.243.61]:4705
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230185AbhFWTXM (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Jun 2021 15:23:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfCLbFiKZNaJtqUAQ4TcmSlbAqzwJZn1PksO+w9blfoE72zWN5ZruZyj64U+NXYPaUCRLZdH9ee8Oeq0IsJ8aGV7GiiNGHqj4AixqD6wiRWaVutSZwABBiMvx+MR19Y3q24FIyT14FfW3RgjdINJTdr3IrZlfs0AMFeD684m24QkRo59F2JZ5yhCgtRFM70gZOVkJJTu3qicRfXmUxJ1jBd0zN199xLdqr73HyLnh2q8nUGtnw5u9m/EdANHt5I6dB23gRRZubCbRRdxi/gyLXiYpKixTz/ea5/OPyIm/Npx2ZMOJ6YpHYWl8ZoO0ULqkUKZbL3sj+eupfv+E8Mvtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/h9K7kVPUPIFANWxUc5k0M/0eKqoA7Vj+sQxf4mmDE=;
 b=PAnpqBrmjFeOPezrDcPQtwgmxle/iYxmf18W5G0MlEe3mxkxErMQTMAkRfpHfd2srHcgxQTYZBw3IxIZdhH3BbEQdzwWP00+lPtJY1vXZIBkcNWzWAGyYRyE6iY6n1hmGcZqBtdfPivLYu5LE+GvkOt9VuSeYpX/z/IY5le6s4+HWYZUxVVKvIBAy8fBJGw7mK49PhI/ACf8UpDHAuOuKyWYqq5+LJwrgd/USqABGlgmA1DWzMIuPh5j9KoHV0VDHY5aQtIb7+sHDYySQrnRgWzjrGKMVlWDhG3dhpsepqBXYw0CMWdXO2E0lAq5lxoZpi2UOyF7G0PvM36OCnqOWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/h9K7kVPUPIFANWxUc5k0M/0eKqoA7Vj+sQxf4mmDE=;
 b=JZ2nuj+DQB6/bIPNTsOIS235ZoqIOPzWj3oeId1KRRJjfIzYoiYr1umugTT9gssWDb/p3JAylzqAiPmSV4X1nlPdrejjdj8Yz3Wyv2VBnTeUjpD1mZoEjYH/z4+00e5zBKO6SAgqAX2/ngws+3/nvy6NWcxFKGh1x5E6Fm5nmp4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN7PR12MB2740.namprd12.prod.outlook.com (2603:10b6:408:23::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 23 Jun
 2021 19:20:51 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4242.025; Wed, 23 Jun 2021
 19:20:51 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, Smita.KoralahalliChannabasappa@amd.com,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 15/31] EDAC/amd64: Simplify function parameters
Date:   Wed, 23 Jun 2021 19:19:46 +0000
Message-Id: <20210623192002.3671647-16-yazen.ghannam@amd.com>
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
Received: from yaz-ethanolx.amd.com (165.204.184.1) by BLAPR03CA0107.namprd03.prod.outlook.com (2603:10b6:208:32a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Wed, 23 Jun 2021 19:20:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c98663a3-c7fa-47f5-aed9-08d9367c0395
X-MS-TrafficTypeDiagnostic: BN7PR12MB2740:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2740F8636C948148B413FC26F8089@BN7PR12MB2740.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CEddcBn4SH9nqUdoPHSyItPieo+C1qzoAkQVjSXLDSIBsfrAI24cQEcdXzYx3p7hTWFrYnGXouWWkaoMRPKmInn/LzCtSRGkQCKbpLO5CFrIZZn8maTayraeP9VhBE9vXTh6ndcnPjIn4kVILmohLJYWv0vFwbUbAs9DuDNo4DK9zoTG0FKaq+mDHbPWXeahyLsubijxDC2jd9cL0cuMxpBzPYcOlQ22vyIO0D/zMw1G6upmj2PohV4EeicdI8wjNJBkCDtDveQWdSdQtWVlhm3ajI2zxrgxQK0Lc+sDMVGr+4BURznSHm7XbvoY9/JVlvD2dond/qZN4pYklpKdDypsoBVHH03fY3SH+WILbClKn/Xpn7aicNiiJnKbe+izFG6NtzTiyXT1iHBlYGzdNdF6ZkNNEzIAPHArozcooR9fBhkUDzTgHGj/mSVDC6as2XtqxW0kfzSlUzdEdTgLXdHgj0J+8QJtYKHgxbiM+fqi0LrmtsGfBVjLv5PAHf0HgNGvpJdVFuSWcZcOVA3RarGRVkLjKDIuoNzVKBcdDaE6ShnmteL7MWr4bozQ6ArAviqZpQ0QQrvPNa6ruXxw5sjsVM5hq+H63oZ6Kt6b/niHK58uICcqZ7jbRc2sjG+QSA0UaiJd/rgAoChHROnY93zc5HXWNzparTrFH/c7wLi4U4DJP1cRcejpVAGXorJe5+K26PqvyCrWxniv5p8BZwkjUjwRWyZi5Z9+LW08/JiYu2mHAHT+Cxj8IzfcigcLx2jy3Af+hhnyVC3+/7GYZaCoRFQoEO973xJkDM2rG3HgYill1oesBRT/IWli2WQWo1FN+gfcU/5bh0BT79Syog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(5660300002)(6666004)(2906002)(83380400001)(966005)(6486002)(66556008)(66476007)(186003)(26005)(16526019)(86362001)(7696005)(478600001)(52116002)(38100700002)(2616005)(956004)(44832011)(316002)(36756003)(6916009)(1076003)(8936002)(8676002)(66946007)(4326008)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jMPD1JEDWPC5BKPChm/ah04iHQfC/N4n4os3+ZE+3Aa2QU5yzV62JUmbNF03?=
 =?us-ascii?Q?IJdW4tmbuK/5isLZe4ZbXMvsLgBUTbxLJGqXAfjbbP5gi/diirMqbi4LlxF0?=
 =?us-ascii?Q?eaQ/nbj44WHe93/W3/QPpw/FKvymsZ4/JXwPkQb3UGSK3Pd6BBprvUCr0ck8?=
 =?us-ascii?Q?4+uY800tz1uBkkpL7n4bcPb6H6NDgWuaExMcrPQ5+RJkgNnapZiNKcn/OTjW?=
 =?us-ascii?Q?8VKARHE05iUEyXk7L2HbaiqfNyZLY3sQxsU1g+C/fpX7cPwsQmhmsis8NhvN?=
 =?us-ascii?Q?qelCtC1o0UeqZQdzWtJWBGd52fLfotK6xFkbhLZdZ4QicrO8lai0IIBBD2Us?=
 =?us-ascii?Q?WX4Fd88zz5vwt2qcMXy7M4qvkyVphDPnDsWrFuyGPoOZylzD15xmajtoVSRv?=
 =?us-ascii?Q?obxmcckt7PsN2O25fyovKJNpBdsDN6/NJQZ1JaQWMr4VEATsI9/1M5UfCbh5?=
 =?us-ascii?Q?S3IDRUwtZ4JFb3t9aBDlFJOHqSFd3iR2zcudmsRa3e0BuCSbJZ10WQnxWAE6?=
 =?us-ascii?Q?iuTsThW8uWs4JOyO6KkTaGCT4xNbqiR+MpC/s87a1VYwyxfCDknOIJangGAS?=
 =?us-ascii?Q?+nKU54sWZH/nDB3oLvj+yLuIGuUcG/lNjVfNMWlSj+U/s6FSIllDddSERCwL?=
 =?us-ascii?Q?TOIN0maNN5gerHDsoOXDGmzOo0zWSwi2EEXURbmBWkzfmEux+2j7pDUpVyHh?=
 =?us-ascii?Q?XQcoswPz5iOtX0PFy/HSJSJdp8piZk3KYaTC1YIIL1T2G6fj34x/S1O5ySTR?=
 =?us-ascii?Q?A7mfNTrmcNwrTLewIiISfvhEodOC+ZVMltP+E7sWTG3S/zt3JVJvNzAWZ8FO?=
 =?us-ascii?Q?ZVwTw70maXdfs1X9EX0PfjAYUFSTNhZRP9EUL8WO/wuV+PSloAoBqFJZyRXB?=
 =?us-ascii?Q?vz2SPpNrOFM3Nj/BBBtJysoYgyPTKnaPyV17yS6hPpbBxblXl9BpFUL1CzcM?=
 =?us-ascii?Q?JW9gt1oR0h5iT9RYLXMbDL7W+yRslgUM1OHb3OLeKZHcHymwjY+7TFnGYWBZ?=
 =?us-ascii?Q?Brei6EayPFJ6oDmUa98aGaGTbQItwpgmZUazOIoIQmgmUuFUoaHdHkcrpwry?=
 =?us-ascii?Q?6Pg+FJklTpOlAdGrWTuV8z9NqWKKf0yvMU2ZAcAbEFPjN6FXJ74AM2II6jmt?=
 =?us-ascii?Q?X/Mb9lzmNKR+zJ8ZkaJZqRYHuQJOzqbLwU+Ksr2c+aIaM7Urg26GRa2qNHiV?=
 =?us-ascii?Q?y8aFMPJcC3dLzR77fp9DnvgM60WkVHXKAogjKo1cRbXzIGlDVeKir9R6HHJI?=
 =?us-ascii?Q?va8L3FCCMFxX/B+cuwtv7h5vVJe71m/XbaJHKtHm0cVpRG/AtSfi5nfv78lS?=
 =?us-ascii?Q?fGD322b3k1ct7qxwcV3GbaZC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c98663a3-c7fa-47f5-aed9-08d9367c0395
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 19:20:51.5210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FcsvfHEewiZqSujbBmPmSzHm4FR2coT9a3G4qqCyG2ks9Hnx+tNQC/Zfk+prow7mF6RYKQRLWsse5de/jMn1jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2740
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Use a single address parameter for input and result to reduce the number
of parameters.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210507190140.18854-12-Yazen.Ghannam@amd.com

v1->v2:
* Moved from arch/x86 to EDAC.

 drivers/edac/amd64_edac.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 3f1ff5adce4a..496ca863f45a 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1371,14 +1371,14 @@ static int addr_over_limit(struct addr_ctx *ctx)
 	return 0;
 }
 
-static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
+static int umc_normaddr_to_sysaddr(u64 *addr, u16 nid, u8 umc)
 {
 	struct addr_ctx ctx;
 
 	memset(&ctx, 0, sizeof(ctx));
 
 	/* We start from the normalized address */
-	ctx.ret_addr = norm_addr;
+	ctx.ret_addr = *addr;
 
 	ctx.nid = nid;
 	ctx.inst_id = umc;
@@ -1407,7 +1407,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	if (addr_over_limit(&ctx))
 		return -EINVAL;
 
-	*sys_addr = ctx.ret_addr;
+	*addr = ctx.ret_addr;
 	return 0;
 }
 
@@ -3314,7 +3314,7 @@ static void decode_umc_error(int node_id, struct mce *m)
 	struct mem_ctl_info *mci;
 	struct amd64_pvt *pvt;
 	struct err_info err;
-	u64 sys_addr;
+	u64 sys_addr = m->addr;
 
 	mci = edac_mc_find(node_id);
 	if (!mci)
@@ -3345,7 +3345,7 @@ static void decode_umc_error(int node_id, struct mce *m)
 
 	err.csrow = m->synd & 0x7;
 
-	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, err.channel, &sys_addr)) {
+	if (umc_normaddr_to_sysaddr(&sys_addr, pvt->mc_node_id, err.channel)) {
 		err.err_code = ERR_NORM_ADDR;
 		goto log_error;
 	}
-- 
2.25.1

