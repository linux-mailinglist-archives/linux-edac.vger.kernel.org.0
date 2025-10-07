Return-Path: <linux-edac+bounces-5001-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B681BC1D12
	for <lists+linux-edac@lfdr.de>; Tue, 07 Oct 2025 16:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6E519A2B6C
	for <lists+linux-edac@lfdr.de>; Tue,  7 Oct 2025 14:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8367E2E22A9;
	Tue,  7 Oct 2025 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KDe3nIe2"
X-Original-To: linux-edac@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012025.outbound.protection.outlook.com [40.107.209.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68E02E1C54;
	Tue,  7 Oct 2025 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759848768; cv=fail; b=lY+Dj4Qz4Ng6vnkS5Q5Cvsc2kfuY1bWHLR5WMSRPx6R0IZFusNbhKU0ARcw2C3/YkHtOKmSUCmqmOjAU0VJQ5mjLk/FzBtyjZcld43hE5WwPD7KjANkx/HlF/anUAaOlBXBI9Ucl19UFvPgaQ7vMAfrWJ8WCvP8GPkv8qrUX1Yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759848768; c=relaxed/simple;
	bh=O7ZZWhNZ8YvxrjBKZw6Q3yx0vi7kVm2z5w8vrCxgFDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E89KsvMTtU9kXgOWQj5E32v3vud2T9qHJWyRBvXUZ4Fw5A0z8JrBw57E+oUXF9Y+c9x10o1p6OUj/GjCyiLd3B2SNhq4cmNPMWxd6dUMX0ejtBIuRXUraCb27d8xn5vUI6J4D9uFcXJe68KmWZdw0o83DWo+RR736mjYisXULlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KDe3nIe2; arc=fail smtp.client-ip=40.107.209.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrX+RDCXMUX2YFnKfZUSGapSUa4ZpJw4YV4yYfTdMgYdKVkTpvNeYrir//Pr3H8ueOspBFWnYXJW5saTCL+p9K34+TVjhGJU7aABsWcEC/a53GhgWBY8q7oZCdN+vyqVMOUmz14jtdQAjt3tC4RHqXqpsCD+FjKSRiiEMVO0anyPwFUCGAcwoLi8kQSPeqQI/qWJ7GwJ11IFe7lm8VGLyS8HQpp8vJogKsHCYgJQLco6nbpw17lhq89tYoKggIYuRomo1PaEmsI/pdf8Nf25FRRubVZb+bisbekMc1BwZ7fmMobicIKck6uUbyGb56Uw81PfqYd/L74j0KAeqYt+Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGecSHvfZvBF923s4J3cjTQGupp5getb/213eWFs9B8=;
 b=Hd1GvAtrABhVHFNvRw/Z7kNE84i2OrALuB1Nj+zQSN+T5Jj3vl5EOxVIUoo8TvIrYJshuFOW5ulC6plB9Ny8KcPUGRIwV1vihFfzT/Dh8M75Pn2GF/S5cS+A86hh+8RLbWvAmAijSjAPhw/aSbUvsdmHcZ5hdT0qVwxf1aaVPX5u0vMWqVnDcOGWpGSz6Ov605NnEIQifY1ppoZO8PQXXJOCyr+4RBRlwRc4GaK8wICVWcc1S18L80era2/isBLIl6KgeQblv3W+mflPEeEFF9h8ciC66DKLJZuWc2VvPPcHOWjQVFwHAm3KWvS2/tbBhX/viOjnZJEB0tfSyseR5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGecSHvfZvBF923s4J3cjTQGupp5getb/213eWFs9B8=;
 b=KDe3nIe2cJB2tuRjXiQmfE+3t+/hmUnnyhD3+aaXL3W3xoT4F6rryioDmfABvj7/7nK+c/5KYeKnlCS3wxlXVNqQIsaWgSdAf3QHRMA/zb+dSl3BHsfo70HuBF29CaWXMyDmIY6hyNWdkLWkV1TRir9ISd1RUu/+myM++PDUl3Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SN7PR12MB8820.namprd12.prod.outlook.com (2603:10b6:806:341::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 14:52:40 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 14:52:40 +0000
Date: Tue, 7 Oct 2025 10:52:29 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-edac@vger.kernel.org, bp@alien8.de, john.allen@amd.com,
	linux-kernel@vger.kernel.org, avadnaik@amd.com
Subject: Re: [PATCH v2 0/2] Incorporate DRAM address in EDAC messages
Message-ID: <20251007145229.GA11984@yaz-khff2.amd.com>
References: <20250915212244.886668-1-avadhut.naik@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915212244.886668-1-avadhut.naik@amd.com>
X-ClientProxiedBy: BN0PR03CA0046.namprd03.prod.outlook.com
 (2603:10b6:408:e7::21) To CY5PR12MB6369.namprd12.prod.outlook.com
 (2603:10b6:930:21::10)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|SN7PR12MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: f54b4a3d-17ae-4eaf-d6e0-08de05b129ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NbMEQHctUNVAgwenXnDQ0Qj5MWgpi5lx9Gvew6RDLdcLIzdyPNdPeRHA0IFc?=
 =?us-ascii?Q?yrK1catDXViy/AX9g5sa4/XFnRvYFNTrl8ZUh1Dfz2bON87Y0wjZLFE6V/zh?=
 =?us-ascii?Q?bAnsxmfq3ttQCBKnWN93Jo5mDk61veyAiOS6n2yDRTf0xmdFj/c5sZGutwuG?=
 =?us-ascii?Q?xtJFU09dtfaqoRYkmvM1HC18fxNp1cPMUt7I5gnUAZ6J7c9HbxOqcmcq6eZL?=
 =?us-ascii?Q?4EF/oqhogt7loSLiHDl8MbbzlC83f7Pl71PRi4N04lS1fYJBNOVvCdvCj4Sd?=
 =?us-ascii?Q?4v2fs5F94cUk0wIJ4ObP3GsCgvBW8RrcNkYlsdLR4Kj6g2SGtV/J0R2NqvX1?=
 =?us-ascii?Q?nShN45bDNB/8fv8Pat4yupoVC/26CZlclw5+yn26ZsHtrVA59feu67kUh4TC?=
 =?us-ascii?Q?7fHOHnGFPfeE9HE6Hy0OM/RADgKysWV7oEdrtPVrbOiPjRVXboUset98Cklw?=
 =?us-ascii?Q?ruzYlQtUqbBXdSD9DEeQHARASaeTXl9Ve0EVRo/pMNuQzCn2ZvM8iuzElbup?=
 =?us-ascii?Q?YnZz6O3o5qSMd45XihCBEgQu4TgLp95UEBrpwc8gUW6JQ5DFiwRs00hBJlP0?=
 =?us-ascii?Q?AYQ+9VTZhEC7CTpXvoeaqgjfc+5hh0Sl1B4szyuGPN6cSeA1unWl/gJt198v?=
 =?us-ascii?Q?xObS2bmsP2sjnlyS1mWIFItu/2Z4deyZBVGWAi9XI+xfUdREq9DRRC8aL7qR?=
 =?us-ascii?Q?q9NV/GW3u7xTVSq2sr/wd9uvlm6dcU7xMlSadwaCaJdpbPhs2OHVXTinKQVl?=
 =?us-ascii?Q?A4s/3p8N6QuxndN5vrjuoZpjtTAQW0Mfjez5Dsu2z76FT295z9b3FBF19YNg?=
 =?us-ascii?Q?mtV6SWjl0dueaUFZJpx9Q4snxCRpiH6K/F6X60X7FUh1tL8NQyZUQtOGlFKm?=
 =?us-ascii?Q?wVefiCCPRSmjne13jkKi4YnGsbbHjJBRnDWjj9OtGlID8m/XeqMA4+bnL0gf?=
 =?us-ascii?Q?JMwcnPq2ojVXTF5758KMGQhNipJvRDeoJXGRWpPu/5RL+gxRadn7PSrucjSl?=
 =?us-ascii?Q?gVNcOP8b3t1US20JS8dhiEl9A2mFVHaSHP49xS5QpP8Wyv5Fbk2oa/ZdkOOS?=
 =?us-ascii?Q?bYnckDH66HgOb8lHTohKcx+HPmWjDmEwPCXFpRX8J6OmNUIZhnzQWBnBzrR7?=
 =?us-ascii?Q?xUGBJ0EuFPOq4KGV+S5ECYsx8r1igK7Xv2brFpch+GViZ/x93ieKb+GdaNvj?=
 =?us-ascii?Q?hUWdxv/5EHf2NfjwmQDGD+GoBRv/6N4YAOJVpMxSyv0gB2HtNc4XAztfWmLm?=
 =?us-ascii?Q?EwQ/bUeSgypgMcPAqiCZtTkxvjXXKAfV/0x+rTvZy3hFtHaFXh6mElYOOKJs?=
 =?us-ascii?Q?ea7ZYhGxdXMw0V9OKD0ldptCxxe8jP8bF0xmQ3ZquZCLMNlffch7THGY9mPy?=
 =?us-ascii?Q?3YaAhUW/UGZ2557z8MQrKAZdtM6RrMM3rq1x7i8ZIcEfJUrfJpRvm6DrGlht?=
 =?us-ascii?Q?NUoxI11eyGPFxWYm6Vtq7aQZ271kUQ6y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lNFZiCqJG4mnkPlGUQCXAktfmMTvR4K9+pyz5H5UvEJEb1Hc5XmoQLfsdT59?=
 =?us-ascii?Q?432vV3/pTIDAPXke5YALVX22O5/ZkDVht+6bEb/Z2RBW2dsQoXsSI3pl4HHB?=
 =?us-ascii?Q?38n+LpAV9me3pG6SsSuxiOpdSsWUMvogWRWWvsGl4R7fYfaiqu24wdku4hiK?=
 =?us-ascii?Q?cesxSnk5BJJ+9Y9LsoCmDMzEr58nfWpHQe3uOu9T80uSF8Wpmhyhb9GcgIAc?=
 =?us-ascii?Q?43if8iVQF4KwNNsSI45G1h2woiumJSCMUH2Xrk9d5Pq5aXqJCT3y7ZlZ+y4T?=
 =?us-ascii?Q?TTt8INbhCz6/9VkqN/W3vAuZMelD6deCYBl0ChAVnWqZ9K9xlXdtsCw7C6R0?=
 =?us-ascii?Q?UgX38NjRGLG6mKCe9Gp0Z1Eu2/ONlaZWkmhHP758wGtqgta43dfHELOAaaEM?=
 =?us-ascii?Q?llBePMEgb2wjZBBesjry+ugRuDx17yje8PfZC3yR+wAqFceiGf3sRyz+1txe?=
 =?us-ascii?Q?slM3q3v107KrsVPI9PTwR9VdIu4zyhv5WMRW1iqHk8YJjrOMdmzDCoqo60Ku?=
 =?us-ascii?Q?2DcMhWkY1IRx9VJR9FL+mBYh5BwaBTY4VBbRhmWHTbOcI/E5OC6m0xMV5gqq?=
 =?us-ascii?Q?YwQoiFzHcBj1RW2YMKo4R2GTo7idBWCOLGvATsXhGz5kTizOEL4CNjlBLDsV?=
 =?us-ascii?Q?xkp/7M3iEmC16PGVtASnRc0b+ouuCoHfMmY4QJxFl2i5PUDgv2W/ovv3CNnr?=
 =?us-ascii?Q?fpweL7Miq2zfImTZk7M833UpHEXpdt0El1RyFjLOU/qNEF8S17jIccPV1Hnd?=
 =?us-ascii?Q?1mNjF1Uya9mHNj+9XsHnizGNTQAhQf/Fy3U1C0Q9MXxLNf57gFi9wtEpZxYW?=
 =?us-ascii?Q?8TLg8tlv9fwXIAc0aGosubLyxkpTOVwzc5BNZWl4e+Yzhz7WxXOY3q+xV67e?=
 =?us-ascii?Q?ZqLU1kKUn47NhiN6g1ho6rrTsuJioYlatmWi6abFcC4NYl9diYF3qhwmov0S?=
 =?us-ascii?Q?h/0PCmjpQsGw8osgAoruDKj8Z2tAezgLFBChs4/Ce4o4NZHsPERG7yv4LZ86?=
 =?us-ascii?Q?jHfqlag/mcePR1+4CrR0W2c3lZLXZchVxK9VwgAYpeRu+nWnJ8c2VWLgDqqz?=
 =?us-ascii?Q?hjId1Rr7416NajR/sibjShW135jxVoQ2RGpMykkqRYduTgHeZFiSWlQCoDtU?=
 =?us-ascii?Q?uM5QuuwMggiCIZXdfOrzWktKfKRCrj3ybhibbL/04vqqWZg0J6zAPZSG0mto?=
 =?us-ascii?Q?Of2E5qBPKHe0GV1arl4N/c6WZ1XCiPZO/u/+ZJwNMzdg+wuiD7g5erywgqQj?=
 =?us-ascii?Q?SDRxK8YVF/cMKiIpFNqo3q/axlST/ANS98cwyLBlE1YEeuXA4OKtWyEOrajY?=
 =?us-ascii?Q?7iNWE/eeIPaKUSSDZ0XuJS8JzUWYuS59ZLPmpds+Ep9cVlbbGf1JqKywPMgj?=
 =?us-ascii?Q?TpaTxKoB3CXVlbG+YdOf7bVNdRdVDNn47YmmW1XUrYRe1ipjftUOL4OfOs+5?=
 =?us-ascii?Q?aDbvnSyRnyag/cyHpK8UjsjaSrfI6nUp4r+ToUv8QC6WkhOIxNQ34AOkLyhU?=
 =?us-ascii?Q?6wW6enXraL+RSxsUq87EuywY1NlqI/crbWqkRK6k+mv7QLX5Bns449jS87yX?=
 =?us-ascii?Q?Ck2UyOvhmZstAd1gwavy97ryUa2pWfpaLv5Z3bzn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f54b4a3d-17ae-4eaf-d6e0-08de05b129ac
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 14:52:40.2779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tP09adx/DTURGW4RvqfN8v3hRKEMPDn4GRhQqG8cbMgbNsderllnKeHgSiyKNvKSroKvlOEDi3yvQKDyHltm4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8820

On Mon, Sep 15, 2025 at 09:20:21PM +0000, Avadhut Naik wrote:
> Currently, the amd64_edac module only provides UMC normalized and system
> physical address when a DRAM ECC error occurs. DRAM Address is neither
> logged nor exported through tracepoint.
> 
> Modern AMD SOCs provide UEFI PRM module that implements various address
> translation PRM handlers. These PRM handlers can be leveraged to convert
> UMC normalized address into DRAM address at runtime on occurrence of a
> DRAM ECC error. This translated DRAM address can then be logged and
> exported through tracepoints. This set adds the required support to
> accomplish the aforementioned.
> 
> The first patch adds support in the Address Translation Library to invoke
> the appropriate PRM handler to perform the translation.
> 
> The second patch leverages the support added in the first patch to log
> DRAM Address and export it through the RAS tracepoint on occurrence of a
> DRAM ECC error.
> 
> Changes in v2:
>  - Modify commit messages per feedback received.
>  - Remove unnecessary variables.
>  - Rename struct dram_addr to atl_dram_addr.
>  - Replace sprintf call in __log_ecc_error() with scnprintf.
>  - Pass the DRAM Address to edac_mc_handle_error() through "other_detail"
> parameter instead of "msg".
> 
> Avadhut Naik (2):
>   RAS/AMD/ATL: Translate UMC normalized address to DRAM address using
>     PRM
>   EDAC/amd64: Incorporate DRAM Address in EDAC message
> 
>  drivers/edac/amd64_edac.c      | 23 +++++++++++++++++++++-
>  drivers/edac/amd64_edac.h      |  1 +
>  drivers/ras/amd/atl/core.c     |  3 ++-
>  drivers/ras/amd/atl/internal.h |  9 +++++++++
>  drivers/ras/amd/atl/prm.c      | 36 ++++++++++++++++++++++++++++++----
>  drivers/ras/amd/atl/umc.c      |  9 +++++++++
>  drivers/ras/ras.c              | 18 +++++++++++++++--
>  include/linux/ras.h            | 19 +++++++++++++++++-
>  8 files changed, 109 insertions(+), 9 deletions(-)
> 
> 
> base-commit: 501973598d05fdb1d1089fbf3cf40b605b836e16
> -- 

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen

