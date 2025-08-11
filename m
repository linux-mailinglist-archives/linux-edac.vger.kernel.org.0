Return-Path: <linux-edac+bounces-4547-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66775B20A97
	for <lists+linux-edac@lfdr.de>; Mon, 11 Aug 2025 15:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C06718C0032
	for <lists+linux-edac@lfdr.de>; Mon, 11 Aug 2025 13:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BD92D3758;
	Mon, 11 Aug 2025 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bPdrmav1"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AB122D9EB;
	Mon, 11 Aug 2025 13:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754919835; cv=fail; b=tU5pHILEQGHp0N/rmUsSfqLUgn05BasIKsVtg0I7+e9q3w9Y+tojPfvf6TWb9lPcNbZpR+v1aJR04YUN0yMEvt9Ybo9sP15BIhxpqAgatAl6MjPZnzrqa1DScxt6tJ6LeOQ32h1nXHi43TxyJFCk3u0xqCH6JqTJeFYbqigtruY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754919835; c=relaxed/simple;
	bh=Hd21XLLK+lPxASxF2LK6MfC/4pKN4ptMvE6RB5iJByg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ly0LVkM78i1HLmslt/i/9fedIaXDv8swqR0dycHI7bnD/Ehy9e34CETWGrWLqfQcVHF0i7VjKPPGh4xb5Qp2elclbjRHXNrJ18Q3JZpoTFMxuKqTjAJm8wp8fAuvAxuy47NFzGX1OGPo4S8H++1RZLKXlsNGWlz7p9uUyOUQm6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bPdrmav1; arc=fail smtp.client-ip=40.107.102.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QsnXjjapt8hk8jZsWqSBnPeEx3EI2rKHXrchwLb+irKM6ghoT7WkYEtpoPdl8GnUT8REKneqWBb345kGpm+KzDyGQihe2y9dfJLpTdoA7I5Vga1HwgeZIY0N2jawFHllzp+bpZlfZ+HrYv+Zf2bvmH/2Ej33zmVLB37eSZY+VDHjOC9fR08e1u1ErlF+OH8XPzee7yOibSMGGMbatyPGh7qeHOfWoulJcwjjkXyuJBjSEqwn0z8cvo+baJ2aQUEeHU1/uKO2dYWwojFNQn0mU58TwaXapbAKPPxBVw8dakA/ddS2LLbVgCobCnExhFFD0IS9B7UPmPzo0TI1Olmnaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JTACTfSOVX0A10oDiAHbtu7XqgVPKVF4cEdomtXEso=;
 b=xf3XCsUH8q6IVKGspIvm/nNdpv6qhcvmktWK8o6mkNZqDd9UlO70LcxPmfhQCpZ5DRwDr8QbdyTWF8ujdh6deC9SxKifsHX4MTYbrnIlGSbhejK6MxN0g2J0Sdqefwrv0dzZbvd97gjPJm8nqonLMrudai87a0TiX+orDI7KWcFVVDHXeg+89F9NT1EHOpiWpOl2NMlx8guquJh/Zfd12RnUYqpPg9aEuZFfi+GvkgAeHn8w1gSmT5o4eu069Pbx3MYhoixIRqhFiN+zUvnsbEYQSsUW9inr8wPCLH613DZfyiFTxg7cacBhIhg2V1tFoBiUALU9RKjJXRK8ZutymQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JTACTfSOVX0A10oDiAHbtu7XqgVPKVF4cEdomtXEso=;
 b=bPdrmav1oTKDpTKBaBdPx+HgvfLJ74KY6KI1QsSkmGNWdnGB5SzN9MZC3PcRlz+s5mCGHx4mfuNtDji6KJ7e8XkD8DlfBp8mijldFsgR5K69rVKCBnyFSxP+fXejjKczkSvkriA3zhJvMqJiZ/vLi34yldsxdXtEqzeyLcEVg+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.21; Mon, 11 Aug 2025 13:43:48 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 13:43:47 +0000
Date: Mon, 11 Aug 2025 09:43:39 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Naik, Avadhut" <avadnaik@amd.com>
Cc: Avadhut Naik <avadhut.naik@amd.com>, linux-edac@vger.kernel.org,
	bp@alien8.de, john.allen@amd.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] EDAC/amd64: Incorporate DRAM Address in EDAC message
