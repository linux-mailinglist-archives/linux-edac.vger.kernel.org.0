Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787146BFB43
	for <lists+linux-edac@lfdr.de>; Sat, 18 Mar 2023 16:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjCRPjz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 18 Mar 2023 11:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCRPjx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 18 Mar 2023 11:39:53 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD29125A9;
        Sat, 18 Mar 2023 08:39:50 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EDB461EC0752;
        Sat, 18 Mar 2023 16:39:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679153989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TEtvTxGmBN+qkDwx7N9vrJsMEmp2G1KnBU9qR/PDR4Y=;
        b=sg1ESW0u7ohN8CTpZSYruSGt2jTqkaqXScGSw/v3RrTr1SO1z9W/19laqooxSdFGOkMy3y
        4ctKFCjfyh3DS2CstsLkjvck+axcCLAC74isoV0sEufSXHqASwx+KDF9pBLAyrPyOiedL+
        WTwc8/BMsp4E2TBnfdt+j4cPFpJqZMs=
Date:   Sat, 18 Mar 2023 16:39:42 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        muralidhara.mk@amd.com, naveenkrishna.chatradhi@amd.com
Subject: Re: [PATCH v2 10/22] EDAC/amd64: Merge struct amd64_family_type into
 struct amd64_pvt
Message-ID: <20230318153942.GAZBXbPuuJQoDMkhon@fat_crate.local>
References: <20230127170419.1824692-1-yazen.ghannam@amd.com>
 <20230127170419.1824692-11-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230127170419.1824692-11-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jan 27, 2023 at 05:04:07PM +0000, Yazen Ghannam wrote:
> From: Muralidhara M K <muralidhara.mk@amd.com>
> 
> Future AMD systems will support heterogeneous "AMD Node" types, e.g.
> CPU+GPU. Therefore, a global "family type" shared across all "AMD Nodes"

"CPU and GPU types."

...

> +static int per_family_init(struct amd64_pvt *pvt)
>  {
>  	pvt->ext_model  = boot_cpu_data.x86_model >> 4;
>  	pvt->stepping	= boot_cpu_data.x86_stepping;
>  	pvt->model	= boot_cpu_data.x86_model;
>  	pvt->fam	= boot_cpu_data.x86;
> +	pvt->max_mcs	= 2;
> +
> +	/*
> +	 * Decide on which ops group to use here and do any family/model
> +	 * overrides below.
> +	 */
> +	if (pvt->fam >= 0x17)
> +		pvt->ops = &umc_ops;
> +	else
> +		pvt->ops = &dct_ops;
>  
>  	switch (pvt->fam) {
>  	case 0xf:
> -		fam_type	= &family_types[K8_CPUS];
> -		pvt->ops	= &family_types[K8_CPUS].ops;
> +		pvt->ctl_name				= (pvt->ext_model > K8_REV_F) ?

The original test is >=

-	amd64_info("%s %sdetected (node %d).\n", fam_type->ctl_name,
-		     (pvt->fam == 0xf ?
-				(pvt->ext_model >= K8_REV_F  ? "revF or later "
						^^^^^


-							     : "revE or earlier ")

> +							  "K8 revF or later" : "K8 revE or earlier";
> +		pvt->f1_id				= PCI_DEVICE_ID_AMD_K8_NB_ADDRMAP;
> +		pvt->f2_id				= PCI_DEVICE_ID_AMD_K8_NB_MEMCTL;
> +		pvt->ops->map_sysaddr_to_csrow		= k8_map_sysaddr_to_csrow;
> +		pvt->ops->dbam_to_cs			= k8_dbam_to_chip_select;
>  		break;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
