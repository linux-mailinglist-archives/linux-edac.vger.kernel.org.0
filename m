Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64AAED3D34
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2019 12:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfJKKVF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Oct 2019 06:21:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59936 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfJKKVF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Oct 2019 06:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qti+5pZBdvQNuWk/xly3sdA3/A5zKsS2T8r+qwx9wyE=; b=ofgUsQR69ol2W/cQ6XmPzk6aE
        WUDBGY/xe93HRgE1/2DPR2PUDwE/plCoaXA9Odk/VQ1C7NYPJ/TaYWappQPH8b1WIAqEtRogv8o7j
        JS2FzPM6hCOFZwBAoqKiepoKlWimQzctydkeoPeAtzinh88vPku4iNYHtwHEBw76aQIQ2pyXXKRbT
        5V6AsyOd6VNsvJvrwN2ydQmubzLxZsP2C6Edj5kPvLH0LcnGrbBBKbABXR4XljlqdkrkXbWAjJUgq
        LuSk8HA5ML0yJd/e3BiF2zEGNT44qGTo4BTYaeR2ErpwenTEUzUkFs/mFm0ZKQN2Gm0HuWk0C7l+y
        gNepZ9VGQ==;
Received: from 177.17.141.107.dynamic.adsl.gvt.net.br ([177.17.141.107] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIs2g-0004pr-4f; Fri, 11 Oct 2019 10:21:02 +0000
Date:   Fri, 11 Oct 2019 07:20:57 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Robert Richter <rrichter@marvell.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/19] EDAC, mc: Reduce indentation level in
 edac_mc_handle_error()
Message-ID: <20191011071920.3fb8c45c@coco.lan>
In-Reply-To: <19dc4500bbfbb9d09f9730764a2b59353534358d.camel@perches.com>
References: <20191010202418.25098-1-rrichter@marvell.com>
        <20191010202418.25098-6-rrichter@marvell.com>
        <19dc4500bbfbb9d09f9730764a2b59353534358d.camel@perches.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Thu, 10 Oct 2019 15:10:53 -0700
Joe Perches <joe@perches.com> escreveu:

> On Thu, 2019-10-10 at 20:25 +0000, Robert Richter wrote:
> > Reduce the indentation level in edac_mc_handle_error() a bit by using
> > continue. No functional changes.  
> 
> Seems fine, but trivially below:
> 
> > diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c  
> []
> > @@ -1171,37 +1171,38 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,  
> []
> > +		strcpy(p, dimm->label);
> > +		p += strlen(p);
> > +		*p = '\0';  
> 
> This *p = '\0' is unnecessary as the strcpy already did that.

True, but better to put it on a separate patch, as it makes
easier to review if you don't mix code de-indent with changes.

Also, maybe there are other occurrences of this pattern.

Thanks,
Mauro