Message-ID: <20250811134339.GA616@yaz-khff2.amd.com>
References: <20250717165622.1162091-1-avadhut.naik@amd.com>
 <20250717165622.1162091-3-avadhut.naik@amd.com>
 <20250728151440.GB33292@yaz-khff2.amd.com>
 <c9ae8b26-e254-47a7-8e2f-b5da90f50030@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9ae8b26-e254-47a7-8e2f-b5da90f50030@amd.com>
X-ClientProxiedBy: CYZPR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:930:a1::29) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|PH8PR12MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: 755a9b7c-cce3-4baa-9cab-08ddd8dd1905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+pyUx6Gh0AeU5GNbXLfH2ig4id8hDvMkk3IrsFIf7fw/G3yyyXRGxkotY59j?=
 =?us-ascii?Q?Ea4q4+oFKyPzqgjHZi2Tq10+k/VsDmc9m78QM4E875kWye4xYnsRK+erYFVr?=
 =?us-ascii?Q?979c/EBNb7ufpNfDXbUVrFFMr5VBjHOaLXgl8OhbM6bK487ND2LxH0hSp+50?=
 =?us-ascii?Q?zl50IPGVHam2UPyRwrjRR2NoXn/iU09of9s2i5Gt4Nzuz5atMOraTw1FY40o?=
 =?us-ascii?Q?kADpvFJW3dtacOjb5gSme/HMUkOqmsOqWDO/P/Bg+C6cqJLXfeDCeG8IXl++?=
 =?us-ascii?Q?DPMC0U/GiNSc1H3XmGvgpsu3a9SoQ1Bkjhr+xrvWtLIVzI5E0bcCZJAgmxkw?=
 =?us-ascii?Q?RNHITPZB/aPzKn//DFGsf9YTPMG+iJ9ujxb5IeEFa4UyLC1p+cNly+5KOtaH?=
 =?us-ascii?Q?IXiVlM5Nw88FNTL+Q9NbiHf9VHAm7FJioRK0EKq07MhJJZs1vhUf+8tA8n7D?=
 =?us-ascii?Q?7T9YByk9MP0Thcyp1mEWoJDPZ2L+j2uQLIpR4y1q/dcp3Mpg1bcdjAtJOG1q?=
 =?us-ascii?Q?mqpIJTSyRiJLdrmVUKIIZbdRJkDIzv+0z2wWarB+XbiUkYqXjEvrXraPIFkG?=
 =?us-ascii?Q?OUzyxSuqKI1bbuNaVTGHTfto31n/NaHwir3mE9BRderP+L17nq/q79OCBySh?=
 =?us-ascii?Q?ji2ghElxF/h8OGfDmuACmxuRbEIMMymQU+xQOREU96UFYDlJ5oNS4deRcjED?=
 =?us-ascii?Q?IWwx5xHC7X0aPe5Hm0pKn1pAn86xsaMWQIH9O2zgBkTMkbgJswZeK1o1Jgln?=
 =?us-ascii?Q?nlkGkRAm8sn1RMAAcHSZEd6vvrTOY5o0phAaOOONjgeyP621k1r22dBnouEM?=
 =?us-ascii?Q?F4+IlfzTbRKbDuulruPNVq08NaHSz297/aGNzmdikH8VBXIVDHHQbdY7VlRT?=
 =?us-ascii?Q?WE34rNzxkyOYOFDcCQeYAAI8ZyHl3aT1wEW7qwkytQ2HIq1GNx5H7hWsV7cw?=
 =?us-ascii?Q?Lps4AZoOwSJoZ3dsBkaEizdwzvsDhr4GmaglK4Ik7v0PO4i+5NFPLP2HaZLT?=
 =?us-ascii?Q?5zlBHJHGRXbqEsZGVFjmfpa4l1DcGR6sQBG1cKhc6jPRb4h63AtW4xBvNq4A?=
 =?us-ascii?Q?0Glvy7ie4bAJC6timTCqa/S+dwLBT95IxBZdZS1+b57i9NgxVjB5OULoy5gx?=
 =?us-ascii?Q?HSOHjgtPZs5oj0g4v925uzQOeMUVukU1EZab8ljHvaIkQ96ba/s38jydTwge?=
 =?us-ascii?Q?AdOTpjtsKCixyVremoJRG2RHTIEHNsp7elajzLoCWBtkqsIDHVDZ3EzcbK1n?=
 =?us-ascii?Q?dcf/1i+jJBwTgdX9DDCw0LquvDQAKv1HO/ykL+f2S2mPi3eWPrDtBy8t8Ojd?=
 =?us-ascii?Q?MICuZFGWWwax9vH2DNVSwrhJXw4NWjKqaLJ6mCQh6xUOj70OVHPZpxJlijHl?=
 =?us-ascii?Q?SH6sLD6o7WK3yzwyqW2Zx++te5Nlr/+2GlhNFxDSJaDRPonQg+iFnp/P3eaE?=
 =?us-ascii?Q?cXgM2CHfwGE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6gZ8nbb9cuoyk5w2m+2UU+H3c+c25G/7FCOFQwplsMdt9dyrNBFDnN1QEhlW?=
 =?us-ascii?Q?PlY8zNOjNmL6BGqIYR4N2XuJP5ovu75uEmTPIduBR1XaSvSCyYgunwsDrzLK?=
 =?us-ascii?Q?gKwdlYMgBmgVEt42wuCdJVbeB07qbO2JrQJLHSjDhPhHh8pKmwnuXqp6ZNJX?=
 =?us-ascii?Q?RjdJZcUmRE4yRQR11wRFhv/+qrPuY2AzbaTYww3guLWA4jd+mrRq9ut+wvRz?=
 =?us-ascii?Q?OdM6kc4ziwHf+zoaVVXDdEszZSAc0jVV5qQit/gSpdSx5bKE23yDto222rj7?=
 =?us-ascii?Q?tzGelAkyUy4Uuh2az/tEpA/n35TTMBwpRIMGqhP5iTAzCz4doWI3qJE58HKs?=
 =?us-ascii?Q?uOQQycin3HNy6PfIiThoMQaQj5iSSVQ3iC/RfWduppUveERmyEyS6oiE2ciT?=
 =?us-ascii?Q?1ldVe6ZFtrNmgbihqIIvx26K+nC+k0vve7z9Y69Q1qFHfNeHeFuG2HjjixWM?=
 =?us-ascii?Q?oes/ToPhElMy94RNK0WFV9fjGIvsnQXlmiKMSq3fyoBne4jwT/yi9qpxnW0c?=
 =?us-ascii?Q?jILOJ1aMEvR2JRxBc7Bfx0Fdy+H/e5zFhg3XxsyVmXYaNnitnZ3e0x09Cu2l?=
 =?us-ascii?Q?iIUwD41hMyddjMKIy2g0mhZ7N6x+YMKcD5uoPnW+nyaBtDXD5G5vMPAmEoBL?=
 =?us-ascii?Q?j8H2cIPePbAiTBkMfd/ZB3PFv+GYw7RoRiWEPTVndsExiI7mmnd1j7S96K4k?=
 =?us-ascii?Q?lww+g6Ofey7X8UG2VyXeMsn2T/XBZF8yso7AOnvFnfmmE+bMFoAR5T6HnL/N?=
 =?us-ascii?Q?aKosBKoT2Yi2nyr5NHMRHwHM/BsjSPzu/IqVKlIb+0RGv384AwsCjtSVRccx?=
 =?us-ascii?Q?lztEMIG2uMzZsj+g910/kMUWzn5MGCOxeVB57CNiQmehTltFJBrv/NOkWLEM?=
 =?us-ascii?Q?SJNmyQcVD1GPLd846hMfyR8oLD/SA5iv0f6X7xoRik/F0nX6KH3vKDwiHWvM?=
 =?us-ascii?Q?Kwx06/+f8yR3fFNZvkeALSrb1U+9+R7obqEFutM1Me2RqLOgYc3SBZnqXnZO?=
 =?us-ascii?Q?WOZtmAgWnrRN/mEaGQHUbw7H19HTgZcq3gSd43xjwoaBKxP8pbSami4+1n9Y?=
 =?us-ascii?Q?Qht1tA5y180Q6+DZ8cxkNkWjdpBEekGCWAtxFKI9lb/JfxW+7TBKPOHjCUTI?=
 =?us-ascii?Q?5ZSL246J+TVtHQZCMaZXKQ81p68I7743QcUqBM9Pw3IA0FZEdMFUwxTqXm8W?=
 =?us-ascii?Q?pYox75hBAtAgRn8G4gMDCzNICZWFUdu8PheBw4qH502VZQsidBdOh5kMmewR?=
 =?us-ascii?Q?Q24D7lpHoowQl+jvdn647uBCT9PNDNT6Pjv0FYHjyuUIe1qLNlwVopwNNyUW?=
 =?us-ascii?Q?d16iaG+gamPTh6zf58805/N+qltAbbsn0aDX+HjzDcPvF4zczPC1oAlX9ZTG?=
 =?us-ascii?Q?PFBSWVFybPFp9bnC3z/FQZzD2ROc33HuWGKts+8PUARZEwaWj6+f7gtMcT10?=
 =?us-ascii?Q?4GUtU3p2GNMjJz/trgjDIKD6oCkSz7kaJfT/cUElAFm3CI4PQd11SF8o2rtY?=
 =?us-ascii?Q?B1qyt9Kq9YXg3fJZPFsZim6VG6QYFsS3Dewr25ucnfdIfMPkaym19DZZugkX?=
 =?us-ascii?Q?3zPWJp0rlE+UaRV/jIxfFTGkoNcfW6YIq5WU4ZJx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 755a9b7c-cce3-4baa-9cab-08ddd8dd1905
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 13:43:47.8113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cwexjj6Lb5ZqPtMH+2K3aV4h7p7eiUvUbZ4++KIN22PFK/NWjt1RKbOO9jx7SF+wl1w5LHOjDGfUWNWA8CDY8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7208

