Return-Path: <linux-edac+bounces-2740-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DF79F6A2F
	for <lists+linux-edac@lfdr.de>; Wed, 18 Dec 2024 16:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D3A170B37
	for <lists+linux-edac@lfdr.de>; Wed, 18 Dec 2024 15:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7081F0E2C;
	Wed, 18 Dec 2024 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RO2N0+gu"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB3D1E0DED;
	Wed, 18 Dec 2024 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734536231; cv=fail; b=SYklmuvZMoIOUoxh9jJ8OeVB70kgHjTtB9izUv+ItVy8ndhHwEqvWj9SFqFibO2oYiBUQuEcVFQDOBu2i8yMY8vidoEP2gHEsIkC52c60iTBqBzrH9YGJzm1K6PNK9SVoOiBGWaZ3udJRtvT9JD4c3TrFq9c99aXRGS11MRKeQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734536231; c=relaxed/simple;
	bh=KSu4HlRyM90cNH3Imr5BZceOWXg7R080QNYJP/K2RG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=abf9ZbwxhNt+p9u06DBdeLj1mvgevwA5axAd2NviwpA9ybkRBzi84VW/yLR4EjROmICiYug22WKO4vLg77gbs11vezVxPeIKAvy4G62P32dZZ6VwF6/oa2WSXX3yPYz9yb/6sRbh61WzA1dbSTOiFHLEl/tTzq1IwA2dMD5TTRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RO2N0+gu; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nC8d2KBHUHKjeLnPMP52cxOmTBOHCQ28Mpwj3ECywBzBdgNitGkoxJHR2DzUfsmsi3+N9fnysaGf1rgroTvJA7dYTnhM0cU8qjmyQLi2gev6uUmgPQ457L9M6vyo2zTW2bJ+r1pX2mDb5rfssi7JmdedgOE2Iq7ZoDMDla3AMv4Wg4ud+25xATdxzx1ANhYznc3d/zX/x83a5FyB8FhF9tPBz4HvlXm1oFmUqvkMZnx81ijEoRw4597jtbZQBH+noUPu5nVt2nCVU+pVWjUdQjWXbbZ42l5PbIx9AL6lSAwIAlTu0vPCGQmakIj0cC2ofl2JwqVF92yHI5afO/2szw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvEE1uRpbO66+t7BuFFR9SICO9gK5SqYAnVX/eJO674=;
 b=uLFtDCcX08HS0QKIkfwhK5aidVkrXOkF6zXJA/VJgLLcHFbRZ/vAuNUfuKVeLxZKecpe+ITc3F1z3Z8i4AFNz3xEJ/e+lBtvsD4HckQzJqyX6R4VvKDFT3DbY/EnTPdrZplsu0Gzm1ozEzqkrjqSS5Xskv3nvd/pkY1WUPcdZA76unQuwk3x2Yb/kIDd/WeP2KCBlLsi7bghag3HU3ZxF1qN+EEbE9NtSbZKoBvlh6ljF/jsVG0dVVrDov91HuqBzCYGPYDYBm8Nghtpfq6fHfBDyk7XGy3oW3YwP0njcVMHXDn4jcAtikcCkxVdiSQ9iHUvrdUl0vmMvRy//qSG3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvEE1uRpbO66+t7BuFFR9SICO9gK5SqYAnVX/eJO674=;
 b=RO2N0+guuHusc9zwgf1ut3qMyClPkGJqRPBGlw9x0NVD4Zg2YN8uQqfBNSpCaGtqRhU9D/DyJpRZt0ZVft03+YZ+MGczeCkJIBzgKOPcv5tdU+T5v56unbxbrJo5zc6Pod8QWQiM4EKIgJXkFk4ZabY2VwkAmz1TfNEI/+k4TqU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DM4PR12MB6543.namprd12.prod.outlook.com (2603:10b6:8:8c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.13; Wed, 18 Dec 2024 15:37:07 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 15:37:07 +0000
Date: Wed, 18 Dec 2024 10:36:56 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: bp@alien8.de, tony.luck@intel.com, tglx@linutronix.de,
	dave.hansen@linux.intel.com, mingo@redhat.com, hpa@zytor.com,
	sohil.mehta@intel.com, nik.borisov@suse.com, x86@kernel.org,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/7] x86/mce/threshold: Remove the redundant
 this_cpu_dec_return()
Message-ID: <20241218153656.GB1155365@yaz-khff2.amd.com>
References: <20241111060428.44258-1-qiuxu.zhuo@intel.com>
 <20241212140103.66964-1-qiuxu.zhuo@intel.com>
 <20241212140103.66964-3-qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212140103.66964-3-qiuxu.zhuo@intel.com>
