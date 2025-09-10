Return-Path: <linux-edac+bounces-4782-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A93B51B58
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 17:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62ACE3BCB75
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 15:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9F42586FE;
	Wed, 10 Sep 2025 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="22daUxzJ"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181FF2571B8;
	Wed, 10 Sep 2025 15:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757517446; cv=fail; b=Zaz18FcWdsa6xzS9dGzB/hCAICW/D1NXIeg0qee0RGeuSfOTO7dWXteoyV7FBG23GL7R4fYhTuBArpW+Vce/mWt6xjOQfknsjkBKgT7b47rn6fl6TMhs3v0Ibrz1XZJjEypxwAqbgM26tJFiJzVQY7dbmPxoXaJhiVIOEfpNEqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757517446; c=relaxed/simple;
	bh=UxRIReVqvZhjYIZoqbWPjfPYKxiHkeBPC0tt3PPLolk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TAv05lm8TlU0NpNjKQQ7PGguW754EA8H2nndNToLMx69gxQw6cuBQPKHJBGYXXpfgBSdp0hMMvHLAqrEUZ0qeCJ0CV3il8gmt7wRvh4oyGHz87b5wlmaFcSGYqV1TPL+kTOid1mt3k1+wlBWeCfPsgxtBbr0B1a1aYJrYIF0khU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=22daUxzJ; arc=fail smtp.client-ip=40.107.100.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PsRb9FdQoxGT1dQFRydU7HWTgIWMSi/GPcWDSvSQvql55GOv8F2PxRAHkdZnjK/RFKVFR62YRkLG9p9iux3361f3mFJamg7p0m1zRcl6T+21EFOHRve5GGxkbvgrUKgtfOeIQBez71rBUKlRt3oNOOjGNieFyMgStsmwmu6iZbI8gj5LLh/0JwbNciJ0gTy4eHnt/vGPkt/AD1UoTNSxX2VKMZ00oHJFXHmH/j2LRt8l464ONa/dz16gyMoPnSyjQ1uKqj3775CB0EGoeP9z55xxBP3JjfZ1sKQB+fb/aij8R7hNICJL1ra/HfEOdxxyh6PP+ssvD5CXLuXroR3eGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnPm1N+ryRgo7KRW9zaCoeoESWX6EInqB8QbNPCjYQk=;
 b=Uj1DCSxa8D2HUA5mvr1mmY1fbU7Y87aCo95kX/OSz5MgaGR73U/p8aqo/DDgJMp9xzpJ0aupxA4Vs0Vueu87NG/R4JP+A+ccPoDp3ebDHFPkBO+yZTmjNnurdTPPtXc0mbmvB2Pq5LE9zyKz8PJWy5hvrHZdoeFGYkxOtX5OZrsQZFf/ygQ7RD9morSydyoXFp4xE9q816rSxn0JJ9uNubLRWJ44QPfGy9v8MCo9DgsBUe99FLRudZ60EuJ9/qg8Mu2hs3D61oGJgesVvqP4CY281uSHG1CBRVDMNtua9Da5An/PLgZgxEHLxbHulvY3iH0on/gPHRZNx2h1M5JKTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnPm1N+ryRgo7KRW9zaCoeoESWX6EInqB8QbNPCjYQk=;
 b=22daUxzJgPDUfZeA8Nd3Rond7Ku9gyRyA+BUhIEtsqc7tTS5ogmG5nMiURemL/u/0RBrjOiMdDjYYk3mAhnXVDQqy79svrSiv8Z1Df70/5k6zYOoBJQGPj1rxM8RIKcWZYvSuXm7GX6DYjiz948Q89LsPwVTcmn/OcMk6qIQiZE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by LV2PR12MB5943.namprd12.prod.outlook.com (2603:10b6:408:170::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 15:17:18 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 15:17:18 +0000
Date: Wed, 10 Sep 2025 11:17:13 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-edac@vger.kernel.org, bp@alien8.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] EDAC/mc_sysfs: Increase legacy channel support to
 16
Message-ID: <20250910151713.GG11602@yaz-khff2.amd.com>
References: <20250909185748.1621098-1-avadhut.naik@amd.com>
 <20250909185748.1621098-5-avadhut.naik@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909185748.1621098-5-avadhut.naik@amd.com>
X-ClientProxiedBy: MN0P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::24) To CY5PR12MB6369.namprd12.prod.outlook.com
 (2603:10b6:930:21::10)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|LV2PR12MB5943:EE_
