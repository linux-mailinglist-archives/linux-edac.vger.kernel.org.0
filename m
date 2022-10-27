Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1474960FB0E
	for <lists+linux-edac@lfdr.de>; Thu, 27 Oct 2022 17:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbiJ0PBv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Oct 2022 11:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbiJ0PBt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 27 Oct 2022 11:01:49 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E43F160209;
        Thu, 27 Oct 2022 08:01:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BoAoUPTJxSNPJQJxbOSn+JNOx8/n3eTeqq8wIzDZi6FO9ime1+L89c9O106mGGR55ghcPkyHXjMho8NtqHkVQtE0jepWR/C1VRy1k7wod40rQ9BTAfpxb1Va0zjeUVIt+gAhngyY1helzPLCABVuPYvu72xkFvtngGIBKpQcAyZtrfuVHUl4rQtegxr20rEN2aTA3qvB3pDxcSyOiFJKs6YyQCksGJ7ITfdQ3uDOtE6qtFOqiBM+Y9geUTZfqW75ealDTmDjSHVmTd1L8xmV9PIHAh3wNOAnR7WOI44AQOYOgJDEX25OpNN1vKlwPPbriR/wUc4dAMy5mJjTSXOeaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsAcQnR8MkM2EWr/Cb1rlmy46gbfMu2kBvRUNr2yJsk=;
 b=GvnEQfIZk+4NwC3ynGZ+jgYjo9CVpsBoccY8+1FRvnkVthq4Rbz2nNDDp1Tzzn0YIa0Z7+Mz4Q/oMJC61BxD3Iuif6R50QxlSloSrmgGTBHmYWndjpeEQNPYW+m74od034I5jdrCgKjZGfICFQ29J0NJVSrEJT++HfLWPRn8jqPfh1CWeQi+RkgpcRkjIduRJwbORnQAkH76QNkiR74slGU6TwG/am9t6t6oONRpQmrODNpMjQwe6vJfqoQiXKBjNczUVZNJw7AVm5biGWu5YBi8xUMXBwC7Mcd4PM8rzQY+J+ZG/X8LpqWaUvlEBIq4/viGNHzOmzyYWkIjRESNZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsAcQnR8MkM2EWr/Cb1rlmy46gbfMu2kBvRUNr2yJsk=;
 b=cPC/l6MX3RCZkglLjWSmId/C9xK48wR33rIxKVCdD8EZFvT9tswdsjiDT+NWAagPZw8e6+JR00qCVZETEPbxylbJ9RdDtXOcpaVHGfOF9fGJ9thUJa6EOFOBEEMKwiiPs91qcnyhZ2UOZVqxN30K9XXPkVosGiIDyg22Jkt/Bf0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Thu, 27 Oct
 2022 15:01:46 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ee94:4f22:751d:278a]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ee94:4f22:751d:278a%7]) with mapi id 15.20.5746.021; Thu, 27 Oct 2022
 15:01:46 +0000
Date:   Thu, 27 Oct 2022 15:01:38 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH] x86/MCE/AMD: Clear DFR errors found in THR handler
Message-ID: <Y1qdUvc1774POBi9@yaz-fattaah>
References: <20220621155943.33623-1-yazen.ghannam@amd.com>
 <Y1pvkIJ/Uipxolqy@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1pvkIJ/Uipxolqy@zn.tnic>
