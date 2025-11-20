Return-Path: <linux-edac+bounces-5492-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2A9C757CC
	for <lists+linux-edac@lfdr.de>; Thu, 20 Nov 2025 17:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3BE7F340F19
	for <lists+linux-edac@lfdr.de>; Thu, 20 Nov 2025 16:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76C536B041;
	Thu, 20 Nov 2025 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DyMTFKQH"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224DF266EFC;
	Thu, 20 Nov 2025 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763657401; cv=fail; b=TAPCJJBUabVdxQOzViSfUnkIphs/aEfUHbwHSZ1aYOsTD63sw0JfPHZLBQz7SgbzeXC0/Rug848HK6N2Aw4M4mLiPif52pES0uLqfQ0JfAGNjd6GQB4YSO/H0EhG1icveVsdeM3EwNkDxHqMMfcRyyOHrbyh4/HWEy8n+iRdEd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763657401; c=relaxed/simple;
	bh=K1pfaDkO9oWoTj+Up6dGpMJqnYdyYXhZW7kw4G5NJ2U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WAr1FnRlNlybRKoJ2EkdU1W2z3gdbaavqGle9yiEi1nROSstRHQOHcDEu854QfhiMsAuL+cwTwNGElMUhTPuneIzISzqvUJKSkYS7G3VgEwav6albE3gkk/VWCBGLaKhV45cV0fQwItuNfwAzfEDMNPwqA7QGgAyr5Pu+iF4QRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DyMTFKQH; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763657400; x=1795193400;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=K1pfaDkO9oWoTj+Up6dGpMJqnYdyYXhZW7kw4G5NJ2U=;
  b=DyMTFKQH1Vqp+N7zbU9Jw7QCLkEGZPOKRiJ7sMHe96TWCN8tn7bUhann
   59YU5PhNuQxb7mPPTmE401FPjzQkdyOLZxG6Uxg6tuA5E1lgwBCXOEO43
   naOcPiVPmWJHnAF2jZMxjpU7GAYXGl8BZxn+0bIhy8jS3zAgNd5rv1ivA
   7kAu9Gc3qnbrHtmnEaNe/GU3eQGd+6viSP39A1MSlbn0VnwNhEZZGVIV1
   bnR/KrxMEIdtJwGUhhDDDCy/ANzN9i54gADc0hY7gpYqaSOicePEMoFrI
   eB4fzpxhOGbp4Z03KWg5BN26SSJY11eNMzprBLDJzWEpb+nN3FMAqgSWl
   A==;
X-CSE-ConnectionGUID: X4wonloBQNKcm2Te5verLA==
X-CSE-MsgGUID: dEt4hjFITF+ZxzbW0VJmgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="65666742"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="65666742"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 08:49:59 -0800
X-CSE-ConnectionGUID: yfErVBKITDWr8W64+taClA==
X-CSE-MsgGUID: eKbAdRehSP+LbXNoNAUvgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="190703289"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 08:50:00 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 20 Nov 2025 08:49:58 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 20 Nov 2025 08:49:58 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.44) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 20 Nov 2025 08:49:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmF8NjSFm/g/xK2+5/tTK8xOYZ0cGeb39rdYdwVSC2sUCzUB7HnSjq9X66C8sMfpfnZpbkI3YMHtx62LHyhBM4IUFQ9p72s5DnZvh5R1P8QTRGVDNpjOHgQQFPZvpa7PJFdhOGIFBsFQT4taL6KhKliCsB4+5tE7hKME92kk2R7jBlizY2rvMmT1pKs+AsWfxiLHqfuL2TYVidwfi3JumURZVtBQfU3K0tWe9aojxjd77bh621/OlAqKMkYoUjYcjmqt+AeeI4yYx5Eq09iNCRmZO157704Oy8anmgApxkV5iuOAEQbchtaGt+qpJJgaPDrLcu61/b4vOCG4Mma3GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XR0AUPedwoIbxM2qjirXV5sX/ncBRH92DdpZ4O+Y4C4=;
 b=N8rMLTqNYcc7IIxAp1BY09iOa7+8MjpAF48cORQhv5doZNGkPdkIubnYYDN1V3IlDMxASaj3Cu1cis2zChsMkZal07cRClxdnfwNlfeqWe+Dhox/dSxulrDkeY3PAv22VpbY6ARbX/dZLfPYjCK87MUZvZ/WjMua4UkF0INmQ9vchQlt5j1Or8K/pPT9klTU6/nW2Bgnl9iqZcpm/RgH/um8Aft9kVCeBpK11pUGpQODcuvPAd9isvQ9L928COPknIiuudkt2e7ydsnmdepVm3JHLfBHdyfzEsRC//WNyI8KKkhrx8cRSzYwhN5+dMiM+Xjm0rHlhCdgnOvGl9yteg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA3PR11MB7611.namprd11.prod.outlook.com (2603:10b6:806:304::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 20 Nov
 2025 16:49:56 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 16:49:56 +0000
