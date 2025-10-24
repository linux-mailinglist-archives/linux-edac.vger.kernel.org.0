Return-Path: <linux-edac+bounces-5188-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC1CC08101
	for <lists+linux-edac@lfdr.de>; Fri, 24 Oct 2025 22:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CFBDB355FF1
	for <lists+linux-edac@lfdr.de>; Fri, 24 Oct 2025 20:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D982F5462;
	Fri, 24 Oct 2025 20:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ezlIFMq7"
X-Original-To: linux-edac@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012050.outbound.protection.outlook.com [40.93.195.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6702F39D6;
	Fri, 24 Oct 2025 20:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761337821; cv=fail; b=cbfztw04TQtU+yKu02k7xGL3dmBhfPD7ULCr2YvEnqzBDyIZHYBdAKlbr8UmnW17m5lP06EtAT/L7hixoGSW+eqmLNva8TuhY7/N/vEpWHqHmeKcDFFr9vulX4l/zzUoGNnq++SAQzrhKiiv1OpVDPNZFeJJRLW+UaPV10WWoYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761337821; c=relaxed/simple;
	bh=oOIjcZ8wpJNRxBEnTGHf6YAMdmYXdY6aiBCzztGNeUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jhFl2KwAPo74me4WPIitJDkk+oIuKThNzit1krC2z29Fr8RhqjwYaEx4jsghg/i5tpk4vJ2aoefXUFnKbYIfmx1ZLPRPAaGO7wshlwMt0WBuuO3g95X+xJEeuNYg79DOz5iHi7JFOZQlKPkaQpsIJPGl0cF7yvtEuCWY5bAQmfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ezlIFMq7; arc=fail smtp.client-ip=40.93.195.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDDWpwku/F6XBQNXduNMjiupCEjzyRFbXGtcmlmjS2i+iXgoisFtjzIwLMoy11N0LLG2NEvpbsJkDSyEUshFVqxaOvNX03SyHzICkymiyKOsA2fa/0FKvsrCqwgFIA7M9/Izc/K5tmnPpcGazYooJ5qsQUR0aH2Hu54pMN6yfeOe5MnDg1sRye57w369jP8N3quqPTEe6Gjzk1ij9uoJeo1TYUuVIZXkD5UAiJvwzBcAghLYxCPgtkbiYwq+FOUYalDy/g/0qIsmafgA9u2IptYgqAMUW4do69RX1WCUG5L95CpoEqI2TTdYs71kN+781wbK7ol60auC46M4+Q3p8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LeeU1fhSfiOpxiw59koplAMJTlucWpmZvT8aGwbQS+8=;
 b=Fw385i6JJIQYfUeCtT5MomREctqS2qwHlD6CPJq+wFW0QHguevHf8t0+9l+kiPEBqeyYMTeJbRa8dqVXhPDZ0letyh+CHgoqlN+rjW8uluRbxJ5JntfYoQ/F+2iQCUVQ18HbyWtl23RX/5kFsFWGJpc8Zpo+7SHHOhpLcaTUIVS3ER+GsmJ0/X/lbOSNzOVOpY+YJ3LPzts/W0Nf80rlPdLYvroSMOx5YJzkLJKSYGqiP3P6KiUmDbS3wvNg/y4SqXhCGtSwjDa7AqpyRdlIG8cA1NEJWr4BtUG2ZfHut1/39IqTAK/WbMIsStFzOvSK+k3gtPf1YzC7r55wSBYx4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeeU1fhSfiOpxiw59koplAMJTlucWpmZvT8aGwbQS+8=;
 b=ezlIFMq73P0t0A3cMEj9/3I3dJg/wqiLUyoDGfw01gffDs/ZXNQcSaBriu04DzevwjRrQ2jszeWW18l0VkZgrGNwy+mYTLu4Kyz68I9RfYYSjol7s70UG1iX2X5QryAonr5UmDEdi+dGIkIU+blv/afY7GqdoLYyZqCnRKkNN0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.13; Fri, 24 Oct 2025 20:30:17 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 20:30:17 +0000
Date: Fri, 24 Oct 2025 16:30:12 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Bert Karwatzki <spasswolf@web.de>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v7 2/8] x86/mce: Unify AMD DFR handler with MCA Polling
Message-ID: <20251024203012.GA251815@yaz-khff2.amd.com>
References: <20251016-wip-mca-updates-v7-0-5c139a4062cb@amd.com>
 <20251016-wip-mca-updates-v7-2-5c139a4062cb@amd.com>
 <20251024150333.GSaPuVRQYxH92zyrmO@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024150333.GSaPuVRQYxH92zyrmO@fat_crate.local>
