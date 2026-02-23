Return-Path: <linux-edac+bounces-5748-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KdSHK3UnGkJLAQAu9opvQ
	(envelope-from <linux-edac+bounces-5748-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 23:29:01 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6EE17E586
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 23:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1624E31B017D
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 21:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06136379966;
	Mon, 23 Feb 2026 21:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TcCWQGth"
X-Original-To: linux-edac@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010004.outbound.protection.outlook.com [52.101.61.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530C03783C5;
	Mon, 23 Feb 2026 21:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883606; cv=fail; b=hnZ2TAa9KINr3vDp1cuULRlcpJjjF9MAo0PvYzLLci1fJNthqa9jMl3flEA7FQSn0WTwvdcEwB9YF+SNHM1q2UEYGD5JPBG057d5ou7LaWx1G0/7s6OCyqVfcTtIrxwCMISlK+p8rhtOVrOdsqLn2LSllCzyGTBRDz//ccegs9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883606; c=relaxed/simple;
	bh=AR9CxJawcq1A/GcW8/GF05S5jsBYFHulnHe4WfA7UI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hfqxbomfDXpRxkuNtoSa8/ZhVEEna+51tvrEUzf1fWNA02G4EKmS3883HyNro84EerByjN9bz8WOH9F4wFdDHkPhxto0jfes5obK+2Ok5Fr8Tgb1dLDqtWENm/KaJznS056k/5whwsej0LhFAKplCwhHdr3oe3U0nd6EQbakVx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=fail (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TcCWQGth reason="signature verification failed"; arc=fail smtp.client-ip=52.101.61.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMHOeyooix7elBkgVSmqd+Cs+YYh3GH3lOZChBQEaqjXr3YvsEkwGz/SKpKd9gnp9VAakEQLDR6dwaeU10mShQlZ6LbGecZ85OzKZirkFzclew0olQzPWuMmmgLLgRTmY8FjfClgEHwuGA+VODU/41/ZoGs27Mi8Z+O0wAHt6Ic64TZiJOfFPwMqPyKAafFGDpwGgqtAK6aZDA0BdZWnt0s3cqjx1ea6oRwuw6gHCRP1tLlNH0xgMKJVimBIZfcsDp4Pvt/jRIP7S2zs64PIyc40n9N1q/4gJF7ejce+Mo46cDASTa7tPw6D2Osi5PcOlVeHsQtFkVDxCIqsJCOe5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPXbWr96mlihsE5EYH+2GEFPA4PIRGrifHVx/WSGbVs=;
 b=XGDQiswbuvuBZ4vX36pY5fHd8BRNFYso1mD5aczXVTAD2oBp89b+mo2KWE80HuK2wEAr06CWz02gkp1C/xBHjRnG+ZAOr+MBve8/joDJJ5BwdDtP5hLc7LP83Cu+maGKFZhNqom51jSNHelUeysggcPehS7+H8tFL8DyAeaoweHFPGXoJqOsDHavSqi5IbUqwK7HjHp8YXI5vbou6C9y+8MgfIeVMzFcZFVmuTljmYlpmWkdNo/tue4PaT/Xw3GlUqcXRpJITIPBsjsoIBv2V4vt1uiTPdP0J7TMK0Xy5bvnlGpog283gD1bSfsdHkZGlC6V+D0GmfOnFaR+DlH6QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPXbWr96mlihsE5EYH+2GEFPA4PIRGrifHVx/WSGbVs=;
 b=TcCWQGthAXlQw5sNx2eouyzdaQioMCdxmea56hXF9hQMMWsI0Ho07Iuzj6Dlfe2aP08Jd9l2Qm6jTi0i2/U4HDeLy7FQoWPylIqYzIdFBH6mZ+niG8PMYdoPV1HQqiAb5y0nQBfcWQ+XCZ3Ey3csBtEDM6hrKW6Gb6LD1TfPWWo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 IA1PR12MB8264.namprd12.prod.outlook.com (2603:10b6:208:3f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 21:53:21 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::7da:cc3:cf2e:8ebf]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::7da:cc3:cf2e:8ebf%4]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 21:53:21 +0000
Date: Mon, 23 Feb 2026 16:53:16 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org,
	x86@kernel.org, rafael@kernel.org, qiuxu.zhuo@intel.com,
	Smita.KoralahalliChannabasappa@amd.com
Subject: Re: spurious (?) mce Hardware Error messages in v6.19
Message-ID: <20260223214825.GA3130@yaz-khff2.amd.com>
References: <5ba955fe-2b96-429e-b2e8-5e1bf19d8e8e@suse.com>
 <20250918210005.GA2150610@yaz-khff2.amd.com>
 <67c7de1011ea7b8863051889ee2a41512fb0e044.camel@web.de>
 <20251009132055.GA472268@yaz-khff2.amd.com>
 <21ba47fa8893b33b94370c2a42e5084cf0d2e975.camel@web.de>
 <20260216202546.GA420258@yaz-khff2.amd.com>
 <20260219143345.GA5486@yaz-khff2.amd.com>
 <4e0c5a7ce9f1ab35eaec2c2908df3681ce6eda4d.camel@web.de>
 <8530d765-6676-4ba4-98b5-07326c8dc924@amd.com>
 <290ee50cbe68d246a9899b03d5c7ddebc549f0bf.camel@web.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <290ee50cbe68d246a9899b03d5c7ddebc549f0bf.camel@web.de>
X-ClientProxiedBy: SA1P222CA0161.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::9) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|IA1PR12MB8264:EE_
X-MS-Office365-Filtering-Correlation-Id: e9b9f0f6-0f5c-467d-114a-08de7325f619
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?5db1iY+WP2WtuFHVbuZMY3seJLERheebdO1NMtUT6xEEYYSZOVKqXo67a4?=
 =?iso-8859-1?Q?n4+afxBmJmscoOgay9Mw1Ku+CjTzoRI8KbIAhMz8cmdTiY5QFnAWxMcFMA?=
 =?iso-8859-1?Q?DjBaZRmnO6p4OK2kYNcOIgx3WJcsC4pfRgWRBXRkub334BRXLgnI5Bs46n?=
 =?iso-8859-1?Q?sxLTHPJ01y+hk/QPvJY8AHPv0T1cqUSikDGjcq2zXLhpwqNEZsHErMkti2?=
 =?iso-8859-1?Q?ShY/j7afWCetEgUBdMaAdocv7vw7ndgk4qXzYPT/V/utRPS/jYjYzwUqOU?=
 =?iso-8859-1?Q?sZEmmUQ31dHUg/zk+f9vtUxJfoXqK3VxTwOD63WV5eYE7ZgiyQkwMUpDVO?=
 =?iso-8859-1?Q?jDGnFjIC9zeS8r/kH1/e+EewLDeExZI7+eFfV1ig9bqeka4PkUGa7t6BTH?=
 =?iso-8859-1?Q?uD3uovDqBa463LDvu6dfKYpkDR6lnbtjyoLZp9AV6N97G/EZ6tngHHuILe?=
 =?iso-8859-1?Q?VGp8r6ZtTShfNgvFIFek5v0dHQFDw73OD7CaUXSsm0jdZS8bCH5xnnZQtI?=
 =?iso-8859-1?Q?PsVS9VPghIXUHc99Il8mSJgX9lX9wrtDPAVRNK7Cwzpu5pIuSiMiN0KXVE?=
 =?iso-8859-1?Q?fVYMKQ2mDmO+Xh9ZI8ZdtVCdBJmty9T8KlrpKhQMV2dQhYo1qoQtPaMQ4O?=
 =?iso-8859-1?Q?lId/ult6SPDGhdAjN2FLixrTSLW6RnNfN1/VBaYVYa7DaYMENNQIDHnuBe?=
 =?iso-8859-1?Q?OqnoqKn3LCEYMMk80zYEPs+cjAaQl4NTThTvD7Cv1LT30rt6ux1DRqmlN3?=
 =?iso-8859-1?Q?MpWGsBC3PWVTjriLzrCkx0rxRRJnmR7d8fCcT/522nHeEDqhWbH+CrOQWo?=
 =?iso-8859-1?Q?cYqRTrWIbezZLu3n/ucGxmEx+kgkF7BLXZo7izIjYFrmjQg4tOoBEnwgB5?=
 =?iso-8859-1?Q?hBvHxGYl11Mx5HnXRByJBS4VmtvR2w8OxjFL2YWT4anCPIGcWzry22sMkR?=
 =?iso-8859-1?Q?D5kC5qY3dCVyFPai/NzWbgcGMRsWoSYLKSYeYvIIA6A8esb88ygeVsoP2M?=
 =?iso-8859-1?Q?VQ+G08d9k7rBxQ8steUEepxQBfYMFNwhEKX+VZH2PaQSOqvzsrZ7RzC/it?=
 =?iso-8859-1?Q?8j4L4Q8y3pPBCUmbHG9vFxRpA9A7PM3TcxtWZQo5UwgMXlfp5gxS7s1HU0?=
 =?iso-8859-1?Q?FV6ZI/VaFozD7S+SQHkHI/oYVQ1+vVCuAiq6sWUL+T+Wb/aId4s6sbyRDS?=
 =?iso-8859-1?Q?5wHiE9KDKi3lU1rNP73BaYjY7R34kmRQA67+J7eqWh4YqLnANwGY7w3bd9?=
 =?iso-8859-1?Q?V2XMYGmGqzxZBSKlhU1nfqbL4yBcDz8pdqq8kWT0eaHbbgef475V1fiiOQ?=
 =?iso-8859-1?Q?CAB3wCPb0+qfEtAvIw4W9KKn6CUqCzwgZkAZ130zNZRyAPe3hrhH9YCrZl?=
 =?iso-8859-1?Q?19njflynRzVa+z5QyjxAXbaA/wW7OYWP+6y3LiVbkRuAeuAOMFMeaP7JmD?=
 =?iso-8859-1?Q?t+kw7vWCJi54VBihjnRqEuj48K/fdOlgJ2q/3bVfgLAx+Wmp5g4MM8udUr?=
 =?iso-8859-1?Q?EeWKLzt/5PrGhnlOF1NwyXG7+D9ehAy2dx6FjJZHmw10UneXrq4JsqmBLE?=
 =?iso-8859-1?Q?5EhzSovAX+SyfiHYZcpJ5j0qUhIa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?u1u6oK0pCIcpJy6SpLKsR1y1kTwM8gsAKsxlmSz+c0loI4hwjpt6x1Mi55?=
 =?iso-8859-1?Q?cbv7uSWWGHD5Xpod7oYWqn7sJrSCdxROUsT6G+TE3kTJcH7wTYlc4l+eJ1?=
 =?iso-8859-1?Q?qPw2csDnqnXA3gAL/eCO/BkYc8OXEeNWT/ckGuZbegc35Gdc/sBNF7RG/K?=
 =?iso-8859-1?Q?/lnKhr8XlH4tOg34od7xrghxmev3V+bSgYbCzZtUAA0GNxrQfsKq/+nU+2?=
 =?iso-8859-1?Q?TJ4W01XBQ57TUv5GabFq0DULiHj3lxBzlNaHbMJDYDWObJleyRKh/+KgHR?=
 =?iso-8859-1?Q?Zbur4mmidAWQztG/fmwQRMhNCj1LfXEkHK1vNxsNORmacsdl4LtGvOSvxF?=
 =?iso-8859-1?Q?nWNasL8uls/hNQ3k4ayePwBzvXs6/EjZahTZe6DKlNIMSQp6y9cjTZY5Kt?=
 =?iso-8859-1?Q?y9rckHiySh6pptf2yEuHfuZ9lmNjAACYeDojWZ0bRanX2DXLkWiSjI8z90?=
 =?iso-8859-1?Q?tL0aw4VrgLB7HbLtPeBo9+a88MV2jdQybsWi9J/66xBrr04xcJ74W5U8nW?=
 =?iso-8859-1?Q?E1UpCT4JY+yiYXxT3ldNt8vMuJo7Ahh9dqSu10PLLteRatX/hlVepgdEN9?=
 =?iso-8859-1?Q?qpMjhK/u4hRWeGOvaatqDw4lv5h19cxTEEZgVfqCciWIMF3VEVmPIwPGZF?=
 =?iso-8859-1?Q?b4F4CBHZUADboi+q5B4DrWU4fY5vv8UVWa9mPbFBlRCeTrFJj6lDCdcJ1u?=
 =?iso-8859-1?Q?8QYNYOGTxMglzw+YhgZWB/iB2U4a4acGUWhugnoEQyq6Td91jyxKG1C3Bh?=
 =?iso-8859-1?Q?ipfo0yUCTMn/uLAUpzwLSuBaCAK1qPcEq0S4gAKgXgWftETBSuYjphed17?=
 =?iso-8859-1?Q?rcsdkOoLwvPU9I5q9JT2WYVzKGqhZVDbhBZx5HxY5YGGBgWhFec9sJ0OXZ?=
 =?iso-8859-1?Q?bSt+NxC4GjAQ2LBHETSZW85q3AWqvATSbB4gd4oIbJHcUEqbqCu1d2p4Io?=
 =?iso-8859-1?Q?ClDDab/D4JlCEUV975Zwfkk4E6SseQpsDMwUD99+0YYg2CHR9LDAkTWG/B?=
 =?iso-8859-1?Q?F0G3VcoAeJLUUFgyNDYZb9iqcB1y/1ep+e3p3Co6XlNXcwQ10f6cZp6pCP?=
 =?iso-8859-1?Q?xDX35NVEEEtgdsMRiwsG7MDueKzuR001Bw2tylJ4dlSfnhTZ2cAJtPfITK?=
 =?iso-8859-1?Q?z5J2FoalmGu/m4L6bUgrsuyztgnIZRRqwDAHDQjAO5fM/t1rStmgtLF204?=
 =?iso-8859-1?Q?y+uYpv3G9EunslnwYn+CgJGy3BcsQs3VyC7x2sS+hss9GeRbU2b/FIYBxS?=
 =?iso-8859-1?Q?3bqi3+5O74j/7V0duRMMPzli5iKjh8drOMrNuUg6znjjHnChyn8imTLv05?=
 =?iso-8859-1?Q?IPKw04E0wmNzQ58oJOwun4n2A+3hscv8AWO7B7TIc8yg/bwoF6wDGXpM1h?=
 =?iso-8859-1?Q?s2Hc1hGRCdnFzyJKWRsNG1MmXMjnrGXDzaC4u/D7D0d0mRIIkaVOXiXN0j?=
 =?iso-8859-1?Q?YEJ4FN6aGryo9z8gvWbS5GpCOAkCAehPAyjC5Qlf9ltjPG5QpOVv6N05xL?=
 =?iso-8859-1?Q?WFnmvUneGra+3iDGk8IDboLPHsMxIdw8Xju9FgHmgWuxqFSheLH4K2uTn8?=
 =?iso-8859-1?Q?e0evEdTTttikCOJpQqG0VG7CYfp6Pw32UUwDbht6fTG5M96bN3FHjSHC/p?=
 =?iso-8859-1?Q?2agG6wvbKHK5nODFaUWSgmCGKccqlglnfvdA9drKOd71872hUfNHk5h5ko?=
 =?iso-8859-1?Q?tHWYodJcUIsoVGN16NhLg2Z67HKcWg8Dex9oslmstYMVNtJ/nU40DBLtBv?=
 =?iso-8859-1?Q?lrXrMPKlz/NDXamSS3i8Q7/+byDFR0mH6XYawk+gCjcoUf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b9f0f6-0f5c-467d-114a-08de7325f619
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 21:53:21.5852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YklqtSEIfliOXhvBm5KJCeLDoFG6yAy7zd9a9HTNPwnjra0sOn8dOaj5rT5sngi4Ag36bjOXbVkfKIyJNOAhsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8264
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[amd.com : SPF not aligned (relaxed),quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-5748-lists,linux-edac=lfdr.de];
	FREEMAIL_TO(0.00)[web.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	DKIM_TRACE(0.00)[amd.com:-];
	DBL_BLOCKED_OPENRESOLVER(0.00)[yaz-khff2.amd.com:mid,msi.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alternate.de:url];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yazen.ghannam@amd.com,linux-edac@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[linux-edac];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: CD6EE17E586
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 07:24:32PM +0100, Bert Karwatzki wrote:

[...]

> > > 
> > > As far as I know is a production Laptop, a MSI Alpha 15 B5EEK/MS-158L model with
> > > bios version "BIOS E158LAMS.10F 11/11/2024" (the newest version available at
> > > https://de.msi.com/Laptop/Alpha-15-B5EX/support?sku_id=89840) and without
> > > preinstalled Windows which I bought in December 2021 at www.alternate.de (a shop
> > > which MSI lists as a "trusted partner": https://de.msi.com/service/bzq)
> > > 
> > > Bert Karwatzki
> > 
> > Do you know if it was purchased "right around" when it launched?  I'm 
> > wondering if it's possible they used pre-production parts for some 
> > reason with their initial systems.
> > 
> > The reason for this line of inquiry is if this is what we would have 
> > considered pre-production silicon, it might be more appropriate to flag 
> > the CPU accordingly and ignore these MCEs.
> 
> Yes, I bought right when it became available.
> 

Thanks Bert for confirming.

I'll send a patch to filter this signature.

Thanks,
Yazen

