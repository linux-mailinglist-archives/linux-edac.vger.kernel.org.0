Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C8E502C2F
	for <lists+linux-edac@lfdr.de>; Fri, 15 Apr 2022 16:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354719AbiDOO7g (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 15 Apr 2022 10:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348301AbiDOO7g (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 15 Apr 2022 10:59:36 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6C3EA9;
        Fri, 15 Apr 2022 07:57:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhcQdhZydir/xtfycffwLRgcRUbhe5ZgT7Uxm//wLmRkfdoqTi7hMub018lCem8l9UidpUBbkALi07go09HRTWriaRk7j2BA1H6N01oxXlyFhjlply+VNMvQ83YOrEboOHy29sbi+v+3LUJiM3l8LIU+gTJYazMUvK+pWjE/qoazmfwJHuq4Z/HItvHn2PW39sIHDHoBfggeSN3CjMl1pEROvzjWEZsFeOaJ1dBtb2LXL+xgyWjiG8exEzDNy3RWPOABf9MSATYxPvRq4JUo9iI4fAg6ithfd7DsN5DjCyReByxAPs1ef16yw4N3xJDvvQ5haNF9bGSImaJ3Uqp1Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlB9YJtcTZSrrRDSWiANCa+YPbH3Ui81E7IjteIOSmM=;
 b=goGI0yNVnuDZee7WN+LJXGRYpNFTne1oyCua63GJF40Pmcn1vYcbBGezDP3bSAat1CZu3YfEgAkne++D8KjKiRJx2i8s9k+GwdvhCuI9UDE4IG9zcDGlFHyV8OZUFk7Rt7o7LAjkeTZPfTbEik6HlNLvrAWpb7U9M5tkArW3msmx/07+gZ3lIcltbHowAo0W2N/09/7bcI7sp1tpXbxAm21FJm1aqZF48fg7X+pdwfnkQm2pV0oWFGNCCCfy1GCzDMEUmBENLo7/kmQLvt92gXEqg7E+G/fwY96hCQOFkjoklvhiXXMTHBIvimKqgQaUEc3rmggYnwz5x+lrYR+Xsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlB9YJtcTZSrrRDSWiANCa+YPbH3Ui81E7IjteIOSmM=;
 b=yDtkKTiXq3hj9k50uqHrT7gnm+PNedqf/uw4gEChwg90Lt7aRCoRZUPIxi/+6KFwtKEqE0D+7p6Cm7CsSDHH230mZb7cAtGsqm9Pe8iKz1Fot6fYEFkXY/FQKlOnhonLj1JJ8ZRPygl7YD+Z9HQDCc0dNjD2soMVJqB9g46xaEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by PH0PR12MB5499.namprd12.prod.outlook.com (2603:10b6:510:d5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 15 Apr
 2022 14:57:04 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a941:fe42:23a5:c501]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a941:fe42:23a5:c501%3]) with mapi id 15.20.5164.018; Fri, 15 Apr 2022
 14:57:04 +0000
Date:   Fri, 15 Apr 2022 14:56:54 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     bp@alien8.de, tony.luck@intel.com
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v5 2/2] x86/mce: Add support for Extended Physical
 Address MCA changes
Message-ID: <YlmHtlKABn9W0pu5@yaz-ubuntu>
References: <20220412154038.261750-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220412154038.261750-3-Smita.KoralahalliChannabasappa@amd.com>
 <YlakNe012hhErszh@zn.tnic>
 <YlbZ1k1cT1FVJj4W@yaz-ubuntu>
 <YlbkCK9LU2KdXZUG@zn.tnic>
 <YlbzbZO6AvxOqQb/@agluck-desk3.sc.intel.com>
 <Ylb3/4oi6KAjdsJW@zn.tnic>
 <YlcnN2q9ducdvsUZ@yaz-ubuntu>
 <YlflJfyQR/j/eRkn@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlflJfyQR/j/eRkn@zn.tnic>