Date: Thu, 20 Nov 2025 08:49:53 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Ma Ke <make24@iscas.ac.cn>
CC: <qiuxu.zhuo@intel.com>, <bp@alien8.de>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] EDAC/igen6: Fix error handling in igen6_edac driver
Message-ID: <aR9GsQiZL6l1HdpW@agluck-desk3>
References: <20251105090244.23327-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251105090244.23327-1-make24@iscas.ac.cn>
X-ClientProxiedBy: BYAPR21CA0005.namprd21.prod.outlook.com
 (2603:10b6:a03:114::15) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|SA3PR11MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: 9998e23a-b602-463b-6d4a-08de2854d541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JFJDrVGtS8pBb6Zj6YLiwqJVKu3oPcsWxP8vtP09Hy+jfB+8LH1RcqtmJrJm?=
 =?us-ascii?Q?LKk/RUGH9GdfJs7e5eBBu2EN8lHfmQCxuAHzQrG7RnRrExUfZcjrZle1IAMx?=
 =?us-ascii?Q?ZxK/OL3BWfulI9RatlBSIm+ewfh3W5JJo7Qsixi5czhYLiNhx0BAVJXb5eEG?=
 =?us-ascii?Q?xZCpgOfcH1Q0TYmlfkl4GLRic1EtF7TDRVx9XLYOZrFdJu/gQ1RLN6hgTuZP?=
 =?us-ascii?Q?tzyxf0bWZ9vOK4S9OzJeHbjwLohcM3UxDvlNigjRUi/lm7f67R2M7NOI/TI9?=
 =?us-ascii?Q?3nZKDucykNqePpNQAal41zQdfuJ15vsx/rVeFGd09vtAh7cNnl96tGwWGfNf?=
 =?us-ascii?Q?nejWmjbpKaCkQ3FPIMuooF0sC62xPvUuU9K4Fw2MA+VI8yI4Zdufe0YwumYs?=
 =?us-ascii?Q?dxK5k2mOD6sghP35tLqvKwvFbVNQDpG2je/QYuI+lTAFiZWJaJjBGe9mmkWM?=
 =?us-ascii?Q?RbN4ANACbhLcIuQ7VdPETEgd/aRl10WcnOgo2QQ9nMwHi48RsKB3G4lwMjE6?=
 =?us-ascii?Q?bdKNYLO3OaHDkoILjToLvx5ajMzhheyFLkSaThrvcJTnFC9ktqOMivqxFiIC?=
 =?us-ascii?Q?iZFHIWPLdlHi1NxvNh4y/RgCe8jINDTdPsPGLrbuikH2FiieV5RUyQcN70a8?=
 =?us-ascii?Q?vJ+AIaCIhfbuYH7kNJj9h15zFJjLqg7N+WdzTwOjwv8wTTGhAwEUWwAN3jw3?=
 =?us-ascii?Q?w0wWbVlmKSp6aiwCR1ruusnp19+ZCIOCfk8K91uyOX+s0BQXlcHfivppj6PX?=
 =?us-ascii?Q?tYDKU0Slcqi53LmFhssRdkqzWOhLTTwVo66Jax1jZw+ickySpfanfLadof7t?=
 =?us-ascii?Q?0xIOkqE99Q+2KjvjAz+Vy/YsnMACuOFbW/4FpeK1OgZGUeTKG1HQnHbbCOef?=
 =?us-ascii?Q?4Cz/bX1cS8uAPfXsox2MkcEThCzUZ3if51k1V6da5ZEcXCkdk9TgQ2jnCPbZ?=
 =?us-ascii?Q?5s4kXfZ9kDdn7JqryeaRXTHU70aDEWq2AANW8lzU+FS+rFlCaLWcXzfjbI5Q?=
 =?us-ascii?Q?/0AYHvIvbboZNLVvwZBDXpJ8+jZinNbbfKngNQr/MUhErEXEagioTyZrFK46?=
 =?us-ascii?Q?Jmb0TuGMkgtZCNs2XDKNKAr+iZ7ki9tGFNABJE2qaLE16grVOhZhzq3vqaqX?=
 =?us-ascii?Q?sPKUXyb2vR7sPBWcV/RvtrGlza2SNjUb60nTafcNmQ8Vsw8m2pxPaJDgQeYM?=
 =?us-ascii?Q?nhVZV3xyubSwv5jK8FOw078/j9ohxC59XLrarNr5Gdj4agWYDW0AzC2V/ZN/?=
 =?us-ascii?Q?hDScGlSS6at2hVawBcnaeJE14oqgsTiGvC4rGVaTNhCrGJd5kDEfgr6Is5UR?=
 =?us-ascii?Q?RERkX8177Il+JkeqVBIY/dujthYbSCaUljr2eNMV7XlmeQs4DNTmhdP2/kJZ?=
 =?us-ascii?Q?kP0u9YjUFq3sv0GEMB1rHb5OjFQeoYWKhO9jVQN/oVhaqBxtZOT776HiThAf?=
 =?us-ascii?Q?h62EyZYhmbgjEgfEpsBzxgxERbnzIqbi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eJH7XkEuLnD1axkXrQblXw4U9n5I0VU0Tv66tOrXabatwqarRFNSu6gAkGWQ?=
 =?us-ascii?Q?7tWQBwMjAvyA6xYNdGYI3OcsnSeOWiVl95WeBK46UbwxnGWtmiMobtG5WJGr?=
 =?us-ascii?Q?3L0RBwLWVOx+T4I9L0wMA7sMKSyvGsiH8HmQ7OTaDapl/xkuAcitgoYjermk?=
 =?us-ascii?Q?wYV+ZQ721oKB0PoJoqtd02egVSFvFzv7p3pKzMbRc9qrZw6VMd3OeXGo1Y8Y?=
 =?us-ascii?Q?A13MgF50liVZSSk13wAIsV30/ViVH7+4UXfbZ7goWK1EvOlmszgXew1K6GfO?=
 =?us-ascii?Q?5BrV/Be2mg4Ppwr4ZVHsWkn/jlIZc0e7h9oKXZsnfKqGU+nCSjZTro/1shtj?=
 =?us-ascii?Q?b1egpPF6ImNM2WxcVj6j7jkL7L5nL41VbWvT5wPnmJP+jctywPUspYpZOoAP?=
 =?us-ascii?Q?XpeqMA8R2wzDKvu6l297uzYyIV6lXA2D3pzzQVOcXbZVy7dkZxLWRbeB5Mbb?=
 =?us-ascii?Q?OFIY8fIxy8wrNj8MTZl7BSknLsmZCua8FNZj7HaNGhQ20CBV123SSWfDKIIz?=
 =?us-ascii?Q?CPDyPQMt1hOkz8N9FZbP+eKxltculM+1+nROsHW8myX2dJQS65pLCugqm2Mi?=
 =?us-ascii?Q?Tk9M9AZ6KcL2H2r29ylCj7BEdOSprWGIikk4ejgpHknykZJIqTozohqcnUxH?=
 =?us-ascii?Q?tYalO6Z+yRdVRdoJfxEBWjBQ2/chgKLLD9UmtPv0+i0l9CE6hJD/ZiHGH9KG?=
 =?us-ascii?Q?q8nC7s46t65UF0thuue269IN/GnNATTL9XVoiJfb57smhedjT8XBWGCXnPTh?=
 =?us-ascii?Q?oCxYsiWtJsQnU21+Uhsuno19cfh9oPmayxkfdWI/kTlcybDjau7L9mE7DeUR?=
 =?us-ascii?Q?DhLKkrwc3Yx94F6nICt6EUv5HOKxMbBGQGStHRocULelwANDjc/1zBMKVvH+?=
 =?us-ascii?Q?/FlmqXQrlWbkwvW+Ou9l1JWQSiDRgrVm9+Bk34AxPPou////S312b9vi8Qoz?=
 =?us-ascii?Q?yN0Guoz+NjI/bHga6tkisYW+5Yt01ZyBe8407vlf18XNpGcpq5Jdwa3BvmHp?=
 =?us-ascii?Q?8+2SbzE600E9Ru+az3gNq1tmr4pWSZpwV62nCzJf1iZcFrHeDr7T5G4Ncqg0?=
 =?us-ascii?Q?hHUbsb/WrC9jv8mm+T4z93BIDX4G9mati02yOICK9vR2HjsR7GBIADV8imEy?=
 =?us-ascii?Q?xchnbSn5k/+IIzOhaz+2jmWdYa/Zs/hgNLE/MGfvrh6CcKhIlYYQTATgMaSZ?=
 =?us-ascii?Q?QbGzKQF80EPBynEp9pjDalRTkS+y+ed2twyQ90c8FDVpsV3bTlPk5ExDGjWS?=
 =?us-ascii?Q?QsSLiTlhXo+xjxHIq2SSlPvNcKt/PoFiOBmmSxBQPDy7zxjO0pOIBekdteki?=
 =?us-ascii?Q?+kxo4ox0fCDJeWwkvAP/3FoaBV7SieeegfDHO19DYa1VnuCYH06mX6wTyZlu?=
 =?us-ascii?Q?ENpeCu4HrPB0bk6RsD1rhGl0NyTk4xbliOer2S7znZbzKm3P5j/R3Ori/FjS?=
 =?us-ascii?Q?k/Jl45K/5KhqAlARYAz1YnF4PoqS1zyvxIaPUPkS8BjlhPF+Y0DH6cw8W9aX?=
 =?us-ascii?Q?lRbHYNcgnTcxrK10JYOCHvpe+mv1pFm3glmigtQ0HjGuylAR3WyaIeic2hTh?=
 =?us-ascii?Q?tewGKlhXlrsMtfKMDah3ZaLEOX4brLGReHMohbTa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9998e23a-b602-463b-6d4a-08de2854d541
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 16:49:55.9199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GUJgZMPG7aXL9pg9k+rxeoP+XyoRywQmMY2uP/SmgucJW3e4e963q41SC1i6p6ZgJYXedNGp4+/DFwJhnX6LYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7611
X-OriginatorOrg: intel.com

On Wed, Nov 05, 2025 at 05:02:44PM +0800, Ma Ke wrote:
> The igen6_edac driver calls device_initialize() for all memory
> controllers in igen6_register_mci(), but misses corresponding
> put_device() calls in error paths and during normal shutdown in
> igen6_unregister_mcis().
> 
> Adding the missing put_device() calls improves code readability and
> ensures proper reference counting for the device structure.
> 
> Found by code review.
> 
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Applied. Thanks.

-Tony

