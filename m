Return-Path: <linux-edac+bounces-3585-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50198A938B6
	for <lists+linux-edac@lfdr.de>; Fri, 18 Apr 2025 16:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94B497B48A7
	for <lists+linux-edac@lfdr.de>; Fri, 18 Apr 2025 14:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C10C82899;
	Fri, 18 Apr 2025 14:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="mfTcCXGS"
X-Original-To: linux-edac@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010033.outbound.protection.outlook.com [52.101.193.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C67B282FA;
	Fri, 18 Apr 2025 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744986673; cv=fail; b=bJaS0kBOcw3QilrnfiXzX+JlxG9O15o8vYZjjrv+q3hIQpUvMQ9MGI3xVKUZ6GdSmPFFdWtTcDz4Nxq90WIdlZ5ZeLdGUz8nKIHDhFw8YmhTskZzQy9NZGtzTyAKQR+fdjCvqT0LgMr2re2bAjKQsAEHeqmN9jNrrTbV5/oWjXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744986673; c=relaxed/simple;
	bh=ii/ZRy7YCksaiW8E633PAb3esJzIoeryt+ZR0Rp13mQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=HdzgP3drDae2AHWNTHGBHEhaUGfrjPnj4g0qzHRCBAl18qq2rSGJeZPMP6sLyrpTgJGz/h4UldjdFPMyCr2MkxtaLieDVOkkMSPivyxqd4Z7Ga3h4VujWxJ7oqFh4CX/dcVl7R2pUIzyXypFOrin0YRaisfZOGbu9H6en9inseo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=mfTcCXGS; arc=fail smtp.client-ip=52.101.193.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+0wRuM72AxmQFpU9xrwIOgeDhYJsCQfWk3hdOwkwxE40AwJDMtGIbJ7gUfL+OTnBaT2lbEqnfMKJ6RUjD/WdHFfDb0xDOSBAY5Gf/u3j+Pxs3zq+3IOgixQ/P9WoQNy2NrylZshoVSBWh6u+xgWSY91jPyAGd3XjT25n2XDqZekSFpRK5Q8BLcxW/UkMb+crL6TGPyPVzKTK7mZe/IOT9CiubkJVPUvhXzq/BTILOImrW1nhVLb2fZL9yJO8xCAh1OAxshMfvQb3C8VsWLViEnjOZX7JQ7BkIgUfhVI5Aw8Wm26m2VWH1evJRpaZQKi+Mq5GMKrXqtsnUuroLYAWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05Kk0xlKQtGdSskDhCbwGn+OV7rFfRBYLn5Sn4K3Msg=;
 b=aOrWDWYviMSWVibuNmb4E0dVZUYvTmXBRM8DLyrRSMEO2ZnM+8+/pFS6gWtn85n9KRCKW2Q6/KOdsbr333sVHM0f1Pr1PE2RKioO8ach34v2c+S90KAn1sF0g6KVctXsDZGK7Wbly/FbCMNZY1V+RJTilWZbRcU7Drz9Ke+0+4QHmm7UaBLJEBindEPSzxxelbu/lo3537S8x283Awy6P9N22/+ZFh3bU04ETOvC23Ti13FNrOKYAn9j+roRRX9oEVCzBtwQHCzR6KWPc+LXRWeZAH/Q3qiaKYavrKcCbLBMTbdJGOsqOXcCFwEnjjfHiP1rAwqbIIURB6pEnjnSTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05Kk0xlKQtGdSskDhCbwGn+OV7rFfRBYLn5Sn4K3Msg=;
 b=mfTcCXGSDp2/FXyNhGs9RGgC+hq9TvK3f8TvAJ3LEnod6L33iq441VT3DKqhkiokIB21RBgpxnqgdrA//cwtf0/3J+xI92UFbliZYj/Kvq/s2J8fS69kTFO3Xff6mQFELlNSPUTc7rWWBMLtt5ZB2dsmIWrx5bUIZSMu3/2UFrb/MmnxTs5CoDcs95vkXgMXOGRrJhcSzLMIrxD+UVWISzFeYE2pVTnry8ybaZSXWWFkRHadcQ/knDbJJw5IYxsLEEQF6BL9laAAGpND5FmbcFbFIPWRHbHdrmkjHojw0a104JvaMJ+wNZG1zTKtql+zR4DT1vGV8zLMzpSAKhytmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by SJ0PR03MB6674.namprd03.prod.outlook.com (2603:10b6:a03:396::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.27; Fri, 18 Apr
 2025 14:31:05 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%2]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 14:31:05 +0000
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: dinguyen@kernel.org,
	bp@alien8.de,
	tony.luck@intel.com,
	james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH 0/2] EDAC/altera: two bug fixes
