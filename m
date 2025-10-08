Return-Path: <linux-edac+bounces-5006-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C16BC5535
	for <lists+linux-edac@lfdr.de>; Wed, 08 Oct 2025 15:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04D564E694F
	for <lists+linux-edac@lfdr.de>; Wed,  8 Oct 2025 13:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7B7288C20;
	Wed,  8 Oct 2025 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0W7jD1hb"
X-Original-To: linux-edac@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010054.outbound.protection.outlook.com [52.101.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502512853E9;
	Wed,  8 Oct 2025 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759931777; cv=fail; b=MUB+wkjaXYtLfgq3nhxkuQqf9YAWUVEW1/G9LtFAWjdihX+DIrZEC3NiRr7DbBOo2NEDaIfr/hTj48aciJFBq5pw7d1lbqT/Wm1t+Eo1yd9PDpTGhpkgxmg8IiVl1Dl491o25/Ut6L0yAv786yyda7YKFJipsiUNvOmtvrPLs9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759931777; c=relaxed/simple;
	bh=kJ0HaxaIL6EG1FZNNA8CqTPnEBmiygTDVpWBzjSRBoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tgoHiDI3dNYGI1Z7ootLXZrivJAS/GHGqFiCwz/PQyQUwCNzp9VwON0PRzR0+n950okblVvKf9I+qduukYK9XhfK6HCb5sdiTtkTZzZ9jY0K4uRumUoEwKcN0o/42rBxFH53TqGZHNLyJDh9FTneZsJQBN1S12UdTXvIyAvt4SY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0W7jD1hb; arc=fail smtp.client-ip=52.101.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNItkbqekRqRgCk+cBq2ChEA1w/YioRuvooHYDCTjObyVWpKkCFU3RN5funSxhZc6S+4O0r7Je5747moqvJfyW/vtwO+qhfs9D1mDWxCYO8tDvcVdra24fIxgSIovNg/Lu5clxGEQ+q9UNKFx/ntjDviI+cwTDuwHKXVXXGf8KlLBb11rFddSzArUYzzKOSdteIAevCm4FGs53V+O3o2i9lAbaVRGjplpZmOeIywFPybQ9H3+3kpbwFXjcE33N0ty5FY7uN3vYLxCbbCefUH3m7V7Z3Pu1mQSlkE6r71mSixEPvzYdAwDzxx6Fg1+Pl6xr/f9xHV94yuvC0WBpsleQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CscSJ0IeKDzG8I/eUWQN0BZMjc5CZhvVnycEqG+gTOE=;
 b=xv6kDPm5whxwOw+dbvS2jb/pC592s61+SKdWaT7DVvYUT7CRfTMKPikmLqhzGsRAtwtcYWTyQ53gK+bTKRKaPN7wdRVuMKcKH3OkGk/6B+qeImKvhmwrHRZ/FjRiKRIB3Z7GZBLfZvw6qblHob37XXi082XqaXTIKPGSKXtDyWB6e3kgMyxkHAKpbzICba/VHMCK1UIEjDA9OeoSDGZkp2ezbe+24YZISsn1K44gq5A59KPry9nYRG/JS6/z53NWt9UublPAyuKvG50x19v0Q6cPUTe3O8KFKsnV5wdUMe8mT1d9C1YYxvGnK0Ze+cR1Nf2JwYTaq39c0jgy8+L4Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CscSJ0IeKDzG8I/eUWQN0BZMjc5CZhvVnycEqG+gTOE=;
 b=0W7jD1hbmHvYzg5++0kfnWBi8HyC2mfxPTZOwFtc1427UkoaHhL1HRW7b+TDOpcKOMXaQWYfkGuWKaYGIMsdyf6CCOLDHjeZPlGTinp5DX0ubugZs8EM2/uDWq1bczjlERsNi1kctJeISLg1wPyJ0RY8Yca8Y0MwVRswvhu0fH0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11)
 by IA1PR12MB8191.namprd12.prod.outlook.com (2603:10b6:208:3f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 13:56:06 +0000
Received: from IA1PR12MB6354.namprd12.prod.outlook.com
 ([fe80::1d15:ff5e:339:c009]) by IA1PR12MB6354.namprd12.prod.outlook.com
 ([fe80::1d15:ff5e:339:c009%4]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 13:56:06 +0000
Date: Wed, 8 Oct 2025 09:56:02 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] EDAC/versalnet: Fix off by one in handle_error()
Message-ID: <20251008135602.GA18912@yaz-khff2.amd.com>
References: <aNfX-qj_KpCrnCUy@stanley.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNfX-qj_KpCrnCUy@stanley.mountain>
X-ClientProxiedBy: MN2PR15CA0062.namprd15.prod.outlook.com
 (2603:10b6:208:237::31) To IA1PR12MB6354.namprd12.prod.outlook.com
 (2603:10b6:208:3e2::11)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6354:EE_|IA1PR12MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: 32a1b0ab-7e99-462b-51f3-08de06726cf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iyXv/xXlbiCEINA14yRfa4nAnYX44Ca90i5dSZlm8HtSi77SGWm06kvkl0+J?=
 =?us-ascii?Q?LaDnUcxy522GsnVslL/RmFvm/LpU8qwDMMSsSRw3Yg532QttrBKXrNBFyyO8?=
 =?us-ascii?Q?dSCvtlGJkDwJ7nXmjc9d8aQREIreATwm6S8otHddUJAzFat9MWAITXM3E1aN?=
 =?us-ascii?Q?nJ8zLyubFmb6/DbtAWzn2z0ZGiLQQDRj1I0o8AdPaBD35Uw9B0h3zJEXQnzW?=
 =?us-ascii?Q?oZyn7o59OD3rsuQjJQF6KQsU/mrz9Vcl6xAC5/EIDWq1vw5hLzBjGFnBdb2k?=
 =?us-ascii?Q?LQllQorn3czeIhAaGVcHtggHieQ6NiXUbRPbpuq26acx02FPnToyFRLUVzhE?=
 =?us-ascii?Q?yhpQEDb9SmDD5+uBfPJd8Pd5YG/P7OonC/YZgAFwK6rl+wSPSJIH/caboEZt?=
 =?us-ascii?Q?c8WpXf/uILVJX5WA2OlV9XEEZo6eEHGyLg8z7BiD54zgJuqZ7NXBV0CbRu9U?=
 =?us-ascii?Q?2qqYI18cXXOFj3OMc1G9aq1KtoWOvlshzuakkl4kK3Drf0Ks6QnHV90m4q2+?=
 =?us-ascii?Q?SuJtUB7dDYjKKKEUaczOe9/3mn62ntlqfQ4BuxwN4hDxxQohbs+r7JHaFatt?=
 =?us-ascii?Q?Niu2+gffJ6p1kjlMgamqTY8BO0RGphdoeTfSBfILlmCu97eINVjMHVPFPOrD?=
 =?us-ascii?Q?8wO4mlqRXAOZgSfeKwnYl4nARTG1luaGrLgKi7dysfWXw2hyZq6jgXmFdpck?=
 =?us-ascii?Q?7z/S1ptKY7/2ZjeH23NYE+NoeUyVbodsJaSspStCmvIOfyTLFBSzvy8tZOyj?=
 =?us-ascii?Q?sY/UacxOXJ7NNV+FRnL6o1nS5m/KvCOj5T3EpMj+bXM46mvTyWfmK4izfEXy?=
 =?us-ascii?Q?4ip1/LTPXKA8+V3jJzWioGHx8RBqc4nX+MQhNG1tusFVFabujKPONzKqOiT/?=
 =?us-ascii?Q?8pHghN2TuvmH8Vfem5078kmelyTi66dVOcYTse49BRhsxlDlEWlhAYrFODDd?=
 =?us-ascii?Q?a4IqZRzgqOIHuK4zBupUefgT/4j508iVGwh0EmFioZ/S2Bqh6EV6c//dagyu?=
 =?us-ascii?Q?hkxe11AH5K+dgqsS+BSYAueTGr01WvEloRy9C5X81PHy2RaXVbSUzhtRUM/8?=
 =?us-ascii?Q?gHY6vq+MAT8qlVEI9E8qWU12Jg6CKHeRGDx+I87zTchxAKTtZR9toG4iYOLG?=
 =?us-ascii?Q?UgoQ+u11TF7W7jTXMepl12mVZkN83/xX7Kc+6ATnIqciGC5mtiBbGCk1OlOX?=
 =?us-ascii?Q?pVo0PLU6AhPtVZbGLxRhDXkEvHEYm+8sr8fQGDvweItlBI7GIKq13mPBPC9w?=
 =?us-ascii?Q?Qa64sU3c2p1BvdqV1Kv/nRnkAt3nm76x2A3BZi2IVO3lPdxukF4DfVZ+pJht?=
 =?us-ascii?Q?RwRsWX/UZ2hVuWWD9pckHZZqRP98lb9/90SkPoMv/heMhpzDpvNrixNPN8Dm?=
 =?us-ascii?Q?mGJz6eZ1zCvVpTHZJDl5XV9t7g5yvIqRdyoC18NSZE2dmToKHGRbTKvovF2S?=
 =?us-ascii?Q?1ngLrJqtmggLCL72MIDvQYClfszfTOa/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6354.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sjIMsHUBT1gHuvuKL7lQHwqxIQxmKmCLrIoTIznnzNXdRLI1ivd9cUaA6Y1F?=
 =?us-ascii?Q?JGqdE/vrX3W0wMVcE/zqLoY+lX3+k+pxwCNBEeXso9EDJjyb6wMUfAgnY5q8?=
 =?us-ascii?Q?AhcXjiGBue8vTRcBli3l3RXD2gCXzQ/oxCtDpCuckVEewDEsJREESZutNWg3?=
 =?us-ascii?Q?lF0Z8AaC5/PeUEaZ61kFXRUdosfEGGNdWl/thhO7ob7oD42MA74jjqiCOzyj?=
 =?us-ascii?Q?A8hsb3JNVkOBRVGN+USvZHC+DnsNafZwBiW9uqu7fE1Vv2B/TmMXmkxCxsLG?=
 =?us-ascii?Q?CuPqKxe9UOPzBi0ttGhD5gk5p1hyLi7I70SWXN5RDfx1sy6UtU2D/X6hxvkJ?=
 =?us-ascii?Q?tVZ0nH7i2hOzGhWnYZ97Zd88udPKmbGdfkqocUmFw76mNrxN87asP2JGWf9g?=
 =?us-ascii?Q?IN39nE0xiXRGzQwQngmuF/JbE69J9ja87H3GO+dURONybP7PA7rQCAqTUhPG?=
 =?us-ascii?Q?kWnYjaUH4Icxv6JvyaibohzSO0qabblkG6SGd3Xi9WnyszKC8qFEu1RvHGct?=
 =?us-ascii?Q?F3CuZ1qkd2lkRdmXI7NV7x5bxl59HBErZCHiaeTb8bLB0rh+K5Lw8oiPQ2ZP?=
 =?us-ascii?Q?q3x1bPsJ4S2x/vbfVljBBo9Yn4eachFVmuwGV0MFPFw1Jt8aBfTd87BF1B3U?=
 =?us-ascii?Q?Uvo0cjGuutDxO/gM1I/RsLIoQanLno9VNMTADj7fKcT3DtIuRhiZG18iCB45?=
 =?us-ascii?Q?Wfs/MHnd6DUefGG4202sDn+Pn4E5tGYm0rc+RgquWmBtW2vxk9AWw9fUNr4+?=
 =?us-ascii?Q?RHmMEsTCJ8raywvwX5ur+/9EyIsoAGsqNA8p2Ghxf3YM9sVwc/UX2KDq0US9?=
 =?us-ascii?Q?WzlMWVSpFSHG4TXlChKTxTiHh7XhB2f21hl17LJML7HPrRtRG5VRHqAaZrTo?=
 =?us-ascii?Q?iOB8/fM3a7sOi2UYVeZib496vR7SWrOl2xFiXqBmOiMX5ogy6sDLZ1NgnTt2?=
 =?us-ascii?Q?LZZUFgrbNKn6bqyNuG9EVd2UO54gnho0mMoU0tUXw1YiIcewNg7L7IvoDPfw?=
 =?us-ascii?Q?s3GKS4621iiswCpN9hq807GbJrKgyyKMbjc3wW9pTCGoOIx1VMAxOcSrd7v0?=
 =?us-ascii?Q?zFw2AQGjxWBGAqQ7GxsBiSNBBFAe0CU3D+3ilycOhjOEXk2HG2Mv6YSt+l7s?=
 =?us-ascii?Q?qW7TBdqt0UZtB/eLF4Ehc0f04LIWyTRClXx8VdBPN6swMWMeLJJY3NugVv1F?=
 =?us-ascii?Q?H4JGNhM42utkyKh2O73ZGNEaA62nDLkWSbTRFGBqapYQShGnlX60XL0GJd7S?=
 =?us-ascii?Q?7eR0ytEJdM8oo1AaasKPPonycbd62Wr4K75tR5EOFT6xC5KxOMBMFBYfJofq?=
 =?us-ascii?Q?2fcz1gzsXgap5BIB5FqFzPGS41nam43tU9cm5cqQK9uPlggLku/ZfpE1foGW?=
 =?us-ascii?Q?eTgP2SEA3xNG0QRUOqH/Y8VhzBjU5Pp5wdC+Yi7K2Z+pUP9fqHlOd4xKI6j2?=
 =?us-ascii?Q?1yb8twGfnQQNjmip3MSlpyXRt9zGQkdPq+wNwppeSqUou8n0ogxpIGZI/piI?=
 =?us-ascii?Q?aYL7IjsiLc7wvMSPfpwQRRmqDQxZLnDS1tI3lDcJphKAL4KIkrNl+g7QhoZy?=
 =?us-ascii?Q?HC4B6eCKGNvAgufxggswDLQOkarENAxWWlKO2wtL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a1b0ab-7e99-462b-51f3-08de06726cf8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6354.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 13:56:06.0441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nudaK57fPYAmysEphrOLQjch/o5s3nBvVZrA+sPZyBF1ZFpul1gWA0HWrvtC9rJDIRuNsNoF48km5x60ycuTBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8191

On Sat, Sep 27, 2025 at 03:26:34PM +0300, Dan Carpenter wrote:
> The priv->mci[] array has NUM_CONTROLLERS so this > comparison needs to
> be >= to prevent an out of bounds access.
> 
> Fixes: d5fe2fec6c40 ("EDAC: Add a driver for the AMD Versal NET DDR controller")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen

