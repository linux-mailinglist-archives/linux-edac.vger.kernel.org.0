Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D924B4D3C65
	for <lists+linux-edac@lfdr.de>; Wed,  9 Mar 2022 22:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiCIVvR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 9 Mar 2022 16:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbiCIVvR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 9 Mar 2022 16:51:17 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2054.outbound.protection.outlook.com [40.107.100.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1712C0853;
        Wed,  9 Mar 2022 13:50:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZU0pwOGMfv0BIu8a1kTqfGAddH4ID47bclV1MXT9HCh+Hgzn4N81yNSGzC/ZbXYo1zxh1jN1T7T2OdyNzoNljqTCmgJeSl42xC19mrUw+H1eAC68GzsM7VYlFu0MJ1AEbV7svL3d1e57A+Io4WQJFMHEmU/kB37pcDYW0qCao9F4/lllbp20BCvMymSSoBeIugJVz//utNT1Z6RyM8KRqcu/FjkgN3Ju0T0FdUksBPtQ4OQeXo+Vn9cllQm7ySrNSnjh6iDYExuX1fRMwgiZZw1nEUhPBNFQ1wV16EsgcI//4Pps2mMjtVMyDlZ4tuMWGVS3qmB+JwSP6SKLMnY3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HScW5Y1oqxNJSk80j3wZoQ5nIn2w1S62e++/FTCdVkU=;
 b=MPQw/IWPbU6ROVtqYbub+eDnlYVlVPaiagHG7ZBolIMf/nwtYnKsRgrBeEkE4g2rv8u73kieJ+nCZv8HB3N9tWuH8LwcAqHKnog/iDpOoJKArT2GvUyBe7h0oOVYBTsdubBZFt6cTQl5duUcUVBhtqj6Dn8QwlEjF5D4epVoE7/DF+7u2C3URIPzGG0+M4oG2Kts1GEO0Mxs4D/XuRNSXxQrreFGPKv9TpYpceqYQhOKESSHRqZbLhXMbLZI/1ufDwmMLMBGp0lMNSO0m2H7S9kkaOG6+i4+NN9qxG5lYIsif0gaZ2rFOWDScR71pscTZdI7toeNcORX7QDSDQUnzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HScW5Y1oqxNJSk80j3wZoQ5nIn2w1S62e++/FTCdVkU=;
 b=CULTOnJt8vcf13XW2w/dfIw3Q++8zuZPfPJDO/Y53n6pExlGQ3JtIX6anvcVFULCYRumUdl2mb46BSqzKblDhtU47DhXfbKGpKlY1gza49rEgf4wnsi0ZnoHJq1251teM+c4IBHeG5eQJY/7qxTZPVbv3POLubVGNRCcUWIeP+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BY5PR12MB4855.namprd12.prod.outlook.com (2603:10b6:a03:1dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Wed, 9 Mar
 2022 21:50:12 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ad74:927:9e6:d2cd]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ad74:927:9e6:d2cd%2]) with mapi id 15.20.5038.029; Wed, 9 Mar 2022
 21:50:11 +0000
Date:   Wed, 9 Mar 2022 21:50:06 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v4 07/24] EDAC/amd64: Define function to dehash address
Message-ID: <YikhDoGD+V7OdBq4@yaz-ubuntu>
References: <20220127204115.384161-1-yazen.ghannam@amd.com>
 <20220127204115.384161-8-yazen.ghannam@amd.com>
 <Ygbng0RZ0Pu1fOFj@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ygbng0RZ0Pu1fOFj@zn.tnic>