On Wed, Aug 06, 2025 at 04:08:07PM -0500, Naik, Avadhut wrote:
[...]
> >> @@ -2808,11 +2824,13 @@ static void umc_get_err_info(struct mce *m, struct err_info *err)
> >>  static void decode_umc_error(int node_id, struct mce *m)
> >>  {
> >>  	u8 ecc_type = (m->status >> 45) & 0x3;
> >> +	struct dram_addr dram_addr;
> >>  	struct mem_ctl_info *mci;
> >>  	unsigned long sys_addr;
> >>  	struct amd64_pvt *pvt;
> >>  	struct atl_err a_err;
> >>  	struct err_info err;
> >> +	int ret;
> >>  
> >>  	node_id = fixup_node_id(node_id, m);
> >>  
> >> @@ -2822,6 +2840,7 @@ static void decode_umc_error(int node_id, struct mce *m)
> >>  
> >>  	pvt = mci->pvt_info;
> >>  
> >> +	memset(&dram_addr, 0, sizeof(dram_addr));
> >>  	memset(&err, 0, sizeof(err));
> >>  
> >>  	if (m->status & MCI_STATUS_DEFERRED)
> >> @@ -2853,6 +2872,10 @@ static void decode_umc_error(int node_id, struct mce *m)
> >>  		goto log_error;
> >>  	}
> >>  
> >> +	ret = amd_convert_umc_mca_addr_to_dram_addr(&a_err, &dram_addr);
> >> +	if (!ret)
> >> +		err.dram_addr = &dram_addr;
> > 
> > I feel like it is not necessary to pass a second struct if it is already
> > contained in another.
> > 
> > You could just clear (or not set) that field if an error occurs.
> >
> Slightly confused here.
> Do you mean we should avoid passing dram_addr as second parameter
> for amd_convert_umc_mca_addr_to_dram_addr() and instead just pass
> struct err_info instance err?
> 
> And, in case some error occurs, we should just do
> 	err.dram_addr = 0x0;
> ?
>  

Sorry, I think I misread this before.

I was thinking you can add 'struct dram_addr' to 'struct atl_err'. The
intent of 'struct atl_err' is to collect all needed parameters for the
translation functions.

Additionally, I just realized, we should have an 'invalid' default value
for dram_addr. Technically, bank=0, row=0, col=0, etc., would be a valid
DRAM address.

Thanks,
Yazen