X-ClientProxiedBy: BL1P221CA0015.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::34) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DS0PR12MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d3f1286-ab62-45ce-5fe7-08de133c24ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zQlRJ8YDKqgTAno6YBgGBidy/LB3IPAQJKUgQAJkcLXXcuCPK8fuUbAbj5bz?=
 =?us-ascii?Q?CEidJEWnyqu1RfwqAmT05gwLEdVjlYZQuQy929CJIvIOsqbMV8OPd5KmmepK?=
 =?us-ascii?Q?rP9nTrTsItkKP0hMG0Tm49Q5LPDrmMfJm+JgBels2XkkxbKAIWwcEqKxKiwd?=
 =?us-ascii?Q?fL7AJFlW+LRHzcXJBoW9oTjLAeYFcv1Wc7Oyf0UkVRJTrK7+jHhLH1H1NsgN?=
 =?us-ascii?Q?gy7sXaX2zkA+F4ljboV/27x0L0vrDzs+zI82m27eeMmouQ3M/UdCAmCjLM6L?=
 =?us-ascii?Q?nAKLxNEL7hzCt39WgEa6wnGygqXwzInXr9RgWRu+oq9Cdh26wPCp8alASZgr?=
 =?us-ascii?Q?nVRZTPUkAiOoTetJ8PSKqAANp820SeOJ8xJ1n9HYSOn32YthLzT867KryzSs?=
 =?us-ascii?Q?mUOHMMbak1EVBqR2fB7SkSFBsbZ/ULJuQkKVOOm8fD6wAQwQ6O/ExeEHPBPj?=
 =?us-ascii?Q?RlfMwkj70d69BZ0zGMh0FUZJ8X+iwblv/moC+P5AeiMG/fk3jrhTN3xprAqb?=
 =?us-ascii?Q?ThZKOt1uHlebceNAyxZgMn6Ppo5uOotXGhPmlWQQ2iKMnBaA3zKrw8fWkWWH?=
 =?us-ascii?Q?nN0Aq0CRUctozqXm2O4BFPPgxo5iMOw2f+/apM6LlCG+zJWNtw5nelRc8xF4?=
 =?us-ascii?Q?Z2857bGi5h6mfmFs00O9nG+dW2sN3ECnrFIcM2LcFZMeOgMo9tADKOszTOsB?=
 =?us-ascii?Q?rJVQHtq/qIXVe5O08TNBTYtKPXCvqbDNYbjZ/uTDnXrfS1ae+UEQw0wZSuFg?=
 =?us-ascii?Q?KynKiXKGqysSdHxohQVAE8T2P/dCvR/0nu8YJTzJRonspUvxgCTMjGEQPZl3?=
 =?us-ascii?Q?KNRaVkTaxGAU7GznDwGP9A78dtIao8GWHgHxIAHYTMbbJ4kTuKbiDOJTNzQ4?=
 =?us-ascii?Q?routSU44zESO4q5mJh93PwnXac4uu3oU393Ftkp6+soQKfvJymtXPzey5Z3l?=
 =?us-ascii?Q?Wg0sPLSDGpm2RCVyTLLn7hp2qyCEbSjNtvdAid886JYnOV5KNLsHjwtNVGy2?=
 =?us-ascii?Q?GYBylG5fIeMHBxJuXXM1HpK8koJqUYLiZWdmJmoYvkQwCjVQYN6KNi3tlnHc?=
 =?us-ascii?Q?OsK8a0nFAgDq99I20zXcgz4H1hH8HandBV9kBh20LZDNHWmnoiRcaV6h32Cn?=
 =?us-ascii?Q?mjWmw/FvNzsW04DQmW+sxLx9dA6hOV4hFcGbpl+6Q54lCmrBga5KOn4vaukq?=
 =?us-ascii?Q?O6zva1DsWYAC1mYLoEivLmHWkaobDqSvEad/cFl82RrdZ9VkbcAAYsGvsys6?=
 =?us-ascii?Q?cPwaQnueFJRnbMD07x9BrsQ/0MBJkV0MQtDrnaUXDOuIfOiBrCrF2Oi9HyFv?=
 =?us-ascii?Q?XY3MoK/8AeE+BNBqPStK59quRyGpbCIaFhhMEmeaPAMvI+7+5ZxYkD5nWep4?=
 =?us-ascii?Q?P8Ig3+Z2MbGq5ICTAXJpTioDx8xxhHRJd/dJIFdwIz3TVBsfvpvmdKpBJAJI?=
 =?us-ascii?Q?4PiJ9u7AVS9iUYch+BCDSXjLDVC7EBGx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xy4ZmH+bdhb1EqwKY4HrjTp0G4Hq6znPkDZ5AOcfYU7KC3hmp6HjWsmxr3UH?=
 =?us-ascii?Q?T0D1scFjOTqpHAhudsNTb6Nhiw1liXDj95Jb1/y+qcvp6KP4+szdwYoILwdl?=
 =?us-ascii?Q?Zsz1r9q3HIUNOjh+bcTl83zGNsTaQTh9EGrqpUmIz60krfq1OJh/hh3uOfCV?=
 =?us-ascii?Q?qK+8LB7O1ydmukAmPZfMf0QRyRBH/0d5W5HCWi3lDuTBXZFzh3FwzvBnEKQ+?=
 =?us-ascii?Q?uA6fi/G2D2v44O15lDEWu9AKDQ7tbylKjJYsE1GecNMvssRVzHqIYt/UKw9e?=
 =?us-ascii?Q?QC9cfjD2QyZvN+F8qfG7/2JpyJvNt8dNnFnntWuyitjm5BYfANHOanbwvkfq?=
 =?us-ascii?Q?lY5o7mT33iJFRmcX+LklhYkvlh6CsKJc5KGFuQXbp43ec/JBd5drEaEUt58b?=
 =?us-ascii?Q?7TYVFFwvksWl4y0M9lYbV3iDYHxNbtLihGP08AAr7n0pxBefV5pZAH9Xhkwz?=
 =?us-ascii?Q?cl2siRobjf2xt/8l/etsT+Oe45ItpV31uZ8R4aMAgWNXdCEqlUbXDenXo49Q?=
 =?us-ascii?Q?/3YM//iodhuVJZC445B6fdxPPHcJiM5SnCYSxeuxrYIzZ9lBimeP7HOAGu5n?=
 =?us-ascii?Q?sTu0QnuIleT7OD9zcehFvBtHamTaUAXXFtkrkVZAS0b8XJPGPShOAxRhrpIr?=
 =?us-ascii?Q?WRsax1vQ2j80rXnC3sjhp88AEiKalG6ghEXfc30He2pYvsSkA8ILZnYonbax?=
 =?us-ascii?Q?YVnPwou5+jFNP+lFZEwKkZhNdaVLwD8yHGZw4QToIsfJ8/FegyXZvra6Os44?=
 =?us-ascii?Q?ADJG8q3tLUYP1QTa5tak/ogrzheYlnA6Orlm+XYy7MTujmKzUG0MB5A2f9oQ?=
 =?us-ascii?Q?uw5N7AfoDfuPeD5dxHdBJunZqnUkD747zcId+T/b2eG8bI7gY6jFIHdLOonN?=
 =?us-ascii?Q?uCuJFblsvCRCulu6lUxacFMva9R+2n+d9sm0oMOuou/NtsfUtlsR5Y2Zt7I9?=
 =?us-ascii?Q?HMxK/ZAbaDHVxIHYnUx9PkWQDp364LZ2qhCYKgIXe8yyJJUoiwAtEpCt2Cdc?=
 =?us-ascii?Q?PlL8zTF0BUwbn/bcQM9lWMuAeqtfPI5CvfCNduuMaa10hr0ESYxtCA+INVul?=
 =?us-ascii?Q?82obAgspL8zQYeQXj57RTTAM7Qr9Vmd0X6bd81DESnpEbKem5sIsDiXqL8nx?=
 =?us-ascii?Q?OoZb8yRejRe0UC5HPJRAJjLJm1PpFvZMytcvPlDckPAMn9PT66DJ+5X4Gh3f?=
 =?us-ascii?Q?ZC4ZJHizwMyj4MydHT1+AU3LSL0gclEQplKIx7gchdy3Q/f4+raZgi/3hoMp?=
 =?us-ascii?Q?nReyBW9EFRR0VXlF/osIAv4rbnfx4rFAndNRysSChFPxNlZh5ItxipnNdpET?=
 =?us-ascii?Q?/EUKb5+NM8Hp7ew8eawmSSzFA60G9zbVbyNz2lvnvO/s0pwf9LDvnCGeAj7a?=
 =?us-ascii?Q?WTHaez8TJH6vVMNOOckiRkb63j0U0t2yFep0KTM+Ki9How6QHYfWZn/U7kEO?=
 =?us-ascii?Q?TtfCmiSaQHfODZT+g3VHAZvSFBxoLcSFUiZir7FUf5X583LX+ELfPASCXbPD?=
 =?us-ascii?Q?d/aTmN7ebrhemJoF4lU/N+YUrRZC2UD+yjJpocvaTEdxQjn0iYXORaERc/6p?=
 =?us-ascii?Q?rcw0y2fshlGjRoEsuS034lvL7RYksk4SiZgAYB2M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3f1286-ab62-45ce-5fe7-08de133c24ff
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 20:30:17.5085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xYyg3x99aqqroynIhXuZgU0no46pjEMFcugeWXW/gxUTMkze6ok3oekBhzvfeOcLjiH1caNdpaTAIt9mDAkB0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6608

