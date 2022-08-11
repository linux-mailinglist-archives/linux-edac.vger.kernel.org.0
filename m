Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3232058F913
	for <lists+linux-edac@lfdr.de>; Thu, 11 Aug 2022 10:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbiHKI3s (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 11 Aug 2022 04:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbiHKI3o (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 11 Aug 2022 04:29:44 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A1F8A7C6;
        Thu, 11 Aug 2022 01:29:43 -0700 (PDT)
Received: from zn.tnic (p200300ea971b9870329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:9870:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 86DEC1EC04DF;
        Thu, 11 Aug 2022 10:29:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660206577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5PuTsblVh83NGZYPqHKM9oPxgYPO8vPv5belNAU2Cv4=;
        b=JXAQHyJbUZe+T0dZK01NGhKmSZWCyuCmFniCO7F+auJu2FU5kjpDw1Cdx2EClLbfI10V5p
        GvdqtvHJgVFy/1hUGNu4m+yLPdWoYsvgQuLGhbsMfAMmZ8TaZ+WB4MFKBP5yhK5NfHVaK0
        k1eE1atd8IEgQz1v02u6q18zCmZRajQ=
Date:   Thu, 11 Aug 2022 10:29:32 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        Doug Thompson <dougthompson@xmission.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] EDAC: Fix some refcount leaks
Message-ID: <YvS97Ixj2cbOBjek@zn.tnic>
References: <20220512075906.21915-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220512075906.21915-1-linmq006@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, May 12, 2022 at 11:59:06AM +0400, Miaoqian Lin wrote:
> kobject_init_and_add() takes reference even when it fails.
> According to the doc of kobject_init_and_add()
> 
>    If this function returns an error, kobject_put() must be called to
>    properly clean up the memory associated with the object.
> 
> Fix this by calling kobject_put() when kobject_init_and_add() fails.
> 
> Fixes: b2ed215a3338 ("Kobject: change drivers/edac to use kobject_init_and_add")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> Changes on v2:
> - fix wrong label
> v1 link: https://lore.kernel.org/all/20220511081402.19784-1-linmq006@gmail.com/
> ---
>  drivers/edac/edac_device_sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/edac_device_sysfs.c b/drivers/edac/edac_device_sysfs.c
> index 9a61d92bdf42..a48142a8ea6f 100644
> --- a/drivers/edac/edac_device_sysfs.c
> +++ b/drivers/edac/edac_device_sysfs.c
> @@ -542,7 +542,7 @@ static int edac_device_create_block(struct edac_device_ctl_info *edac_dev,
>  		edac_dbg(1, "Failed to register instance '%s'\n", block->name);
>  		kobject_put(main_kobj);
>  		err = -ENODEV;
> -		goto err_out;
> +		goto err_on_attrib;
>  	}
>  
>  	/* If there are driver level block attributes, then added them

Actually, on a second look, that's not necessary:

                err = edac_device_create_block(edac_dev, instance,
                                                &instance->blocks[i]);
                if (err) {
                        /* If any fail, remove all previous ones */
                        for (j = 0; j < i; j++)
                                edac_device_delete_block(edac_dev,
                                                        &instance->blocks[j]);
				^^^^^^^^^^^^^^

that cleans up the kobjects.

> @@ -640,7 +640,7 @@ static int edac_device_create_instance(struct edac_device_ctl_info *edac_dev,
>  		edac_dbg(2, "Failed to register instance '%s'\n",
>  			 instance->name);
>  		kobject_put(main_kobj);
> -		goto err_out;
> +		goto err_release_instance_kobj;
>  	}
>  
>  	edac_dbg(4, "now register '%d' blocks for instance %d\n",

Ditto.

But keep lookin' :-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