X-ClientProxiedBy: CH0P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::18) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2d982c5-9176-4ee9-42ed-08da0216c92d
X-MS-TrafficTypeDiagnostic: BY5PR12MB4855:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4855F2E2FDC9B697B10FB935F80A9@BY5PR12MB4855.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f6tzYTXxAzZ49XNUgRtiLKNmygcVrayu6vEp+TikxdgxjFt6pnuSBVcLDpu5Ve7m7lk885x77d/R71nwwVjz+cn0GtEFSHL5nCdq4aoFiHbb3sonYSK4bzoMc8962GSpXW2QqoWNCl8A8/9Mj6xk9ZiJACYdMImQrovAbG7VSdQ2q//HBDqPt9iMhZAMPH+iT/hlhl/0jJNoJVcBVB9JwRqA/gaLokCMIcvW5uiymfTtZ+ke3wZ1rIaS1cEsMAb4BN2ObEI/qj2Nb1rtw9db+lQ8d2fXWIQwN0zUqQOaCSdQrUdWxkAgYAIAi4uvcSNfIIot1C0sYF4+e4A4jb4tQwLBAFS8u3cbNxunQapEzaHiWoRNZnI3sQyuHk6QheV7/hTm7XWhPGoqxtKdMGHzy/5lkiKwiJhFyaIwZ4ACpXDBVNPbX8OUI42xkn+DrXSsLCO8egM1qxdDFPkkARkyzdXa6H2HJZTCJWTCQeMsvChDPfi1t5MoA9pyARpIosZQr1Zy6K5gEDV0PiguGAj+Vzy+k7ea+pJQO+TasG0iyv9iJJWBLF5wCphD9+V0tHwEYiu+mIiSk26l++TClcZJnFHOpMdP+ZieIfHTSsV49KgNREAhiAhB5r+GU0IFP5MgC+fSSN1vKHxQy9II1SF/PggVdaonG+I2BYUYY420vtNDDH7o9NaCksA9fw9GnC5EFQzAHpy9WK9DLI/XCAzmUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(38100700002)(186003)(26005)(9686003)(6666004)(6512007)(6506007)(6486002)(8676002)(8936002)(83380400001)(508600001)(2906002)(316002)(33716001)(6916009)(66556008)(66476007)(66946007)(86362001)(44832011)(5660300002)(4326008)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DGSPn1n49K4SSXuT2QJCENStxnyuON/o8GI6zp+DHDu0Z5I09ZllmZoGUf38?=
 =?us-ascii?Q?sCdrNqRyOVRlckTXwKIOzmWN9OgrPWmAJleHN/gs5cdc3zgNQhaPaPoSWH3P?=
 =?us-ascii?Q?/WOSV/dDlxwcazkVlv9AIL6IdWgl2SaDYzV26nZgsY8Q7sIQTFCwo6hjsGLh?=
 =?us-ascii?Q?rBBBr80NbHtSDkcXHf9l0KcyVM5CW/sn9TQMkK/WtL+iRv0TwJJFExWK1xlA?=
 =?us-ascii?Q?hNMha9tjrEnUr5dzuuq0HdhoQaCND7vzHfPXl4gEao8Dn10Gb0m3egXOtzER?=
 =?us-ascii?Q?jPeVVMcnyUZy4TtoweN1vsvAhK0Dr+YjxymKS0721bJpcdtc3Ce121H0A1J1?=
 =?us-ascii?Q?8wltqRuEXCQzy+xIbV2Q7+5QaiAQNcakeTc5gKKloSV9x3/HguzUcCa6yv9d?=
 =?us-ascii?Q?4Gf5iiqBGNMlQN1vhkvhdrtyL2jvcnhO0/nXHh50dxz12PDwiQ4tsBTZj5uh?=
 =?us-ascii?Q?HIu3VSjLlV4V8lYxMg7rFHi5rTuBwACE2A4UgkmADXShrdP4h18J9A0mzcck?=
 =?us-ascii?Q?iD1jIL0kDvrDAmd2EVhb4KEx/A6M0WEZk47UXlyJ5rqFtxZmx1PwMi2cw6is?=
 =?us-ascii?Q?S2uxt5drvaiUD/goPBNJvGHTYgJVQTvqlS7uLuoOwE5fXXTg+Iy6YF/MfaiG?=
 =?us-ascii?Q?qu0Dxlaq1W/puOxSCkVuqugxjNXk/HK6N8JgNKMcXM7cl+jqtdz/RIqBOATd?=
 =?us-ascii?Q?x2BXQgICA1+dE6Wqot7SIFdvS/oJOGYISR8Tb/P1cyfqq/5oHq4SEAeawVZ8?=
 =?us-ascii?Q?JQetgscSO6740qVaZAEYGy+BxGzxQc8vQZ39yPT6cQlLJRKydAhT6tI6dkec?=
 =?us-ascii?Q?OdDPFRo2unLnRPC4HIU5xhKSCUjxPDzPa4sMdpW3899d3HJvB5MuM1jTm35J?=
 =?us-ascii?Q?ymkfEqLQecNpb3OZkq01QDeI6lVVYlSw6PJa9yJwPdRtgZA06Uc662102FPS?=
 =?us-ascii?Q?IAxODbxTOdCX3j2USnZHqGnuUQfabpaeVRTW3E18OAsA776bZZD8sZLnbtqo?=
 =?us-ascii?Q?hrwtVFG0/QSk0aTpEH0CievTy0YrxWmn69vGn38yeYQpfeu/5oRLlsezg7xH?=
 =?us-ascii?Q?i1uVtTo2egI+t55qYuQebsOKdhlC8G9qHwUYDdQaLgCAmVdYRKrHcFDfTn04?=
 =?us-ascii?Q?miWym+W+i3qiByUABLJnUgy3h+UzAHOxVrJTjaOaKsjNiXvJTegb1bDrzl3y?=
 =?us-ascii?Q?VG/8H2rfgzvha+3yqSpnj+xkqYbG3NkCHAyGw0GMUkfhVG4TYYNOHbs8Rwoc?=
 =?us-ascii?Q?mjbmyTdM7QI24aypygDqGLENi6gu9vdYG9Jxx56P0h2gkrXngcvzWcfyEhVS?=
 =?us-ascii?Q?L2qYKpo9IMRVDLfdSy1u1ylQmpTers691SjnJf7tCcSif42FNx8B06gunesk?=
 =?us-ascii?Q?7IUeNwJ74FPeiPSZmjSkQTq5lq/qULe+JExqxyurHjpHm9GyvN+1/r/katVg?=
 =?us-ascii?Q?y1m71oM2FASkYDIBk7E5nscMkHKsomY5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d982c5-9176-4ee9-42ed-08da0216c92d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 21:50:11.6100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Jbfk2PHIx+Z6jBbqdYSdX8FNZwzWpQEfIbIDO1I/S2S5TpscrbA0ikkOUfcp5ESAM+OMSQdM1QK/f3dGY1Hng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4855
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Feb 11, 2022 at 11:47:31PM +0100, Borislav Petkov wrote:

