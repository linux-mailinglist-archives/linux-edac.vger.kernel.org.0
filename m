Return-Path: <linux-edac+bounces-5763-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLp8IF7rpmnjZgAAu9opvQ
	(envelope-from <linux-edac+bounces-5763-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Tue, 03 Mar 2026 15:08:30 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 288BA1F1132
	for <lists+linux-edac@lfdr.de>; Tue, 03 Mar 2026 15:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1F3B53043764
	for <lists+linux-edac@lfdr.de>; Tue,  3 Mar 2026 14:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3522F36D9E6;
	Tue,  3 Mar 2026 14:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="16B/tNqW"
X-Original-To: linux-edac@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012011.outbound.protection.outlook.com [52.101.48.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD93284686;
	Tue,  3 Mar 2026 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772546442; cv=fail; b=LNXvQTq/FNdm9jHEqhdNlfuVlBgeyRjBW/8AjpS5N8wl9wFgDv3IBL9hQca5Acp4JytiTmLBrFDhVJqJEIUdQKQExkRaVwhjDhtMi5tWKMaJ1tJgZcHEp9WdfymidbAGDQta6kw8ZJwJC19qlABnzGNALrBcQo0g3/AA9nO5Bcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772546442; c=relaxed/simple;
	bh=nJ9MkcyCXCvnpqVnFGhb2naxpaQd2Fc6RW1NK+Hr4Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nyTis2UHIEFjvo1uYgZ3hVfeDWYbhiuHn0Yk6CJb/Zn2kYOP0C3ZmH9IBacvHGXmayeoGJGwVeayQC8T1nkiXOBcJHjeLe7ZJAYouw93PUiI7yyN1ni9S1usLZ1QPYo6bBItWZ+q1++j3LqExGEgbdsmjTP3L9KIbNSwhxtFPXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=16B/tNqW; arc=fail smtp.client-ip=52.101.48.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8axNp++wzRN5kypGumkxK4QIdIR6WKEBlFkarUvoIHdtrgE6uu1JmVS5KNmvKB9/CzQORcT/GW755RL5ACHp2jPrmFQyfaRh9m1lXdF2GOlg+mnoumr6NojJLmjAIw+3shqcvAzXg948Lp9exbeSQPpjTXA5SdX8e6AnA9XGfatrbeM+5BdevrXJs1hBmVMOEH805UjAbV21MPk7bPiHL9l9PwJ3sl6wT8XdY3XOIA04+fBw0IKbXbnEYvHKNnUq0znTJhBTWV4rPi5gYLLVG3gmtB16f0gM9s0+hZSncqgJrrgyYtpMuFQY8HNlv78hHMdJP5d4/yllH2+ZNUXrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJ9MkcyCXCvnpqVnFGhb2naxpaQd2Fc6RW1NK+Hr4Fc=;
 b=oL0IDWwXb/1aWPVF/1irgTHXU1HuwS3J2nu1IiC5HVpzbLX3XfcpPTbtnU3n1gMuPRkQtF+7b6D0/QVF4jzw7J0+kudouPiOZ6U58tCOmsUVc9NqEmdavwkZ3176yxj2tXsNBFhTJSJsqasFyEErNQcMMmkHEv7h8THzkqCHUdSNCn56y1y+IJ24olb2DD4yLBDKZHDpM8zzrrYxu44XOv5mPWmZEo8YYxk98P4ElbdJ7zpFWjK1g2G0CUeb+0jFusJuJnBG/REgL/qRzwYOXJ7e+XUzSQ34o+SOhbWXYlCqwsx2rHivOhWArMonxFUw3bGkDqne5DkAkcEbEYfirQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJ9MkcyCXCvnpqVnFGhb2naxpaQd2Fc6RW1NK+Hr4Fc=;
 b=16B/tNqWqjfu8lKYCALBgW63pX25z4qnQPLXUUGfvIWVkKkUu6H9hei+tRHXyJLV8UPLL4zTSKDmxYaWhzdCbw7lb9jRyB8kZqLSqJU4+9xfYNXht3xiNUyoEGevpwetJ4AhS2f2lUu9J78/ZFkMidpFM6IxIIBhc1ZIqVzw9B0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 IA1PR12MB8262.namprd12.prod.outlook.com (2603:10b6:208:3f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 14:00:37 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::7da:cc3:cf2e:8ebf]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::7da:cc3:cf2e:8ebf%4]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 14:00:37 +0000
Date: Tue, 3 Mar 2026 09:00:29 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org,
	Bert Karwatzki <spasswolf@web.de>
Subject: Re: [PATCH] x86/mce/amd: Filter bogus L3 deferred errors on CZN A0
Message-ID: <20260303140029.GA277447@yaz-khff2.amd.com>
References: <20260228140814.76375-1-yazen.ghannam@amd.com>
 <ab7c5c4c-1477-454c-a47d-8adf32d6d738@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab7c5c4c-1477-454c-a47d-8adf32d6d738@amd.com>
X-ClientProxiedBy: DS7PR05CA0104.namprd05.prod.outlook.com
 (2603:10b6:8:56::16) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|IA1PR12MB8262:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bcacb0c-1cc6-42e1-6e23-08de792d3ef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	eKgUUcHLGUhn8s21AfvGbGV83iJmkY3G1QHj/3rxa67fpzHLPJTa6t/sln15PyrW96ZSNDdv8kNu3w7i498iMlA2vydtywZjkq6sdubsVTWpB4sE7hXiDUEGYoPukG2Jp8KiMBEE2xDDncjqCleu7RaafxIIiS9z3Az6XCcQk0rIsXfHuCQqbztMGOLaO1Y37vEm3j/hL9NTSYGZD44avuno2P+7GZmothYKjgRsbMdnNWz0qollwb90T0OXUyCInhthRFc9g8C4wTshhVQytVWLCshi5HhVu+rp7MFaN/1Q0FFRDZmrgoZkGsO/z4TyMACfekkORENzwXFjyU26rikJw6nNxKemWCRGqX1h8682XSWN1bYOZxcHw1jSBzPHTnAEUVJDyGP7+C22pRzTy9hSM33PlVn6OxeJ0Od4jAhVpm2UKiLCeVOSqSr8x15ZV8Hs4XFUOsc2PkR/lHuvvoGhJGW7UoJVwdSb91dF+HNa6Ksm0VplI0FI9SNNfcFSDuyE4bFtoX2ei/LMGlZsCepiRFI1C9HWRuLpaqkj8WOSvHwnTuzpfk0A15ko43284SvHrteG6vk867moQ+Z6D0sc9xCEJQdQtASXUQC7+tjkoMt3Su1poiBU90qmEusQ91InxtqoricuBkif27rshLVEpzpuEqhUgNqD9c9UyuY6bgUg3x2xg9CAwvOVT2BWK0C51tPPIFG6DfCqnjYJM8PsLpj7osnOueq2PZ4Tlew=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xKhNTlE+rf04QeDsAzvoXhwChIPkqp+0+Y5UrpAvzjRTT933K6l3A2WEQJ2P?=
 =?us-ascii?Q?XY3XA2g1fb9rdBOcdFnJo7gfrK5kNTe4w61TE47rNBvZFvLT43b8ByijrK19?=
 =?us-ascii?Q?f5WEkG2JkNFoj1vh+KapfO0cNXtv1xts3ySYH/Lt3+RVBnxIG40yEvErNWne?=
 =?us-ascii?Q?YpajhDGXxdYURPkvPvalJ6LWhmVy0B78wUssIXm4ErhC4K/XrofaTc5RMjuN?=
 =?us-ascii?Q?Ex1J8N3ts8Adbmi+7BVGYbxzr2OnJ0Xh1KfAaEGSZ4/zpDOrWiSdXNwt2SnA?=
 =?us-ascii?Q?EwLfgDkHgtM2p5yYzpqyhxw9l4soFJjYztlPtwqIo8q3Ruz7F8xPR74W/11j?=
 =?us-ascii?Q?RcH9KHwdCPT+KAwlKcXMSFBLU1w+TBbGFqZFzvUyjSISqj4PzW85LcjUgAly?=
 =?us-ascii?Q?+ZN+RnDGHZWSYMZxfA+OGFtvCTlNVwnC7hvOnoOu2hlBFtCAdPHrj3VUsYx6?=
 =?us-ascii?Q?Zm/0mcp/Pe7GGx0f7e8qqHWHhx1YJk33rpu3/OGdH8ny2cOd+E7yU97914GU?=
 =?us-ascii?Q?sXtlRAD0zSZNBKM1KbvOV15CF7CWiW7mAJTroG1kmOi/2wbzBbC5IlCLBvD3?=
 =?us-ascii?Q?KsIYlj/+wL4tWhg3InIZxI2E/P5bd43Aw/tFqvvCQLtWGxI4avzOnhw/xera?=
 =?us-ascii?Q?KYg5Q507ipmLY2vSsaTnz49Krci9lkfF9eo1qZPX5MwhaKW56bD42OR1tHIH?=
 =?us-ascii?Q?bMXUwecESBfwmNjXw4T4gb2xoxB2bmHgTxWQahlWkGttUdHIZ4XR8+jQsiGh?=
 =?us-ascii?Q?6W819AjrkTRtHbsBvDNfRcEG02FMbM8oXyPL1jMtCHMKCDlsoSynmLSmmWtg?=
 =?us-ascii?Q?c3BXhQkB5q5kH2ZCZ+JQ5yRSdn/MOYSqsG+Mv2WYnysHI9pGUb1OWkBk8d1b?=
 =?us-ascii?Q?6OD8JVb2RhohxNgfm8kUoGtF9A9kJBzSSijeB9+vaMn/88qO7Xw2I9leG41k?=
 =?us-ascii?Q?bOt902anDwJbElsYnaEFKaCHaPRP/M8iT6Fr3MJ2H7YywhWwHX8pUjCav3Gr?=
 =?us-ascii?Q?ne/IXM4Yg4IthzMeWf1QhBA11F2j03/QsMs41cAedg1A8f6wYpW1bi7ol81U?=
 =?us-ascii?Q?79fcgvDuhCvFob0kIB1GYk/q/+ywyBZbfms83mmAj97EdHez6kpwwcYJ5iXP?=
 =?us-ascii?Q?3qeWbW7RZtCbRm1NYXnuY0125OZdG+inYkl6kSsBVIP9JzgtI9K1rRS0Q/Zl?=
 =?us-ascii?Q?cumooWYMkxkcRWfbfqdPDXRijYXFHX9LRbcSldUKURt5H66aCJwTE04baBQT?=
 =?us-ascii?Q?T2DaGDX6w7E8fQlXpHUmpu4NJ0toxnNjVdgWXvk4pPoFQnyecVKXQUKchoA7?=
 =?us-ascii?Q?Bh4AK/alYceud1SgBRwRQZqOS/KMKyTXng4iDT3f9VLysizY98YnUcnwX5tR?=
 =?us-ascii?Q?cckF/FjWMp5GY8ORVOCaIGqFognyj20XUJSo5qOmoQNa4QEepqmNNEtfiS8a?=
 =?us-ascii?Q?DvH4BRZg/MWJGvC7MmqpfCOlxkwPUlaPhe+oCyJM309hQhkJrUsCX5gehz6Q?=
 =?us-ascii?Q?Pp5bvuDaioCkwve3I+ca+0TkX/7IjxOYL5TM/N0NtHq8UHhcBMvPDIWodIGj?=
 =?us-ascii?Q?u4lIogHU2EQ8gktIKrgcZBmvWXq6nidIq5oz5QK8oCmHSkxTEGiz+qrMHAh2?=
 =?us-ascii?Q?40TtDBJ95emIq4bkK0btPkAxTjF3f35ITpDLrLntWec9IHD81hVdFCGGLnSj?=
 =?us-ascii?Q?HxEukzE5+/UIJi/yvIyX/u0O+yM3pf3nfZDMd7ZuKpgyLwur6Cfbyl+VMJTc?=
 =?us-ascii?Q?ml7xDgp0gw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bcacb0c-1cc6-42e1-6e23-08de792d3ef0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 14:00:37.2002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9px1+dQ7/5tVgYphJ1XcfuUJztp+Af3Fe17yCYRjpa1jXVB514kzGMDdWeGYwCeJcgxNDTpl511W/9oO+vhqhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8262
X-Rspamd-Queue-Id: 288BA1F1132
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,kernel.org,web.de];
	TAGGED_FROM(0.00)[bounces-5763-lists,linux-edac=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yazen.ghannam@amd.com,linux-edac@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[linux-edac];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 10:16:31AM -0600, Mario Limonciello wrote:
[...]
> > ---
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks Mario.

Bert,

There are other options to prevent these from being reported. And
they don't require a kernel patch.

"ignore_ce" parameter: Will disable the MCA polling timer.

"dont_log_ce" parameter: Will keep the MCA polling timer but will not
report errors that don't have a usable address.

You can set either of these through sysfs or on the kernel command line.

Thanks,
Yazen

