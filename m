Return-Path: <linux-edac+bounces-3529-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 861F8A88137
	for <lists+linux-edac@lfdr.de>; Mon, 14 Apr 2025 15:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 442173A78BD
	for <lists+linux-edac@lfdr.de>; Mon, 14 Apr 2025 13:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96C72C376C;
	Mon, 14 Apr 2025 13:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I81ncViJ"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC461465A1;
	Mon, 14 Apr 2025 13:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636273; cv=fail; b=GV7Ysqal4DbfYJzrHjGq1Ba4ZxlKmISMpRehqgCWtt5D4iu3J1y0d5zMLpeGgaZx4nRFy6qFJzUAGd0BGrm3dvSXXhxpRl9TUD8O4fWPmTQ8PT+sYoQ7II5Ij3HG3eVPNf504mcPdndyA5nZUNye2lWwK2SZj+stWUAbU5wEwxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636273; c=relaxed/simple;
	bh=ccIdKaBZ7wlUEvYiQWNHU9i/3lH+lE5CPabUjcQvHr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nkA0KeB7u6BpeY582+HuNpEGx3SXdJjTZsfMelejyi47hadVZUXNLa13Yptb6ShjynzDipSX6UHI9gPoJWCmez8mV1JM5Ackt9GBuCx0CctODy9xFF6oDwrUgP25hdo1tFOh3GxIrrCjsY7DmTt6A3AhG1tTqHr7n8NFmcWiXiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I81ncViJ; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLLHOOgaPf/B/cmj681D2ySufDlmwxnIlbGP3aAld72LjBJKzIgTjkjw0ZgdcxEr4IcnrELicQNNTeE5eb7cSD8gJrWR/MNyTTiJiH+wbsiXMt/P+ZQhapLA8c38hLjsaFUWNrLdn35Dm55E4gk3SxWCq2cSpzE7X6Pc4fupQu1F3Vum9GUIQBs0ZIKW3zRrANroMMPGVwx6k4I8qoUtLKzrOjhY1U2u5ygOz6QnSAVN/5wFF/ZsP8M7GOBKbtzf0i39XkrLD9JQdeFWqAnna7hQiUXNfExIRBJ9dgJYhrg7vRUytgzz9+4ARy4x2I+t2pqyrFPQJgd31AjBMJ8Q2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6bbR1cLIW1oa7vD2V5Gq4W5FqXu9GqgkZB8ahOXIqo=;
 b=ozLNMD5k8jYpahup9cM9xOrNkeGFyrt4QxZiUcrhMfUMnA0mSmisbh1AYLq4q0WmN6y+G+LDgV5OvzIfhIKPOHKjT24hUIcyiCpVZhXSKcFMbwm/8G+g4BCNHbjpibvijCpfY29ahfsY8zY1qr7rlkRPPclElLBGzrDdphSnyDKWxmS3oZ6semVzt5PVlUbHppVzSCcJr/WagOz2WrSU9Hv1CaUa8t0P1WD18g1L+G/4PX/IVV61dQ6Gl+/EehZkV91MyvZjx+oemHz+hIczkHg7v1lyidDLMHCjExY2xDDLB08Y3yBrtBPtMFEcuq7lxilI7/zgeezXzMxhRsHqsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6bbR1cLIW1oa7vD2V5Gq4W5FqXu9GqgkZB8ahOXIqo=;
 b=I81ncViJlZrxi1pcc5EVsZzNElJLJtnkJkaKNVLoMqFsKy5xnHscWcia0Qk2Rb5V/gBITN7bSF8A+Qdv1AP3wOTWflyOjGWmceVHI2m090lGwGb4/a7Inng5hMUgTiIuZra7apYm2lIw084wcko1+glz+E9JcRrOjAIFdFyxhLc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.28; Mon, 14 Apr 2025 13:11:09 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%7]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 13:11:08 +0000
Date: Mon, 14 Apr 2025 09:11:01 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Naik, Avadhut" <avadnaik@amd.com>
Cc: linux-edac@vger.kernel.org, bp@alien8.de, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [PATCH] EDAC/amd64: Fix size calculation for Non-Power-of-Two
 DIMMs
