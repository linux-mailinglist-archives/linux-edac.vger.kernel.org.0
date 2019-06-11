Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4CF3CA84
	for <lists+linux-edac@lfdr.de>; Tue, 11 Jun 2019 13:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390059AbfFKL4y (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 11 Jun 2019 07:56:54 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35390 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389499AbfFKL4y (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 11 Jun 2019 07:56:54 -0400
Received: from zn.tnic (p200300EC2F0A6800DC92A88D55C2D513.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:6800:dc92:a88d:55c2:d513])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CC9F21EC0467;
        Tue, 11 Jun 2019 13:56:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560254211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QukcMNGwZckUnii5x0hqUwmjRq1rlJQHMCtyQ0Z8UYY=;
        b=pnpCqfjp/JTTeaGIsxUClj6wZjVmlGUmmX/r6HmRNnoLGEWgqXFfkDNSEqoXl1CwLtGWmG
        3WXVYFeZWUgZdYROGprUTVIKezGTXxbqmTGfBYosVD6Xdf7H7DMDa0qHJYsVn7+MkJCOsn
        bbSOc4P5r72saQcFPaXyQ50MzJz0mxU=
Date:   Tue, 11 Jun 2019 13:56:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     James Morse <james.morse@arm.com>,
        "Hawa, Hanna" <hhhawa@amazon.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Shenhar, Talel" <talel@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chocron, Jonathan" <jonnyc@amazon.com>,
        "Krupnik, Ronen" <ronenk@amazon.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Hanoch, Uri" <hanochu@amazon.com>
Subject: Re: [PATCH 2/2] edac: add support for Amazon's Annapurna Labs EDAC
Message-ID: <20190611115651.GD31772@zn.tnic>
References: <1559211329-13098-3-git-send-email-hhhawa@amazon.com>
 <DB09EE2A-7397-4063-B925-66658D0105A5@alien8.de>
 <bfbc12fb68eea9d8d4cc257c213393fd4e92c33a.camel@amazon.com>
 <20190531051400.GA2275@cz.tnic>
 <ce01a2bc-7973-5978-b033-a6bdc61b9d4b@amazon.com>
 <32431fa2-2285-6c41-ce32-09630205bb54@arm.com>
 <9a2aaf4a9545ed30568a0613e64bc3f57f047799.camel@kernel.crashing.org>
 <20190608090556.GA32464@zn.tnic>
 <1ae5e7a3464f9d8e16b112cd371957ea20472864.camel@kernel.crashing.org>
 <68446361fd1e742b284555b96b638fe6b5218b8b.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <68446361fd1e742b284555b96b638fe6b5218b8b.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jun 11, 2019 at 05:21:39PM +1000, Benjamin Herrenschmidt wrote:
> So looking again ... all the registration/removal of edac devices seem
> to already be protected by mutexes, so that's not a problem.
> 
> Tell me more about what specific races you think we might have here,
> I'm not sure I follow...

Well, as I said "it might work or it might set your cat on fire." For
example, one of the error logging paths is edac_mc_handle_error() and
that thing mostly operates using the *mci pointer which should be ok
but then it calls the "trace_mc_event" tracepoint and I'd suppose that
tracepoints can do lockless but I'm not sure.

So what needs to happen is for paths which weren't called by multiple
EDAC agents in parallel but need to get called in parallel now due to
ARM drivers wanting to do that, to get audited that they're safe.

Situation is easy if you have one platform driver where you can
synchronize things in the driver but since you guys need to do separate
drivers for whatever reason, then that would need to be done prior.

Makes more sense?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
