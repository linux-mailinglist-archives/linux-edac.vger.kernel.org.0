Return-Path: <linux-edac+bounces-5580-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DA0CD20DB
	for <lists+linux-edac@lfdr.de>; Fri, 19 Dec 2025 22:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95B44304BD80
	for <lists+linux-edac@lfdr.de>; Fri, 19 Dec 2025 21:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F219253958;
	Fri, 19 Dec 2025 21:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gb+CwD4N"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821C1849C;
	Fri, 19 Dec 2025 21:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766181016; cv=fail; b=l8SbUgmGL5ZEak6vKapbeq8/6DqdB7rF8bfYqSfa+7F81nF5lKRXEd2k2xEgAgcNHgwUoaAHvFvHno40WPpr0gXqjH6qzFDZ/M3IDnaCWVRbLOZUjEev6nmFFjEZVT0HcNdLCmY705Ed/SChAt2AOYUcimC7jSyYYfLgSdIpNdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766181016; c=relaxed/simple;
	bh=TdSr3TS79XHEQSsKQH4Ya9rPwul0gXdxHHXW+nMOTCw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y08hhOVJbNKmgYvddtLqGrRvGbJznWodpBcyhvjkOcXowSo/D1RX+jqmQAJatT+v939KnDi1sUPI3A9ZkrA51GPyDEcPll5Dmwx8Ah5bdL3FBpU7DNgbis9oebY0RIndjcKHCafrMwbl8WKqBRNjoaoSPw6ZD6rrbrErfYRC6oQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gb+CwD4N; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766181015; x=1797717015;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TdSr3TS79XHEQSsKQH4Ya9rPwul0gXdxHHXW+nMOTCw=;
  b=gb+CwD4NGTS64fN/Wvsai34/6OJdsLFJx/nMJklMNOC94Wk2m3rCeg+7
   roH0+kbVKl1uOnG4/9qR55r4LULeYzh5RYNrh5bTNg7h3zDpRuTgfWMIj
   O9vk7Is/NIrI8XO6m2+KSbQ9BPYuDCYb9nDPlC6qS2W6cRkN3u1cj+2aK
   j0MQrdVe9fQPvNlXUKO978Ip5lBsGu2CetHup+wPI/nnT1dZ5CV4HIiUx
   5VMllssJNYaUVZUqOVbmOubo41LMiTM4div+fVEYMEpqwu+zda4SpMllU
   H2EgXCx/4Bw2Y8mIuE5Q1mhgxYggujiJPZHB7m9WnLCKFXYkBHTMy6WGi
   g==;
X-CSE-ConnectionGUID: dxQIBAngSpyPIpEdt5Tipg==
X-CSE-MsgGUID: 0gu4a84TTgOIQ9lo/hk8PA==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="68079492"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="68079492"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 13:50:14 -0800
X-CSE-ConnectionGUID: hghwnTnxSZivMSXwiiY99A==
X-CSE-MsgGUID: bHCtORV+Q6+o/Q4rZAZoeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,162,1763452800"; 
   d="scan'208";a="198116267"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 13:50:14 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 19 Dec 2025 13:50:13 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 19 Dec 2025 13:50:12 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.34) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 19 Dec 2025 13:50:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zwnwa5dTDwYVZI9w0CIU4xiboZ4f7RMkMeKk2AonIWAe2BO++O6xzaGvYmsQxcwPCrZfW8QkNClw9ba/OOwRNHhLZLSz4NAnie3tBJQ9eXGmn3bp7H1EXYtI1l1BHRh+EMBwEEFsniKQILXWoT0xOnqi+XoK82EgwZ0s5Afs5LYZba9ssVB39RYQKRhX2kVTxRcffSqeFVfndDsawmudIsQefvI4bXf0kFXdW1GKwhjsMTgVkCaHj5JwKlhyqk0VBYkfcVP2F69vQM8dw3GfUzlCnrpoqquvepxHkbJnjX796eBVXjV6BOa9TYft2edddjxAh2Pfw9811quaR3RKOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWYM0f9txYXfrHyztYFSNU4gHVU5O8HGTfqTOn+VnnY=;
 b=J7l04jlKuilwpa6pexpdwLUCK3nE/SJaLxf0Rpp8nc4DDPvjmKA+uKiZgji4p8hbmHxn0XaLfvG2z0NtXM+dKf8nDYgrjsTlfK1EDQAWJRX6sQqb4faJhRUSh7rbi/MfmcmcuAsEto5TlORb1JXNbcX/LMemmCyqRPqW/AzEP0RuW1huFfSQG3JoQIXLPSzNzam5E/kvNmETn3YsAobdZsVBxVCFDjjmRt9C+Jz58dEbWGbd6aIOocRP2nen14vN97+eOPCr6YBlVY44vsaEPL4iUmY7TziHqSMb3Z+YAZjHDBr8HQIPUR5hKlyU3XujJ60ksGdjuNGDE2e11X6dcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA2PR11MB5212.namprd11.prod.outlook.com (2603:10b6:806:114::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 21:50:11 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6%3]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 21:50:11 +0000