Message-ID: <20250414131101.GA65192@yaz-khff2.amd.com>
References: <20250327210718.1640762-1-avadhut.naik@amd.com>
 <20250405005832.GA1625290@yaz-khff2.amd.com>
 <642236b9-a19f-417b-bf1c-888ca54cecca@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <642236b9-a19f-417b-bf1c-888ca54cecca@amd.com>
X-ClientProxiedBy: BN9PR03CA0853.namprd03.prod.outlook.com
 (2603:10b6:408:13d::18) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|IA0PR12MB7699:EE_
X-MS-Office365-Filtering-Correlation-Id: 55f39a9a-1ef7-4bf9-5929-08dd7b55d21f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oXti6amTBojEqe6npUR3j8i5xKbbj/COgS7kKUWCR51VDNnIuBNlcdYgRDSo?=
 =?us-ascii?Q?07Z69Z5/kQKT9q4W6v6e04HK1KTBO3J7bqXltOHn0WKdKLt7tMDscFY85a5M?=
 =?us-ascii?Q?7PQcj2k6BIymmdTExj7voy4OpR8eh9B9BCjxP+8e4+tXLjv5VppySR2hNbFC?=
 =?us-ascii?Q?MMyq+k+S7MLhxgYPUwdB95hDqNOqksEiGu/un8/7nUXbwKpxF5OKjxrnZ0oe?=
 =?us-ascii?Q?A6BcQWU8EsDZ2gxDST1to5Bv/nBuHkRvZY2P1uE41GNbNhu1MHbWnoAb9Rsh?=
 =?us-ascii?Q?6i23EMEKR08QldC4efDyhZKNH/2lzraVqQiliUxZi1Dym3fhI3CBHrjsC5zU?=
 =?us-ascii?Q?/UDtz3o4OEZUWy9PEp6WtTIUjq+GFWOWd+XnTGibwYoHv683LsOgrNjFTMLm?=
 =?us-ascii?Q?DP6rRY6b2CyO1a967tvEbLV7USsLR5M3OO+45gtrnuZG/z+k73iTeHIv4lJz?=
 =?us-ascii?Q?LP0vWFLdOSvXx9xgu90LdUUZEZRhcTFO3R9eACSsaNgBXMvdPYMzPb0d4vdF?=
 =?us-ascii?Q?X90JDRFu/zhWUQd6dl2ruXwoZ7X+ISKcxtqvWRojynsQ3Jee3vAHB2olm5FW?=
 =?us-ascii?Q?qf1lfDnVQx1zb8gRBfTs3F1N+RER9aIz3nWK/a5PpIPHJGf0HXuWSzgAg6YB?=
 =?us-ascii?Q?rzgVVwCDfFkF+09ws/x2LYofnxE1M/mimYTQhgm9/hN7mzyOsQPVUyQ5X2dj?=
 =?us-ascii?Q?lV6kLuVUf/BPD52yL3d0jlCp5od0BesBW30s/E1aPHwFPu8xuIcheqa/cg+U?=
 =?us-ascii?Q?YvUEyOF+P06xDZojhFX/gSS7jRORFzw8y4VW+/DBO/MLzIyYnP46CKQkOIuq?=
 =?us-ascii?Q?6Qn0xDJsBeyS4BYIXdA7fk39VJenD63EXYcEuWG0bT+Wzliv2qtQk8X5iBNw?=
 =?us-ascii?Q?h2fxsNakrMNqzr/DvXGe0qhwmBbTZz6Etbhj3b2V+nstgifKCyX2M538YLgB?=
 =?us-ascii?Q?BY3xMDQxEb0AoNjNwm1n1Y028b9x9t9F+l2WXpifZwCEBdDwOa9girDM4v3X?=
 =?us-ascii?Q?wBToLNvaD0uc1y7Di0/6lFDgwbL9TcHXjyI+5aTEj2K9p7bWPiedBnU80SL5?=
 =?us-ascii?Q?nXq6BObBSCGjPB+vf+WlIYDTE9W1l2do0/F2c0TNZqzgg1pFXIUdxa8+hrue?=
 =?us-ascii?Q?soTXe4Mx7hFqrP7zQeDFuD4mRK7xqSjczJmPx2wMPuZ8TQJ9UTF1ukZZhyfZ?=
 =?us-ascii?Q?/Jwrlk09kkGvmtV6bb3HG2fQLpCV84TNinUJVQGxND6FwW8k6YSST52PbzqP?=
 =?us-ascii?Q?UFJnxxq6WZzHwVtnXiFqTS34WgYCKZYt6fpIq8ufLcz+T89ogg0BHjpU+7kC?=
 =?us-ascii?Q?lHCkK4ldgMd56g4B61pNyce7eV404yacmSpb36kLgxrwYQaPWOnum6w/X5mN?=
 =?us-ascii?Q?QLyQfifUfoZMI62OkkwvQarxkwIcAlIBuLebTW1x1HWGLQR9nY2hM1Y7hRms?=
 =?us-ascii?Q?QTpsgaPFlCI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qKrlqDF8NX5zfD8L+Y83oPYIsyK1bw/qJd/ZfxMgdG9igQ+WhXl1YzN6No4F?=
 =?us-ascii?Q?nLbCNzdg6IAFgGnqVkAkCbBXb+mMlMUs10sQ6FTEQXbbwww1ar3K07dgCXHJ?=
 =?us-ascii?Q?gxLMf+n0uqk5BTfRysgv2WABBu0Urb62KTuImYGss6NaD7WHgEN+tCLvsVyQ?=
 =?us-ascii?Q?1NTy0GH4PbF2skdVPUgvV4u1hLzYgDMxm8855DIP+J+U2HUcs6ryzwnVGPqG?=
 =?us-ascii?Q?EZebQu60cJjqvQFDDt/iFY6WdpfmefF/vdp4MM6HLnrYayJilfCi669Xrc82?=
 =?us-ascii?Q?StPl/Wa2Nut0cE1Ql5nbuq7DRij/7fVz7ASHZdFclkVuja6pH9Dbt9/J/V5W?=
 =?us-ascii?Q?6HM2427euzRysgLu5zZCcIccFhFyBtcfP34ZhlFay2riSx8VBdr8nMeiSuJb?=
 =?us-ascii?Q?3zSa4fPzg9Vy/FFNPoKMMaJTpxEEc8LErpJ28R7oCfs5ZzY4dBvuUw2wnhT2?=
 =?us-ascii?Q?u5iQkHkHXaiSaYBj6OagrDYJr8109S9wNvfijPxgh3XvBOwPSwexN7PpAzYF?=
 =?us-ascii?Q?a8jFxSIZsKF9k0xJq/ULJ0M5RYx6j2CgDVWFE37p6JiF6Ri/ag/JbabjobPo?=
 =?us-ascii?Q?6b6z8X7zb7Rb651qUs3vrnn9ygG5g4GxGaOXdFzGSm3cAdORqk6IRroSJ/3g?=
 =?us-ascii?Q?H0rbm/mhcLlVHsuj+eHZrVmbRCf8XHC64jVtf+KDUQG0rDtYW6iuhRQ7Avsg?=
 =?us-ascii?Q?03GYDkOWt0wK94sYFqexO2vZ3mvg5zvCyyW72I+BRMpXmLCyvJP7jV0gkRKX?=
 =?us-ascii?Q?NZeBoVX7C4gB7uDom8oH1xIOW6DOxH4iN9dBDStiRKmvGaOWA2rUfEJdCWz6?=
 =?us-ascii?Q?h/yuZ7XuHTvXQdnaxOHTFe48KZ9bL/TxLfaSvVq2WRmG37ThdekaE9NHuatX?=
 =?us-ascii?Q?xSt2+ehQeu2QuogIdF+R0goEC3SdB8UR/KjLcGl/DtaJIoddm2Iu35q2RUBx?=
 =?us-ascii?Q?XCGfswjpwsYiRRngcIAEmFalbwjsLCAz1M4Nho+8ZootIZn26+eMEAaQqOyj?=
 =?us-ascii?Q?6QlPtV8s62fwxeaB4UZ95oRktcHPNUEQAl14yjLY04KXksiJT2PtKz/euIgB?=
 =?us-ascii?Q?MUUlkDZOoWda3vTFL9Lp775jbfA+HYVbg9XMDJ7Ecm3LMoFfvVeW064/7RG4?=
 =?us-ascii?Q?Gf2kxsrLLxYxN/apmdy3Rix8eYoNPwvKQr1oMFgSUDbji+Ls+UInY3wwxXwl?=
 =?us-ascii?Q?cYlOfEv0+R8SYe4sOH9mZCKUGn2tdt21tK9eJmJI41CUa9Rw09NvvxQAGaAe?=
 =?us-ascii?Q?YH5QYJuYUu553kZMzLFr7ra04oxHvPPplRm1MTrPDDWryvDmj/Mw+7+2GMTi?=
 =?us-ascii?Q?FrFC5GUJRw+RE1zvWpOqngdMvY0IWHvJA6zJZ3rT/pJgDD8U4gJeFwTaIUdv?=
 =?us-ascii?Q?SyU9ImeGjaRyQGwrdMmBKLKHkT5LNcgqXjlvVxz+VywheLdoO+zVhdhkRtBA?=
 =?us-ascii?Q?YWkQd8vIlXirbxQXEnJpdkDF9iBPCnjoTIeGAOGMikUhebY9KCcRAN5xLv5j?=
 =?us-ascii?Q?ukFOpGgffroGlQuE1o4Sydfm8PUGc/w9EqWlbXz0xvQokoNcDU9mP5CMAVin?=
 =?us-ascii?Q?vPa4h6nfLPCmr648pTQW48RpxSOjI6ySKWQvi7HZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f39a9a-1ef7-4bf9-5929-08dd7b55d21f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 13:11:08.7052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/B2bYKDvSEtcB9uIX31J+BcOELsQbUuFVnCVjC3M9bdKpGogOCBMVugAVCKQEHjUvMzk+U+v28JtEx9j32+UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7699

