Return-Path: <linux-edac+bounces-5722-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMhQFtV+k2mn5wEAu9opvQ
	(envelope-from <linux-edac+bounces-5722-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Mon, 16 Feb 2026 21:32:21 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B11D6147791
	for <lists+linux-edac@lfdr.de>; Mon, 16 Feb 2026 21:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42DEE300D14A
	for <lists+linux-edac@lfdr.de>; Mon, 16 Feb 2026 20:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CBD2EAD1C;
	Mon, 16 Feb 2026 20:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hSgcYN9m"
X-Original-To: linux-edac@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012065.outbound.protection.outlook.com [52.101.43.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0216B2D0C82;
	Mon, 16 Feb 2026 20:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771273938; cv=fail; b=MGya4rmAn9RPG6YfBWgkq6/a0h27NJyBHqlhp0G6F8+m/mkjf6Y855sz1kk6wY0Qshedy7ENqviocX89i4KAFuj5sjjk+LZhmybnlleN8SYHCtYgK05l+RZpiIihzx4LpwDwY05ie+lCuAxxA4thu1oSmxsVahQkJe5uaFgtbjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771273938; c=relaxed/simple;
	bh=WoXl8fZV2NY5Hgy9CiDX86sKBuClY0iWtJEDyO1tbOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JTPSwmfzPo1zkJxfn9K+2NzfOrJE7dkAZhyetxAmd97R5awlLEzMlQplc2AtErCpbc6j5Uw83v6OZT73yOWMdqxjLQlfwNEscGokt06wtIb+4TANBsjNPk10MAHIM5rt82YmXsUfD+Tvl1z1TTvJ0ydHu7QrNziKos8t1e9/GSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hSgcYN9m; arc=fail smtp.client-ip=52.101.43.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hfShLi1lb7atdrzL38GoyvwNThZPe/jDSrFzAeZi8yjfWLiq2EPy0tHefK5crOOoMC64OD97WvtbdTlJEu3xzV7HAcbJN99PLRctWcJP6zlXWjn9Yj2iJNnfjsLVKt4PrjSAzYU3Pj1lArdJOIi5I49ur3wVy9tQUjRdKk76NUxT8jf1HIuyTLJRJv8rA2MMwv46YpX5i2Y2aD0wKbpV4NXp/ik8LeldGsyrtOaFpvjae9UGdQRdde4kN40SNMbvR75taC15/FsobJWWpzZmm/KBrLyOdu5bOb057BxuLY2zavP2Qifp/INkztM4HHB0khRM6sxjrljOx4BdZ6GulQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kz45Ipdmb1a5hYZoDmwxBdj4hAX7N6MDp8DTpRS59QA=;
 b=mzPLJg6wTzFD1UWMu3wDPABUd0cmf+SiWMiMtHZhRvhyFt8cq/vq9AgdaDe17S1AKnk8aBppprbIcqKs0W6uxzqEfZiqIJr3naClXGLcj8Pq9gAZ50j+/YpyblAuC7iAm/TuTJTSrZTm1HJMMg0ZVSpdupxACPn1nQPKWWhgM/B2Cg/5NBUMth4PdgSW6p5SyeYg6GOCmruTC/HQsa0LUaJgPy8ZRPB9r4pWqvetzBOA2TIOulvV7F3lXZPY9tm5dGZw5xxnAf9Be6GwbPAgZlTMg0/DvtlYn7jgWIECxQx6VLcjdc666EvWmQLpyx+w2n0+a0O875mGF2XiIgvmgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kz45Ipdmb1a5hYZoDmwxBdj4hAX7N6MDp8DTpRS59QA=;
 b=hSgcYN9mQnwSk/o1DfaXr4FJZivtXD/mxSgTGpI0mvG7g0+vzXi0kYh4Uo6UkzP7ifLbOOvgPvjB4HcXk/RqUQqy+g/BqMLevMFPL5dWZU6aQQZgFKKODoIXcistYM80hbUeAcMrRRzMBDl+jfDo17ZK4aOLT9SVx34vnDIOFig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 CH3PR12MB7740.namprd12.prod.outlook.com (2603:10b6:610:145::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.16; Mon, 16 Feb 2026 20:32:14 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::7da:cc3:cf2e:8ebf]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::7da:cc3:cf2e:8ebf%4]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 20:32:14 +0000
Date: Mon, 16 Feb 2026 15:32:11 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Aichun Shi <shiaichun@open-hieco.net>
Cc: tglx@linutronix.de, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/mce_amd: Fix Hygon UMC ECC error decoding with
 logical_die_id
Message-ID: <20260216203211.GB420258@yaz-khff2.amd.com>
References: <20260214064203.62488-1-shiaichun@open-hieco.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214064203.62488-1-shiaichun@open-hieco.net>
X-ClientProxiedBy: DM6PR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:5:333::13) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|CH3PR12MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: afac3159-a109-48ca-1fa4-08de6d9a7859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jHV9ZiUajZ4N1oKWrNy2sdIt8Edp5lvXJSdHCUJFdEDHo7M6cK7zkhmwu9E1?=
 =?us-ascii?Q?bqW6XAZIkXrbjuM7j/+sABs8fCr/vOnINxMC1zZIQTyifNJw5ETM/vCVNa3n?=
 =?us-ascii?Q?H9Hh4L8gj8iozlgabAO4k2H84U2v7f809EsKUJ/WweLq8PQq/tKGpsWHriy3?=
 =?us-ascii?Q?FLi8E2G3Eh8yf+q8IvNFrtoeOdWHgM95oR4cHPXla1lqm/KsJLcn9goqpmwj?=
 =?us-ascii?Q?8eVO1jBkmCA9ysk9ebur1EY/2zUo/PnDd2fYXdq2GJ8YxtOVRJE2PDyoT09q?=
 =?us-ascii?Q?tH/ALIPaR4zONQvqMslIUdUtbp4DB6S1NpozTmbgwTmKoZStom44xUwuUhIK?=
 =?us-ascii?Q?5oJReeiDNZ/fnWAjCMAT4zIiIBcgkFjr30Tl8RSHQ127fweKvpebXe32x/FI?=
 =?us-ascii?Q?eRQ+TLjm6hlbXtf2C21FCCu6e9udfS9vY16yt3R1HmeEl/QYytG7ixqib1o6?=
 =?us-ascii?Q?puZh5+9b7UkjUNgr6QQ8lCYcBjbK6suH6Qb8cfSq44iIFtPsijLv5kFO5bSo?=
 =?us-ascii?Q?U11l0tbR2GtF7lwXz0Lo0SMmRot2LPcSDbJrUIrR81V3240JBlKq644d1z4W?=
 =?us-ascii?Q?YH5LseIITXDdIvxbHIAIURY6U4eleC0rsYxvrEBDK/3dXBHESl3DZiRPk8xI?=
 =?us-ascii?Q?eox2EmUd4KjRAdbMrkbtkSQoABrz6pHpCYtXt+sNzAU8RaGdd3Wlz7v3cVx7?=
 =?us-ascii?Q?m7DI1cjRstOM0sDdbMBUmcxyGp8WcvPXiXpAL99ktvSak2KtaAD0gWMwBL8Q?=
 =?us-ascii?Q?OjuO5VvIt2MwxR7vWkAFisvo79RaZEM0Q7C+ZbSBrHdrrVVp0uChTjFTwJ2/?=
 =?us-ascii?Q?2lRaWN9P4kzps4JIiWpz+oH/eMY5MVr2Tli2/jYxiKKI2ayVJ9kDZ3uKCOGy?=
 =?us-ascii?Q?1l1EG2Rih4vVWBY1YczbO7d5O0XTfdG3h3sitHCMQB+yznHtqZA77EJfBHYB?=
 =?us-ascii?Q?UaKpIeX7FysJbBygtmX0LyltTcX+a1dPIsVRWVfsvI7y3TJ7G+wdIq83wQYl?=
 =?us-ascii?Q?xKTMoJkBaIzy3YIpo5A8jbhdzauE1eMu1fidXM/yD6D219T3TgWXcNTfZwTl?=
 =?us-ascii?Q?bskpUPFv5CuU/niVPhDkGJTno0RYyCd7B9WxomC0pUVzJeHsJXtfpGKcPJy1?=
 =?us-ascii?Q?7Ju/ccpuiuuXIf8av01kQzzpVCw9bxQj2L0ixthKHiHm2RSjvuKJhwixfInz?=
 =?us-ascii?Q?Pf98Q77LufB63fxh4hZCXBVordOHywOGqt4n9tQJeV4Et3lknHp+dObPfDr2?=
 =?us-ascii?Q?ugw1ICP2aTdp14TDLJ7pbFIM2+x1vrof2PZYd3Oo9iZjggE8zcmTLSdP0TzV?=
 =?us-ascii?Q?rgcfq4WDKlx4z9Irk56OP0Nx/KRucl4s815l+bJmVXbLzaKOmiisniqNV0Zi?=
 =?us-ascii?Q?RUsHBP55v2gm7IjJWru/N8Q/beprb/AxoBQsMVmibR/GZra9b0pJUfqY4oiM?=
 =?us-ascii?Q?OTSrSRbIKhf9DAZkKkiWFBxYaOBBwzREksjudWJ8/c0IEEw1SxVdnFtaK1DE?=
 =?us-ascii?Q?hbv4I45Nlf/KX8AULzcMcxkxhXkxu/7Ztc6a51A6WZ7iJRaLpuD/xkrmC8ch?=
 =?us-ascii?Q?M8JeT+tFG949s85zdfw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?be6WuevyNnbN+NQN0oeoAMe9aF6xBw6qAf2t4z0IOBaJSU9y4r7jKK43oJby?=
 =?us-ascii?Q?3sQw2EOq13YAVh114rG2Por9QQm9Rjy7rtdH2MGrbUApGVA97aeHLdzL/lGO?=
 =?us-ascii?Q?gCMQRbgWtExsStmDY9BSKFMQF3WQriSjUbImTm/QS9OO8tRgXUBmN02PPhl7?=
 =?us-ascii?Q?Xb0WvDyKiSNF5sT49hG093Rmv5Qje3czBF6GZ1+Ym24vOhF4//aoHhk0asko?=
 =?us-ascii?Q?KUWNczhFK4qJy+qZfxQ8wu8ORws+z8srG9YowxPHyN9zTknhFA8zryjX9XNe?=
 =?us-ascii?Q?IRCbTLIiHHeQkB9tq/YYQHVBb9WaZ5ts16qAEQb7ejgV09+GCCFO/8dO+qy/?=
 =?us-ascii?Q?ybFH5Pe8Pjo3sg6IctB1zKf1zYCBbz021Cc7yaazW63HBaDLs4rOg4KCY2R8?=
 =?us-ascii?Q?U5PuthtYLMDHtp9A0qGAMEHD3QB/iHBOKaRTglIiLWSZuIagTZAJ7W/hSSms?=
 =?us-ascii?Q?Sw2G/jjyNNMXbtdtAoh+35oV41nGzJ0lPhdLL94MCRPmtsz7EPiFRb+Wr8fc?=
 =?us-ascii?Q?CQMHoJju9srlM8qKZE1/adjdP7Nfm4rGBnrXvnqBakyk7rMvDSLahdMe+PrF?=
 =?us-ascii?Q?BF4qsNpxdWYQqhoNGkR+4EeBGWwwgqaKzR4V8R/0t2gvCpCOWTVI4ZzoUdi6?=
 =?us-ascii?Q?/sdoVx0IekugoRjyXOLIntyt4xn3dcSihihKkQjbLZWH7vwAvsKwyEhbVA1o?=
 =?us-ascii?Q?ecI7EfquOSPOPrDhLiY9+jJPW1Jy9DiKep2Uk64WEnqwq66CZAsm4Yg2Ybgl?=
 =?us-ascii?Q?cLr0iKPxyJ10ey5swswhidSPEI0GgSAJSeybEvErI1OsFbCK53/2tUjQmjDa?=
 =?us-ascii?Q?CPZk95k77K/HpYYsAMrvxBE9icUJzkg03VTjj7fQQ9hAaYKhhxTlGtnBsGlf?=
 =?us-ascii?Q?BPNZKxwGw+/ZEnpvJqq+J5OQi0xhx3laI17yKm/MmgFq4JaHJ/jk+jO/RHMs?=
 =?us-ascii?Q?9S9WVog0KUyCEqpDogKxw51UZdJeD6bUvVR7Ory6e9kMKI/q17h/0WjTjBd/?=
 =?us-ascii?Q?IWWL7Y24vPn5m6K30SlGs1hJucsmBAIeuVmXDKDcBCZsLBIosZLY4scWRrf0?=
 =?us-ascii?Q?EckKWhJj6vLFawbLzmMcgLExGA+rZb6cJdf6448mGtndEUcU6tpNAJ7CcDgc?=
 =?us-ascii?Q?HrQOPz3sBWpKShfLB/z/AyjbcD54XUTB1OH6ptGqmnHP1SxVsO1XQQz5FD9L?=
 =?us-ascii?Q?+LxVBHAhDqvJougwiaO5vXM9wAfvnrzMnyVKhY/g23E7YojMmIWuEtgOdLMa?=
 =?us-ascii?Q?b5JPUohsmd5c2Z28fmWHsfW4C7cOZVqVtukaQi42nawD0UCXSE7zHOqTNg09?=
 =?us-ascii?Q?DFX0ekSSX1qprxtWBR/0k8/+wy8neZ88KQ2aAuq1EUCBpKlz585XuCxZ75kE?=
 =?us-ascii?Q?nnbKxz8MsJLsjuYz0QJdnW0c3xgVgDfYmTrUFPvN+MoBr5i4RIGTPvkhzu00?=
 =?us-ascii?Q?YrsiYzH5ODIxnn9WqvH0Gr34Zc/4KoIQY0FQRASmDMI5MYfmiTtgWV3Gc0Fd?=
 =?us-ascii?Q?LN/7AYryuNphbdmG43evPlkQfwYhl4HG85jQubs6VKVTmGvuKITlwmp8KVXa?=
 =?us-ascii?Q?Ktq7h1zDkTU8pTln4NKaPg9XViTeppLNlmhcuEJPNGYHz+2QrQFAtV9YUucn?=
 =?us-ascii?Q?4wuJfac27W9hkY/TJHDH8XsLhsBF8c2CSRMbtG6Ug93t+1jJGhlz1W40AjtT?=
 =?us-ascii?Q?RqxMn+iIgtIgktDxw4Tzfzb9NCbA/Tn8vxoTZrlhJM9JhfWX9sB5yEqi+Rv6?=
 =?us-ascii?Q?IqNwb32nxA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afac3159-a109-48ca-1fa4-08de6d9a7859
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 20:32:14.6779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lex6TQZv/jA9HDPf4rSQVZH0KWZTVhAdBVEMbmcHnJfHp8AFsfjVaiV9y18T7jv9u66giUyfA9i+RRfK630xHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7740
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TAGGED_FROM(0.00)[bounces-5722-lists,linux-edac=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yazen.ghannam@amd.com,linux-edac@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-edac];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:dkim,yaz-khff2.amd.com:mid]
X-Rspamd-Queue-Id: B11D6147791
X-Rspamd-Action: no action

