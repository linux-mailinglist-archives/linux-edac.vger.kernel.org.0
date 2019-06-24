Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49A1050AF1
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2019 14:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfFXMlk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Jun 2019 08:41:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57600 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbfFXMlj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 24 Jun 2019 08:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yeZEN/lvAWBOBFz39npagodYTbEtl6pn+EI6Vjjk1so=; b=d6pYxJ/2Y3A0iX35rh9XmUfh0
        gXVobml3SAEoakC8svIyjsbsFSbEYEuDjuVROZ1K9pi7rH3pgNWP4dID2i/Zx4YMmQm+8C05K07Yz
        dRr60kGjU7pUmJfvt9BCnrG3ud6Z8IWw2sPCvJ5jouGkxhm8GBbCzwa1Ld3W6rORotKOu+n91Zc2j
        aFKLCtkyZ5Av/eBHKMlE4j9C0d9WgkLJ6eyHvpLd1nq4n9VmzQpFWtex2EcxnXLMt5cSGEGuyf2jE
        uFCQk01QXsH2bmJBCN+ZoK1GiyM8q61O3DP2/mgKhFm/lGz050ZjEIYm4N4vR/xRaNlQLmyMm+cWh
        UC5umoOmA==;
Received: from [179.95.45.115] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfOHz-0001Mj-6U; Mon, 24 Jun 2019 12:41:39 +0000
Date:   Mon, 24 Jun 2019 09:41:36 -0300
From:   Mauro Carvalho Chehab <mchehab@infradead.org>
To:     Wen Pu <puwen@hygon.cn>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] ras-mce-handler: Add support for Hygon Dhyana family
 18h processor
Message-ID: <20190624094136.1017a6b6@coco.lan>
In-Reply-To: <bdb9763a-b111-1927-9fd2-3fd933b3981d@hygon.cn>
References: <1558616422-22997-1-git-send-email-puwen@hygon.cn>
        <bdb9763a-b111-1927-9fd2-3fd933b3981d@hygon.cn>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Fri, 14 Jun 2019 02:18:10 +0000
Wen Pu <puwen@hygon.cn> escreveu:

> Friendly ping...
> 
> On 2019/5/23 21:00, Pu Wen wrote:
> > The Hygon Dhyana family 18h processor is derived from AMD family 17h.
> > The Hygon Dhyana support to Linux is already accepted upstream[1].
> > 
> > Add Hygon Dhyana support to mce handler of rasdaemon in order to handle
> > MCE events on Hygon Dhyana platforms.

Applied, thanks!

> > 
> > Reference:
> > [1] https://git.kernel.org/tip/fec98069fb72fb656304a3e52265e0c2fc9adf87
> > 
> > Signed-off-by: Pu Wen <puwen@hygon.cn>
> > ---
> >   ras-mce-handler.c | 9 ++++++++-
> >   ras-mce-handler.h | 1 +
> >   2 files changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/ras-mce-handler.c b/ras-mce-handler.c
> > index c11d489..eb548c6 100644
> > --- a/ras-mce-handler.c
> > +++ b/ras-mce-handler.c
> > @@ -55,7 +55,8 @@ static char *cputype_name[] = {
> >   	[CPU_KNIGHTS_LANDING] = "Knights Landing",
> >   	[CPU_KNIGHTS_MILL] = "Knights Mill",
> >   	[CPU_SKYLAKE_XEON] = "Skylake server",
> > -	[CPU_NAPLES] = "AMD Family 17h Zen1"
> > +	[CPU_NAPLES] = "AMD Family 17h Zen1",
> > +	[CPU_DHYANA] = "Hygon Family 18h Moksha"
> >   };
> >   
> >   static enum cputype select_intel_cputype(struct ras_events *ras)
> > @@ -200,6 +201,11 @@ static int detect_cpu(struct ras_events *ras)
> >   			ret = EINVAL;
> >   		}
> >   		goto ret;
> > +	} else if (!strcmp(mce->vendor,"HygonGenuine")) {
> > +		if (mce->family == 24) {
> > +			mce->cputype = CPU_DHYANA;
> > +		}
> > +		goto ret;
> >   	} else if (!strcmp(mce->vendor,"GenuineIntel")) {
> >   		mce->cputype = select_intel_cputype(ras);
> >   	} else {
> > @@ -436,6 +442,7 @@ int ras_mce_event_handler(struct trace_seq *s,
> >   		rc = parse_amd_k8_event(ras, &e);
> >   		break;
> >   	case CPU_NAPLES:
> > +	case CPU_DHYANA:
> >   		rc = parse_amd_smca_event(ras, &e);
> >   		break;
> >   	default:			/* All other CPU types are Intel */
> > diff --git a/ras-mce-handler.h b/ras-mce-handler.h
> > index 8aaecd1..94395eb 100644
> > --- a/ras-mce-handler.h
> > +++ b/ras-mce-handler.h
> > @@ -51,6 +51,7 @@ enum cputype {
> >   	CPU_KNIGHTS_MILL,
> >   	CPU_SKYLAKE_XEON,
> >   	CPU_NAPLES,
> > +	CPU_DHYANA,
> >   };
> >   
> >   struct mce_event {
> >   



Thanks,
Mauro
