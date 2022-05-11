Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4C05230B8
	for <lists+linux-edac@lfdr.de>; Wed, 11 May 2022 12:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbiEKKfB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 11 May 2022 06:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiEKKfB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 11 May 2022 06:35:01 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DEB68992;
        Wed, 11 May 2022 03:34:57 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B865E1EC053F;
        Wed, 11 May 2022 12:34:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652265291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xYwFWjunZwz78iNmNmCSFKXQO+ezhvDDENrdfQAs/3A=;
        b=YC4CtV111oxmhi8zZw1doNUkxyupALR4xAGmcVk9AYreCBsInPG57v9F9XYd6X5vrzjG6X
        /KmlHucPRldcE3+deCqtNHqVuXErF3C9LSnRFfrVtmyFiWk7QJFCPeVzMBlx+QaIkbapBf
        hHIv02z4+o9WKtkfkfb8APlsmonG8yE=
Date:   Wed, 11 May 2022 12:34:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Smita.KoralahalliChannabasappa@amd.com, muralidhara.mk@amd.com,
        naveenkrishna.chatradhi@amd.com
Subject: Re: [PATCH 04/18] EDAC/amd64: Remove PCI Function 0
Message-ID: <YnuRUsAcnzT4Advm@zn.tnic>
References: <20220509145534.44912-1-yazen.ghannam@amd.com>
 <20220509145534.44912-5-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220509145534.44912-5-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, May 09, 2022 at 02:55:20PM +0000, Yazen Ghannam wrote:
> @@ -3287,26 +3276,12 @@ static void decode_umc_error(int node_id, struct mce *m)
>  /*
>   * Use pvt->F3 which contains the F3 CPU PCI device to get the related
>   * F1 (AddrMap) and F2 (Dct) devices. Return negative value on error.
> - * Reserve F0 on systems with a UMC.
>   */
>  static int
>  reserve_mc_sibling_devs(struct amd64_pvt *pvt, u16 pci_id1, u16 pci_id2)
>  {
> -	if (pvt->umc) {
> -		pvt->F0 = pci_get_related_function(pvt->F3->vendor, pci_id1, pvt->F3);
> -		if (!pvt->F0) {
> -			edac_dbg(1, "F0 not found, device 0x%x\n", pci_id1);
> -			return -ENODEV;
> -		}
> -
> -		if (!pci_ctl_dev)
> -			pci_ctl_dev = &pvt->F0->dev;
> -
> -		edac_dbg(1, "F0: %s\n", pci_name(pvt->F0));
> -		edac_dbg(1, "F3: %s\n", pci_name(pvt->F3));
> -
> +	if (pvt->umc)

I don't like the sprinkling of those checks everywhere. And
hw_info_get() has those checks too. I think it would be cleaner if
hw_info_get() would call a df-specific function for fam 0x17 and later
and do the setup there cleanly:

hw_info_get:

	if (pvt->fam >= 0x17)
		return hw_info_get_df(pvt);

and so on.

Btw, I completely agree with leaving the old code as it is.

And I obviously like the code removal, ofc.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