X-ClientProxiedBy: BN0PR08CA0018.namprd08.prod.outlook.com
 (2603:10b6:408:142::29) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DM4PR12MB6543:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c82bc72-ea71-4882-cebc-08dd1f79d48e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zJEBOyZJdGC+PR19hSng74+YzDCMYckU/3xTQYH8O6l5feSPZboDqOUJie9D?=
 =?us-ascii?Q?yC1Kdcmyc1tZx/A+0rADt7l2sPYPRWzr+JF4Zk7uVLotglqPffwYJssXs18B?=
 =?us-ascii?Q?lXDq8EMMax8wjYEnEwaCrSAMAWmPtJXMFpR7FYRni7dCBQFLMpf2IiRyzq4v?=
 =?us-ascii?Q?Z7vJAsdqEUHOM7DMCjasrkpm3T/5o1ztVSUFOXAIcYzwbK0SEnpnHtPNEyo6?=
 =?us-ascii?Q?Vln7PyjxxcjDw1rHl92/kQNyJlyLyHGRF+LrkUsJid6KW5XclJl+5tqEuNFH?=
 =?us-ascii?Q?mJ9sYC3rqKW5zru8iBZlRgiC/wSCQjnb2VTdLqv08uStvqjBr+nFRDR08Ofc?=
 =?us-ascii?Q?wwQD5PwYFbvY1nlZ9TZpMI5UGJxC+yf0iJFKplr/dwY6RSk/zL+6/GhxGJ4U?=
 =?us-ascii?Q?el3Fnea1DHflA1ay/VABm04m4xS0J/uOoVA+bBzNGdrcEa+UUH3ns8cygyRW?=
 =?us-ascii?Q?w1Ht34dh52873LOBg/r4X6bYVEVb5ymidyh/PUPLpg9/6glOZHhLzrsJcDyR?=
 =?us-ascii?Q?VMC0D2Xl3I/o7MxSsStZ2UDkkLLL9STgHXbeU2IspwqKVUfuOOkgd5k2F7vt?=
 =?us-ascii?Q?TlXRLVtSlWGmdvaoKFvgUBAPmwuRy+ZnSY5YKuE8ocZ1cae1/PxdWaADuhfW?=
 =?us-ascii?Q?qMSUUbhs//1HVmjk+lxK0QY+ppVz3A6m5KWSzfN4l5eRak3JkFbK+IK02MIe?=
 =?us-ascii?Q?o2AA7rkpDeH3VrWCMD60ZwNgDpMLYyLWXKyYh206P6rG8UAbD5Ca75bJf8dh?=
 =?us-ascii?Q?SCqubaLa+cZ2OX4uoWQmMsfJJVlFTypUaWDJKGut2m6RhhFbPDPvEbAYZxv9?=
 =?us-ascii?Q?374gur5Plfl1v3tQnj6DwVprfwKQbrqhS0ErY1gyZm5awJ2V3t8/auT9NoH0?=
 =?us-ascii?Q?e4I88/nOCmZZqDb6q0TqPdKHct1fJpcHgALq06JSiwourfhiUGv6hpFloeYE?=
 =?us-ascii?Q?p0h6V0wQxpJjfmohyhdtWoZruQrGYvdvrSxoyz3oSbN2PKCwrzKFS68Z9Aeo?=
 =?us-ascii?Q?gvyPnphNXL2VQbdZUbXzaI/ESlxOJHVsFcWBnXLo7wDOVr4LGLwz2OVwMvxw?=
 =?us-ascii?Q?PHTNg9RLHnxlQISDg/szP9gkJNescj0vxX6oexLwBmez69tPGCJAk9q1N7R8?=
 =?us-ascii?Q?BmQa79W3M1T9JPTTufz5dQDSSpFCwpuCwusMFoUzQWY0Wcghnbap2OWJcB97?=
 =?us-ascii?Q?N/Fr/KupoLiP6BI33XZdvlltbpCoPoggvCfCermmLxkCoi2PkgT3swipNJJA?=
 =?us-ascii?Q?kukj/OqaFoH5B1rgdiH/80P/2xeb9fQqSULxM2oldaGbvgUTwIa2fLaPDO74?=
 =?us-ascii?Q?EZkf8oZLCM9CM0KN1+aMyDdG2PpH/X6rImQSkv8Zuv+ta4cpnFu7ZrhD9Irc?=
 =?us-ascii?Q?k9X/uOkInziQQzxD8ezKU4nBA0vH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6VVEIpQNf5voJrVXQjed4e8VHMPPSn3mwimpT2iCTa77hbyxPFsQ3cLPY13f?=
 =?us-ascii?Q?dLYCIAYPVHVFk1CQMO/XcdvWiJzipefiVC8SgQMtYg8PZM1Pc2i2qNzhbgsT?=
 =?us-ascii?Q?Uu/fr7BC52ffR/JkfC/GMzkYLsDtvU8OK95yhD6o91ymPgyEcmAauuPQJ7cc?=
 =?us-ascii?Q?q5nnp6Dus/MHz5sVxd9CaPORpmvAbkSii5L2WFLSYt1l4bflE1aaRKOnf+nO?=
 =?us-ascii?Q?0LVnYHt9gk/qRL6X2uWvJ8d+jD8rLwagKvVgp0v4W9hrvkv1SUqckSywnsE4?=
 =?us-ascii?Q?FUm5h5VH73j53SBTR1lxCEsxpVuFVxQem20qSmRw0PRJZcuWKsz5leOzSqxZ?=
 =?us-ascii?Q?p1rglTZbWRh1JXKvIqFQRf9WZggypiXUpb7+XrNcAanyR8bZM2dJhBU/GSIv?=
 =?us-ascii?Q?C5Ss/ZH9imYk9SNQ9joqo7iJuWQHOE1JOYaVGF4Vl0BAKvLw6afhtyP5J3rp?=
 =?us-ascii?Q?eMQXRcLDJUwpg4qoG6BXZlv7WaFqoqlmSfoh4+SgRyAZ7Y/bxfMB/NE1QcuM?=
 =?us-ascii?Q?ubJZdrOBteBjIx/ngx9vSrhy7DfNzkSXLtR66ucvBo4mUCXQd1HhAF3llt6W?=
 =?us-ascii?Q?GQjYIdOeuRzZ/3ca6ei4SUjMEwINjuxJD9JvS+EnHjy2O/+8XCLKmqu9GOq4?=
 =?us-ascii?Q?91Q+D3K/vEkLNqE7sEGVt/Cf83/V8CtPOUwb6aA31o4T/yTl7N+y4r9Yk/us?=
 =?us-ascii?Q?8igCXPHRJubKj1YRtLyaQYO0ftE2sDrYXCltKoB124vWy/Ed+vr6q/crtOfq?=
 =?us-ascii?Q?7dMLTyTOV0/G6GeSuP9gjmNhtFO9Ealk+vVnxBuKJT9kaQcB0HpilxvLDIcb?=
 =?us-ascii?Q?JfkO9GL9XfyA1VVNJ2SKz1vgAsy6MwJn7weMkGAvyojkk6+Q0wciWv3aDS7q?=
 =?us-ascii?Q?o6IrVicdj59BjlbkQEjMJZ3smR/BZQHDY9PHP3GmVUjIkt9U1r+qs6tSKz6+?=
 =?us-ascii?Q?wzINGzmjQ82LTVjoIIX+SkBeUC/HqAdvlX0bVXnjgS8DxHFGgb74lhyekIC7?=
 =?us-ascii?Q?7NL2wfUwKo+gb7bOmTvJrkT1wQHP16qjFEb9FS8ryowG3Cz0qG/aLs0gLwEd?=
 =?us-ascii?Q?lQrLYr7sB42YFNCRPCT//oMCKZGRaAL/WRvEFfKc48vlH3GmuLrjmisl6Din?=
 =?us-ascii?Q?c43F4/CtykhFgFJ45DgPYbjgphrOogaJXyJm2akdaql0FPkRCSBK2a7ln9Dn?=
 =?us-ascii?Q?qjPU9KNuioXQIaE1cMGJ1BUIDp2EPF1lvJEjOUg7310XPXzvngBKOUoovzYL?=
 =?us-ascii?Q?W6igIRAspkUs2P9NnmSJSM8h5ESfnwexaJ2CgQSkM/Z2V1vKksL9MJV/nAYL?=
 =?us-ascii?Q?Mug4MCKQtP5wbtSBTM7GUgc6/bZrUQrGl3OCGOrFv1X8nVYVXCRHRKb3RDFq?=
 =?us-ascii?Q?n4LQJPsTGBmyPJBnisl2H/XzvNGqpuYKxkbhWcKUdvpKMhiFh3sCWanafB7o?=
 =?us-ascii?Q?T+vqyw/f5iqTsM+jdZpW19LSKXFhDYuqlvB0OKIcx8bJ1weKdwtJFfNgph4K?=
 =?us-ascii?Q?I2baLc0HYuC24/3OYbK3yjrRIwJh3Jyq70pZTEgfRN4hgitVymt6ef3ODGRg?=
 =?us-ascii?Q?T30HF2PpJEzj/a658nvAC4qxqt7Q47HvSTwjQCDn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c82bc72-ea71-4882-cebc-08dd1f79d48e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 15:37:07.6119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZywTE8uX/6K9QPdGe6uqMQAYoQKxA9aHMEqxByHm9Om4+AGb4zFmbJnVXPdDV1ExMBNrsfynS0I8yaclWDNuOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6543

On Thu, Dec 12, 2024 at 10:00:58PM +0800, Qiuxu Zhuo wrote:
> The 'storm' variable points to this_cpu_ptr(&storm_desc). Access the
> 'stormy_bank_count' field through the 'storm' to avoid calling
> this_cpu_*() on the same per-CPU variable twice.
> 
> This minor optimization reduces the text size by 16 bytes.
> 
>   $ size threshold.o.*
>      text	   data	    bss	    dec	    hex	filename
>      1395	   1664	      0	   3059	    bf3	threshold.o.old
>      1379	   1664	      0	   3043	    be3	threshold.o.new
> 
> No functional changes intended.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen

