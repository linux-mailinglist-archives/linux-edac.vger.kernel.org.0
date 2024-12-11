Return-Path: <linux-edac+bounces-2688-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C4C9ED050
	for <lists+linux-edac@lfdr.de>; Wed, 11 Dec 2024 16:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5578628ADB3
	for <lists+linux-edac@lfdr.de>; Wed, 11 Dec 2024 15:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ECE1DEFCD;
	Wed, 11 Dec 2024 15:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FqNzWrCL"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898A91DA633;
	Wed, 11 Dec 2024 15:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733932019; cv=fail; b=qW8ycAGNAosukjzDrzwilARULVUh0ms3I3H2nM3u1kMhLaOX4zBRB4nWIYm0KCm+Wf5l8IojnoWL+kkPzs90GhKaoGQrTtV78IA4BeUX6aa9y1HCEbl9n5y7uNWxmb5H0T4WMD0ZJSxctsK/ejs3eZZESBPV4sDZwGJ+ySFVURk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733932019; c=relaxed/simple;
	bh=hyCQXMuF41TZ+oiS+3nTLxo96GSSaR3ew2wen47VQII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B7q5UN5CJl53SBApKEdPCAqoAnDWMWUOoNxEaTXnTbjFGNZBrSZYW/n9L8LJMUPgFUUl5CpHLr8WDKpuNz97tT7/T8Dz4J1CqRQZ2hHlhqrDRsMgJxzw1CtP3NZjdG0BJmTDCEK006G0b2+7KNYwTvcUTQ5jEKr2cTCq4L435Bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FqNzWrCL; arc=fail smtp.client-ip=40.107.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBEQbp2Mzlm2zNVEZKs71Upnjs8bhiZp2ZKjY7P/vFedJMWN+vZ5lY+mDxVD/1vjhRd3HIWu3dZ0IjVNVigMirNUO4+1kMxtKLPIXW5sgtOTbL7EoTtn8yXTFThgDvwlAJWRzpZ7Z3S645fm5mDfAyJaRADdVUH9TA8q+Y+mJ02hlFs7AjY207Pt/Buovb+X3YlGGHpJhPKSF+NuLg+580IBVDFfZlnxajUXECnPhAdIzoT7Dpb0QJgRnfXxXwBU1iYir+Wi4z6+a7Wdr9WS8BBcmo+sMB1E5lAWyTsh3DsoyNgTl4GIlaRaFXBsqM0PysK3vpk8shuERjeEPmJwAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMG//1JPCVs067JhE2OuYbmGaXMuqoDcBoNjtF6Wsqg=;
 b=kY1rt4OP43UUIDSun7B+Oblb34xXfEAdvH/U1K+EB95HYobKgaUTz/p7UBO5jJCsW//zlGVGjhhrZmdTACsgPx/7vvUFVEK6KHWn9EwSn13aVVME5x0n8QEqmq0cEYYQJXPqkxDJvALO27vgWT8311yzEM96G2N/yLnx/M54/I5Bz/XygRP8EE1rS9UyjbkdevhS+wHa+STPQnVXKBrlr8cQkM/H/z1NZ1ugxZmfD2TXazA/O6tW6a0BNa+BwRl0pzTPewdfZop4jBEEkidAxIBX0ED7jEBFlSst1sAZ2qHy2Ipt5c85lgUOPwwyhQB/+fOjr8c9QojRfNg32Elrbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMG//1JPCVs067JhE2OuYbmGaXMuqoDcBoNjtF6Wsqg=;
 b=FqNzWrCL1DoOhtWlzVSdVpYtPktLyxHK1+Ljb+YNJ0qAEcGroJHm/R68O4YdeIVsGYm8cd9tYNZX4Iu8jRY9Kd99lHMNm7S/ef2X/FOmOcglP/o3zFSoN+Hozg0J9FkugD1hYQsY7zM/1uSrVDWYxzFRWk2tb1KIGHVLs/Lp45Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 LV8PR12MB9333.namprd12.prod.outlook.com (2603:10b6:408:1fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 15:46:46 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 15:46:46 +0000
Date: Wed, 11 Dec 2024 10:46:37 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Avadhut Naik <avadhut.naik@amd.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] EDAC/amd64: Fix possible module load failure on some
 UMC usage combinations
