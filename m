Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4997719D8
	for <lists+linux-edac@lfdr.de>; Mon,  7 Aug 2023 08:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjHGGCC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 7 Aug 2023 02:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjHGGCC (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 7 Aug 2023 02:02:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609B010F6
        for <linux-edac@vger.kernel.org>; Sun,  6 Aug 2023 23:02:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D64C4614F8
        for <linux-edac@vger.kernel.org>; Mon,  7 Aug 2023 06:01:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1692C433C7;
        Mon,  7 Aug 2023 06:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691388119;
        bh=uo8+tFYw6wpXYV3huWw6KN1IdxTkJNzVIY85nkqD9Fs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dy0ni2/iZjbtw3LiAn5DLLIEIPOIMj+bb1cEx/sK67Z/fcwf0YT/xqYfg3ARSny8g
         EnNMkCXg129XjKbPLlw35C7zuDMPyE1EaUs2yr/vq2LEXLQabfCf+4/5vFP3wLoN2H
         MlQMoQyCLIC1CwzPRFd6Tzb6iZwZjwcSfwTbNdOs=
Date:   Mon, 7 Aug 2023 08:01:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Atul Kumar Pant <atulpant.linux@gmail.com>
Cc:     shubhrajyoti.datta@amd.com, sai.krishna.potthuri@amd.com,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        bp@alien8.de, tony.luck@intel.com, michal.simek@amd.com,
        shuah@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v1] drivers: edac: zynqmp_edac: Updates return value check
Message-ID: <2023080727-wildly-veal-c0fd@gregkh>
References: <20230806130514.159102-1-atulpant.linux@gmail.com>
 <2023080631-salon-banter-31b7@gregkh>
 <20230807023104.GA4030@atom0118>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807023104.GA4030@atom0118>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Aug 07, 2023 at 08:01:04AM +0530, Atul Kumar Pant wrote:
> On Sun, Aug 06, 2023 at 03:37:01PM +0200, Greg KH wrote:
> > On Sun, Aug 06, 2023 at 06:35:14PM +0530, Atul Kumar Pant wrote:
> > > Updating the check of return value from edac_debugfs_create_dir
> > > to use IS_ERR.
> > > 
> > > Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> > > ---
> > >  drivers/edac/zynqmp_edac.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/edac/zynqmp_edac.c b/drivers/edac/zynqmp_edac.c
> > > index ac7d1e0b324c..cefbbafb945e 100644
> > > --- a/drivers/edac/zynqmp_edac.c
> > > +++ b/drivers/edac/zynqmp_edac.c
> > > @@ -351,7 +351,7 @@ static void setup_debugfs(struct edac_device_ctl_info *edac_dev)
> > >  	struct edac_priv *priv = edac_dev->pvt_info;
> > >  
> > >  	priv->debugfs_dir = edac_debugfs_create_dir("ocm");
> > > -	if (!priv->debugfs_dir)
> > > +	if (IS_ERR(priv->debugfs_dir))
> > >  		return;
> > 
> > Again, not correct, sorry.  Please do not make these types of changes.
> > 
> > Why do you feel this is needed at all?
> > 
>     edac_debugfs_create_dir uses debugfs_create_dir that return ERR_PTR.
>     Hence to check the return value by this function I changed null
>     comparison with IS_ERR.

But that's not needed at all, right?

As this check has not ever really worked, why check it at all?

greg k-h