X-MS-Office365-Filtering-Correlation-Id: 926f7efe-c98c-49c0-7fad-08ddf07d2156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6tOL8TKfVcUqv1+LXRtfsKuyDt0ociNLHBZOci+jeCW/T9K9KNPgBDNRty3F?=
 =?us-ascii?Q?/G//qkkV+63roSqi27iiG+4F38tqsDAvVMTlsg4F/hUVnuLDXKMwR2rLT48z?=
 =?us-ascii?Q?/fnGf2G9lArFZ6Mt3R3nG0W89sVZbrLHHTKHTc95Rt6k6Cub/qiSfR4X1AzM?=
 =?us-ascii?Q?eINvn3SIlA2LupmqrOrPGhCyLjLWvNo3XtiokWg7zYNT1M18AxApw0GQmVS4?=
 =?us-ascii?Q?EzmNROCgdcX6aDOzcXs3WhnE+jn2vZYF50sbG8tXmaToVKElec3ULb69CMZ9?=
 =?us-ascii?Q?GflZzYGx02uHx5koF3m3haTS+wRv9HRsG7krWQcTbh6iQiHVaZ4ekdXfrSPX?=
 =?us-ascii?Q?rN8iwD4C5gTYS13hUsST2E+7GVr24fEGkkYmePcSgvkRu0xC4hmFxbNXz9Y9?=
 =?us-ascii?Q?L/mD6R7bAq37wKZHx0OnqTZbtE8t9e/c7ZqiH95ovxAd6KRHDl+nS5vVER+p?=
 =?us-ascii?Q?V6TIjKxXFjXRL86PdLoUKH+9p4xJcWCrN6gtK/9Iie41HjCEcmO03n0+D/nT?=
 =?us-ascii?Q?MvZUfRnX4Wm6vjriciUbR530DJTBIqWAMw7Ap6yVQrF/LGmeS9XQJ6XbbdXD?=
 =?us-ascii?Q?KINsedEVOa3EUSLPS32p94U8MRDlXrjGJ9af1DKqBUUQk+cbGMt24PXuZiNP?=
 =?us-ascii?Q?UaTPuUHLQJFo1l0qWDpB8BSMXJ+lX6+pd1TKoiUs3SQ8mzLwgSR9syOb9j3o?=
 =?us-ascii?Q?en1Awv913moGt8VaEQkzL5WTtcxLyYChuPVOYGMUSgk573WI/M8ZzWmtiVYZ?=
 =?us-ascii?Q?YYFloSTl20zSL5rHhEa54D7q8g/7pKcByza0ppx6XiIKtX3CESrl2td+IeCT?=
 =?us-ascii?Q?OZzloT6QU0X5M+W8ru+6Lf31Nbyo5suiMrC4CKWGbusaoBV8LNJImlbi0Otw?=
 =?us-ascii?Q?UoR8zrZ8rHi1fm9vzSSZUJR0i5xuc5+kikL52tf2O6yJVvnIQuqugsrwr2oi?=
 =?us-ascii?Q?PJ4Oup3mtLEtvGRFi2RYZdZBbNWjQtf12gLnZv+qNMvTp3nydZkkaGHnu52n?=
 =?us-ascii?Q?dSfkBP916BxY5qiybtmXxoPNk/nTI71J4BZn++G4VjVhHbolLD7bqDxqs5Tz?=
 =?us-ascii?Q?CKMY5HDxUlE3a20ZREP7XZXpzAE5CmvFSTqPJWHmpwEajkVlPIBv5YEWAG8Z?=
 =?us-ascii?Q?WuTABbo4zXA6Geg/yYm5YunWQsEmCEXw4MghQN9aN5jSnY+Qsy8nds0EAAi3?=
 =?us-ascii?Q?8J9+7AUpfWYJnRsFmKyBlihPWniuQtGcs/kj5+nNraroRHA8Z0fPoDnadsL+?=
 =?us-ascii?Q?wHU0t1MFX5ts+6kp5uxQN1D1P3jVt5I1acEGVrUlQSlNoa7CcZI7X5fr5TB5?=
 =?us-ascii?Q?unZa7wBuTKcr+cdpyjMOICl/a7P7KmbMthLwG/bpjplyBBfq0DvgPSbPFcSD?=
 =?us-ascii?Q?4kaFMaSu3fBpB57w71hODt3hGm2l8RF5hRiu1576TYc2PSeexqzjyan5XOzc?=
 =?us-ascii?Q?C+Fy9VYRQk0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vxvydfqDj5VGxf6F7QL28mMbPw1JVC1sjyWwgHOo0513CkJ4qdP4HWYYT+He?=
 =?us-ascii?Q?JhHpI6i77f13pKiyPwXXK4wp+ujuJ2b87OozLi2kluhSlmi75TNnHaJQnfJx?=
 =?us-ascii?Q?Zfyptbw8qZ+f+YCrXYZd43VyGAuVc5WPEwub3uCWSyepnKG4ViKYgpdENFTA?=
 =?us-ascii?Q?1EfAS+g+vY+Y3CkRq3x/R+y0/dTiWgaziBPNxNS9roQZ9yhw0lM0HHnaqm0k?=
 =?us-ascii?Q?ogUFGeE6po7npyCsNmr6GydbyRFIqvx9W+rhJolA6B2hg1rW4pdY+sTm5Dcr?=
 =?us-ascii?Q?KnvpMNkGWdeUsWzk4SDRS01wFSVHr7EHxBhDj4+J8Y1d/mD/DFMBiy6BdRp5?=
 =?us-ascii?Q?MxlDbhFVFxlceDzOJnxcnJmTJOuPHikgOinuGhX5Q9AD+2x7r2+pZCV/sUkF?=
 =?us-ascii?Q?uiPgKYdG/OowtZLVfbi1ZOIp9dlStaGRZkgM3yEDVCkfVarxTeawoKZHR2r1?=
 =?us-ascii?Q?eezAXR1rmvAaiFtHZwy/55Fp0lrejP14F0qFsoM5LbqeCwaibvC230fN6UhH?=
 =?us-ascii?Q?rVCmxbpXnC2nAB/f7M5aheGUYXjt/oRKVKsaahlyMLNfLxJ7Mh/izs58XaJH?=
 =?us-ascii?Q?DtPgpDWp6MOISPnSwQL2NS7NODSardGYimi71z3RmpI5ZRnkf+toGfCWilzZ?=
 =?us-ascii?Q?9l+RAwlDnHK5c1ynsPeH4bZbKK8BVry5fLnK4q5ki3pM5LlqRcCBvqP3lxvS?=
 =?us-ascii?Q?YtpuFnYFW6x2gzCqrXPWEYx5md9DrrWeHwdqv104mWm1tLHwxsg6K52y+TK/?=
 =?us-ascii?Q?S3dIKdXzCPzYRjZU79m9Tl+076G30sOy1QfCyhedi8ZYXdwYBFfgpbB6Jflw?=
 =?us-ascii?Q?OmVdPebgUogR7a+XaCb2US/6vb5BJYdNowJF0IEgh1EXQfFDd1uBmvrYn5xz?=
 =?us-ascii?Q?sPU0V/i5lYBUkZxBDGvxlVoBkC/10IuyP8lsPBx27KIJAJDbi/JrK2hak4IK?=
 =?us-ascii?Q?hT8TDWCjMQGfvvbJIu0OcTxQ718v38cWZ/PqOH7LAuU8hTcNu1c4UyYCcgnJ?=
 =?us-ascii?Q?hbLSCxC+Fd0ISe7aOCXglRfcFzxoBxbqhcjhRDcovVWRLAJ91t0nu5Z1NHzQ?=
 =?us-ascii?Q?8ZWm53myiFxBO6Znw0rXPIsqc3aC4VZpU8W45zhEPWzSFqqXTXM+Xh9O5hFj?=
 =?us-ascii?Q?FTsWUFs90z71ActYoBr2VRDtUK5WbC6LH1nDxUcgD3Ghw4HsvXj1sFzh2ke8?=
 =?us-ascii?Q?kEsjyxtCLyKdQn+i1oZmLMkiln+wz4m5w9lvCZOQ2sFv0sWltM03HPEBs7Go?=
 =?us-ascii?Q?3k1Si8cpoWjGQrFEW+tG9sHYUGgPykBcBjZK0kFFwuw+JGzB1rLSPcIeXjIP?=
 =?us-ascii?Q?LZzpE3r3GMbH25/m4+LJwgXVDJFEK48y4DDM/4dtnpR1NtNcyhvq7k1t0Zo7?=
 =?us-ascii?Q?l8LEoOzVPGn3zMuvQCgq8EDPtwvYh7OYgwGff0+rrkiGt1YEbYsNFbgrlqBS?=
 =?us-ascii?Q?mCiRW8OtcFSs9iq/7nmVSx935OHXICrZu9S6SGJdmWwzMv0CbZjHA7rm+CGK?=
 =?us-ascii?Q?1Vk0MR1JxT/VmQzq6jYi7T9NSmUn7ywdCOoIJzhArWV0K4zVeh5v9WZ4Y2PU?=
 =?us-ascii?Q?lzTnMgGJeOpbEHnf6SLjMQJjdB4jEriXMlID7T0T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 926f7efe-c98c-49c0-7fad-08ddf07d2156
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 15:17:17.9870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8knKtfbrXyfDTloRtxdaWVmPsfwR7nji6MSNB1oJuVG9EKx3LUC0TscgR5dGmhUdSK1YNQX00r08VwmiH2NRdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5943

