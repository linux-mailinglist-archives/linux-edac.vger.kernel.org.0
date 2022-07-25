Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2F257FDCF
	for <lists+linux-edac@lfdr.de>; Mon, 25 Jul 2022 12:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbiGYKpb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 25 Jul 2022 06:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234822AbiGYKp0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 25 Jul 2022 06:45:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05764CE05;
        Mon, 25 Jul 2022 03:45:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EEE460B6E;
        Mon, 25 Jul 2022 10:45:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3654C341C8;
        Mon, 25 Jul 2022 10:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658745924;
        bh=8FN7wqx7Bn6NDn4fHaqkWhzadFtp7D8Qq1pnKah2Auc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BsHkSMgzSXnEev+OixsDAfFJyitvX0T+kTPo44UA4XMte9zrAEt7yXx1M1D4qiA6K
         Wo5pnCnrdgEfJwhReT6Rdn2i/8A/zjIFtUGwg5jd1BEc9Mf0E6jCDqCNAz2gOuX/BM
         PfEuU61D2lrGnjoNQiF1uAQzd6r+Rv6evCnHlGh3Ku6ZX1t0hP3wWBlVJttTxhxCmy
         43PKIxamZ3p9tA+qQj/sdOai5xu7wMe+DVsQMPujNiRgIau4bNLph4++T3DC/DpXJ1
         fkIxS123/fMQeXqUV7at2lcZO4ThphXhDhPfQiHYwVn+x6cdwb5TeJrRb0Na5htz05
         ZsNvizU2N6N8w==
Date:   Mon, 25 Jul 2022 12:45:18 +0200
From:   Robert Richter <rric@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Toshi Kani <toshi.kani@hpe.com>, mchehab@kernel.org,
        elliott@hpe.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] EDAC/ghes: Fix buffer overflow in ghes_edac_register()
Message-ID: <Yt50Pp3kQRCtSqw6@rric.localdomain>
References: <20220721180503.896050-1-toshi.kani@hpe.com>
 <YtqkMicKdZdPdUWB@zn.tnic>
 <Yt5oAjbZ5Koy9v5i@rric.localdomain>
 <Yt5s/f/jyRcFY1Md@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt5s/f/jyRcFY1Md@zn.tnic>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 25.07.22 12:14:21, Borislav Petkov wrote:
> On Mon, Jul 25, 2022 at 11:53:06AM +0200, Robert Richter wrote:
> > The dimm->label buffer must be pre-initialized zero. This broke with:
> > 
> >  b9cae27728d1 EDAC/ghes: Scan the system once on driver init
> > 
> > since krealloc/krealloc_array() does not zero out the new allocated
> > buffer for struct dimm_info in enumerate_dimms(). This uninitialized
> > broken struct is then copied in ghes_edac_register() to the final
> > dimm_info destination. Originally, before b9cae27728d1, the struct was
> > zero initialized with kzalloc'ed by edac_mc_alloc() and directly used.
> > Now, that a copy is created first, this copy must be also zero
> > initialized.
> > 
> > IMO this is the proper fix:
> 
> Maybe, but this needs fixing too:
> 
> 	/* both strings must be non-zero */
> 	if (bank && *bank && device && *device)
> 
> Obviously one of those strings are zero coming from that BIOS...

But the label is pre-initialized in edac_mc_alloc_dimms():

	p = dimm->label;
	n = snprintf(p, len, "mc#%u", mci->mc_idx);

You check if the label is emtpy when copying it in
ghes_edac_register():

	if (strlen(src->label))
		memcpy(dst->label, src->label, sizeof(src->label));

So if there is nothing that comes from the bios, this default label
string from edac_mc_alloc_dimms() will be used.

If you write "N/A" to the label instead, the sysfs dimm_label values
wont be unique any longer between dimms, which might break existing
applications.

-Robert

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