Message-ID: <20241211154637.GA1923270@yaz-khff2.amd.com>
References: <20241210212054.3895697-1-avadhut.naik@amd.com>
 <20241211110729.GAZ1lycaGYmjgNDGv9@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211110729.GAZ1lycaGYmjgNDGv9@fat_crate.local>
X-ClientProxiedBy: MN0P222CA0008.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::12) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|LV8PR12MB9333:EE_
X-MS-Office365-Filtering-Correlation-Id: e16dda34-4097-4721-64a4-08dd19fb0478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/L7rsY1NdlG81my+6jpCHksYO8R+6CQROS1IirJZ5is5V/nsRTT/lOmpeYxk?=
 =?us-ascii?Q?zM2LKuVWjryArQ8CHOjUxoB7HEFzwWS0H+94p0HDdGsTIGkI/KIWhZudw1y3?=
 =?us-ascii?Q?Yt6ViwEwYmHaO6bGw1yVYYa7crwyf/Bn/aIopN+449r5NbNv3hWQ7dUZG8WT?=
 =?us-ascii?Q?R4tM0lKOtDYO/NnwzFLZBHY5qK1paNDGtv8rZarQwvS3E02vxy4AptGmvGO7?=
 =?us-ascii?Q?lQQ9ETLuFGsQDG/xIZZ/po6LLUDbenuLcKEmHVBQ/SUnUylboveUDyh+n5ga?=
 =?us-ascii?Q?w3RAOGVbOUmPAEBopZahBMnEnW16Q2/2ZZVmUhg8Kqxb4kL5PU8eoIjdERhy?=
 =?us-ascii?Q?tqn6agPgwoYdRVN/WjTS1X6J8qTjSdLH2u7/FPTrKtpExWASzS5+85vJNZzs?=
 =?us-ascii?Q?CmUyrL4Nt4i35KhL540AJdzNzkcXXCd11QZsoP0fPPSj+t2SnkbmuusWWPK/?=
 =?us-ascii?Q?TcFbS3oMhjdKwmxz6xO5cYlINPufi+Ad4BDQGuyBgy0JNAXnnqt4Uhu7uScN?=
 =?us-ascii?Q?5oIl6NnQ+UrOReZavDQzk5O9SeVvbH1KyFlKDJnl+D0b1MGQypXcXEFk30nC?=
 =?us-ascii?Q?mVuJumu13DgQkoiZNR5ooosHtOPS10oqfEo12BXRj8fUSN6S0Z/BjHVl/R13?=
 =?us-ascii?Q?y/m6G5RucCAaRQb311qwOijLNsBNnaba+4Niwej2CVxv3AIxxaTHva+HePWa?=
 =?us-ascii?Q?0Y9JFI7BXN5iRYKnzrKkqO8aGjUwE0sSAai7LqkqFvBiwdj1CeYpSZunJySD?=
 =?us-ascii?Q?wxY9B4Ot+B6d9qqb88cCZvXoN+Fz3yBk2Ji1xNOR+tKQU00pZiDxxsJFCN4f?=
 =?us-ascii?Q?H3cCDmZQqpYSEVrgKSVn2InZ04gGR2IYMdipvKW9L/ociwwP9R7Vxds/vIzY?=
 =?us-ascii?Q?BM+Orlk7NUJBVgAcHZghbEAJ4o35EMNkWO9IfaGWw/3GygEflY7mQ4G8cF2I?=
 =?us-ascii?Q?OkOrXv9p9/3Tj4huXPjLKHTNrJq59t/pw2VqODECUA3MyNG4vQVfbTBfFQjH?=
 =?us-ascii?Q?n+1JDzIKSd2UQdIn39gW1ZpHzBnCG1DPRCLSHxcfd3JcdkEMdu7GIk/9oD2+?=
 =?us-ascii?Q?pXOzq3L1N8sTDNzqX2iUvW/X+jZf4IU03R10nCt+MoUTToicXUbCKO8hP62l?=
 =?us-ascii?Q?VNowDnoreyQtCxgookaiyGcTeun3cJKtUO+9hssoDK0AKCTCcTwY8/xNHVzm?=
 =?us-ascii?Q?CVSAq8/A6qKPeu/k3Kmz6HQ26nBx83TcjxzFHOYKxyGYjUh0II+ltE+K2G6D?=
 =?us-ascii?Q?k2Sjzd7kB8gGVSbye6SjHz/gOSJvFwFdRObB7Nw95T5042OFaBmYfN6ObmWG?=
 =?us-ascii?Q?o0NzpTeDs06lPIdAcoNpJL5u8Mb34DHyFKOAMTTNd1AAWw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/YuqM4ev96HIdd/rVU0UNU8zgMBS28Ff2BbCDVihA+36IIFQc8dIW3ANati2?=
 =?us-ascii?Q?tx1QIGZ3K9+5dmDO8dZ5Uu+rf0CKEP9YxiYPmlwv4XHahktq1MmbT3zhnB7y?=
 =?us-ascii?Q?UFgLjKaIPKAIRJmmF1iWYIBCGMslDyQyz6nLKtrqAobvN4Ek4VUltQAEgZFf?=
 =?us-ascii?Q?86PknOcjeUKRGUAaIhl9c23/T6l63+lms5WpkxMiqMS5gzPyLHrHWapF2zxi?=
 =?us-ascii?Q?QU879OnLV2ZALGYr5GYoJNZi0iSE2YBaWkrl3Ot9qej6u1x8pEBrFl16Opkm?=
 =?us-ascii?Q?QL5dtskuuCw+Zp18Em4T4Y8h1/KMRiv2q2aksnab6j+fgm/nZlwXLV6aRVFJ?=
 =?us-ascii?Q?XGBOYWnYNGoPxSnXOeIFeSyL0OEsOanJZMsNq/FqzJSiXUuXHI4eIkQMYA0Y?=
 =?us-ascii?Q?UmAe16l3g8qRVP1+vTMd2utzVipmJVBjFDSls6Ku8KXsd9JiHOmR+IGsIENX?=
 =?us-ascii?Q?2Hp2p53Jrosp56EHippqV2uQV39QwVyVeb/EAvW3V66Xozw8pFhEGt8u9vIX?=
 =?us-ascii?Q?iTXkWxxbbRTywgYJIJgfMS6rlEue4nHwNND+HJog4HcnsTAmRNhCgJqDw7rQ?=
 =?us-ascii?Q?19pT3vI9enhOlh/gZARDVjeU3LP34vmtWDyopcQfTCLjKmcS52drz1Rgqc1l?=
 =?us-ascii?Q?SbIWYITOhvrO0mtfv/qrBETrw8XZmCqE82IdStCCUBL422M3VPSZs03ueWwn?=
 =?us-ascii?Q?esfV5/hmWwgdBaUes+ZhiD5lYtbFXWoLy40y9xJrPmfhWF9NNvK48O/nnN1O?=
 =?us-ascii?Q?Us0NGF9tC5c++oU9O1DWIdA2J/uPR8MTsEZywKoDMCMokERpKDCZBTo+TOJ8?=
 =?us-ascii?Q?eYJYsF4YgxHKsDwoModSQyP+CR5cPj0/FHPoUcFDLoNmVXHHmcoUa+6u2BV9?=
 =?us-ascii?Q?gGrcooBi/b3+ld+2zj6Ll4RKqpsXD9Ph+NexGDMGs3QQH8AYwnVEB3JFIm8I?=
 =?us-ascii?Q?eJ8oCtjKjR/WLgrDvTzODb08U9ItyE4OO4rPNTqWHRP2vEGvc51rhTmqbL2B?=
 =?us-ascii?Q?iZYpfIXuv+bo+bUVgDOYCaiJgDm9PEDiu2KuJYIyUHvHd2SdoXGdfmPIcIaf?=
 =?us-ascii?Q?GmTlBDFHtACITth9UTm/D5USjkCyk2qILauGp5FXsO3iNqyaOrhMcLL9sycS?=
 =?us-ascii?Q?Fjc6+ft0CICNhJoPv4+zDRsLC+agt4JUVDWGz4obzKHHVMlwFg89qkgUxx1i?=
 =?us-ascii?Q?P8RKYt0pfOZtbY759LgTRmduzTV+WWgS7QQOxW8OXe1sEfVg+0qgjNf0DVJg?=
 =?us-ascii?Q?ePB+I9JOBncYBf5D0ZiKN2FxeT3bvYTuTRkfKbUMlzLEmeOLJC1EW98OoVqe?=
 =?us-ascii?Q?+9G0U1AHEc+EPEPvPg/WroDw1YFXMV/xgBnnLQTgL26eKGyeci4jSMCJ2ADe?=
 =?us-ascii?Q?fHBSVFKTVeho8GzpaZGvPf4ODQzOcfDZ/XjNsubQ+I7XUhuv2n4EO6FL39iA?=
 =?us-ascii?Q?PUZiQGukZjzKGfrVkQnWNfTKXi1FWteSFmJnLteilP559wZi335Tx0TIhELZ?=
 =?us-ascii?Q?1233Mre2Qbor9HVWWu6/IVE7YTBDnuO7btcVoBPt8BEh6MR55tsrT8d6xLuu?=
 =?us-ascii?Q?/Vs1v40Jifs5hqQCjnQX0rGXsASAwD1qF+ybfWEL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e16dda34-4097-4721-64a4-08dd19fb0478
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 15:46:46.1703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /th8nlTtaWkKOSmGUpOnzfHkeuz9kksrssSJ0/dV00iWX2Bd1eQXBdCAOuQXMmER1QMFNpmwZjIZM8vKBcrvww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9333