X-ClientProxiedBy: CH2PR07CA0025.namprd07.prod.outlook.com
 (2603:10b6:610:20::38) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|BL1PR12MB5753:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d82b598-85e5-4847-acb7-08dab82c2aeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V/S25m7Q6WwiU9iHnxPJYri71RGFDLkcVINSLt90Gg4Cbx/kRveOO4DtqKXHloaJYSCzIjJWSDZJTpla1Zup+BAxvN8qteOFgyrnb6Wg3cjAuR8kOndBWzMIB44K6FxuT3742Uy6AtcQeGQCmXO9fTOTzYwnSX/0T5F7HcUc0vSkH7PA8mzrrxbQK3AQ/74CqTFQC3ah4rUfZsE06tAgjYBB0cwG6TAguRGe+wglinQqbYCg6w7xHatq07h/dsD1UyhvGuxHiiv5+z72fepc9isWzdsmPz6EJMX+2ejZNVbw2y5MT98Itn5U7moIM1El0pQG6fF8o1yCHXyDgE8mAiho438kNJZ6ZDyHPkKi9WY++DOoCShP5YCusKCrR9S2AGP212t1jy/+7sberO1co2Gs0BJvRb5gcrGuu7pMDFSuVQ6/CSGtP7ZCZzxTP4UU1dI3T02Usvt9Gw7zCd0i5ekPKwh1NMvBjh12DbJzrxY+f6yTCXMFkRx9Xckipx/Zj0bPALXlkjkGf5TZ27Z8yywV5DXdTtfqFhX4BXoRldpvHaxZQLDPB716jwVwzOjGeqrSRLLYf42WsM8HSIg9VhCO33Qtx116+TN68kAPt1RsyEvo6LMbrBtl5zxiS0UGwGfQyDBwVAesnDVrx94nMtRr2EKVui/nvfTyzPlm1ZAJGjCWEkf5kxMTN0Z29aV63wRPAwECybwOxqK8Gm0EiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199015)(6916009)(8676002)(38100700002)(41300700001)(4326008)(316002)(6666004)(66946007)(8936002)(6512007)(478600001)(26005)(9686003)(83380400001)(6506007)(86362001)(5660300002)(6486002)(66476007)(186003)(44832011)(66556008)(33716001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a3/vDrZ/QZRogNkIuWOwiSh/l95AYnZucBLBL7aHLQ60YqvkL7JJJoWDQeiK?=
 =?us-ascii?Q?yqXkfuXR2KCLrlrn/eyk+vi9Ij78frrJW1Z4XUOGo3Hat6oycRSPtAlHg4Pt?=
 =?us-ascii?Q?nE+FH5qvg8aWMY9D8t2dKhqUF2d5zoQ6muzmS+xfSjF+ywPSgogGTDoQ2Rcu?=
 =?us-ascii?Q?MFEQHUR+eTpIh3gkjwEFtHEDwvYBEWMkW8UE3By+kLSn92XCQ+k5VkK/G+h3?=
 =?us-ascii?Q?7+x27g/srq84/H5WcLM/FRZcrbNq+IxApswPYfAhZqGaIk6LagsNTeID0tXG?=
 =?us-ascii?Q?ZfgXZet4xKWffgq3vwnl74R8OoK0WwDl8ZQgJZ3EjhQEqdVYbMtqU2aKS6Fd?=
 =?us-ascii?Q?Zp3HfY5OsZ91FHaJUu90KOnhQstC0vTaka8C/5ed1PRtmccAz1mOCSFOB2Qm?=
 =?us-ascii?Q?d7+/9YMAFps71WCqA7PTdhhorSW2FnSMgAkrBh8BqBIeFmvsEzs6EcPnrD3x?=
 =?us-ascii?Q?vtJ7m/eIf+M3I1nd6/Anu8qWzijR9Bp1cCiD5tHhfJ7vgF8bWvledXqtDNl3?=
 =?us-ascii?Q?0zcqMitCMKoq1Mc6qIzjVJj680TmxoaaqBIH4mjsR4dt2fWImyY+1v0acvJ9?=
 =?us-ascii?Q?NW+iEbR6ZX/x+UmtyqP0hU5ahORS5KUonk33NwTfbwnMo3odlsz4CB/bAzP5?=
 =?us-ascii?Q?Jz7RMEjBR5cvOGJQp7tcjBAb4aqVjHPfFl7D69RayQvyIcG7AYanC+2ZMSGQ?=
 =?us-ascii?Q?hywXgz+/FBg/x0u9Shq9IlH2OOwpxlb9hMSdcpDd6rnT2nstInMrEAbOoOXn?=
 =?us-ascii?Q?KkXBr1LX4qE4ghvhUrsWw/1IDSrsQZt+x291zCbWYIl/y9wo8+4sMnnlhVKM?=
 =?us-ascii?Q?aVeDiH87LczFkX/hTeJxJntp1YJwUNVR6zJBzdhEZE2dFsd7dVhsyqWnySlY?=
 =?us-ascii?Q?AdusLvoNX2eXApFKpeMtgCDp/maZrhP5dDbGIepQj/YtT40I8dUZ3GaylhsA?=
 =?us-ascii?Q?GWrgAEVagYn5cGPNpRnJgZdOVbTiBburN9r6GVaC+7y4m/6RHMKCHleR0Nma?=
 =?us-ascii?Q?MoxpZjhZWlDEORrKt+an2+kF+7YLbUlU3YlXak3kQXH5Uq2c353h56A7e81S?=
 =?us-ascii?Q?CHSI1oE4JtCObKhLqm3cGbUYMW58jZuwykTo+M6Ff+7h7JCyNkaIgOjwjRhs?=
 =?us-ascii?Q?6Tj7Djh1lfMIqMmCfq+WQL75oAohkx1hhL9BKBfcRWMYwgZ5AyVKXqWQBdtS?=
 =?us-ascii?Q?kd/xP85dw/g3rXPancO1UB2Zf9ZWnFhThTEBeaftMwcGrSeUrrUvb+WIlCuP?=
 =?us-ascii?Q?VbDxEa/S+kXhIUqPTJoxHT4avDEnbfj7occBnvP5PLQ2Fc+tpiGPTbcp15I+?=
 =?us-ascii?Q?fLsG9etUPbwTpy8CxQp7C7Y2YaGIg1zMHE/RC5o+9HGuMQz2aeT06kgZyeBg?=
 =?us-ascii?Q?FE4ZSxyDuJ9fxlIag/02q1TMg1vIiyORtk16u4w68nqdUkF8E1l+p3UuemXv?=
 =?us-ascii?Q?9CuGaTPhPRqc6uDwt6yQhs1yk5AdgZn27YEH0/7Rz/FfMVYZrAH7Etw1wCyd?=
 =?us-ascii?Q?yle50soddGakFQJFMMiNER+wyRbAnDoN6hGlKGrPEWI8PkwOIKY1YUpSpg9P?=
 =?us-ascii?Q?4+E50r9UXXj7sfGoyrSoe5H8OTzpolyJ8BvJCuDm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d82b598-85e5-4847-acb7-08dab82c2aeb
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 15:01:46.6068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TK+srmqRNZV3At91hT6WcbpBzCM+BKhL9Fh6gSBWce/ctXncJ0nLZfF0AfBgO5BH24C0QqGD8bJhsI4HSrcCdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5753
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Oct 27, 2022 at 01:46:24PM +0200, Borislav Petkov wrote:
> On Tue, Jun 21, 2022 at 03:59:43PM +0000, Yazen Ghannam wrote:
> > AMD's MCA Thresholding feature counts errors of all severites not just
> > correctable errors. If a deferred error causes the threshold limit to be
> > reached (it was the error that caused the overflow), then both a
> > deferred error interrupt and a thresholding interrupt will be triggered.
> > 
> > The order of the interrupts is not guaranteed. If the threshold
> > interrupt handler is executed first, then it will clear MCA_STATUS for
> > the error. It will not check or clear MCA_DESTAT which also holds a copy
> > of the deferred error. When the deferred error interrupt handler runs it
> > will not find an error in MCA_STATUS, but it will find the error in
> > MCA_DESTAT. This will cause two errors to be logged.
> > 
> > Check for deferred errors when handling a threshold interrupt. If a bank
> > contains a deferred error, then clear the bank's MCA_DESTAT register.
> > 
> > Define a new helper function to do the deferred error check and clearing
> > of MCA_DESTAT.
> > 
> > Fixes: 37d43acfd79f ("x86/mce/AMD: Redo error logging from APIC LVT interrupt handlers")
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  arch/x86/kernel/cpu/mce/amd.c | 37 +++++++++++++++++++++++------------
> >  1 file changed, 24 insertions(+), 13 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> > index 1c87501e0fa3..ab1145cf8328 100644
> > --- a/arch/x86/kernel/cpu/mce/amd.c
> > +++ b/arch/x86/kernel/cpu/mce/amd.c
> > @@ -788,6 +788,28 @@ _log_error_bank(unsigned int bank, u32 msr_stat, u32 msr_addr, u64 misc)
> >  	return status & MCI_STATUS_DEFERRED;
> >  }
> >  
> > +static bool _log_error_deferred(unsigned int bank, u32 misc)
> > +{
> > +	bool defrd;
> > +
> > +	defrd = _log_error_bank(bank, mca_msr_reg(bank, MCA_STATUS),
> > +				mca_msr_reg(bank, MCA_ADDR), misc);
> > +
> > +	if (!defrd)
> > +		return false;
> 
> I've zapped that defrd variable:
> 
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index ab1145cf8328..6ae7edea3270 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -790,12 +790,8 @@ _log_error_bank(unsigned int bank, u32 msr_stat, u32 msr_addr, u64 misc)
>  
>  static bool _log_error_deferred(unsigned int bank, u32 misc)
>  {
> -	bool defrd;
> -
> -	defrd = _log_error_bank(bank, mca_msr_reg(bank, MCA_STATUS),
> -				mca_msr_reg(bank, MCA_ADDR), misc);
> -
> -	if (!defrd)
> +	if (!_log_error_bank(bank, mca_msr_reg(bank, MCA_STATUS),
> +			     mca_msr_reg(bank, MCA_ADDR), misc))
>  		return false;
>  
>  	/*
> 
> -- 

Yep, looks good to me. Thanks!

-Yazen
