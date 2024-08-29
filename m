Return-Path: <linux-edac+bounces-1747-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4887E9647F4
	for <lists+linux-edac@lfdr.de>; Thu, 29 Aug 2024 16:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D6D0B278DA
	for <lists+linux-edac@lfdr.de>; Thu, 29 Aug 2024 14:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5F81AED4C;
	Thu, 29 Aug 2024 14:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WJOtZwsT"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885441917C6;
	Thu, 29 Aug 2024 14:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941108; cv=fail; b=m2x5z0jmY/uM5OwRI7lEUBkI+hRP6hsRatVH2tEj6vuGSxJcytjGf1DFcrbxeOJj7AHbPiw6jam8RACuv0pNTi0B9N3nXknDLIKPf7SFjAK+W+pDaxIhxtSzLRmvFdF0bqVX+l/wLj3UFeYYTH/mNAFWOnffFCXkwnf/4Qm7X54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941108; c=relaxed/simple;
	bh=m4y1OASdUdr07udhLgBwpUOvlhuD6sjpoIdac9kdVvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TyRcEkC8IIIzifYs1/V1NZUTgqe3su7/psZ52QNFzceQLeHaGjpf44doczOKDbRqMBqp2DAp9kYdpCkU+GV+RfkoN2ju2ZdUnpx4tresAnGHwgjFci3xaBap6fvYReVrH9GyRdxBgSE/dRD/Juiv1Gj/i0GtJPxL6jQLagkJX58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WJOtZwsT; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lEWJRPOYX23rbeW1o71o6tPHAwlkb1aN7nr2fGOvb02gN5DPpZARJRNERBV58RTIKKLUdvNudAfGP3tkf4BB6Q9zpwHVNgOdTfPwam19ICag0xsGsokkk8XHD7RqnwxDVQFtkN2QqWDO+sW99SMUmw562XzOdzdnClp2ysF5kY4SAUQn7QvWLGPZl1PuXHk8Ypo6UHTCaR5jrHWDpxr7F8exWezsmEsbpsTFBIXxacGXK9GzgkovMaG2wiAFoSMZsjbUdgHQPMedEuJMxdAaSXha26vMaOxlvTYM8Y7qiH6AtgppWpIm0JqtHBY7/OcNoUok41tS0cyHsYslCILlgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYDNhSA38JhFcrwPiCyOHCvdOF1ihmi6s/QgaP4PjGY=;
 b=jBh2EjZa/7+EWsQgib1ZOlZgvHvcOx1iOKgQX+JxcNcro2fg5/TXehf+FwTM7iCjkVyb2NG56ad57JMmlhCV2cY/1xIbxnHhEFb5CWwNLu9qABD8A2SCj2YL19Vy6xA3Ksnplp5m4WtByWNqcdvmj/a9pk31pBCSYIdV1deywhhE2ZavJ6qaHIEobWEiY+c4CXpoJJXomLUEDx5XZNRWGz79RidTD2fTYJQdKz+XABh0SmRco1TsPZQbbBDeMlOsJgrt0agCOwNrj35wK70rtRoTGhH/ThbGAKHe/xzV7F7pO/RpZxmH/jZEMPBixwO4x/XqCUHJTupHZSlJcTqD4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYDNhSA38JhFcrwPiCyOHCvdOF1ihmi6s/QgaP4PjGY=;
 b=WJOtZwsT9Cso/wVTSCbdQ4wK5NtI0fDcVWUmxZVDLM4HnR4XfH6OH+7szO0v+dRBb3BYIwQOclEyam4PaKRclFKiskTQBFM0ee3mgMU460GluweS9HZCwhApXZAbzu8b+RBEVhMPtzcQiNieC8dU2I1E0sdz0XcPBUlJGX5as48=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 IA0PR12MB8421.namprd12.prod.outlook.com (2603:10b6:208:40f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.26; Thu, 29 Aug 2024 14:18:23 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%7]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 14:18:23 +0000
Date: Thu, 29 Aug 2024 10:18:18 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
	avadhut.naik@amd.com, john.allen@amd.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH] x86/MCE: Prevent CPU offline for SMCA CPUs with non-core
 banks
Message-ID: <20240829141818.GA458692@yaz-khff2.amd.com>
References: <20240821140017.330105-1-yazen.ghannam@amd.com>
 <87jzg4g8dm.ffs@tglx>
 <20240826132057.GA449322@yaz-khff2.amd.com>
 <9D26E333-B33C-4FD4-9A8F-6F9DC1EC6527@alien8.de>
 <20240827134706.GA719384@yaz-khff2.amd.com>
 <7D571DAA-E399-4580-98B3-8A6E7085CB54@alien8.de>
 <20240829140305.GA448036@yaz-khff2.amd.com>
 <20240829141415.GDZtCCN89eyjycV0uf@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829141415.GDZtCCN89eyjycV0uf@fat_crate.local>