X-ClientProxiedBy: CH2PR17CA0025.namprd17.prod.outlook.com
 (2603:10b6:610:53::35) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e300766-f173-4a56-ba4d-08da1ef03414
X-MS-TrafficTypeDiagnostic: PH0PR12MB5499:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB54992EA8D466C0F18332AEF0F8EE9@PH0PR12MB5499.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J4ktLKNrAIHltq2tnrYtOGGc9n/IxBjcnjq9bl854vQ2ytgk6o+y40rCCb8/m5dNwt+kYU9vddi+czDLB0hwPlgPnwk631FJCqKPQ+flzZ+LKFDpAnJ4piTW9D0XtzHdqiciKGzsCbsIgEJmWaxI3IedCGXcOi4gw6sZGXVyN8Q2+11GWAskdo9UN5PKhYEUYdkti9hMDtQxs7FbLF6gKrIkmChXZ14sQxtIkhbYPok1JeiPswLx2wBmb0mikFazDR7nLriMznLUCEBiN7bu1/CLKd/5pA3HoReEDp4Rktxbcm5DQqmbgpKZadvGPxJStcyyCBvUY89zlG4njB4OdlLI9CmUrsNasuZ0Ko0WUuXtWNoCMiRyTzAlh3BBmMxzZq9J0uyfOJLVgGSWOurG64ldHPn5NqO/FSWm+4oKXKpcGHKex9hOIcK+xU4h4FZwQzIUwWlWdoVoaKJbTgNTlxwKH/FCGSrhzVrmb3zqCUZJhoj7UF/NfkJGU+TERl9HX6kZZgQ6iYI9JiUWWeHgBFbOPfNRXJEEozj0UtYMObR6C3wZgNO9vzdSlRC/YeSg7U+wbtGzEFCcOazD9yySt2iwGEkCyjO3W32YVICRZ6N3av5EhEs+fJ04jHxIHxAMs4MHyGGUGzO3cnmzUyCCleGvPGaYPXL4ViPySQk9CeHoQozHjMyvpQrQ9xsP1ScjvzR92S03Mz0uy2o+VxlkLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(86362001)(33716001)(38100700002)(8676002)(4326008)(6486002)(508600001)(44832011)(6666004)(5660300002)(316002)(66556008)(8936002)(66946007)(83380400001)(66476007)(26005)(186003)(2906002)(6506007)(9686003)(6512007)(54906003)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R9gTJy1H/9HuerZ1NT8q1XEACy+r57Ib/ypBL+FxzBaO5PyF6KbDQqD6g5wU?=
 =?us-ascii?Q?nZ9+grEet6ibb0qJJj6ytnaJ+yJUaLmK4xzzoz38gMkDcu+w7R9o/M0JFfJm?=
 =?us-ascii?Q?t85OtaUaZipzj6hS8UchmcIyArMm7BMkOR7Mf1Z+04aJsOCMCB1X0fjbM/GI?=
 =?us-ascii?Q?vqcHFFUopHRtD+ndElDCtJWiYtCl+CTxLP/5GXfqPTqFljyLj6zkz1xwRgZC?=
 =?us-ascii?Q?Xp8+PbsTWyWB/gYcmlvstLAsgnW+SOLeXYZjcuVbkPqba89/sLym8A4ApBWi?=
 =?us-ascii?Q?ci2BBVLbG/vIX6CBS/lc9Dp2BxvPrY2QbO3f7u/XxP/l30kRZij8Jkt+SlMu?=
 =?us-ascii?Q?8b1B/ji9Hv/8wcPZ8G25OnWvUKa4D7rSVRLu9HADWzlYEZeC/eMOlCc8c1pw?=
 =?us-ascii?Q?w7RrpOI77racGpwqUTX14o9PP66t5WfAeAJ4xHkmGwUHsuoFksA1ySFG4WUJ?=
 =?us-ascii?Q?fyfDR7fjaFUOkhefXszPIRxM3QZXf/uNkIkOEyRhvqDI+XptuFE5HyJsVyqr?=
 =?us-ascii?Q?9PxfXAItEYp4tbLOaE0CgC7Q0okYcjYCBnoJ9BUQ1TAfdroE3KV6pwJNhQoV?=
 =?us-ascii?Q?ySRn8Pn81+uTbjoRmJ7adqaiIc4ETS1A0rScAcKyPf9h8V2t/FCkp+GgolUC?=
 =?us-ascii?Q?eBPbSC8CuitwK0BvZfcwROIgWfRKF2hVimMKUCniFDg1kPbHSvJDUKvU1YBr?=
 =?us-ascii?Q?Hhl7BBu378+MH+SubjP3r4LOTGIKysf+nhLWDqSoL+rqXBLpaEVHopdRyOIA?=
 =?us-ascii?Q?oxP57Um5OuBXxKBilz5N17utZSQnefHPKUBKIxhnycXDxnQI5YVDOZMiq8vw?=
 =?us-ascii?Q?2p9Dyz25H9BJXo6GkqhPYzWtEJMfSyMM8tmAXpIBS5RpD0k/Ig/hmQykGEZS?=
 =?us-ascii?Q?g9F3IZpD4MdoJyJlPqMNnLpm7wD+ME0e9hmJbCWPu2W/5JjE3afh1TYbOLO5?=
 =?us-ascii?Q?lWqn9vfDWgj6nRvxHkJ23G3OffQYTt1XGB9HNq14pLDrKX4Os6gQZDstZrds?=
 =?us-ascii?Q?BmH/tia8FHAmbqFTjKhXghgHrFU6pX8k89kEoPha0YyATlL1jq9axpW1OpmR?=
 =?us-ascii?Q?GDJoxerrMP+s1oCCxNYCeHu9MJ1k5tbzL9CsZEcejwOlUE9sq4dTt1oePguX?=
 =?us-ascii?Q?jYG+J8Fr/15MlMu4KzGOtYm3wGDGSuNkz1dY4O4JkJHRAQWz1gayzL6cmgfu?=
 =?us-ascii?Q?eBjosnLCQpyUQRbvwK4XfEZllAvca+kmoym6+Nh4ZwWs5IWKJh3QZqz4kfKn?=
 =?us-ascii?Q?UOP6EPSI72n1wqyiHwRYTvE/3UHg+2glf0xNycHsysVTnFV9m+/1BMwLjdBx?=
 =?us-ascii?Q?mzJSFnyFdGqnO+T5Z7xi6ogjICrR0jkRHgqRvifHHhpM6thttqHrs4h1iKbT?=
 =?us-ascii?Q?PfODLZ6ulWOSKOnSfZXyLJX7XznQh4/9SriKwntlfu38ENGmTBADXku1Iv18?=
 =?us-ascii?Q?UU9zq9nGfODT4tkmte2NpG8Vd7KK29yse8hupi3PiecmYsaWHSbkNavGxSuY?=
 =?us-ascii?Q?1Ehyk7q7WL50KO/4S7iCCozIrLzWzbsrUkDk6qt1NNEgVKCjUW2l8kFMVe67?=
 =?us-ascii?Q?g1T51civVTdVuMmy3AvA2PdzNDKCfpjb5c10arT8ojqm+XutSbkKhXbLQ69v?=
 =?us-ascii?Q?lDOgpV7IVaqByHEq+jUicrbJRv8WvxHSsN81vRI+MNzdmJqG6UNOKNzdYRg8?=
 =?us-ascii?Q?p6YD4p8mV4PeMlb3RUGJ8HbPzIz9/jyWM/8HNougENToyprsHIE6APHodPR9?=
 =?us-ascii?Q?b0n7YX0EYw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e300766-f173-4a56-ba4d-08da1ef03414
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 14:57:04.2666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OYQfrlztNPD4fnHXg2QbTEmP73RSshxE2aERxQo4+dWGa35U6uzIoS/+X0J+WufuKQNLrO+UUo5yYdeRAiMkQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5499
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Apr 14, 2022 at 11:11:01AM +0200, Borislav Petkov wrote:
> On Wed, Apr 13, 2022 at 07:40:39PM +0000, Yazen Ghannam wrote:
> > I think the init logic breaks here. MCE now gets enabled before clearing old
> > errors. So it's possible that the old errors get overwritten by new ones.
> 
> Err, I don't understand. CR4.MCE bit description has:
> 
> "Regardless of whether machine-check exceptions are enabled, the
> processor records enabled-errors when they occur."
> 
> I'm guessing enabled errors are those for which the respective bits in
> the MCi_CTL banks are set. And I think the CPU comes out of reset with
> those bits set.
> 
> So the overwriting will happen regardless.
> 
> The only difference here is that "[s]etting MCE to 1 enables the
> machine-check exception mechanism." So you'll get a #MC raised vs
> shutdown on a fatal error.
> 
> Or am I missing an angle?
>

