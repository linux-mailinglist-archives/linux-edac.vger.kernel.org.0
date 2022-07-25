Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA0057FE17
	for <lists+linux-edac@lfdr.de>; Mon, 25 Jul 2022 13:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiGYLJW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 25 Jul 2022 07:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiGYLJV (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 25 Jul 2022 07:09:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3979E1208C;
        Mon, 25 Jul 2022 04:09:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC6CFB80D94;
        Mon, 25 Jul 2022 11:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E78AC341C6;
        Mon, 25 Jul 2022 11:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658747357;
        bh=7s8wumHi7uCMnB5Lfg2/f4FNxAw+WQi+UNCXFTORKmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X5HW/OumUS2GR5HxkR84tIUnt8t6ElnWNHP/sdYrpmK0Wl0mNrHtt7gCjUIw0kN0i
         VbjfGzLg3dw7Y3QtGhgj1tToo/belxF6WRPii2diHisgKlL43xL2aUV+Z4xZN6k0jH
         U6FBEYmDJGLxJJVURlaq+6MyDT+0SB8n8s2nFu+r4E7EqThHZxJode0lJKmzDhtdqq
         ATI4HxVPH9RgYOTPZpP1XuYZ8ctXrWl2HluiFepcc8Cj7pl0dzav47GXGw20m5iFxT
         MIq/UNz+o8Qjkfr6tZY3mBRe6FSIpuccqEHauNOpszD2L8gEQbWK0hiZjdJqtymh0N
         DsmB4S0At0O5A==
Date:   Mon, 25 Jul 2022 13:09:11 +0200
From:   Robert Richter <rric@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Toshi Kani <toshi.kani@hpe.com>, mchehab@kernel.org,
        elliott@hpe.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] EDAC/ghes: Fix buffer overflow in ghes_edac_register()
Message-ID: <Yt5510+uLKzv+Qvt@rric.localdomain>
References: <20220721180503.896050-1-toshi.kani@hpe.com>
 <YtqkMicKdZdPdUWB@zn.tnic>
 <Yt5oAjbZ5Koy9v5i@rric.localdomain>
 <Yt5s/f/jyRcFY1Md@zn.tnic>
 <Yt50Pp3kQRCtSqw6@rric.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt50Pp3kQRCtSqw6@rric.localdomain>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 25.07.22 12:45:24, Robert Richter wrote:
> On 25.07.22 12:14:21, Borislav Petkov wrote:
> > On Mon, Jul 25, 2022 at 11:53:06AM +0200, Robert Richter wrote:
> > > The dimm->label buffer must be pre-initialized zero. This broke with:
> > > 
> > >  b9cae27728d1 EDAC/ghes: Scan the system once on driver init
> > > 
> > > since krealloc/krealloc_array() does not zero out the new allocated
> > > buffer for struct dimm_info in enumerate_dimms(). This uninitialized
> > > broken struct is then copied in ghes_edac_register() to the final
> > > dimm_info destination. Originally, before b9cae27728d1, the struct was
> > > zero initialized with kzalloc'ed by edac_mc_alloc() and directly used.
> > > Now, that a copy is created first, this copy must be also zero
> > > initialized.
> > > 
> > > IMO this is the proper fix:
> > 
> > Maybe, but this needs fixing too:
> > 
> > 	/* both strings must be non-zero */
> > 	if (bank && *bank && device && *device)
> > 
> > Obviously one of those strings are zero coming from that BIOS...

I see now, what you mean here, may be change this:

	snprintf(dimm->label, sizeof(dimm->label), "%s %s",
		 (bank && *bank) ? bank : "N/A",
		 (device && *device) ? device : "N/A");

to:

	snprintf(dimm->label, sizeof(dimm->label), "%s%s%s",
		 (bank && *bank) ? bank : "",
		 (bank && device) ? " " : "",
		 (device && *device) ? device : "");

It keeps the default assignment from edac_mc_alloc_dimms() but changes
we label if one of bank or device is given.

-Robert

> 
> But the label is pre-initialized in edac_mc_alloc_dimms():
> 
> 	p = dimm->label;
> 	n = snprintf(p, len, "mc#%u", mci->mc_idx);
> 
> You check if the label is emtpy when copying it in
> ghes_edac_register():
> 
> 	if (strlen(src->label))
> 		memcpy(dst->label, src->label, sizeof(src->label));
> 
> So if there is nothing that comes from the bios, this default label
> string from edac_mc_alloc_dimms() will be used.
> 
> If you write "N/A" to the label instead, the sysfs dimm_label values
> wont be unique any longer between dimms, which might break existing
> applications.
> 
> -Robert
> 
> > 
> > -- 
> > Regards/Gruss,
> >     Boris.
> > 
> > https://people.kernel.org/tglx/notes-about-netiquette