On Wed, Dec 11, 2024 at 12:07:29PM +0100, Borislav Petkov wrote:
> On Tue, Dec 10, 2024 at 09:20:00PM +0000, Avadhut Naik wrote:
> > Starting Zen4, AMD SOCs have 12 Unified Memory Controllers (UMCs) per
> > socket.
> > 
> > When the amd64_edac module is being loaded, these UMCs are traversed to
> > determine if they have SdpInit (SdpCtrl[31]) and EccEnabled (UmcCapHi[30])
> > bits set and create masks in umc_en_mask and ecc_en_mask respectively.
> > 
> > However, the current data type of these variables is u8. As a result, if
> > only the last 4 UMCs (UMC8 - UMC11) of the system have been utilized,
> > umc_ecc_enabled() will return false. Consequently, the module may fail to
> > load on these systems.
> > 
> > Fixes: e2be5955a886 ("EDAC/amd64: Add support for AMD Family 19h Models 10h-1Fh and A0h-AFh")
> > Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> > Cc: stable@vger.kernel.org
> > ---
> > Changes in v2:
> > 1. Change data type of variables from u16 to int. (Boris)
> > 2. Modify commit message per feedback. (Boris)
> > 3. Add Fixes: and CC:stable tags. (Boris)
> > ---
> >  drivers/edac/amd64_edac.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> > index ddfbdb66b794..b1c034214a8d 100644
> > --- a/drivers/edac/amd64_edac.c
> > +++ b/drivers/edac/amd64_edac.c
> > @@ -3362,7 +3362,7 @@ static bool dct_ecc_enabled(struct amd64_pvt *pvt)
> >  
> >  static bool umc_ecc_enabled(struct amd64_pvt *pvt)
> >  {
> > -	u8 umc_en_mask = 0, ecc_en_mask = 0;
> > +	int umc_en_mask = 0, ecc_en_mask = 0;
> >  	u16 nid = pvt->mc_node_id;
> >  	struct amd64_umc *umc;
> >  	u8 ecc_en = 0, i;
> 
> Hmm, looking at that whole function, it looks kinda clumsy to me. If the point
> is to check whether at least one UMC is enabled, why aren't we doing simply
> that instead of those silly masks?
> 
> Yazen? Did you think about checking anything else here, in addition?
>

I think we used the masks because we would only read registers as
needed.

  196b79fcc8ed ("EDAC, amd64: Extend ecc_enabled() to Fam17h")

Now we cache all the registers at init time. So yeah, I agree that this
can be simplified.

> Because if not, this can be written as simple as:
> 
> static bool umc_ecc_enabled(struct amd64_pvt *pvt)
> {
>         u16 nid = pvt->mc_node_id;
>         struct amd64_umc *umc;
>         bool ecc_en = false; 
>         int i;
> 
>         /* Check whether at least one UMC is enabled: */
>         for_each_umc(i) {
>                 umc = &pvt->umc[i];
>                 
>                 if (umc->sdp_ctrl & UMC_SDP_INIT && 
>                     umc->umc_cap_hi & UMC_ECC_ENABLED) {
>                         ecc_en = true;
>                         break; 
>                 }       
>         }
> 
>         edac_dbg(3, "Node %d: DRAM ECC %s.\n", nid, (ecc_en ? "enabled" : "disabled"));
>         
>         return ecc_en;
> }
>

Looks good overall. We can even remove the "nid" variable and just use
"pvt->mc_node_id" directly in the debug message. This is another remnant
from when this function did register accesses.

Thanks,
Yazen

