Return-Path: <linux-edac+bounces-3597-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C9EA953E8
	for <lists+linux-edac@lfdr.de>; Mon, 21 Apr 2025 18:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5267E164B70
	for <lists+linux-edac@lfdr.de>; Mon, 21 Apr 2025 16:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5D91E1E1F;
	Mon, 21 Apr 2025 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="lJlus1CH"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9816B1E102D;
	Mon, 21 Apr 2025 16:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745252099; cv=fail; b=e2okkeUTLDP53KBbq/6tV5TT03R0Y00tD7zWqvMQ5WEWHXeD2eluxo6ZzCpZc1j1y2SVsv+rXukrnQalGsMJjyUNuhwZxbuGQcXA7LqrRNq48u5+zn2jndtv1t3Hi0SxJdsMqdNurSHuZWfkQ+NHAq2NqBKscmcX25v5z4NCzDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745252099; c=relaxed/simple;
	bh=lZUZjYlljIC6dFhmgAyPf/tRguvpm3wS/yMu0xoC5b4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=drlBQIz66hD4/xEr2zjIWXFS65ZhVWrcHied6pXm2z5wdCjg37EUPwEqsIvw47le0gP2yrcwn1RvlPA1hwAvU7VB0SrWziqF/mgtZ+rf1sy7a5RIPBiCVJkCdvTodg4zNJgPox3kJo56bYNUbxWGWPCkw7aYVvUBM2IypWWwk48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=lJlus1CH; arc=fail smtp.client-ip=40.107.92.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NROrI+IoK9xU+ngvyD7nfc3AvzzHnnUoiaKWbbhX2EbcqLSXD4dSLuR3EIgxDMrtBIIov0IMGV18qtNIarXwdVQhxl8L0avNJz2CSjpzb0jIy2vx+ovNlifshicg7KfDHReG7cjHwqz/f4NIFLnL9XLtbQOpsqkQTHCiOYKc3Ds2aaSBz0V+gb+jZtvqAbtu85U6b4IKOQaG+HvPr5nylpFtFGZ+5VAR8kIDxJeGc3Ejrxi8qaFw3Wfypqmi1Lc/F6wxlmKkub6EB7qO3UMspQF6S38dhPDZJk5NkRaHhj04QbZwF7TW5pJ+8Qx2+jdl07P5vGlF4eN1wWbpKElrlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Blf9vsT9ycYpAgkw9mQuq2iZ4M/byJ9KcnRdCF89EVY=;
 b=pQH+CAKPTHbFJ3r0mb32fExLtjTbtYi5NiW7lDLaixTwixeN2rvkJfYPsQxJgrm9NH3O8icgkv3yyJjRlJ+7U8/8lwN5kZ+m/hzAD2o6Zz0fpa3pmi+PyFO0bQm3wIjrdHUyivI+VHRTCF+i0QkUMAVhzdG4Np+481Y0bglHHAkrTDhLaFFKm33JqERJsMMyqsLdfkucJ9RibVljpkc9Ei5a0pvYyr0GFHSntTAC2990ABjngEDjpzETwszcTHyD03oIEp+8c95He1xOC5LqHC/gKqepR8ux4lt9tCZ9R7BufO9a3/d8U+V6TiZ/eSmSSiiIvluMKRBJJXvf8P6/oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Blf9vsT9ycYpAgkw9mQuq2iZ4M/byJ9KcnRdCF89EVY=;
 b=lJlus1CHg/WcV6hnKMEZJk8wUA/ds7sa+342W6EUfc+vWNtHOlqVGYvg/b9PRFoHVLablxl6JYErBOhoURx+EOI6b4YHVN1T1e7e062FJf3yAqWbPERfhH38BApwP2rxtsosiM+qyKg/XnVToNROQvmIQwNh4fIa41MpesY2jC33TVeVCqTGY0ASBGPCwDkN7yk2DJ3aagOj3t4zwe4752BQHkTyv3hHmY3ac3iQc1NBREuFvSQ/y6vb7oeEala30q/HYzV+GD76hm7tNJI7qqHpp1zLagjfwHwF6g93x/qj+hVaGmu4p63amLlHOaIwVBiWALIFn9F5j1pyyZU+sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by PH0PR03MB5800.namprd03.prod.outlook.com (2603:10b6:510:31::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 16:14:52 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%2]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 16:14:52 +0000
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: dinguyen@kernel.org,
	bp@alien8.de,
	tony.luck@intel.com,
	james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org,
	tthayer@opensource.altera.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>,
	stable@kernel.org,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH v2 1/2] EDAC/altera: fix cut and paste error