Date: Fri, 19 Dec 2025 13:50:09 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Mauro Carvalho Chehab <mchehab@kernel.org>, Aristeu Rozanski
	<arozansk@redhat.com>, Borislav Petkov <bp@alien8.de>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] EDAC/ i5000, i5400: fix snprintf limit
Message-ID: <aUXIkczNiF9kmII0@agluck-desk3>
References: <cover.1765290801.git.dan.carpenter@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1765290801.git.dan.carpenter@linaro.org>
X-ClientProxiedBy: SJ0P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::6) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|SA2PR11MB5212:EE_
X-MS-Office365-Filtering-Correlation-Id: d91371e4-8694-49a5-6937-08de3f489570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h35W4OmjvxxA+rgJm0gTCbdqffDrbXcDBpXZMyQpC/dmfmtLmLDCfDTeyduZ?=
 =?us-ascii?Q?KNpxQalSyNoN3Kavo3wk0OMnkM/sVdHnulrG1wd6gQPZX5qRzkXJGIQ8UAHe?=
 =?us-ascii?Q?WxEQ0x645p+UTi1IwdkJYSMt81W5TxQiQwtr7JkS/a5ZRQ2ToqLF3A4f++TB?=
 =?us-ascii?Q?BuH1wUgD7yoXaBuagNO0BJB6ahMDvU04pgaMOgYu1AkTf7D8uYUzREokocub?=
 =?us-ascii?Q?D2wi4c6VQUoghNerlFOwtPzATMzPH/ieW9mhhrSfsokdXj9X5R46ndf3VTQg?=
 =?us-ascii?Q?ZVIHJNtJ+JFjl2+hk32fZdxctoHhvAnvKkp9/Siia8nGQi1jCWsEFFPG+Bg3?=
 =?us-ascii?Q?lGcpt9pJ++5nk0LSwLO1DBoMlYFcODdVkasin1U2yxWFTFpIzIGkm8Ks5a5J?=
 =?us-ascii?Q?nEkqURYCBJ8o7ueBhttAPjH7jYPIBWsoMKStfGPt8xX9/sEcjnuLt+M0H1rS?=
 =?us-ascii?Q?RnbOkOnTOVb2NshNBnHLQGWgNL2pbZuu04N8sbi68x3Gw4K2Y8V8E+ADXuFc?=
 =?us-ascii?Q?vjxAY2TAW1fLeuN7+N9wDaidpbwbz+91cKeYPs9PnTThkaraqL82FscyjEwj?=
 =?us-ascii?Q?h8O29+kkJ/hw6KW9rHnRZAGAReKTjfo8k9Ic9nacTLvpCctg3/ylUmmaSi8E?=
 =?us-ascii?Q?A2n4reau9ycztNEBwwDxcAG+ojklxt9bt/mU8puwi1pNcs+PsjAFcb2pms/Z?=
 =?us-ascii?Q?VSmd/XpM0DrJwXXZo45epB3+0FH4xpFNTrpFpqZwZPuzQyryYG/cFFc4hc5C?=
 =?us-ascii?Q?oEP75pLm0K2UmobELKrGJ63SWHKr+612hrViPEhUzIH30VQ+fsRnKTa/d+ds?=
 =?us-ascii?Q?V+9nFFvrTEiE6mdu9Q7XiqP2FhX3OOQTOddRrPiXbafElbW2i4ZJ7bxrWLT8?=
 =?us-ascii?Q?Zw8+nhnho3hHHvmb9o5ShWbpos6Yvnfue9c4RHNTqXmqrup1MjjPvuAY4X0p?=
 =?us-ascii?Q?VAvaUnJE2QCE/O7mvkIoPWvUQq6YOGDEnUZSq8q/w9yDGHxO44OzYQxAqFUG?=
 =?us-ascii?Q?WwwMT6ndE1C4C8sjm7s9FqcdYsmiVdasRmUblxJvOJ80UT5v/l17fHxqrdZd?=
 =?us-ascii?Q?36g4no+xdSUCY6zXZheTSbsbi22S9l89oajIcp+pad4zOLSnz8N1luBNZFhE?=
 =?us-ascii?Q?0DFSTLLh3JyRZJo2zvo4A07LnE8xXLv0INCSbteupKTaMlxxQF0ox+G41+vv?=
 =?us-ascii?Q?lvVDknrFksb8/RVzQTbv3zvmXoS74nPdfmV2x9xU7ZAwWYFS2a7/XSLO0+Md?=
 =?us-ascii?Q?1HTGI2uTP/jSEq8iwXm2YOq7KtP/zH9vmQcW4z8xtPI6mKxyFO3kaisXqtl+?=
 =?us-ascii?Q?uy43qhP6RcUJmmF8fvdH/JRszvaTLyQ60QIRcUCLspgstzn9wHxZL7N43L7z?=
 =?us-ascii?Q?lUAw1wNVMAPXFZ3iojL3Ka8Rzh0swo79QDPrzOof1tAynTKEzYi7ww+7/0/v?=
 =?us-ascii?Q?K9hTVVE02k9FN/veTm0gjZN4b1c3Hsmk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YDjCiWJh5nmez5w+JE4I2pkuswf6YyTbftls5GopSdnBUqFUthDe/LX7FzM9?=
 =?us-ascii?Q?j7d0OVGBj9t95/x7q8AF+WPyO4K2oxUJdWAuTnfvdg+HfqzdzVin2PtN21Zg?=
 =?us-ascii?Q?V6Sx99c+aqVPVbvafDCwqvXPRzxoipJSxnBRRvbmvKnWm37TQI4Yse+T9ETD?=
 =?us-ascii?Q?U1Ti7+DKHnL/FsFxgX0Rj3fBIA3Dp79nByHJjYAAdMVtsdHozurZLDKdmLR6?=
 =?us-ascii?Q?qOc+iEP6sQD6xxbxdmOmMtGSD9IoDlW2NsyXWZZvZhK8fodqvzZSJBWdVCGw?=
 =?us-ascii?Q?ej4SRFtHCy0PFyKtOGW78dXVAsqt0vztX/9W6prv+SNutMRTt7uYCGCqQLMx?=
 =?us-ascii?Q?jNICl6z3mmkfKmWygl8zaUhRoFvtWdJzaOazZDmn+djjrkH6Zl9L9VQ45sdy?=
 =?us-ascii?Q?AwMTilawnXblVt4nBgMSyBIlFd4tqNVrDPLO4p1sdad/9I4X+PntOO6e4Gia?=
 =?us-ascii?Q?OINK1KflsdscWYSN8ORq20O/p5S8Jw4YTjSzni+IUb8k99zd3YeTbvTNGXZL?=
 =?us-ascii?Q?Kg5eoeR4wpkke6idzcTyjj77Q/Njm5jVpL+JE3NMJGjPzSqBfxyynYr7GBUE?=
 =?us-ascii?Q?zdVawwg701heWuMSgwPmhL6ODKiJMnlGRNc3ptzDp0DKxcG1iLQn2kZUMcyf?=
 =?us-ascii?Q?SAMrrI8/eOpck71k8K6EJfTrRK1MoIMDG70VkZhITlqQ4GicQxUXH1wuYdkl?=
 =?us-ascii?Q?Ag0ALtZQcPeV9rXrcwHNCYX17MpQBI0iW3OnbteKeo5SVoU58JSuI55kxnQ1?=
 =?us-ascii?Q?728GQ9nMMKdlV9Man+48fJVZP12TKPvdEtPBmQDNd6wzATGVY9lPfzZmD4Aj?=
 =?us-ascii?Q?UFPUjih6HcFRQ+l6raKnBkdKCUMChbomxcqLTcH008OWwTW2eXoWrGCf8Gt4?=
 =?us-ascii?Q?RsL2MwHh8mw9hqgH674ztay/jdocO1L9AU/LsDwQrsTzFNJW1SPTlPJtXbNn?=
 =?us-ascii?Q?WWuQx8W7SqgPbOJUMQ4XGbCT7q3zVu1ZIMGNxjxlEEjcssLEihIpOgnIkM2X?=
 =?us-ascii?Q?LhmdPT8+a1GKgeS4U+YuXsyUAPmhzSC4REFqGAwJ4b00zBGlE7fy1EAuC0uy?=
 =?us-ascii?Q?yLROqD0wObgzdG6gH4P3DhgN/14D0wJa7w6yfBwnlH0uC5oeQUxBEZ45P3Kk?=
 =?us-ascii?Q?WaKX2uDYG8M7mLr7pQK8M6jA4RF1oLMpOwac+p+RUyTpML3Nafbn5rPI6ddu?=
 =?us-ascii?Q?sVsXz5UsiObQ6q7dpOOXRxbBPMJb4PkJwSisADWY0JYe2ueY2oiz9N/xUQvP?=
 =?us-ascii?Q?8zYJP4Cd5f7RPI/w6JRGQPahCpjYqPzbvM6J924wa3Apn/RfVuGOTiLvMURL?=
 =?us-ascii?Q?Aa3xa2Ub9Ed6tBhHBGkrFP0921UF6TAotAMLYorFeMhXp7m1LC5EZGhdZFoA?=
 =?us-ascii?Q?A9XiNpB5SWnhhlB8nnu9Nqh/aYIqhoi32ls4LWPNkId8rxmWiG8iQyBiGZGA?=
 =?us-ascii?Q?yd5hmQFImcWxIo1Y75nqVRP/7PVkT0O4lhfURPCdq6YmMxlMxydZDzhmPtV5?=
 =?us-ascii?Q?ug0DHUoaCUx8poiFj2wKHmcxCFKz+a6Ddw822MJi2lbFQiEZ6sivNZvl/+jr?=
 =?us-ascii?Q?pwpZajl+/k814PBpBAx113qHBangCtUsEWV3KIrQy8qwHVJOnC1ERjzd2nVP?=
 =?us-ascii?Q?t8bWBHIcGEK9aPzJfVCJSzM79rjFn14hH7HRHTf09Q0dMeE/aAfiRTC64hnz?=
 =?us-ascii?Q?pkjJ8c/mIl5CjAdZqJtTud2t8L4G0T55sssMap6SPWJOtpGbXEWISfvtVL5g?=
 =?us-ascii?Q?36nQwn1Lgg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d91371e4-8694-49a5-6937-08de3f489570
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 21:50:11.2235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aB55d9EPfSM0WmxWjGwTcASWabrQRIj7ZmCiW27UdzHCTVyR7PhpZ6aAXeaNwodMJ/BzjUuz8zGTJjc07OsRcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5212
X-OriginatorOrg: intel.com

On Tue, Dec 09, 2025 at 05:36:53PM +0300, Dan Carpenter wrote:
> 
> These fixes don't affect runtime since the buffer is large enough but
> the size limits used for snprintf() limits aren't caculated correct.
> 
> Changes since v1:
> * Fix i5000 as well.
> * Fix the subject
> * Delete some related dead code
> 
> Dan Carpenter (2):
>   EDAC/i5000: Fix snprintf() size calculation in calculate_dimm_size()
>   EDAC/i5400: Fix snprintf() limit calculation in calculate_dimm_size()
> 
>  drivers/edac/i5000_edac.c | 1 +
>  drivers/edac/i5400_edac.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)

Applied. Thanks.

-Tony