On Fri, Oct 24, 2025 at 05:03:33PM +0200, Borislav Petkov wrote:
> On Thu, Oct 16, 2025 at 04:37:47PM +0000, Yazen Ghannam wrote:
> > @@ -1878,6 +1924,9 @@ static void __mcheck_cpu_init_prepare_banks(void)
> >  
> >  		bitmap_fill(all_banks, MAX_NR_BANKS);
> >  		machine_check_poll(MCP_UC | MCP_QUEUE_LOG, &all_banks);
> > +
> > +		if (mce_flags.smca)
> > +			machine_check_poll(MCP_DFR | MCP_QUEUE_LOG, &all_banks);
> 
> So you're going to run the poll again just for DFR errors?!
> 
> What for?

Yeah, I guess I went too far with trying to catch bogus errors.

> 
> I think this is enough:
> 
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index 1482648c8508..7d6588195d56 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -299,7 +299,6 @@ enum mcp_flags {
>  	MCP_TIMESTAMP	= BIT(0),	/* log time stamp */
>  	MCP_UC		= BIT(1),	/* log uncorrected errors */
>  	MCP_QUEUE_LOG	= BIT(2),	/* only queue to genpool */
> -	MCP_DFR		= BIT(3),	/* log deferred errors */
>  };
>  
>  void machine_check_poll(enum mcp_flags flags, mce_banks_t *b);
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index 64aa7ecfd332..d9f9ee7db5c8 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -807,7 +807,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_deferred_error)
>  /* APIC interrupt handler for deferred errors */
>  static void amd_deferred_error_interrupt(void)
>  {
> -	machine_check_poll(MCP_TIMESTAMP | MCP_DFR, &this_cpu_ptr(&mce_amd_data)->dfr_intr_banks);
> +	machine_check_poll(MCP_TIMESTAMP, &this_cpu_ptr(&mce_amd_data)->dfr_intr_banks);
>  }
>  
>  static void reset_block(struct threshold_block *block)
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 39725df7d35c..7be062429ce3 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -779,17 +779,13 @@ static bool should_log_poll_error(enum mcp_flags flags, struct mce_hw_err *err)
>  {
>  	struct mce *m = &err->m;
>  
> -	if (flags & MCP_DFR)
> +	if (mce_flags.smca)
>  		return smca_should_log_poll_error(flags, err);
>  
>  	/* If this entry is not valid, ignore it. */
>  	if (!(m->status & MCI_STATUS_VAL))
>  		return false;
>  
> -	/* Ignore deferred errors if not looking for them (MCP_DFR not set). */
> -	if (m->status & MCI_STATUS_DEFERRED)
> -		return false;
> -
>  	/*
>  	 * If we are logging everything (at CPU online) or this
>  	 * is a corrected error, then we must log it.
> @@ -1924,9 +1920,6 @@ static void __mcheck_cpu_init_prepare_banks(void)
>  
>  		bitmap_fill(all_banks, MAX_NR_BANKS);
>  		machine_check_poll(MCP_UC | MCP_QUEUE_LOG, &all_banks);
> -
> -		if (mce_flags.smca)
> -			machine_check_poll(MCP_DFR | MCP_QUEUE_LOG, &all_banks);
>  	}
>  
>  	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
> 
> 
> 

This looks good to me.

Should I send another revision?

Thanks,
Yazen