Date: Mon, 21 Apr 2025 09:14:46 -0700
Message-Id: <20250421161447.41886-2-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250421161447.41886-1-matthew.gerlach@altera.com>
References: <20250421161447.41886-1-matthew.gerlach@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0134.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::19) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|PH0PR03MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: eb95f2b2-285c-4e12-a4a8-08dd80efa56a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qCONDOR5rFRZ2YMivsac+xH8MENByToZf2/P9n2PjaPXlv+Mcud2XNT18wQF?=
 =?us-ascii?Q?jrrX44uleeukHSEEhlzyBodp+BDz8TDJEtD7Lx7HKWEy0niC9p+AL15GrbKL?=
 =?us-ascii?Q?keKpomwGj7Ox8hq2aJExXDzqayXCixjDlnynwgTmVF8GwRn9s17iICicMTef?=
 =?us-ascii?Q?W4ZWlLt73he9c1NKDEcBXQ8WFAx6/hQYkFIUZcL+EcwKVxmthLxkplMclGex?=
 =?us-ascii?Q?6S/7FPfEp1cG8T8y/5TTJoePtTVIfV2WxM0Zxbds5asWppUYWkc7mvArDP/5?=
 =?us-ascii?Q?ZSukCfPlJssjb+1pgr2VbGEaWGKDcGepACzIkguIxuHZPbY+K3iPO9sVasIz?=
 =?us-ascii?Q?A4NEJe+beOjqQHxpi2TBdezYF0s58o7YzBqRzL9btURYxbmD6SZ7GwMsRSCt?=
 =?us-ascii?Q?o35Rjf4k8xKma/61JcuSd92Ni5zlgfTuysjlb9LG9mwkS50jzXVRi0W3770S?=
 =?us-ascii?Q?ibGHkBiO/iBR+4oWxUBescDug6C3+eaghWaeU5QdOhCMjESHfKXS4XXvAThw?=
 =?us-ascii?Q?zvRfF6gbyL2N/UGHlPYEVikptOZbnVMGdc2xfOpcTJJVInu3lp4yyjFSfqqU?=
 =?us-ascii?Q?CP8d851apjL5YzfR4a938eJ4RG36WZtRbMv9k7JebMvRq/3Ydggp9a/Nvyep?=
 =?us-ascii?Q?DF4FjTDyDkwf9Dbe+73MHvkn4VKDPENHutX6TwfFhtC18lUWxLTjG+lPTWnO?=
 =?us-ascii?Q?DVx0zleIGfpE6kptabVLJf5EjwmQmvVJGvH0AAldx6suGvDZQv92ao5SGySt?=
 =?us-ascii?Q?g+yqYy23gheFwUrHTG6/w+stL8ipew92CjH5B5XctrWskGUGjyIHz6gbXKY0?=
 =?us-ascii?Q?QRzTeTh+xr/q0pdN3kYCLsiu6OqtqEMZ6W7Xzy83Wr6wL3kS8MVw6u4D5rN+?=
 =?us-ascii?Q?V2MRYggHNiFBcnK/Di+WEZPCEbtlcpc1qhCRC2P6PipyOHGW6OG+TDMuZZCX?=
 =?us-ascii?Q?dpqqDlX9kao/R6FfCnvYZu0I7dHHtBez4VS9/IbmWdq3VQBgMMek89axcuIi?=
 =?us-ascii?Q?4fgmagv5swY8KFHq4mw6cS6DQ0ocd1+oOPx4eUsSxIOZKuBDLALIcInsHlv4?=
 =?us-ascii?Q?7zBnvQwUz4LXUyT9L+40WaO4EItxtUjbUCD0BDLNy2IV56J+Jyh9AcxwXgfx?=
 =?us-ascii?Q?mPqVH8GcCx8i9igvMVTLj9aqHhMDtIi3VTvwyIAXNnKayg7R6v9WwpaP0+UX?=
 =?us-ascii?Q?D0EmUMpWjGA6GoIH5p050UbFYatzxgzQSbt2ao1rMw+eFm8dCb6clZbpT3el?=
 =?us-ascii?Q?hwCY1ToFKll3P2QKvKL8NEJ3VFlkdpiCGcttCtRDKQWHFJg3CfXa8nnqvlUb?=
 =?us-ascii?Q?3i2+dEkSBcMTVz2TQpo9xzpLASV60osia8AMn/m0U1tVJn5scUfXcljhTxlL?=
 =?us-ascii?Q?IGOp41iE1RgUswJBm1M53JXXLOCgTIkJHPALqSMxfPWRKpseGhFuTcNqIFHc?=
 =?us-ascii?Q?KdxgQRMZEUM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yu1vjFddle091wUx7clWfuQzMVbm2/hFhJIOHhd7ChyJ7hGT/NMTfBBv1VpA?=
 =?us-ascii?Q?2c8hEDk2WYf/Kkn3zU/rseH/aP9GM7nAIC+ERzHAqwbLerZ6EDMThog5z4HX?=
 =?us-ascii?Q?cHwP8pkzql+TLNSugxUX60ufea4+Ze+mB/bmphCqiu4R5LRM6CJewdQ4gSyV?=
 =?us-ascii?Q?MAvFKmxJujSX6Dbk6FxegjxH5IsJU7xd484XRzJAV9HYdzgLY+Mfuvb9wLK5?=
 =?us-ascii?Q?zdaMm8o6h1S2pYej8tOXkfsYv7sAVc+KWK6tW2h/Pr8gjv2F0VNsfaQH81bA?=
 =?us-ascii?Q?3zuFS6f6c27am4Ww4ZxS6jN2dnWdAOrOqMe0S8W1b/kj5WXsbmqJ5gv6+Xxs?=
 =?us-ascii?Q?mM7KGJdeMtmXEFs9nLoK/A7bS2JdmJJHRoX7CBpJBoubTOFuKXEElOvCRi6t?=
 =?us-ascii?Q?6Yl2dLL0arTbqYsXc78oNqF1KPeB7tihfVQDn2i9vblHn+RL4UOPX/TdXAQC?=
 =?us-ascii?Q?jswpDesuZYqDbIqjjrhjNSbAXdgxcBkjQvsFk/C9c0ZcNwJHJ1ltBuby0oy/?=
 =?us-ascii?Q?reJVWhOekjqcdkQch08YsHBXVC62WWE06bbIFkC8RzFPMAULh4rJZ9jNg29u?=
 =?us-ascii?Q?jDiyQG6E6qivoVb/GAUDzT9J69D9zg8CvgYryCO7gH11dc5tlcM6xxE2b9sM?=
 =?us-ascii?Q?CJjsa0lkfOKVoe9Cl8Map/C9GvAufga7QHW81Cc5dv9Mrpv1n/GONsK4+bB3?=
 =?us-ascii?Q?c+4xz9KXeoFwg6agfCCBUOWb7bfgQAKvvPoOyR/7yIERMR2V8vRJye85XH+Y?=
 =?us-ascii?Q?N30W7znY+5z3xqcFu+8owWBLthhfoQFLH0XFsKnffRZv9D8sPfJPlpl37+8j?=
 =?us-ascii?Q?iLDQOaeG61oBmumGR60DdiK7WIL3t/avnW8b/CRA5n9HrAfQ883hyZNXJY55?=
 =?us-ascii?Q?SA341mXIsH2wmIzz6iXxJdvohtqzEmNDAJN8iv+x0EUavtbkLGNCwRr3iIdl?=
 =?us-ascii?Q?Tjfov4jmVVVsWpqiubRkYbjoCV0d/DtbA3DgeKM2dXypcUYeMZXYeXgP/Ash?=
 =?us-ascii?Q?kUo66e1Jg4apWO92kR7JOzaX82V382ekbuADKqZMmYzN+9oqKGnXtWh/7E1N?=
 =?us-ascii?Q?bTIREi9/dQxWb97Z4GjYPjo1uSkNhZ6CdxPTj4o+zENwqA3rH98MKOXuJNQV?=
 =?us-ascii?Q?SqeVweqHCM7WxM7f5MDAijZIeh5+FWZSpX7tbFbfjZ+STJsqs1qm7SiFLtVa?=
 =?us-ascii?Q?V0gtH/aecTGh9lhIDmw7TSYN7NbcTrkAgWo6lyIuW9rugsXdZzdki3rEAV5o?=
 =?us-ascii?Q?/m/Un6YgOIivqYZ8f7rrDpXBy3+jZpsHISvWCevJsscq17Brnit/4VpfdlZi?=
 =?us-ascii?Q?1SdVvtW8dZ1Ba2E+PDcgEZTaGGEkG/FQQOm5XsDxTKqH0fbvuSbApxIsnZRY?=
 =?us-ascii?Q?Ob6+NWCHlw+D4n97i5Tg1nMceH9TcOSTBBG5lMDDk1BrzRC46bvlhVg8vjWe?=
 =?us-ascii?Q?n7mhD3ayJ2LZAisb9NVNSkdDvl/t6JFJhc1lKN9rCcZgIIst9G2uBR9elL8K?=
 =?us-ascii?Q?YjtPlLGInFZZS8/qR1GSAzZDuYSSMv6w5ntphWw2xkolz4uc9n1491bAnm51?=
 =?us-ascii?Q?cAB6xutVs41+ph6SAPEoBEB92CmEfnEDhlxQCig9Fnifjzu9JD/SpNsoSWdU?=
 =?us-ascii?Q?Eg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb95f2b2-285c-4e12-a4a8-08dd80efa56a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 16:14:51.8669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5WlQUEYKJhMWYCvQN4UXoQZR4OicKtz3fiL8yWuoQyHMVhtHBIV6mKC6K2Wx+dX//jyqNSRbxgOH3igeNhgmQafhqmn8+KPK9XlCUizjBZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5800

From: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>

Test correct structure member, ecc_cecnt_offset, before using it.

Fixes: 73bcc942f4271 ("EDAC, altera: Add Arria10 EDAC support")
Cc: stable@kernel.org
Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
v2:
 - Improve commit message.
 - Add Fixes: and Cc: tags.
---
 drivers/edac/altera_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 3e971f902363..88d9d2f458ee 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -99,7 +99,7 @@ static irqreturn_t altr_sdram_mc_err_handler(int irq, void *dev_id)
 	if (status & priv->ecc_stat_ce_mask) {
 		regmap_read(drvdata->mc_vbase, priv->ecc_saddr_offset,
 			    &err_addr);
-		if (priv->ecc_uecnt_offset)
+		if (priv->ecc_cecnt_offset)
 			regmap_read(drvdata->mc_vbase,  priv->ecc_cecnt_offset,
 				    &err_count);
 		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, err_count,
-- 
2.35.3


