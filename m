Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61E40DBDD7
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2019 08:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfJRGqv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 18 Oct 2019 02:46:51 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35948 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbfJRGqv (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 18 Oct 2019 02:46:51 -0400
Received: from zn.tnic (p200300EC2F0DFC00F134DAC2492356BC.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:fc00:f134:dac2:4923:56bc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5F3691EC0CBD;
        Fri, 18 Oct 2019 08:46:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571381210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ikLh5u7rammITd8Jjc7lWpZdtiSeDNWp7kW6/YVwUxw=;
        b=sbFTsqrDHhVSu9S5cRZfKl3mojHe1A+zddnnhPDz3Wg0q0Dw0tueoJQz3IJ7FV9MesOVQk
        /qW21QR2PGiPUQymlsGOXwmBoYyyc9ZsNtwJ/S6+TB00WfG1ADE+4NroLGH5AbzWfUYybw
        J+bmM5bSWV83za5ukhg6poB7N18M4ro=
Date:   Fri, 18 Oct 2019 08:46:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "bberg@redhat.com" <bberg@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "ckellner@redhat.com" <ckellner@redhat.com>
Subject: Re: [PATCH 1/2] x86, mce, therm_throt: Optimize logging of thermal
 throttle messages
Message-ID: <20191018064642.GA17053@zn.tnic>
References: <2c2b65c23be3064504566c5f621c1f37bf7e7326.camel@redhat.com>
 <20191014212101.25719-1-srinivas.pandruvada@linux.intel.com>
 <20191015084833.GD2311@hirez.programming.kicks-ass.net>
 <f481b4ab6dfebbc0637c843e5f1cd4ddfd4bd60b.camel@linux.intel.com>
 <20191016081405.GO2328@hirez.programming.kicks-ass.net>
 <20191016140001.GF1138@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F4A57D0@ORSMSX115.amr.corp.intel.com>
 <20191017214445.GG14441@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F4A6045@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F4A6045@ORSMSX115.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Oct 17, 2019 at 11:53:18PM +0000, Luck, Tony wrote:
> > * we throttle the machine from within the kernel - whatever that may mean
> > * if that doesn't help, we stop scheduling !root tasks
> > * if that doesn't help, we halt
> 
> The silicon will do that "halt" step all by itself if the temperature
> continues to rise and hits the highest of the temperature thresholds.

Oh, I know that. But that is not of our concern - I believe we're
discussing right now what to do when the lower, softer limits are
reached and the thermal interrupt fires.

When the hw forces HLT, it means we didn't do a very good job earlier,
before it got so hot.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