I agree with you about the CR4.MCE statement. But MCi_CTL needs to be set by
system software. The reset value is '0' at least on AMD systems.

Here's a example scenario.

1) OS has fully booted.
   a) MCi_CTL, MCG_CTL, CR4.MCE are all enabled.
2) Fatal MCA error occurs causing hardware-initialzed reset. No OS handling.
   a) MCA state info is warm reset persistent.
   b) MCi_STATUS, MCi_ADDR, etc. have valid info.
   c) MCi_CTL, MCG_CTL, CR4.MCE are all set to reset value: '0'.
3) OS, or optionally BIOS, polls MCA banks and logs any valid errors.
   a) Since MCi_CTL, etc. are cleared due to reset, any errors detected are
      from before the reset.
4) MCi_STATUS is cleared to discard old error information.
5) MCA is initiliazed (MCi_CTL, MCG_CTL, CR4.MCE, etc.). Any error detected
   now is a new error from this session.
 
> > > @@ -1791,6 +1761,9 @@ static void __mcheck_cpu_check_banks(void)
> > >  		if (!b->init)
> > >  			continue;
> > >  
> > > +		wrmsrl(mca_msr_reg(i, MCA_CTL), b->ctl);
> > > +		wrmsrl(mca_msr_reg(i, MCA_STATUS), 0);
> > 
> > Same idea here. STATUS should be cleared before turning on reporting in a bank
> > using MCA_CTL.
> 
> Look at the current code. Called in this order:
> 
> __mcheck_cpu_init_clear_banks:
>         wrmsrl(mca_msr_reg(i, MCA_CTL), b->ctl);
>         wrmsrl(mca_msr_reg(i, MCA_STATUS), 0);
> __mcheck_cpu_check_banks
> 	rdmsrl(mca_msr_reg(i, MCA_CTL), msrval);
>         b->init = !!msrval;
> 
> STATUS *is* cleared after MCA_CTL now too.
> 
> If this ordering is wrong - and it sounds like it is - then this needs
> to be a separate patch and Cc: <stable@vger.kernel.org> and needs to go
> in now.
>

I agree. The Intel SDM and AMD APM have the following procedure, in summary.

1) Set MCG_CTL
2) Set MCi_CTL for all banks
3) Read MCi_STATUS and log valid errors.
4) Clear MCi_STATUS
5) Set CR4.MCE

I don't know of a reason why STATUS needs to be cleared after MCi_CTL is set.
The only thing I can think of is that enabling MCi_CTL may cause spurious info
logged in MCi_STATUS, and that needs to be cleared out. I'm asking AMD folks
about it.

Of course, this contradicts the flow I outlined above, and also the flow given
in the AMD Processor Programming Reference (PPR). I wonder if the
architectural documents have gotten stale compared to current guidelines. I'm
asking about this too.

Tony,
Do you have any thoughts on this?

> > One downside though is that the system goes longer with CR4.MCE cleared. So
> > there's greater risk of encountering a shutdown due to a machine check error.
> 
> Yeah, I don't think the couple of msecs matter.
>

Okay, yeah then maybe there should be another small patch to bring the init
flow closer to x86 documentation.

Thanks,
Yazen