...

> > --- a/drivers/edac/amd64_edac.c
> > +++ b/drivers/edac/amd64_edac.c
> > @@ -1077,7 +1077,7 @@ struct addr_ctx {
> >  	u8 map_num;
> >  	u8 intlv_addr_bit;
> >  	u8 cs_id;
> > -	bool hash_enabled;
> > +	int (*dehash_addr)(struct addr_ctx *ctx);
> 
> A function pointer in a context struct?!
> 
> > @@ -1357,18 +1372,9 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
> >  		goto out_err;
> >  	}
> >  
> > -	if (ctx.hash_enabled) {
> > -		/* Save some parentheses and grab ls-bit at the end. */
> > -		hashed_bit =	(ctx.ret_addr >> 12) ^
> > -				(ctx.ret_addr >> 18) ^
> > -				(ctx.ret_addr >> 21) ^
> > -				(ctx.ret_addr >> 30) ^
> > -				ctx.cs_id;
> > -
> > -		hashed_bit &= BIT(0);
> > -
> > -		if (hashed_bit != ((ctx.ret_addr >> ctx.intlv_addr_bit) & BIT(0)))
> > -			ctx.ret_addr ^= BIT(ctx.intlv_addr_bit);
> > +	if (ctx.dehash_addr && ctx.dehash_addr(&ctx)) {
> 
> So you can just as well do:
> 
> 	if (ctx->intlv_mode == 8)
> 		dehash_addr();
> 
> And dehash_addr() can inside determine whether df2 or df3.
> 
> Btw, that 8 looks like magic. It should be a #define.
> 
> What you have now looks a bit weird with those function pointers lumped
> together with those other members of addr_ctx. Dunno, maybe it'll make
> more sense when I read the rest first...
>

Yeah, I think I got carried away with the function pointers. :P

The functions in the context struct are set based on interleaving mode rather
than Data Fabric version. Which is why it doesn't work to include them in the
"df_ops".

But I can do something like you suggest. There will be an unconditional call
to dehash_addr(). Helper functions will be called for specific interleave
modes. Otherwise, it'll return 0 if hashing isn't used.

Thanks,
Yazen 
