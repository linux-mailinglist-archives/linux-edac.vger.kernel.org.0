Return-Path: <linux-edac+bounces-1708-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B303A95958F
	for <lists+linux-edac@lfdr.de>; Wed, 21 Aug 2024 09:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35C4C1F21BE5
	for <lists+linux-edac@lfdr.de>; Wed, 21 Aug 2024 07:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C992D15749E;
	Wed, 21 Aug 2024 07:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="QLjzqJmo"
X-Original-To: linux-edac@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2044.outbound.protection.outlook.com [40.107.215.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2474E136325;
	Wed, 21 Aug 2024 07:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724224655; cv=fail; b=poMy1bs3ZPz4WMSulPRL2F5zu1OTAIWL4KMml3wy/WamnF25FsE5CDDe/vlNEHchB59rzEmYFYXkhmMUnOWV3AOONdIDBxUUCy3iKoVvwIbtseqqFTaQjK2klIf3nPNrvk/YmtUnyRLXlB2lgeZC0sPhIbx4l6W0KW/X7vfYfTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724224655; c=relaxed/simple;
	bh=ZBqwgOnL9ifqUZ2UwHQJE+IhHkoYunb+0dGMWegPT3k=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hF2ap+pMvjmkYt79WprMgf4DmjynKQvrycJTSY3TvGe3rd2UPNdjufNeA5iRoLKn0iZVOrRb01OrYnYNeevVBiLq2avTU+eHYctBFQtKjpYK2lLzZnUJ9lYsM4GDYpP/ZJIOfuh6Uoa6mIhaJJ0leBLtsEe2KnBiXreDtvZyNcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=QLjzqJmo; arc=fail smtp.client-ip=40.107.215.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NztO2zZYzM62elQRFgqJ9E2GWfX05wcR1e97t2DKs6yWpiu0nS+KnBUWKLK5+Xvcmlr8ACCNuqcolhhISOUGdzbO9q8f418EgL9BSJAiniFZHqjJJ4C2+jx+9AHCrtX5pUMVA8IcZDhSZXk2A6NZISiwuZXqG9H8TYS44bDnz1oFrdpo3/6QLDIUiIKVDxSPBI+2zKCRFOBynoi4wWlahP7RZpa28QubvWjjzgZKvE+lMvCCPREXTvFu/cNFEmWIuh+IZp4+KH8m+6wwMxUh6fnk9gRF9VQMO2fFxmpaZCo+cEXgMg+Muf86+cSY6kZXcmCMSioGu86NePGuqakVUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usylaqeGKsVC1uKi9aq0MDx7wGjhXKFZMqjTBJteUzM=;
 b=gK5EJSOT1e4HTps9/GUekbiZvQG+FK7jebnhRuEdFa+qTEGgXsDqctXBhZ7IKeLtZFlFz+f/vTzOml7p//PW0r4sLDSM7CfPcBjcs5NNVsNXXjr9f7OQDyL+IGerEbI8La9HqIi/GnROJdhgfMDYKJIGX0CmXGK1IYB+DjsSvsIo04eQaeT41JB3ULLanBEIZPZuCiTHEPCJ1HmDlI6HLU7YbnjYjGkgWqtjwuvOMlpAROrq/n1auJC+6/RmtE98PVvBerHz5iNkwJIfctjc+N4H1iHhliRwWoSdBQ82BrqSAqLoYGJAxjHM/jIY3mCcMw3XdCUmw3nkwvIbvnlsBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usylaqeGKsVC1uKi9aq0MDx7wGjhXKFZMqjTBJteUzM=;
 b=QLjzqJmoRUmO8smnK638f2tjF9iMrukbIZK2j3Ve9gNt2UbitTjd39a7RrAFmIJGJwb85ZKkY83f17C2cslnjg4DSs/l9/0Y7AKDHAS95kOwY0Rpq1jm4twsndG53+peu/B5nK5iGtYCgN3Qi+QlpAseYr5LCDgHqquT11kYMH1mzVRbzciPzUtiAoweKQZHnzD2Bznj5ww707GCk4YETq2Y4cItBlVgTASkACCMvKapm7ihMWJYU0+AzxnuBBZwOon/sYkuiqBt3n5BzAhrtO9fBtjTesq0qL02zhK7B+8LwWsgeKnz28HOcROWY2Kqm/RVYVFSJl2ykgNGpyDQ4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
 by TYZPR06MB6073.apcprd06.prod.outlook.com (2603:1096:400:333::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Wed, 21 Aug
 2024 07:17:28 +0000
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268]) by TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268%6]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 07:17:28 +0000
From: Yang Ruibin <11162571@vivo.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Yang Ruibin <11162571@vivo.com>
Subject: [PATCH v1] drivers:ras:Fix the NULL vs IS_ERR() bug for debugfs_create_dir()
Date: Wed, 21 Aug 2024 03:17:18 -0400
Message-Id: <20240821071719.8277-1-11162571@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0003.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::8) To TYZPR06MB6263.apcprd06.prod.outlook.com
 (2603:1096:400:33d::14)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6263:EE_|TYZPR06MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: 919f3dae-c9be-4745-db75-08dcc1b15080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3jUMMQi27iKTrr+HnYztSo7d9vac5WSb9JYk3nJayQ7A0zVuY1bmfDVHRbMS?=
 =?us-ascii?Q?BalHHHRFrh+AoYiGh+LzN6HczLR1fbRYWUeBaQzdnG9F/sB8jAAsX7bcyREM?=
 =?us-ascii?Q?4MdkNRNccG8jaOhpk9pqhdAqI+INzNLL5rWA408JNrTUZjhV0oWdLBRpcOHK?=
 =?us-ascii?Q?ZC20xiwDCazHQmc4lMbf/fk97G1w+jC5YLJDOpu7mIsDHMJvDuAtRfxPHf++?=
 =?us-ascii?Q?i6nvRswEKghOoqn0bXRDYPi+37xnwY2mTTALU8TktLXBDEZiHEcuG9APoQ+O?=
 =?us-ascii?Q?Qzmm8J4zCUrJH79+QsxN9cYxZtTZDcmKrFM2rzs8ndEB/svS9AiEuNZZGyF6?=
 =?us-ascii?Q?DtDrRPZjYzRv1YBOGYTpcYGddMlF4M3bnJCgPDOPIZMNeeh2wVZBHcFu2S0i?=
 =?us-ascii?Q?nnc2WTl9NP6dRCw5pffr6BC94blf0c/GERKK69uj1JLV4P1Ewme4Mf68F7B+?=
 =?us-ascii?Q?q/qKIvSZBotnI9vVMTkf32/Hc5+Is5/u/hukERjnzEtOhJpFDUvOJGgBA68X?=
 =?us-ascii?Q?u4Kqqfe8aVEMOGl89V+Ae7n26NXUUGjyvN2VQdSGRW1XMfHnsmUkRidu2pdG?=
 =?us-ascii?Q?gMd8aR+gXaZ1zr6fteXiDLrahrlY6zScyVd7PB1Jd08Xb3Y8R8g5jc7FGnaB?=
 =?us-ascii?Q?KIhs9CoII5311+77YaflWAQ9R4BapK4okzeJHH2MwGC5/DrS451fRrERX0jR?=
 =?us-ascii?Q?guWlOCxOKPdHJbSHNttwR5sbr/AaUSDy9ealegXgrapwM8/CPyDFgyQsO+eZ?=
 =?us-ascii?Q?MUDO5oVUjP9j1Qlj4pj0a05L2OQ+Ep5vHdUzN5lsVuQHXCa6HyDVu8jK7UtL?=
 =?us-ascii?Q?0WYY7UtywqMPIV3FPP6SJ09t3M5zZ8XGHyPWWwYnd1lO3W55jqTGc7pV5kkK?=
 =?us-ascii?Q?igIwTjgrRb8VuPfsIqsiPU0dogREzASGwvNZcLiIDu2mV59vfs3iBJX5Kn3b?=
 =?us-ascii?Q?5QOdZgZA2e1zMNG0YN5zUTuLXz8elTkceIfaA5h179F+IDRquAIJuBRiFT53?=
 =?us-ascii?Q?R53qnye6OgsivjM+Ad/0B61OOKYF4UIGpUnYWBV/QlNd2d/vUcwnBmQdrLl6?=
 =?us-ascii?Q?i41PPiKQoFMU/x99R7tWB54EI7wt8BEFb8q69JH9gRkt5ZhfFhSuOXzzgc4a?=
 =?us-ascii?Q?cNrntbSrQnzZGsgwhTpleDC2DzhL6Ii3hxBnbqX/nQlDx9n3gl4mCXLUqoYd?=
 =?us-ascii?Q?VZOGZEYFcgwcZot3kRoRNGnAn6rhrux2XTb4zRErU1wE/LnAPTCFSSrOp/2+?=
 =?us-ascii?Q?B1bUy9SzQq3Vdrg34DENwr5URS6TangB6N+pQTaihVGuDR7r/2r4iFVePx/u?=
 =?us-ascii?Q?3z8Bmzo4XV1rJe80QPEKut7m8q+q6yUGcooHjwgOS2Iv0GkNxKdX5BFLU4jt?=
 =?us-ascii?Q?ofCNBag/Otvo6emwZea1CxcALqzQXKEGypzgmE6dYO98gR+knXt8XQOcwYRx?=
 =?us-ascii?Q?G5Y5g32a+1Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6263.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ndunmo1NJkyhGKv7bTB05LsFJZEDdwjBWAPVsok64ahpc0pAl4+X5p7+2S/o?=
 =?us-ascii?Q?h5rT316ShRocHihEBAHyTKUAyQaYpse0k46GUybvxKWUMFO1dxn+xjnc0k2X?=
 =?us-ascii?Q?2XEIz8jSVsYGs25bKckToXzhLrfJ3tDYNZ++vTTjhKqOIu+EgLsMmCoJrbjA?=
 =?us-ascii?Q?meNQLTJbT/fXNetgHb0JxW5k35mK7sMuS9CHIUoHXAEnyJlVbY4kQqRu4ZKF?=
 =?us-ascii?Q?dY2r+9fo+Cpxsj2w9VTU6k/TL5pEduQrF1LNE1Nu6IUE5x3kRa2HhEU0mgie?=
 =?us-ascii?Q?y0MJKPuRugiYY9Ud+EjD8k6+/0t7JwcA+JwtGe0VA3j43e3kpLTbTmkUqObw?=
 =?us-ascii?Q?w/OPIb7qw00xGz+ueC7AJCZccb1AtjL/8NpeAr1fHmQlVtoZS1hdZj/lTbA7?=
 =?us-ascii?Q?FLnNS3KikZ8q/ZKghV2qDOkqgCsC3TsJR7tMrym6X85mSg2MaKrDHZ5/m9nG?=
 =?us-ascii?Q?Rfe6FMT9bB22bBdT+I/uZWvo3Q0NHzBSRIS/ngmcMZO9q122x56w5q57yzM2?=
 =?us-ascii?Q?SLqU04MxTaXiD3WFbh/0j2onUT7vpZ6E/tAIC5yaaJdJuvjRVFchwGtjFDbo?=
 =?us-ascii?Q?26U0P0tyJObBdopwgro0bovGMwEt6Z7AYV8FsbMVdkBe/NX/j02d026LGAKR?=
 =?us-ascii?Q?MvW6TUTO0pOxFUX7i6961OhjK5eQLh+WHAjRRlvaCRbzj3yzH9q2zqSYWNzu?=
 =?us-ascii?Q?tfXmoKckhCF7hFtvTVb1vNXdVvckwScPqpCK3MRgzYGkYgPsQfI3kZKv92dI?=
 =?us-ascii?Q?rFLZ7KmX3gqJnKlokM9giJDxCJJnKXq7uaDuo7DDfXyW2J4vi/ErorU+SYeY?=
 =?us-ascii?Q?TjnSdFDjpZC3RNbFRgICW2LHTj5JaLNeTF6rvr9ox1GUI/8XKU6YwDZNne1J?=
 =?us-ascii?Q?/RdhX5C2+CnrteojOguWgJNScFlZN5CQYbOJMUiRfx2YmsHDTHDZMA1DlXwB?=
 =?us-ascii?Q?wDySYbRYfycELCBJuKazADvzw3zx3Tx4UsEH38rqHGoa0s9TXBWvPS5w9XQk?=
 =?us-ascii?Q?4TqZoDDos7sRJN+djHBYig2GATS9bfyNZMuV6a+fruBzK4DaSYIi5EWBNL4K?=
 =?us-ascii?Q?+wTCtRQD6U4VZY8nVFBg3x2Dv8E3NCpog57VDWxw8uXrgYpnJPetHStGoyiA?=
 =?us-ascii?Q?aufF005YmqKqACNsTnVCRLqB9EAFpWAfKx1+QZw6CQN9VlWM7omWFx9uZLUg?=
 =?us-ascii?Q?VTK0/qNT8h84WYqK7HN8Vb/xnjKV5JkTiJMA7RKZju5t9vxsY4fOykoRELqM?=
 =?us-ascii?Q?wxNtyeBj0iyt0Rxi26YawaWSvOlWKEySI5kaAw72b7bxO8LvfiDNW3KVd2r0?=
 =?us-ascii?Q?PC8XM8qVzWWYU0yR7FtaTgrZ976O38GVWDoGTWwaIIihzbHo38/IKiBHfzyd?=
 =?us-ascii?Q?pi0Yd8nKAwVjtzQ3W1BMbhulmuYNWYj59OGVROJdqTr8dav0Y4k1DXjZDne7?=
 =?us-ascii?Q?8A+LpDNmuufd1XYKBpUH3UXrZlJwTnKGp2jDTqxt9O9fEKawmTw9OWrKtd2H?=
 =?us-ascii?Q?VQ5Kxnrqi6zUVuhnLp/VphYXFq89uk+1+D4R68BZgptBs/p1XwHx1UVu0lZh?=
 =?us-ascii?Q?fefuO3TQnEEK1u9FmZVpeEWM2GH4xaax3/WFmGyB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 919f3dae-c9be-4745-db75-08dcc1b15080
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6263.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 07:17:28.6037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MtnwqFmSfjbU77LFlZR0gevUHzHyE9T/dKggj9dNoybRIuEBBRWMoHIUZ09Es0np8lqGvTNVL1TDZ0xtgwZwUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6073

The debugfs_create_dir() function returns error pointers.
It never returns NULL. So use IS_ERR() to check it.

Signed-off-by: Yang Ruibin <11162571@vivo.com>
---
 drivers/ras/cec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index e440b15fbabc..ebd4631b685b 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -489,7 +489,7 @@ static int __init create_debugfs_nodes(void)
 	}
 
 	d = debugfs_create_dir("cec", dfs);
-	if (!d) {
+	if (IS_ERR(d)) {
 		pr_warn("Error creating cec debugfs node!\n");
 		return -1;
 	}
-- 
2.34.1