On Wed, Apr 09, 2025 at 12:48:57AM -0500, Naik, Avadhut wrote:

[...]

> >>  
> >>  	edac_dbg(1, "CS%d DIMM%d AddrMasks:\n", csrow_nr, dimm);
> >> -	edac_dbg(1, "  Original AddrMask: 0x%x\n", addr_mask_orig);
> >> -	edac_dbg(1, "  Deinterleaved AddrMask: 0x%x\n", addr_mask_deinterleaved);
> >> +	edac_dbg(1, "  Primary AddrMask: 0x%x\n", addr_mask);
> >>  
> >>  	/* Register [31:1] = Address [39:9]. Size is in kBs here. */
> >> -	size = (addr_mask_deinterleaved >> 2) + 1;
> >> +	size = calculate_cs_size(addr_mask, cs_mode);
> >> +
> >> +	if (addr_mask_sec) {
> > 
> > I think we can skip this check.
> > 
> Commented below on this.
> 
> > For debug messages, it doesn't hurt to be more explicit. So printing a
> > 'mask: 0x0' message is more helpful/reassuring than 'no message'.
> > 
> >> +		edac_dbg(1, "  Secondary AddrMask: 0x%x\n", addr_mask);
> > 
> > addr_mask -> addr_mask_sec
> > 
> >> +		size += calculate_cs_size(addr_mask_sec, cs_mode);
> > 
> > Maybe add a "!mask" check to return early if you want to save some
> > cycles in this helper function.
> > 
> In a way, this is the reason why I had added the above condition check.
> To avoid unnecessary function calls.
> 
> AFAIK, power-of-2 DIMMs are predominantly used, so the Secondary Address
> Mask register will seldom be used.
> 
> Would you agree?

I don't know. It seems non-power-of-2 (24G, 48G, 96G) is becoming more
common for individual DIMMs and sets of DIMMs.

Thinking on it more, I don't think we need to be concerned about saving
cycles here. These functions are only called during module init,
correct?

Thanks,
Yazen