On Tue, Sep 09, 2025 at 06:53:13PM +0000, Avadhut Naik wrote:
> Newer AMD systems can support up to 16 channels per EDAC "mc" device.
> These are detected by the EDAC module running on the device, and the
> current EDAC interface is appropriately enumerated.
> 
> The legacy EDAC sysfs interface however, provides device attributes for
> channels 0 through 11 only. Consequently, the last four channels, 12
> through 15, will not be enumerated and will not be visible through the
> legacy sysfs interface.
> 
> Add additional device attributes to ensure that all 16 channels, if
> present, are enumerated by and visible through the legacy EDAC sysfs
> interface.
> 
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> ---
> Changes in v2:
> Patch introduced.
> 
> Changes in v3:
> No changes.
> ---
>  drivers/edac/edac_mc_sysfs.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
> index 0f338adf7d93..8689631f1905 100644
> --- a/drivers/edac/edac_mc_sysfs.c
> +++ b/drivers/edac/edac_mc_sysfs.c
> @@ -305,6 +305,14 @@ DEVICE_CHANNEL(ch10_dimm_label, S_IRUGO | S_IWUSR,
>  	channel_dimm_label_show, channel_dimm_label_store, 10);
>  DEVICE_CHANNEL(ch11_dimm_label, S_IRUGO | S_IWUSR,
>  	channel_dimm_label_show, channel_dimm_label_store, 11);
> +DEVICE_CHANNEL(ch12_dimm_label, S_IRUGO | S_IWUSR,
> +	channel_dimm_label_show, channel_dimm_label_store, 12);
> +DEVICE_CHANNEL(ch13_dimm_label, S_IRUGO | S_IWUSR,
> +	channel_dimm_label_show, channel_dimm_label_store, 13);
> +DEVICE_CHANNEL(ch14_dimm_label, S_IRUGO | S_IWUSR,
> +	channel_dimm_label_show, channel_dimm_label_store, 14);
> +DEVICE_CHANNEL(ch15_dimm_label, S_IRUGO | S_IWUSR,
> +	channel_dimm_label_show, channel_dimm_label_store, 15);
>  
>  /* Total possible dynamic DIMM Label attribute file table */
>  static struct attribute *dynamic_csrow_dimm_attr[] = {
> @@ -320,6 +328,10 @@ static struct attribute *dynamic_csrow_dimm_attr[] = {
>  	&dev_attr_legacy_ch9_dimm_label.attr.attr,
>  	&dev_attr_legacy_ch10_dimm_label.attr.attr,
>  	&dev_attr_legacy_ch11_dimm_label.attr.attr,
> +	&dev_attr_legacy_ch12_dimm_label.attr.attr,
> +	&dev_attr_legacy_ch13_dimm_label.attr.attr,
> +	&dev_attr_legacy_ch14_dimm_label.attr.attr,
> +	&dev_attr_legacy_ch15_dimm_label.attr.attr,
>  	NULL
>  };
>  
> @@ -348,6 +360,14 @@ DEVICE_CHANNEL(ch10_ce_count, S_IRUGO,
>  		   channel_ce_count_show, NULL, 10);
>  DEVICE_CHANNEL(ch11_ce_count, S_IRUGO,
>  		   channel_ce_count_show, NULL, 11);
> +DEVICE_CHANNEL(ch12_ce_count, S_IRUGO,
> +		   channel_ce_count_show, NULL, 12);
> +DEVICE_CHANNEL(ch13_ce_count, S_IRUGO,
> +		   channel_ce_count_show, NULL, 13);
> +DEVICE_CHANNEL(ch14_ce_count, S_IRUGO,
> +		   channel_ce_count_show, NULL, 14);
> +DEVICE_CHANNEL(ch15_ce_count, S_IRUGO,
> +		   channel_ce_count_show, NULL, 15);
>  
>  /* Total possible dynamic ce_count attribute file table */
>  static struct attribute *dynamic_csrow_ce_count_attr[] = {
> @@ -363,6 +383,10 @@ static struct attribute *dynamic_csrow_ce_count_attr[] = {
>  	&dev_attr_legacy_ch9_ce_count.attr.attr,
>  	&dev_attr_legacy_ch10_ce_count.attr.attr,
>  	&dev_attr_legacy_ch11_ce_count.attr.attr,
> +	&dev_attr_legacy_ch12_ce_count.attr.attr,
> +	&dev_attr_legacy_ch13_ce_count.attr.attr,
> +	&dev_attr_legacy_ch14_ce_count.attr.attr,
> +	&dev_attr_legacy_ch15_ce_count.attr.attr,
>  	NULL
>  };
>  
> -- 

There are many checkpatch warnings here.

Maybe it'd be prudent to note this in the commit message?

Something like "checkpatch warnings ignored to maintain coding style"
and maybe "affected lines are deprecated and will be removed", etc.?

Otherwise, I expect there will be some "checkpatch warning" fixes coming
our way.

Thanks,
Yazen

