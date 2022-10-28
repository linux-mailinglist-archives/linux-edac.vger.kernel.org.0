Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE03861158C
	for <lists+linux-edac@lfdr.de>; Fri, 28 Oct 2022 17:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiJ1PJi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 28 Oct 2022 11:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiJ1PJg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 28 Oct 2022 11:09:36 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7C3A18A;
        Fri, 28 Oct 2022 08:09:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F0E99CE29B1;
        Fri, 28 Oct 2022 15:09:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0595C433D6;
        Fri, 28 Oct 2022 15:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666969767;
        bh=+And50KHKSn3m76HqlqA8nvmePFd6relgoKOvl+hpKI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I/ASjfgehSo4ia/bn8uQMS9mDS/rdlbfxBFv35E66ofDLBDLV5DqkavvEOBcRaa7x
         fWfvMHR/EmEvuXW76QE4E96xJ4PMhhqmAA7kqjHKmmS0FnyErXL65GKcSu60nV53W+
         xsR7Qvup2iUstYVJ0vSZvyGals1RACRmXrlVqKnXWrNesn2MKJ9eqS3YWaMkqmDOOg
         sE7tba6lqyaOxhNlOlN+ZP2LkxV9EjzvyGKO6Y3ODEE4kGIClK9mJfuPO0qTnX+7aZ
         RrPy82ybdU/JUdmYZ6fjhsnaZSsrLELaW9GeVy+JMDUF5GsoEFRTEsYO1Il7mon3cL
         YQHPWwtSILTIg==
Date:   Fri, 28 Oct 2022 16:09:21 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Make Mauro reviewer
Message-ID: <20221028160921.5148909c@sal.lan>
In-Reply-To: <Y1vnr11yG5b0nyA8@zn.tnic>
References: <20220926180343.23346-1-bp@alien8.de>
        <Y1vnr11yG5b0nyA8@zn.tnic>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Fri, 28 Oct 2022 16:31:11 +0200
Borislav Petkov <bp@alien8.de> escreveu:

> On Mon, Sep 26, 2022 at 08:03:43PM +0200, Borislav Petkov wrote:
> > From: Borislav Petkov <bp@suse.de>
> > 
> > Mauro hasn't really been maintaining EDAC for a long while now. Make him
> > a reviewer instead.
> > 
> > Signed-off-by: Borislav Petkov <bp@suse.de>
> > ---
> >  MAINTAINERS | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9d7f64dc0efe..935b42c7f52f 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7314,9 +7314,9 @@ F:	drivers/edac/thunderx_edac*
> >  
> >  EDAC-CORE
> >  M:	Borislav Petkov <bp@alien8.de>
> > -M:	Mauro Carvalho Chehab <mchehab@kernel.org>
> >  M:	Tony Luck <tony.luck@intel.com>
> >  R:	James Morse <james.morse@arm.com>
> > +R:	Mauro Carvalho Chehab <mchehab@kernel.org>
> >  R:	Robert Richter <rric@kernel.org>
> >  L:	linux-edac@vger.kernel.org
> >  S:	Supported
> > --   
> 
> Queued.

Ok.

Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>