Date: Fri, 18 Apr 2025 07:30:50 -0700
Message-Id: <20250418143052.38593-1-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::8) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|SJ0PR03MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f666b3-e8af-44ea-60c1-08dd7e85a68a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vNJjXKNJMxJ6CgRqC668k1wDZX4r9WgPufszebOApQAPkZhJxo5j1OkxgXt8?=
 =?us-ascii?Q?jf0uiRs/Bg3iGOFbFz9yG4svgapjC/b1P+OcuW07I70B3VRt9Q5mtlgQBYz4?=
 =?us-ascii?Q?ov7nOlLsbSQz6RPXORRLY3JNNs+wvtzhN2SWdpc0GdaWNQ1QPruIYNxHncUi?=
 =?us-ascii?Q?p+o4VhGLpnh48PrJXLUwizeIh29zn6HbTT++Qb4wfM6E/ei31SEZ7FxV2sib?=
 =?us-ascii?Q?PdvdafPgF1bwR5llYRrK7/kNP+MaRdCtUPA110FQxQvqzmzCypayEK6fXqDc?=
 =?us-ascii?Q?0gSdshNQ4yztouJ9SRoRArc3B8sKqjD/zOy0/nfFxzNNNrmkQmsDkdwq3wEm?=
 =?us-ascii?Q?3odwKuGclpS3g8cg0DQg2FnO3N91FLHNaNkq4cWYvifou5DMuf5RwDiNPYm6?=
 =?us-ascii?Q?3bKLAVAEtBQKTGajsLHGq1aSaKPAm3NbvtpFEdB1WUzC7aClUhWUEa873RL3?=
 =?us-ascii?Q?P88ecGno06vhS4e6/MB8NmGT4tcD0RIQ0E0oVQWVsT/WIIeDEBU/hBS/vAXZ?=
 =?us-ascii?Q?7LBHI3TmuFR4ACFqIcG5Pgq8nOpiB7Y4t9q9SJUpss1rFAroJKqR0wactRWn?=
 =?us-ascii?Q?wqY+O0c1U45LgyLfBRdGmSMDnDsWuUypjcvV076hOdqIM9I88nIehLJ2nTLp?=
 =?us-ascii?Q?IPC5HCK3QOetETEtpslWZ2hp/qou/UNHsumDOGExfuc/9ieQ5AJbf0L5e+VF?=
 =?us-ascii?Q?xcwidvUAbF5ZHC63I7VoZHQXphbcBhswSvbwkpmiZL3LDLW141KvLfHx5Bvn?=
 =?us-ascii?Q?PcK59lGMYk+EqF26SvIE4bJN88I52A5Z1Nq1NJnr5w5CGqIZA5grlVXXzDqN?=
 =?us-ascii?Q?A/0zfkn6fB9zBcnV2pKnbTPlpyYkzi45nze1m/q39P30NtFzk5R2fxX/K8De?=
 =?us-ascii?Q?IX+JmG/Exv9Fi+Gk0unikX0mGt4Xcfj9OdRHo/z57uKSa50vr2YOOXU04Dr0?=
 =?us-ascii?Q?ezajJwB5K+dTf/kDmVCK1ZYMLEGSHu9EF0DvSIEPcpl5WaQgf211AIJDmgCo?=
 =?us-ascii?Q?b6HP0Kk2TeHtBAfSBlRIMLcEZeD5mbMJHIS4PSa1NZiXtpou4/ECzsZ/5qlu?=
 =?us-ascii?Q?QnoS75ZFhSVw8nXgcrccka5flMPeReydzAVVu79huIH5x34SNvEJBZphOVTE?=
 =?us-ascii?Q?6Fc3i6DCKY5ZYST1mStsQnkTYe86IW72hDTzN5bQZRSQS5O3ar5cKxVMKNae?=
 =?us-ascii?Q?j7TtjbBdPI897QtiNVqKVSZJDZJYovSslmnX4Q3CDNAEOK3ApA57qD86fdbv?=
 =?us-ascii?Q?Zr+KO6QSOQmOuqMxDeH2KX+WJQtJUDFiU5WCRhF742FyVT/8EhCxciBFExSV?=
 =?us-ascii?Q?9B0Eo1gra+nqtHzxb/lu20VyE1ZKLK4SOc7/NjaFb7rHvQNkLQSvGzkMiRJn?=
 =?us-ascii?Q?+haI69k7XUyeOdSnvMp9ggd90EKzwDuzwuPdbAA7mfnMchozq9dvl0E5fBFw?=
 =?us-ascii?Q?CnolM+D7JIY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l/sYw69hlNbtLqT+DNU0HN3GYPPH8Yt/UigP/WoThlbKgqHRMbH30Yvq2RqN?=
 =?us-ascii?Q?KG05Ez78YX0ZGdnhIQ5fFkD0h21IP5T0HJRAJFyg+0iUJywIoQMQ4aYrt6Yy?=
 =?us-ascii?Q?aDKXOWzWc061WgX4E6xcL0CWAiF+qX4DKOt8F6oyQi4Khv33iXF6wstFE5rO?=
 =?us-ascii?Q?uor4m0hIQ93NkC9cBsqTyW/Z1xibIxnhK0XNKVfAtI63zROgTO9/3gFXvxzN?=
 =?us-ascii?Q?LJMugMVDnSMDO7LBttFAOpagLUh/g+j9bUB48izpJ7OpZ5AnS1+tIn0VTi/7?=
 =?us-ascii?Q?anfWH/ejAJmcFxPUUBGwTdE9HivpDE6dLsbRVqk1SoTvuP3U0Luf/zhcrUfE?=
 =?us-ascii?Q?HbZ0qbOYpeEwuFEmUJVo6HIVfZJfStNZKGUHL8ul2sBXqOzf26tslT1NYyss?=
 =?us-ascii?Q?xut3C1FXfviZRDA89kuZCCl8+rB8eWS79zAeeoGMxE9xQHK35gIA7tITJBuk?=
 =?us-ascii?Q?Xh9p2Ip9mREa0kMbViXY7AtEwoePodXppb5dIx9QIaHk1m0oFZMGNTrI2i+b?=
 =?us-ascii?Q?CAo5c88OFihi7dJoDk+MqopIBTJbkNLw0REZlRZRoXM4qMSilgc8/yzPvkad?=
 =?us-ascii?Q?flYgPdyPTTt/Z2pnZQWbRiP71FHMnqgaEjVB26P7xGZkCRbHtYh/XM2kr4H0?=
 =?us-ascii?Q?ngmUXsI1YBoUB2zzEhsB/MfMNhnFbuFB9dbSZpmpBoSLTz79MWMjX3sVNKA7?=
 =?us-ascii?Q?LIwIGuBBp/5Umuk21XJmOhTengw4xab3foUy/ayz+jyQWcf8fJGJJ2gTXSdh?=
 =?us-ascii?Q?BJWf5M86W9cdYKn+v0ouaKpSKGFZWew9SjVQ87sABWdhx605x6Bg41DmsJXK?=
 =?us-ascii?Q?ZeZInkkYkbpRWuia7KoIduLsQevHPv1RaPg2ntSmNBcBYi7hFGZjhUvgtFNo?=
 =?us-ascii?Q?OTyHn3mvmUXQed1A2f41+Pu0j8/5ujni+yL3lCYUL/aaWe4a9/9Cv1/Z2tc8?=
 =?us-ascii?Q?Fj7m6x20jnl7ssFhIXQhxrscTc3olRsMhyzdcWcQPThkt+qqsq8rIFjs8jgN?=
 =?us-ascii?Q?tcyiZ2fASNu0HYvWpnJcA7ir8bkvoFLZDto8dFuRu12zzCzyMhr+GiuaHfXO?=
 =?us-ascii?Q?ssYD22DL5iGgK+Y6/ezDhv0xhbrb0RZ0kcVqSzV+7wdB0nhw4nxysmjIB59K?=
 =?us-ascii?Q?hAaodEcacx/A9TgAXFHeEXS0bnuzveR4L9YLnanIme15oZS8An167pLZP8e3?=
 =?us-ascii?Q?fZcYKZT5zgSqnuKYNt6Ci1XKNlqzDZVOcoFkR2jBup68XVtA7mGzJi6ho9z3?=
 =?us-ascii?Q?FrU92mVikWvZufW72kYMSUKJZBAUV1fcVIimUXufmH9NAxuURmqL+Q5dLDE/?=
 =?us-ascii?Q?rYxjAJqvbwFJt8PgjmHEZ7Xbhg0kfdBZn5wskdUVUQvdpCGwcD0q0DpVCDVG?=
 =?us-ascii?Q?mhaVzAP97eN7Gb0v2pZnf3SPJ/uQGiLp9Byr14X14L54EU6KRt+sx37gLhuu?=
 =?us-ascii?Q?Q9h/ugc1JQP7zmUOfhVIvdsHYpRHPaBfwgTnF2jUHxz5B1+QzOPFUYNo7r/j?=
 =?us-ascii?Q?+xoDBKOFTZMi1c+q6E0XltbkBAumTZvtMLigoZhFHfDT25Ru7Upw579fZKLw?=
 =?us-ascii?Q?XG4pbAGoXZ/cXZixnhqlZLVlGjonutbfp/azL0dGmc6Ragte8AywArbyicLU?=
 =?us-ascii?Q?Zg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f666b3-e8af-44ea-60c1-08dd7e85a68a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 14:31:04.9816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4CU5+cpqkOu1hEEdCxJdRxU0CyfVsE+qg9KsgpRyoI0hfulp8vGua0u5BzVv6dCOZDPbL8IG47sy1VmRcAU02dweKu2pHalZM5wWfejmMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6674

This patch set contains two bug fixes for the Altera ECC manager.

Patch 1:
 - Fix bug testing the wrong structure member.

Patch 2:
 - Mask HW interrupts until handler registered.

Niravkumar L Rabara (2):
  EDAC/altera: fix cut and paste error
  EDAC/altera: Set DDR and SDMMC interrupt mask before registration

 drivers/edac/altera_edac.c | 9 +++++----
 drivers/edac/altera_edac.h | 2 ++
 2 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.35.3