X-ClientProxiedBy: BN9P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::9) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|IA0PR12MB8421:EE_
X-MS-Office365-Filtering-Correlation-Id: 75caae1a-a9c2-4b3b-6c90-08dcc83570a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/KO8fFMREXd/76EIjN4iCB2bJSCZEqg3SrgRa53chXZ84e6+6hEtjkdGbDW1?=
 =?us-ascii?Q?55T63/FE3MDzPj7LXWDrU+T0EkZQPtXHbsItnk5LGtfzpiX32LIm38kqZhA5?=
 =?us-ascii?Q?0b2tAiMsk5GfcfPI38FF44Gd10zfBuXd3X/8MlW4SWOW+goqdL/A0pgln0vv?=
 =?us-ascii?Q?Hr/JmRJgoukQPnammPm5IcwVcLHDoIvBVSE+hwPIXcVNVm72mb/W+G/p9t+1?=
 =?us-ascii?Q?vSGnVNIak46pmCsS4jfHk5QA/gG/qlFfee9zYrIQIx21lCn6y4crUWddjbHR?=
 =?us-ascii?Q?NfLPzHykaWk9A49uxEKdSwyqVvlBuXkDtfAM9e6HSRm+X/uBjUN2mJhJRqBB?=
 =?us-ascii?Q?J7487kUylkZz6VsQGpESFFesbib6lKCqX9jYSsai9obtNClOLHLudXd4S8+4?=
 =?us-ascii?Q?/eIU2Ydsz8k3GW8M3kIUx35K7lO309D3AsyV67WUpiq1JwlB4bpoGM11+1Yj?=
 =?us-ascii?Q?6jV2mLTLLfJ1K8DEXoKb/YhL6y6cJOkoo3a+yEmZ0HshzGS1DLMixGK3WymG?=
 =?us-ascii?Q?EJ6u3OFDK+1aodg+MNuv70n5cWEYQow61c4XRFpO+hYiC36tNQZJe0P1ZyU1?=
 =?us-ascii?Q?5EHc4NtruBdDX4hlj60GqInpn+GSdKVATYzdwLxIIt0dpnpQ53+f49HzbvDG?=
 =?us-ascii?Q?I8gIwPSEH1Fjqr9LwF4htKqlVlynIxkZwyoTtK0xkQEaUtOZjpZKd9e2OCiy?=
 =?us-ascii?Q?wG1Il3smUcG2z3bV46CJFYvtf1emmgH+ezaW8Yr8iqlIV2UsOCYS3G5g0CLr?=
 =?us-ascii?Q?PQHwe/bYC1tg1vunaGTxvHS4gSRXlhl27Jp2UvL3cVU+27xWrNUI0Gdzm/TI?=
 =?us-ascii?Q?nD3tGst7PVfMwqH0RZ5wXnG69s8ETEp08B+bOb5sW8yNPGuUmY150Xe6cW90?=
 =?us-ascii?Q?ds0WA7B8YbcqzKd9y/S8mIqn4cMnlZ3/+nlPMx+gO6aHc/mx9cExAsFrnJho?=
 =?us-ascii?Q?viiUoA5uRYOFspmDopper/YNbNpKv+tQWJA5qwgnZ8SrWslegSW9ZPinvxy+?=
 =?us-ascii?Q?DeSdg8cQ6U5iyLyEUG3NiQ3CP5Ayo2hqn9g4FXYojVIkPtbW7YD4YzdCNUYi?=
 =?us-ascii?Q?6KPmPLKfEX6+CyfezIiFDoMNrG6/tDRTsRbBgIytKGShMrOjeCcNfZzs1HWq?=
 =?us-ascii?Q?AiLfjhMrrFfqfT+LrLRnQLZkO84/O5tDhUuTu85cG3KYCA1LQJNF3IlMr+JE?=
 =?us-ascii?Q?5wRcj7C27SesHrZ8UbZfJKSFuUogfByb44dFBNW/HpS636cniuBoifSClxxV?=
 =?us-ascii?Q?WvnmbEO7z5zZD7jEUl+28BaQXp0FlQh7v/yxk8SEzGxQ5W/Gt58giBDv5RcC?=
 =?us-ascii?Q?YBHCO9CzyCxLyCNClVs1bNprcvg+hVUQqMSR09lEPs93pA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C3OIlhOX/WVHG9MIaHP/3XbvG/1h69RysL1cL9Vjm5i8h3Ruqevsp7YuPCud?=
 =?us-ascii?Q?V2paxDpc8zi11Y9Nor5kH7ykfwWMgornJ6M4Fqlrfxsaa88S/cto2JipGUqb?=
 =?us-ascii?Q?yATM1/1UYADUmzbAp3/YOIr9a41S3/G3UJFRD7NpdAYtZC3bn6ic7LFIEUYR?=
 =?us-ascii?Q?gl/mslh6Svj2YdXvknhx9aLcbTK0216MTHch64OkhubYVJ8BQMvNWWB6BesA?=
 =?us-ascii?Q?MGmncPYaA1LDBzdATE2KzbJGVcK3RTg3URnFxXcTIKHq6LT87idxYVZxoi21?=
 =?us-ascii?Q?SsHUggu2apr2KwK9pz4EEI/agIoN9Bqbj1Iw+TmioJFcHkZKdUJTLOPXfi9y?=
 =?us-ascii?Q?lu35BmvLTa+ysCwJd4D2ZW2wYInTUEeOydywFUbKVexaNpqaerL8L6NZ1+nk?=
 =?us-ascii?Q?/NS5NvKoh8xGLRSVadZcTLL3cOdoOeMjT4SEAnACId/8DX/jN8tahk+t+uQ/?=
 =?us-ascii?Q?d1mifxs+AVCzgVBL4p+5vSHUXrJuVk+U0ZCsouHO3UFcfWsTHd7wZOVQH0M9?=
 =?us-ascii?Q?x1ziFIJeKvnhJXbLnFMzNCXW8spkGVcsPvnxzSAITOcthjZCal8GMOUK10wr?=
 =?us-ascii?Q?8qxOLzlrHqDGhq1iHosttddCkz6oJeQ1sCFuRZFc3swoYNGBU9Z8ofgRMNr8?=
 =?us-ascii?Q?5VEUC8yaOtO1/HYrmEhrUMmfX5RNHQ+PUZy8/X9c2yFCBl7edSfZ14ZIz0I7?=
 =?us-ascii?Q?buXwR/lQABFPwf335r/DUpG9BHwqJ+tOJO3Ok/nsGivgQoItI0TVZZuVaZ4H?=
 =?us-ascii?Q?2pgqLJu5rlrXFddeFNIQSA0oHeI8KSXEKXSmVAVWiNrsQlAK3q8Uft63dP6v?=
 =?us-ascii?Q?Byxw7w3Vhi4LJwtkdXYqVGsAmAnu3fDYgqNYXzRF8nKjVqXOlEWEBG3KnhAU?=
 =?us-ascii?Q?hOe5gy+/4x81iyLJGSB2XCJ9ljGG57ztbNr3NMO4nhVbD49PXbF5Tp8xjrpB?=
 =?us-ascii?Q?XT9n+Fbk6S3wan2D+gXlvtksodFeKw90AVakBkUYaQKnzEA5vmOuHBp6GRyL?=
 =?us-ascii?Q?Tt+8ZyeOguhc6oCQRdF7OQoTl/vSzWYZ3oqW/w3OvJHRyZUz4/rpJpSgjgzW?=
 =?us-ascii?Q?r5oFod5rXdi6U+VF9Ow62g+fJhPiPihutNXHj1M61XuvErymOMiC5islLGmN?=
 =?us-ascii?Q?bK7vWCRx8nDUCkc6kqzfujHMzV7WEz73N4A9+h6Dk3W7yBcr/aebLBEbCRve?=
 =?us-ascii?Q?Q3gAjD1cCpCtFPN8uYZsx+8dlaXj5pwWBWOtgINoTeKATSeYSky1jmVHyGWP?=
 =?us-ascii?Q?TT1JlYtpdbHnwWVUomzWyKOyY2TYZfRxYgL63QV0dBo8dpCBcKPBRQnY5aUg?=
 =?us-ascii?Q?FM2M7S2rVtePxo1F8udtPeW+QPqRBEUEYprhsMzco+eQv3dJATkBbM3qMUSR?=
 =?us-ascii?Q?/eGo7E8Dv3UAou9POe773CC3vvozsZrw58VmWHdkdHQjGRffoKMEil8PV364?=
 =?us-ascii?Q?4oh/nBu9O3lchWIMdkPMXav7VDL3k3IVBriNYokm0LD0TMxYERJnKBNxJncA?=
 =?us-ascii?Q?gpXNJjcHlNLbRI3/n2GXpkIYehUlnX3qW6Z1xo1y4d0Jzx3rZaBZe/e2uljd?=
 =?us-ascii?Q?NBL1X7Nwf4pZc8ZLDsx17kpfRhfDHUhkGzk2sOnf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75caae1a-a9c2-4b3b-6c90-08dcc83570a9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 14:18:23.0156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vBlX1THq2q2/UOJmpzKQNyEjzaNJhxOGBmugIGyCh4VgUAKTCyzY5Vz2LbfgUQxorXbXSWFK42KLwjAqh2Xb7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8421

On Thu, Aug 29, 2024 at 04:14:15PM +0200, Borislav Petkov wrote:
> On Thu, Aug 29, 2024 at 10:03:05AM -0400, Yazen Ghannam wrote:
> > Do you think we should we continue to pursue this or no?
> 
> You mean the kernel should prevent those folks from shooting themselves in the
> foot?
> 
> How would that patch look like?
>

Right, I'm working on another revision. I'll try to send it today.

The gist is that we can hide the sysfs interface for CPUs that shouldn't
be hotplugged. We already do this today for other special cases like
CPU0.

Thanks,
Yazen

