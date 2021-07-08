Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE743C1A2B
	for <lists+linux-edac@lfdr.de>; Thu,  8 Jul 2021 21:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbhGHT4V (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Jul 2021 15:56:21 -0400
Received: from mail-mw2nam08on2064.outbound.protection.outlook.com ([40.107.101.64]:44704
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229768AbhGHT4V (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 8 Jul 2021 15:56:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDtDMSzIkVw7lS2GnRA/VCivL7zg99hF2nHrLWFMvZIaqXqVCM92K7naVECHHErdQPE2w4zio93leRHgw4MvLoQUsyoxU31B028dJnRgbxV+XsAgrEmpOzGLrZeLYEx22AwmD5Ob9U3yN3F1kq3Q0oFB4vNTLFMHXtrojLNouXVzc1LminHilq7Jy5lnqeLnklouoC0kLJQ6LyBEryWa1OBNVpx355borataotFHAZ6/yUeg88gcoaU1nMfq4HYJ4noV5k2m/Z4VoOC078yNkM2nIwlbR0vj6++F9YNCtTLg9icOv1gdgDtG0RqGuELy9efTYkrCX/Fh/PgJ11FGvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvMfz/A4irI9BZ0GpCLNCh5VtT22168xjyz6yXX59rw=;
 b=PifziKY+s9nsJ2OPrFz7o4XyqCQKqeSdLzco2+epRfA0ah4w5xPg0Q1HC6sp8Ss1QzWwKsH737L52f87YYYe7Ny8l77Y97RxN1gkgwIuIxBWfjCuQxXxgmJYJ+dKg4EUsTLVaEwqIp8ZvdOdCDR6syLeF4E4s+76Q3n73/3lgBgu+olcLT+WPzTz2NTpuvimifNA4N525cwQSBcqeE3ObmxS4Ehm+qInXvMmVAlXA/h5HpReTi12mtYp3TWe+SUYHxvCZ+HAyKbf4ltQ5m5yj8C+Y5gYN3QmKh2zBm2WuXN4UG5RYDRWgExZOkqGUj1+uWLiEObBcNJwlc4QHBA30w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvMfz/A4irI9BZ0GpCLNCh5VtT22168xjyz6yXX59rw=;
 b=pl5JRsY6OLl+QFTXqmQykGamughOa59FVQqa8JiRbA1Q+a3NAStJx1ACfuJ6tUYvFHYQhP1PvUL3+5o3zykBvBxogWEJ66kaqIFkc07YT4L5MIiaUzUYMMIQYwr3vLpcgJN6MTtrmXuApMHkZUScNaURZ0KBqIM95mY1j8fmFbU=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3171.namprd12.prod.outlook.com (2603:10b6:408:99::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Thu, 8 Jul
 2021 19:53:36 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4287.035; Thu, 8 Jul 2021
 19:53:36 +0000
Date:   Thu, 8 Jul 2021 15:53:34 -0400
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 05/31] EDAC/amd64: Add context struct
Message-ID: <20210708195334.GC15605@aus-x-yghannam.amd.com>
References: <20210623192002.3671647-1-yazen.ghannam@amd.com>
 <20210623192002.3671647-6-yazen.ghannam@amd.com>
 <YNynNc9oMZVnri8X@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNynNc9oMZVnri8X@zn.tnic>
X-ClientProxiedBy: BN0PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:408:ee::10) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN0PR04CA0005.namprd04.prod.outlook.com (2603:10b6:408:ee::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21 via Frontend Transport; Thu, 8 Jul 2021 19:53:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3cb7e51-f765-40cc-66dc-08d9424a130e
X-MS-TrafficTypeDiagnostic: BN8PR12MB3171:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3171FEC0583F6DA48FE281A0F8199@BN8PR12MB3171.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hsMorONyNZuLaQOWQgYUuvVnFv55ca5QGJ+PuSoirwX4is0uGn9WEEPyYqp5ykEUlJOdcVIvPRCTJHQsrxiQV3mOYLiBaF4D1pS94SHvopIpiEwR+YlW3IuYuH4KsMHCsyyfWDkMDzn0mAT1+J+2zI7OIqmWVzBp0ItFUm2ttqanefLoUAnP8/bJLwLrpH4kSDzhczTIhLX9aWjSFzP/9jjInFCmE3wo8isMzSQWyKiQLP1Lo66sWtYb3IBklWP0dpx/VgGR0Zj15d5hIedV2Z1cAEuSxHPkpkmtlAtaho+ueFmgoNlIOfX1CsR6DGtWb6ckSF6qsWzbLHkd3xQ9s14Jf03mP/R5X6zAyj4Xc8FcDtblElnpBuGBIrW1gKHv0wJL34PeabuUDk2SVKAjmyjmQhSxXpAEoR1LS1K1rLG5CZgy6h0EZgEXsLFuvXahNgnqDM7Dx14RvYjnQ+7itjaP+Xm8fLGsa/nbrVx3ZphWNNVq1/kL34qIrzOas6EhcRgDCExEXHOMHsn4Ho2TeGRNjLvpJ8lHIk26Y5+RCE+AvKWnzrLX9BWcsTAEekiiJoZ5XOU5RgdFV9/V2PbzTXLmCav2/12jau5uDe1IePmWr4ibXYqVBZTR7+Tf0XRHgXiRrbbe39fclEyCKSTsFu0J+oUqvKXFbb2rg/a3WTIj6JiVCx3poXwszIA9Xd2xUEQDfETza7/qwmaOEh8UEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(1076003)(956004)(52116002)(86362001)(186003)(6916009)(7696005)(26005)(44832011)(478600001)(5660300002)(2906002)(316002)(38100700002)(4326008)(55016002)(38350700002)(8676002)(83380400001)(33656002)(66476007)(8936002)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BN6yrlQrclnmweMi5VQYUzCrZyk1Jyuy1WAXvQMZdb8lwYkWdVmP3+NvoZqX?=
 =?us-ascii?Q?BjiU8ifLWVdUFV9bp+bkpT2XBU70StsA7GhK+D5ztKNs2ELsKo23DRte+9BH?=
 =?us-ascii?Q?aUcp53+2l28dV9sXOAcvxSN44JVD06F1SK3xHpEisyKczE/AVfBAcluDI+Rk?=
 =?us-ascii?Q?ht3iVgtGpRiofJ67yF4lWc/9ytzhcbUh314lWGjrH8pL0GNNeQUM1pCrOej0?=
 =?us-ascii?Q?cgy3xooe3eWKI3WYDNLC/1DidSnFjk8hZ7hYZPEGhP2Mo1mi2xIXerU7enpA?=
 =?us-ascii?Q?6KEdFsZdY3nkGcwf18NqGRQqAVAuRMw9zlPSZRc9gqSgZPgQQpu6mL2AWik7?=
 =?us-ascii?Q?RaUaDyvJtV4/y3u7l4FEjKc8O09SH/J6BnYDIvl4apjfJMufaYR1NNtftTwp?=
 =?us-ascii?Q?6OwqIZIMV2uWrmMQaO5TptiYG3A5+dTRYdQ2lDFW5b+PEmALJf3vg7qX/Cdy?=
 =?us-ascii?Q?7w9eZye2pTDNuqRXk5YdrHZVGEQvBx0Sr10e0a/gQpyjI9JbCiINh1/umipB?=
 =?us-ascii?Q?9W1Hewkhk1FZeiyGvGvlAsVhXgXoscEFj08ZCjAK844IysezLiEqVGvyafIa?=
 =?us-ascii?Q?OJb+9K0NQZdODorpiDHgKzh6cfmjEiPf2VGjotm69o344T7zGB/2h+slZs4Q?=
 =?us-ascii?Q?QcXPnmV8GCpfkG5GxOmmw3R1oHEzuHtC+x01v8JMCs42qW1NqvZlkCA+Pnwg?=
 =?us-ascii?Q?XMIRJjgYM1LOdehihK9AqQT5ZQ5RBwyXPvMqKfEM7kCMa2rjGr/Fcie/SBn9?=
 =?us-ascii?Q?sG36SjYGqf+NoHAZLhde8XFdDi+V32QTgPXRGXTZpZfhtJ7Nh+4Nb2vqe+0t?=
 =?us-ascii?Q?Fo3wz/jTURG6Q3uztctT5hiXTridmbu4mEpkEwbNOjjW+y8UChSV1DsMOBTL?=
 =?us-ascii?Q?9kbZ7PIlNaWhbzxvMG+iZBKC2umfrjFxsfYHBmIKBf5u/49QYTlY8YodOSHe?=
 =?us-ascii?Q?x/NC3M98UNrW6OgYdzaUT/MbyQ0La+Yme3WMV+cqElrLM2xcyuW3Qmf3ITRc?=
 =?us-ascii?Q?7bkd/c5W656fe8PEMqzkSaNloYdk6V0AcXysRCGI3o4VQmeZ87OueCdozkRS?=
 =?us-ascii?Q?nTAZvcQ3Xs5sNgNciGtZECVkEDj8tWU3IGPSMg94bqukQGIyM1jSds79qgUy?=
 =?us-ascii?Q?9Anea1s7gtSpMcuxnFbvvlnBUuTd614aLVK65fR4A3w++QXpLno6MviTVcFn?=
 =?us-ascii?Q?fuCcnPWDg0v7BHXIphshc+0GpIv3EkRtz8JKLf5+E4TTrnDb3HhvA29u05sR?=
 =?us-ascii?Q?ZG4YAXDricPA77xZsFSAiECZyNadd5OaqRpG0iBPl7oeSt1nvkX7VKQsMH1g?=
 =?us-ascii?Q?v/KmtRKueAIg0SnwUl8e2K09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3cb7e51-f765-40cc-66dc-08d9424a130e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2021 19:53:36.6488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FezNevWc+eXeVEzmlg2ot+B3XnE6Ykjydg5ZTsvAa8zbrkYIqPtyeF5zqhA+fg5W8OZ5QsDXyxjE6P2RN8Znuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3171
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jun 30, 2021 at 07:17:41PM +0200, Borislav Petkov wrote:
> On Wed, Jun 23, 2021 at 07:19:36PM +0000, Yazen Ghannam wrote:
> > Define an address translation context struct. This will hold values that
> > will be passed between multiple functions.
> > 
> > Save return address, Node ID, and the Instance ID number to start.
> > Currently, we use the UMC number as the Instance ID, but future DF
> 
> Please use passive voice in your commit message: no "we" or "I", etc.
> 
> And this here is a perfect example: it sounds here like "we" is "AMD"
> but we use "we" mostly for the kernel. And there's the confusion.
> 
> So please teach yourself to formulate those commit messages properly -
> the future you will thank you, trust me!
> 
> :-)
>

Yeah, sorry I always seem to let it slip. :/

...

> > @@ -1097,6 +1100,16 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
> >  
> >  	struct df_reg reg;
> >  
> > +	struct addr_ctx ctx;
> 
> Those empty-lines spaced-out local vars look weird.
> 

Okay, I'll fix that.

...

> > @@ -1236,14 +1249,14 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
> >  		 * bits there are. "intlv_addr_bit" tells us how many "Y" bits
> >  		 * there are (where "I" starts).
> >  		 */
> > -		temp_addr_y = ret_addr & GENMASK_ULL(intlv_addr_bit-1, 0);
> > +		temp_addr_y = ctx.ret_addr & GENMASK_ULL(intlv_addr_bit - 1, 0);
> >  		temp_addr_i = (cs_id << intlv_addr_bit);
> > -		temp_addr_x = (ret_addr & GENMASK_ULL(63, intlv_addr_bit)) << num_intlv_bits;
> > -		ret_addr    = temp_addr_x | temp_addr_i | temp_addr_y;
> > +		temp_addr_x = (ctx.ret_addr & GENMASK_ULL(63, intlv_addr_bit)) << num_intlv_bits;
> > +		ctx.ret_addr    = temp_addr_x | temp_addr_i | temp_addr_y;
> 
> You want to align those vertically on the "=" for better readability.
> 

Most of this will be removed in later patches, so I didn't think to
change any more than is necessary to make sure the patch builds.

I'll check the end result to make sure things are aligned nicely.

> >  	}
> >  
> >  	/* Add dram base address */
> > -	ret_addr += dram_base_addr;
> > +	ctx.ret_addr += dram_base_addr;
> >  
> >  	/* If legacy MMIO hole enabled */
> >  	if (lgcy_mmio_hole_en) {
> > @@ -1251,29 +1264,29 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
> >  			goto out_err;
> >  
> >  		dram_hole_base = tmp & GENMASK(31, 24);
> > -		if (ret_addr >= dram_hole_base)
> > -			ret_addr += (BIT_ULL(32) - dram_hole_base);
> > +		if (ctx.ret_addr >= dram_hole_base)
> > +			ctx.ret_addr += (BIT_ULL(32) - dram_hole_base);
> >  	}
> >  
> >  	if (hash_enabled) {
> >  		/* Save some parentheses and grab ls-bit at the end. */
> > -		hashed_bit =	(ret_addr >> 12) ^
> > -				(ret_addr >> 18) ^
> > -				(ret_addr >> 21) ^
> > -				(ret_addr >> 30) ^
> > +		hashed_bit =	(ctx.ret_addr >> 12) ^
> > +				(ctx.ret_addr >> 18) ^
> > +				(ctx.ret_addr >> 21) ^
> > +				(ctx.ret_addr >> 30) ^
> >  				cs_id;
> >  
> >  		hashed_bit &= BIT(0);
> >  
> > -		if (hashed_bit != ((ret_addr >> intlv_addr_bit) & BIT(0)))
> > -			ret_addr ^= BIT(intlv_addr_bit);
> > +		if (hashed_bit != ((ctx.ret_addr >> intlv_addr_bit) & BIT(0)))
> > +			ctx.ret_addr ^= BIT(intlv_addr_bit);
> >  	}
> >  
> >  	/* Is calculated system address is above DRAM limit address? */
> > -	if (ret_addr > dram_limit_addr)
> > +	if (ctx.ret_addr > dram_limit_addr)
> >  		goto out_err;
> >  
> > -	*sys_addr = ret_addr;
> > +	*sys_addr = ctx.ret_addr;
> 
> So adding ctx to exchange data between functions - that was a good idea.
> 
> But what this patch does is pointless because you simply replace those
> variables with a local struct.
> 
> I guess the aha moment will come with the later patches when you start
> passing it around to functions.
> 
> /me waits to see.
>

That's true. I was trying to make each patch a single logical change, so
there are a few that have a lot of churn. I can squash some of the
patches together if that's okay.

Thanks,
Yazen