On Sat, Feb 14, 2026 at 02:42:03PM +0800, Aichun Shi wrote:
> cpuinfo_topology.amd_node_id is populated via CPUID or MSR, as introduced
> by commit f7fb3b2dd92c ("x86/cpu: Provide an AMD/HYGON specific topology
> parser") and commit 03fa6bea5a3e ("x86/cpu: Make topology_amd_node_id()
> use the actual node info"). However, this value may be non-continuous for
> Hygon processors while EDAC uses continuous node IDs, which leads to
> incorrect UMC ECC error decoding.

Can you please share an example?

> 
> In contract, cpuinfo_topology.logical_die_id always provides continuous
> die (or node) IDs. Fix this by replacing topology_amd_node_id() with
> topology_logical_die_id() when decoding UMC ECC errors for Hygon
> processors.
> 
> Signed-off-by: Aichun Shi <shiaichun@open-hieco.net>
> ---
>  drivers/edac/mce_amd.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
> index af3c12284a1e..4a23c1d6488e 100644
> --- a/drivers/edac/mce_amd.c
> +++ b/drivers/edac/mce_amd.c
> @@ -746,8 +746,13 @@ static void decode_smca_error(struct mce *m)
>  	pr_emerg(HW_ERR "%s Ext. Error Code: %d", smca_get_long_name(bank_type), xec);
>  
>  	if ((bank_type == SMCA_UMC || bank_type == SMCA_UMC_V2) &&
> -	    xec == 0 && decode_dram_ecc)
> -		decode_dram_ecc(topology_amd_node_id(m->extcpu), m);
> +	    xec == 0 && decode_dram_ecc) {
> +		if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON &&
> +		    boot_cpu_data.x86 == 0x18)

Is the family check necessary? You did not mention a specific family in
the commit message. So it seems the intent is to apply to all Hygon
systems.

Thanks,
Yazen

